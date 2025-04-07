import SwiftUI

public struct BottomSheetView<Content: View>: View {
    let title: String
    let onClose: () -> Void
    let cornerRadius: CGFloat
    let background: Color
    let maxHeight: CGFloat?
    let content: Content

    public init(
        title: String,
        cornerRadius: CGFloat = 30,
        background: Color = .white,
        maxHeight: CGFloat? = nil,
        onClose: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.cornerRadius = cornerRadius
        self.background = background
        self.maxHeight = maxHeight
        self.onClose = onClose
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            // 顶部栏
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
            .padding()

            // 内容区域
            Group {
                if let maxHeight = maxHeight {
                    ScrollView {
                        content
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .padding(.bottom)
                    }
                    .frame(maxHeight: maxHeight)
                } else {
                    content
                        .padding(.horizontal, 16)
                        .padding(.bottom)
                }
            }
        }
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}