//
//  TopNotification.swift
//  green
//
//  Created by mostfa on 8/21/19.
//  Copyright © 2019 mostfa. All rights reserved.
//

import UIKit
import TinyConstraints

class TopNotification: UIView {
    private var backgroundView: UIView
    private var type:notificationType
    var message:String
    var presnter:UIViewController
    var topOffset: CGFloat
    let label = UILabel()
    var shown: Bool = false
    var durition: TimeInterval?
    var completionHandler:((Bool) -> Void)?
    var withImage:Bool = true
    
    
    init(presenter:UIViewController,topOffset:CGFloat,frame: CGRect,type:notificationType,Message:String,durition:TimeInterval? = nil, withImage:Bool = true  ) {
       backgroundView = UIView()
        self.type = type
        
        self.message = Message
        self.presnter = presenter
        self.topOffset = topOffset
        self.durition = durition
        self.withImage = withImage
        
        super.init(frame: frame)
        alpha = 0
        
        drawNotification()
        addToView()
    }
   private func addToView() {
    presnter.view.addSubview(self)
 
    self.topToSuperview(presnter.view.topAnchor, offset: topOffset - 30 , relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: false)
    self.centerXToSuperview()
    
    
        
    }

    func show(completionHandler: ((Bool) -> Void)? = nil) {
        changeTopOffset()
        changeTopOffset()
        self.label.text = message
        UIView.animate(withDuration: ((durition ?? 1) / TimeInterval(2)), delay: 0, options: AnimationOptions.allowUserInteraction, animations: {
            self.presnter.view.layoutIfNeeded()
            self.alpha = 1
            
            
        }) { (boolean) in

                       self.hide(completionHandler:completionHandler)
                   }
                   

        
        

        shown = true
    }
    
    func hide(completionHandler: ((Bool) -> Void)? = nil) {
        
        revertTopOffset()
        revertTopOffset()
    self.completionHandler = completionHandler

        
        UIView.animate(withDuration: ((durition ?? 1) / TimeInterval(2)), delay: 0.24, options: AnimationOptions.allowUserInteraction, animations: {
            self.presnter.view.layoutIfNeeded()
                    self.alpha = 0
        }) { (Bool) in
            self.completionHandler?(true)
            self.shown = false

        }

        
    }
    
    func clear() {
        self.completionHandler = nil
        
        
        
    }
    private func revertTopOffset(){
            self.topToSuperview(presnter.view.topAnchor, offset: topOffset - 30 , relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: false)
          
      }
    func changeTopOffset(){
          self.topToSuperview(presnter.view.topAnchor, offset: topOffset , relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: false)
        
    }
    private func setupText() {
        label.text = self.message
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
       // label.width(message.stringWidth)
        label.height(20)
        
        self.addSubview(label)
        label.topToSuperview( self.topAnchor, offset: 3.5, relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: false)
        let value = withImage ? -40 : -15
        label.rightToSuperview(self.rightAnchor, offset: CGFloat(value), relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: false)
        
        label.textAlignment = .right
        
        let value1 = withImage ? 65:40
        self.width(message.stringWidth + CGFloat(value1))
            self.label.width(message.stringWidth + 100)

            
        
        
        
        
        
    }
 
    func drawNotification(){
        setupBackground()
        backgroundView.backgroundColor = getColor()
        backgroundView.round(by: 14)
        setupImage()
        setupText()
        
        
        
        
        
        
    }
    
    func setupImage() {
        let imageView = UIImageView()
        if withImage {
        imageView.image = #imageLiteral(resourceName: "check.png")
           self.addSubview(imageView)
             imageView.width(24)
             imageView.height(24)
             imageView.top(to: self, self.topAnchor, offset: 2, relation: .equal, priority: .defaultHigh, isActive: true)
             imageView.rightToSuperview(self.rightAnchor, offset: -10, relation: .equal, priority: .defaultHigh, isActive: true, usingSafeArea: false)
        
        }
        
  
        
        
    }
    
    
    private func setupBackground() {
        self.addSubview(backgroundView)
        self.sendSubviewToBack(backgroundView)
        backgroundView.width(self.frame.width)
        backgroundView.height(self.frame.height)
        backgroundView.topToSuperview()
        backgroundView.bottomToSuperview()
        backgroundView.leftToSuperview()
        backgroundView.rightToSuperview()
        


        
        
        
        
    }
    private func getColor()->UIColor {
        switch type {
        case .green:
            
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .red:
            return #colorLiteral(red: 1, green: 0, blue: 0.0653315559, alpha: 1)
        default:
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        }
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}



enum notificationType {
    typealias RawValue = UIColor
    
    case green
    case red
    case orange
   
    
    
    
}

extension UIView {
    
  fileprivate  func round(by float:CGFloat) {
            self.layer.masksToBounds = false
               self.layer.cornerRadius = float
               self.layer.shadowColor = UIColor.black.cgColor
               self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
               self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
               self.layer.shadowOpacity = 0.5
               self.layer.shadowRadius = 1.0

        self.clipsToBounds = true
        
    }
    
    
    
}

extension String {
var stringWidth: CGFloat {
    let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
    let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
    return boundingBox.width
}
}








extension UIButton {

  /// Sets the background color to use for the specified button state.
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

    let minimumSize: CGSize = CGSize(width: 1.0, height: 1.0)

    UIGraphicsBeginImageContext(minimumSize)

    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(CGRect(origin: .zero, size: minimumSize))
    }

    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    self.clipsToBounds = true
    self.setBackgroundImage(colorImage, for: forState)
  }
}
