
import SwiftUI


public struct MyCustomButton<Trigger: View, Content: View>: View {
    private let trigger: Trigger
    private let title: String
    private let detents: [PresentationDetent]
    private let cornerRadius: CGFloat
    private let background: Color
    private let bottomPadding: CGFloat
    private let content: () -> Content

    @State private var showSheet = false

    // ✅ 构造器 1：使用默认按钮样式
    public init(
        title: String,
        detents: [PresentationDetent] = [.medium],
        cornerRadius: CGFloat = 30,
        background: Color = .white,
        bottomPadding: CGFloat = 20,
        @ViewBuilder content: @escaping () -> Content
    ) where Trigger == DefaultButton {
        self.title = title
        self.detents = detents
        self.cornerRadius = cornerRadius
        self.background = background
        self.bottomPadding = bottomPadding
        self.trigger = DefaultButton(title: title)
        self.content = content
    }

    // ✅ 构造器 2：传入自定义按钮视图
    public init(
        title: String,
        detents: [PresentationDetent] = [.medium],
        cornerRadius: CGFloat = 30,
        background: Color = .white,
        bottomPadding: CGFloat = 20,
        @ViewBuilder trigger: @escaping () -> Trigger,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.detents = detents
        self.cornerRadius = cornerRadius
        self.background = background
        self.bottomPadding = bottomPadding
        self.trigger = trigger()
        self.content = content
    }

    public var body: some View {
        trigger
            .onTapGesture {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                BottomSheetView(
                    title: title,
                    cornerRadius: cornerRadius,
                    background: background,
                    bottomPadding: bottomPadding,
                    onClose: { showSheet = false }
                ) {
                    content()
                }
                .presentationDetents(Set(detents))
                .modifier(ConditionalClearBackground())
            }
    }
}


public struct DefaultButton: View {
    let title: String

    public var body: some View {
        Text(title)
    }
}


fileprivate struct ConditionalClearBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content.presentationBackground(.clear)
        } else {
            content
        }
    }
}
