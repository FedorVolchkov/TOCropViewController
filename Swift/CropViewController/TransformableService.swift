//
//  TransformableService.swift
//  CropViewController
//
//  Created by Taras Chernysh on 10/9/19.
//  Copyright © 2019 Tim Oliver. All rights reserved.
//

import UIKit

public class TransformableService {
    static let shared = TransformableService()
    private init() {}
    
    var resetTapped: (() -> Void)?
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
        button.isHidden = false
        return button
    }()
    
    /// Resets object of TOCropViewController class as if
    /// user pressed reset button in the bottom bar themself
    @objc func tappedResetButton() {
        resetTapped?()
    }
    
    /// init UIColor from hex string
    func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func setupToolbar(inCropVC vc: CropViewController) {
        
        let yellow = TransformableService.shared.hexStringToUIColor(hex: "#CBB147")
        let white = TransformableService.shared.hexStringToUIColor(hex: "#FFFFFF")
        let blue = TransformableService.shared.hexStringToUIColor(hex: "#007AFF")
        
//        /// 'doneButton' for CropVC
//        vc.toolbar.cancelTextButton.setTitleColor(white, for: .normal)
//        
//        /// 'cancelButton' for CropVC
//        vc.toolbar.doneTextButton.setTitleColor(blue, for: .normal)
        
        vc.toolbar.clampButton.setImage(UIImage(named: "ic_ mirrore_white"), for: .normal)
        vc.toolbar.rotateButton.setImage(UIImage(named: "ic_rotate_white"), for: .normal)
        vc.toolbar.rotateClockwiseButton?.setImage(UIImage(named: "ic_frame_white"), for: .normal)
        vc.toolbar.flipYButton.setImage(UIImage(named: "ic_mirrore_hor"), for: .normal)
        
//        vc.doneButtonTitle = "Cancel"
//        vc.cancelButtonTitle = "Done"
        vc.resetButtonHidden = true
    }
    
    func setupCropVC(inCropVC vc: CropViewController) {
        /// container view doesn't have dark style
         vc.cropView.translucencyAlwaysHidden = true
    }
    
    
    func addConstraintToResetButton(inView view: UIView) {
        view.addSubview(resetButton)
        var topSpace: CGFloat = 0
        if #available(iOS 11.0, *) {
            topSpace = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
        }
        let topConstraint = NSLayoutConstraint(item: resetButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: topSpace + 4)

        let rightConstraint = NSLayoutConstraint(item: resetButton,
                                                 attribute: .leading,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .leading,
                                                 multiplier: 1,
                                                 constant: 16)
        let heightConstraint = NSLayoutConstraint(item: resetButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 20)
        
        view.addConstraints([topConstraint, rightConstraint, heightConstraint])
        
    }
}

