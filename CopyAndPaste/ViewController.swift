//
//  ViewController.swift
//  CopyAndPaste
//
//  Created by M3ts LLC on 3/4/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet weak var imgPasteHouse: UIImageView!
    @IBOutlet weak var imgCopyHouse: UIImageView!
    @IBOutlet weak var lblKGCopyable: KGCopyableLabel!
    @IBOutlet weak var tfPasteHere: UITextField!
    @IBOutlet weak var lblCopyMe: UILabel!
    @IBOutlet weak var lblSelectable: SelectableLabel!
    @IBOutlet weak var lblCopyable: CopyableLabel!
    
    // MARK: - Properties
    let testPasteBoard = UIPasteboard(name: UIPasteboard.Name(rawValue: "Test"), create: true)
    
    // MARK: - Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPasteHere.delegate = self
        imgCopyHouse.image = UIImage(named: "dreamHouse.png")
        imgPasteHouse.image = UIImage(systemName: "photo.artframe")
        lblCopyMe.text = "Just copy and paste me."
    }
    
    // MARK: - Actions
    @IBAction func copyImageButtonTapped(_ sender: Any) {
        let image = imgCopyHouse.image ?? UIImage()
        if let type = UIPasteboard.typeListImage[0] as? String {
            if !type.isEmpty {
                if let data = image.jpegData(compressionQuality: 1) {
                    testPasteBoard?.setData(data, forPasteboardType: type)
                    if let readData = testPasteBoard?.data(forPasteboardType: type) {
                        let readImage = UIImage(data: readData, scale: 2)
                        print("image : \(image) == testPasteBoard?.image : \(String(describing: testPasteBoard?.image)) == readImage : \(String(describing: readImage))")
                    }
                }
            }
        }
    }
    
    @IBAction func pasteImageButtonTapped(_ sender: Any) {
        imgPasteHouse.image = testPasteBoard?.image
    }
    
    @IBAction func copyMeTextButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = lblCopyMe.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}




