//
//  Modifier.swift
//  Pokemon Explorer Task
//
//  Created by George on 24/09/25.
//

import SwiftUI

// MARK: - iOS 14 fallback
struct RefreshControl: UIViewRepresentable {
    @Binding var isRefreshing: Bool
    let onRefresh: () -> Void

    class Coordinator {
        var parent: RefreshControl
        let control = UIRefreshControl()

        init(_ parent: RefreshControl) {
            self.parent = parent
            control.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        }

        @objc func valueChanged() {
            parent.onRefresh()
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    func makeUIView(context: Context) -> UIView { UIView(frame: .zero) }

    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            guard let scrollView = uiView.enclosingScrollView() else { return }
            if scrollView.refreshControl == nil {
                scrollView.refreshControl = context.coordinator.control
            }
            if isRefreshing {
                context.coordinator.control.beginRefreshing()
            } else {
                context.coordinator.control.endRefreshing()
            }
        }
    }
}

private extension UIView {
    func enclosingScrollView() -> UIScrollView? {
        if let sv = superview as? UIScrollView { return sv }
        return superview?.enclosingScrollView()
    }
}

// MARK: - Modifier
struct RefreshableModifier: ViewModifier {
    @Binding var isRefreshing: Bool
    let action: () -> Void

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .refreshable { action() }
        } else {
            content
                .background(
                    RefreshControl(isRefreshing: $isRefreshing, onRefresh: action)
                )
        }
    }
}

extension View {
    func refreshableCompat(
        isRefreshing: Binding<Bool>,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(RefreshableModifier(isRefreshing: isRefreshing, action: action))
    }
}
