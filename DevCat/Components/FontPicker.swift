//
//  FontPicker.swift
//
//  Created by : Tomoaki Yagishita on 2021/01/09
//  © 2021  SmallDeskSoftware
//

import SwiftUI

// 定义一个类 FontPickerDelegate 作为字体选择器的委托，用于处理字体选择后的回调
class FontPickerDelegate {
    // 引用 FontPicker 的实例
    var parent: FontPicker

    // 初始化方法，接受 FontPicker 的实例作为参数
    init(_ parent: FontPicker) {
        self.parent = parent
    }
    
    // 处理字体变化的函数，当字体被选择或改变时调用
    @objc
    func changeFont(_ id: Any) {
        // 调用父视图中的 fontSelected() 方法来更新字体
        self.parent.fontSelected()
    }
}

// 定义一个 FontPicker 结构体，它是一个 SwiftUI 视图，用于显示和处理字体选择
public struct FontPicker: View {
    // 可选的标题标签，用于显示在字体选择按钮旁边
    let label: LocalizedStringKey?
    
    // 绑定的字体属性，用于存储当前选择的字体
    @Binding var font: NSFont
    
    // 用于保存 FontPickerDelegate 的实例，处理字体选择后的回调
    @State var fontPickerDelegate: FontPickerDelegate?
    
    @AppStorage(AppSettingsKeys.monoFontName) var monoFontName = "JetBrains Mono"
    @AppStorage(AppSettingsKeys.monoPointSize) var monoPointSize = CGFloat(14)
    
    // 初始化方法，接受一个可选的标题键和一个绑定的字体属性
    public init(_ titlekey: LocalizedStringKey? = nil, selection: Binding<NSFont>) {
        self.label = titlekey
        self._font = selection
    }
    
    // 定义视图的主体内容
    public var body: some View {
        HStack {
            // 如果有标签，则显示标签，否则显示空视图
            if let label {
                Text(label)
            } else {
                EmptyView()
            }
            
            // 显示一个按钮，用于打开字体选择器
            Button {
                // 如果字体面板已经可见，则关闭它
                if NSFontPanel.shared.isVisible {
                    NSFontPanel.shared.orderOut(nil)
                    
                    // 如果当前的字体管理器的目标是这个字体选择器的委托，则不做进一步处理
                    if NSFontManager.shared.target === self.fontPickerDelegate {
                        return
                    }
                }
                
                // 否则，创建一个新的 FontPickerDelegate 并设置为字体管理器的目标
                self.fontPickerDelegate = FontPickerDelegate(self)
                NSFontManager.shared.target = self.fontPickerDelegate
                
                // 设置字体面板的当前字体，并显示字体面板
                NSFontPanel.shared.setPanelFont(self.font, isMultiple: false)
                NSFontPanel.shared.orderBack(nil)
            } label: {
                // 按钮显示一个图标，表示字体格式化
                Image(systemName: "textformat")
                    .resizable()
                    .scaledToFit()
                    .padding(2)
            }
        }
    }
    
    // 当字体被选择时，更新绑定的字体属性
    func fontSelected() {
        self.font = NSFontPanel.shared.convert(self.font)
//        self.settings.monoFontName = self.font.fontName
//        self.settings.monoPointSize = self.font.pointSize

        self.monoFontName = self.font.fontName
        self.monoPointSize = self.font.pointSize
    }
}

// 提供一个预览视图，显示 FontPicker 的不同配置
struct FontPicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 带有标签的字体选择器
            FontPicker("font", selection: .constant(NSFont.systemFont(ofSize: 24)))
            // 不带标签的字体选择器
            FontPicker(selection: .constant(NSFont.systemFont(ofSize: 24)))
        }
    }
}
