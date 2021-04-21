import UIKit.UIFont

extension String {
    func widthOfString(usingFont font: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
