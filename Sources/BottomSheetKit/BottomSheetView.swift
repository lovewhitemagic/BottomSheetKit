import SwiftUI

public struct BottomSheetView<Content: View>: View {
    let title: String
    let onClose: () -> Void
    let cornerRadius: CGFloat
    let background: Color
    let bottomPadding: CGFloat
    let content: Content

    public init(
        title: String,
        cornerRadius: CGFloat = 30,
        background: Color = .white,
        bottomPadding: CGFloat = 20,
        onClose: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.cornerRadius = cornerRadius
        self.background = background
        self.bottomPadding = bottomPadding
        self.onClose = onClose
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geometry in
            let availableHeight = geometry.size.height

            VStack(spacing: 0) {
                // 固定标题栏
                HStack {
                    Text(title)
                        .font(.headline)
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                            .font(.title2)
                    }
                }
                .padding(.top)
                .padding(.horizontal)

                // 滚动内容区，限定高度
                ScrollView {
                    VStack(spacing: 0) {
                        content
                            .padding(.horizontal)
                            .padding(.bottom, bottomPadding)
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear.preference(key: ContentHeightKey.self, value: proxy.size.height)
                        }
                    )
                }
                .frame(maxHeight: availableHeight - 80) // 留出标题区域大约 80 高度
            }
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .padding(.horizontal, 24)
        }
    }
}

private struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}