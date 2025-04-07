# BottomSheetKit
一个自定义样式的 SwiftUI 弹出卡片组件（Sheet），支持圆角、背景色、自定义内容插槽，自动滚动适配。

![preview](assets/preview1.png)

## ✨ 功能亮点

- ✅ 自定义标题与关闭按钮
- ✅ 内容可插槽（任意 View）
- ✅ 自动 ScrollView：设置 `maxHeight` 即可启用滚动
- ✅ 自定义圆角与背景色
- ✅ 适配 iOS `.presentationDetents` 使用方式



## 📦 安装方式（Swift Package Manager）

在 Xcode 中选择：
File > Add Packages...



## 🚀 使用示例

```swift
import BottomSheetKit
import SwiftUI

struct BottomSheetKitView: View {
    @State private var showSheet = false

    var body: some View {
        Button("打开底部弹窗") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            BottomSheetView(
                title: "智能滚动 + 固定标题",
                //bottomPadding: 20,
                onClose: { showSheet = false }
            ) {
                VStack(spacing: 12) {
                    ForEach(1...30, id: \.self) { i in
                        Text("项目 \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
            }
            .presentationDetents([.height(350)])
            .presentationBackground(.clear)
        }
    }
}

#Preview {
    BottomSheetKitView()
}
```


## 📐 API 说明

```swift
BottomSheetView(
    title: String,                    // 顶部标题文本
    cornerRadius: CGFloat = 30,       // 圆角值，默认 30
    background: Color = .white,       // 弹窗背景色
    bottomPadding: CGFloat = 20,      // 内容底部距离，默认 20
    onClose: @escaping () -> Void,    // 关闭按钮回调
    content: () -> Content            // 弹窗内容区域（支持任意 View）
)
```
## 🧩 使用场景

| 场景           | 描述               |
|----------------|--------------------|
| 设置页弹窗     | 修改头像、昵称等    |
| 选择器弹窗     | 城市、分类、主题选择 |
| 内容展示       | 通知列表、项目明细  |

## 👨‍💻 作者
由 @lovewhitemagic 创建。欢迎 Star ⭐️ 或 PR！