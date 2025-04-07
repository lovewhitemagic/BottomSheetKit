import SwiftUI

public struct BottomSheetView<Content: View>: View {
    let title: String
    let onClose: () -> Void
    let cornerRadius: CGFloat
    let background: Color
    let bottomPadding: CGFloat
    let content: Content

    @State private var contentHeight: CGFloat = 0
    @State private var containerHeight: CGFloat = 0

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
        VStack(spacing: 0) {
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
                .padding(.top)
                .padding(.horizontal)

                GeometryReader { outerProxy in
                    let availableHeight = outerProxy.size.height
                    Color.clear
                        .onAppear { containerHeight = availableHeight }
                }
                .frame(height: 0)

                Group {
                    GeometryReader { proxy in
                        let totalHeight = proxy.size.height
                        Color.clear
                            .onAppear {
                                contentHeight = totalHeight
                            }
                    }
                    .frame(height: 0)

                    Group {
                        if contentHeight > containerHeight {
                            ScrollView {
                                content
                                    .padding(.horizontal)
                                    .padding(.bottom, bottomPadding)
                            }
                        } else {
                            content
                                .padding(.horizontal)
                                .padding(.bottom, bottomPadding)
                        }
                    }
                }
            }
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .padding(.horizontal, 24)
        }
    }
}