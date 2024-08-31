//
//  FileHashView.swift
//  DevCat
//
//  Created by ElysiaMae on 2024/7/7.
//

import CryptoKit
import SwiftUI
import UniformTypeIdentifiers

enum HashType: String, CaseIterable {
    case sha256 = "SHA-256"
    case sha384 = "SHA-384"
    case sha512 = "SHA-512"
}

struct FileHashView: View {
    @State private var isLoading: Bool = false // 是否在计算
    @State private var progress: Double = 0.0 // 进度
    @State private var errorMessage: String? // 错误消息
    @State private var isDragging = false // 拖拽

    @State private var plaintext: String = "" // 计算的 Hash 值
    @State private var fileName: String = ""
    @State private var elapsedTime: Double = 0.0 // 计算耗时

    @State private var selectedHashType: HashType = .sha256

    var body: some View {
        VStack {
            TitleText("File Hash")
            HStack {
                Picker("Select Hash Type:", selection: $selectedHashType) {
                    ForEach(HashType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            if isLoading {
                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
                Text("Calculating SHA-256...")

            } else {
                Spacer()
                VStack(alignment: .leading) {
                    VStack {
                        Text("File Name: ") +
                            Text("\(fileName)").bold()
                    }
                    VStack {
                        Text("Hash Type: ") +
                            Text("\(selectedHashType.rawValue)").bold()
                    }
                    MonoTextEditor(text: $plaintext)
                    Text(String(format: "Elapsed Time: %.2f seconds", elapsedTime))
                }
                if let errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isDragging ? Color.blue : Color.gray, lineWidth: 2)
                    .background(Color.clear)
//                    .frame(height: 400)

                Text("Drag and drop a file here or\nClick the button below to select a file")
                    .multilineTextAlignment(.center)
            }
            .onDrop(of: [.fileURL], isTargeted: $isDragging) { providers in
                handleDrop(providers: providers)
            }
            Button("Select File") {
                selectFile()
            }
        }
        .padding()
        .onDrop(of: [.fileURL], isTargeted: nil) { providers in
            handleDrop(providers: providers)
        }
    }

    private func selectFile() {
        #if os(iOS)
        // isShowingDocumentPicker = true
        #elseif os(macOS)
        let panel = NSOpenPanel() // 打开文件选择器
        panel.allowedContentTypes = [UTType.data]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false // 用户不能选择目录
        if panel.runModal() == .OK, let url = panel.url {
            fileName = url.lastPathComponent
            processFile(url: url)
        }
        #endif
    }

    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        if let provider = providers.first {
            provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, _ in
                if let data = item as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) {
                    fileName = url.lastPathComponent
                    processFile(url: url)
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Failed to load file."
                    }
                }
            }
            return true
        }
        return false
    }

    private func processFile(url: URL) {
        isLoading = true
        progress = 0.0
        errorMessage = nil
        Task {
            let startTime = Date()
            do {
                switch selectedHashType {
                    case .sha256:
                        let hash = try await calculateSHA256(url: url)
                        DispatchQueue.main.async {
                            plaintext = hash
                            isLoading = false
                        }
                    case .sha384:
                        let hash = try await calculateSHA384(url: url)
                        DispatchQueue.main.async {
                            plaintext = hash
                            isLoading = false
                        }
                    case .sha512:
                        let hash = try await calculateSHA512(url: url)
                        DispatchQueue.main.async {
                            plaintext = hash
                            isLoading = false
                        }
                }
                let endTime = Date()
                let duration = endTime.timeIntervalSince(startTime)
                elapsedTime = duration
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to calculate SHA Hash: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }

    private func calculateSHA256(url: URL) async throws -> String {
        let bufferSize = 1024 * 1024 * 100 // 100 MB buffer
        var hash = SHA256() // 创建哈希计算器
        let fileSize = try FileManager.default.attributesOfItem(atPath: url.path)[.size] as! UInt64
        var processedSize: UInt64 = 0

        let fileHandle = try FileHandle(forReadingFrom: url) // 打开文件流
        defer { try? fileHandle.close() } // 关闭文件流

        while autoreleasepool(invoking: {
            let data = try? fileHandle.read(upToCount: bufferSize)
            if let data, !data.isEmpty {
                hash.update(data: data)
                processedSize += UInt64(data.count)
                //                DispatchQueue.main.async {
                self.progress = Double(processedSize) / Double(fileSize)
                //                }
                return true
            } else {
                return false
            }
        }) {}

        let digest = hash.finalize() // 计算最终的哈希值
        return digest.map { String(format: "%02x", $0) }.joined() // 将哈希值转换为十六进制字符串
    }

    private func calculateSHA384(url: URL) async throws -> String {
        let bufferSize = 1024 * 1024 * 100 // 100 MB buffer
        var hash = SHA384()
        let fileSize = try FileManager.default.attributesOfItem(atPath: url.path)[.size] as! UInt64
        var processedSize: UInt64 = 0

        let fileHandle = try FileHandle(forReadingFrom: url)
        defer { try? fileHandle.close() }

        while autoreleasepool(invoking: {
            let data = try? fileHandle.read(upToCount: bufferSize)
            if let data, !data.isEmpty {
                hash.update(data: data)
                processedSize += UInt64(data.count)
                //                DispatchQueue.main.async {
                self.progress = Double(processedSize) / Double(fileSize)
                //                }
                return true
            } else {
                return false
            }
        }) {}

        let digest = hash.finalize()
        return digest.map { String(format: "%02x", $0) }.joined()
    }

    private func calculateSHA512(url: URL) async throws -> String {
        let bufferSize = 1024 * 1024 * 100 // 100 MB buffer
        var hash = SHA512()
        let fileSize = try FileManager.default.attributesOfItem(atPath: url.path)[.size] as! UInt64
        var processedSize: UInt64 = 0

        let fileHandle = try FileHandle(forReadingFrom: url)
        defer { try? fileHandle.close() }

        while autoreleasepool(invoking: {
            let data = try? fileHandle.read(upToCount: bufferSize)
            if let data, !data.isEmpty {
                hash.update(data: data)
                processedSize += UInt64(data.count)
                //                DispatchQueue.main.async {
                self.progress = Double(processedSize) / Double(fileSize)
                //                }
                return true
            } else {
                return false
            }
        }) {}

        let digest = hash.finalize()
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}

#Preview {
    FileHashView()
}
