//
//  CopyableLabel.swift
//  CopyAndPaste
//
//  Created by M3ts LLC on 3/4/22.
//

import UIKit

class CopyableLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sharedInit()
    }
    
    func sharedInit() {
        self.isUserInteractionEnabled = true
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.showMenu))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func showMenu(_ recognizer: UILongPressGestureRecognizer) {
        self.becomeFirstResponder()
        let menu = UIMenuController.shared
        let locationOfTouchInLabel = recognizer.location(in: self)
        if !menu.isMenuVisible {
            var rect = bounds
            rect.origin = locationOfTouchInLabel
            rect.size = CGSize(width: 1, height: 1)
            menu.showMenu(from: self, rect: rect)
        }
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = text
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
}
