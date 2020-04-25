import UIKit

public extension UITableView {
    override var delaysContentTouches: Bool {
        didSet {
            for view in subviews {
                if let scroll = view as? UIScrollView {
                    scroll.delaysContentTouches = delaysContentTouches
                }
                break
            }
        }
    }

    func setSeparatorInsets(_ insets: UIEdgeInsets) {
        separatorInset = insets
        layoutMargins = insets
    }

    func scrollsToBottom(_ animated: Bool) {
        let section = numberOfSections - 1
        let row = numberOfRows(inSection: section) - 1
        if section < 0 || row < 0 {
            return
        }
        let path = IndexPath(row: row, section: section)
        let offset = contentOffset.y
        scrollToRow(at: path, at: .top, animated: animated)
        let delay = (animated ? 0.2 : 0.0) * Double(NSEC_PER_SEC)
        let t = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: t, execute: { () -> Void in
            if self.contentOffset.y != offset {
                self.scrollsToBottom(false)
            }
        })
    }

    func registerNib<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: name)
    }

    func registerClass<T: UITableViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        register(aClass, forCellReuseIdentifier: name)
    }

    func registerNib<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: name)
    }

    func registerClass<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        register(aClass, forHeaderFooterViewReuseIdentifier: name)
    }

    

    
    func dequeue<T: UITableViewCell>(_ aClass: T.Type) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }

    func dequeue<T: UITableViewHeaderFooterView>(_ aClass: T.Type) -> T! {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }
}

extension UITableViewCell {
    func setSeparatorInsets(_ insets: UIEdgeInsets) {
        separatorInset = insets
        layoutMargins = insets
    }
}
