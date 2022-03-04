//
//  SelectableLabel.swift
//  CopyAndPaste
//
//  Created by M3ts LLC on 3/4/22.
//

import UIKit

/// Label that allows selection with long-press gesture, e.g. for copy-paste.
class SelectableLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
        addGestureRecognizer(
            UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPress(_:))))
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }
    
    // MARK: - UIResponderStandardEditActions
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
    
    // MARK: - Long-press Handler
    @objc func handleLongPress(_ recognizer: UIGestureRecognizer) {
        if recognizer.state == .began,
           let recognizerView = recognizer.view,
           let recognizerSuperview = recognizerView.superview {
            recognizerView.becomeFirstResponder()
            UIMenuController.shared.setTargetRect(recognizerView.frame, in: recognizerSuperview)
            UIMenuController.shared.setMenuVisible(true, animated:true)
        }
    }
}
