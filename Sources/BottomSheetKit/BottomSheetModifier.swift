
import SwiftUI

public struct BottomSheetModifier<Trigger: View, SheetContent: View>: ViewModifier {
    @State private var isPresented = false
    private let trigger: () -> Trigger
    private let title: String
    private let detents: [PresentationDetent]
    private let cornerRadius: CGFloat
    private let background: Color
    private let bottomPadding: CGFloat
    private let content: () -> SheetContent

    public init(
        title: String,
        detents: [PresentationDetent] = [.medium],
        cornerRadius: CGFloat = 30,
        background: Color = .white,
        bottomPadding: CGFloat = 20,
        trigger: @escaping () -> Trigger,
        content: @escaping () -> SheetContent
    ) {
        self.title = title
        self.detents = detents
        self.cornerRadius = cornerRadius
        self.background = background
        self.bottomPadding = bottomPadding
        self.trigger = trigger
        self.content = content
    }

    public func body(content _: Content) -> some View {
        trigger()
            .onTapGesture {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                BottomSheetView(
                    title: title,
                    cornerRadius: cornerRadius,
                    background: background,
                    bottomPadding: bottomPadding,
                    onClose: { isPresented = false }
                ) {
                    self.content()
                }
                .presentationDetents(Set(detents))
                .presentationBackground(.clear)
            }
    }
}

public extension View {
    func bottomSheetTrigger<SheetContent: View>(
        title: String = "",
        detents: [PresentationDetent] = [.medium],
        cornerRadius: CGFloat = 30,
        background: Color = .white,
        bottomPadding: CGFloat = 20,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        modifier(BottomSheetModifier(
            title: title,
            detents: detents,
            cornerRadius: cornerRadius,
            background: background,
            bottomPadding: bottomPadding,
            trigger: { self },
            content: content
        ))
    }
}
