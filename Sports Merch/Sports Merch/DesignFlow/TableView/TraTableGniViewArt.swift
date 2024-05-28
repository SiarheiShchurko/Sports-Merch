import UIKit

class TraTableGniViewArt: UITableView {
    init(color: UIColor,
         registerClass: AnyClass,
         cell: String,
         rowHeigh: CGFloat,
         separatorStyle: UITableViewCell.SeparatorStyle) {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = color
        self.showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(registerClass, forCellReuseIdentifier: cell)
        self.separatorStyle = separatorStyle
        self.rowHeight = rowHeigh
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
