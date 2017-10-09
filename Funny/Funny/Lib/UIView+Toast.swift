import UIKit

enum ToastType {
    case center
    case top
    case bottom
}

private let YZToastAlpha: CGFloat = 0.7
private let YZToastTopPadding: CGFloat = 74
private let YZToastBottomPadding: CGFloat = 59
private let YZToastDefaultDuration: TimeInterval = 2.5

private let YZToastShadowRadius: CGFloat = 6.0
private let YZToastShadowOffset: CGSize = CGSize(width: 4.0, height: 4.0)
private let YZToastFontSize: CGFloat = 16
private let YZToastHorizontalPadding: CGFloat = 10
private let YZToastVerticalPadding: CGFloat = 10
private let YZToastFadeDuration: TimeInterval = 0.2
private let YZToastCornerRadius: CGFloat = 3.0

extension UIView {
    
    func showTopToast(_ message: String, duration: TimeInterval = YZToastDefaultDuration) {
        showToast(message, position: .top, duration: duration)
    }
    
    func showBottomToast(_ message: String, duration: TimeInterval = YZToastDefaultDuration) {
        showToast(message, position: .bottom, duration: duration)
    }
    
    func showToast(_ message: String, position: ToastType = .center, duration: TimeInterval = YZToastDefaultDuration, centerY: CGFloat? = nil) {
        let backView = viewForMessage(message)
        showToast(backView, duration: duration, position: position, centerY: centerY)
    }
}

extension UIView {
    fileprivate func showToast(_ toast: UIView, duration: TimeInterval, position: ToastType, centerY: CGFloat?) {
        toast.isUserInteractionEnabled = false
        makeToastCenter(toast, type: position, centerY: centerY)
        toast.alpha = 0
        addSubview(toast)
        
        UIView.animate(withDuration: YZToastFadeDuration, delay: 0, options: .curveEaseOut, animations: {
            toast.alpha = YZToastAlpha
        }) { (easeOut) in
            UIView.animate(withDuration: YZToastFadeDuration, delay: duration, options: .curveEaseIn, animations: {
                toast.alpha = 0
            }) { (easeOut) in
                toast.removeFromSuperview()
            }
        }
    }
    
    fileprivate func makeToastCenter(_ toast: UIView, type: ToastType, centerY: CGFloat?) {
        let centerX = bounds.size.width * 0.5
        if let centerY = centerY {
            toast.center =  CGPoint(x: centerX, y: centerY)
            return
        }
        var toastCenter = CGPoint.zero
        let halfToastH = toast.frame.size.height * 0.5
        switch type {
        case .top:
            toastCenter = CGPoint(x: centerX, y: halfToastH + YZToastTopPadding)
        case .bottom:
            toastCenter = CGPoint(x: centerX, y: bounds.size.height - halfToastH - YZToastBottomPadding)
        default:
            toastCenter = CGPoint(x: centerX, y: bounds.size.height * 0.5)
        }
        toast.center = toastCenter
    }
    
    fileprivate func viewForMessage(_ message: String) -> UIView {
        let toast = UIView()
        toast.backgroundColor = UIColor.black
        toast.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        toast.layer.cornerRadius = YZToastCornerRadius
        //
        toast.layer.shadowColor = UIColor.black.cgColor
        toast.layer.shadowOpacity = 1
        toast.layer.shadowRadius = YZToastShadowRadius
        toast.layer.shadowOffset = YZToastShadowOffset
        //label
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        let font = UIFont.systemFont(ofSize: YZToastFontSize)
        messageLabel.font = font
        messageLabel.textColor = UIColor.white
        messageLabel.text = message
        
        let maxSize = CGSize(width: bounds.size.width * 0.8, height: bounds.size.height * 0.8)
        let messageSize = message.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil).size
        messageLabel.frame = CGRect(x: YZToastHorizontalPadding, y: YZToastVerticalPadding, width: messageSize.width, height: messageSize.height)
        toast.frame = CGRect(x: 0, y: 0, width: messageSize.width + 2 * YZToastHorizontalPadding, height: messageSize.height + 2 * YZToastVerticalPadding)
        toast.addSubview(messageLabel)
        return toast
    }
    
}

