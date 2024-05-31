import Foundation

extension Double {
    func rchDoubleFormatingSor() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        numberFormatter.decimalSeparator = "."
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2

        let formattedAmount = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        
        return formattedAmount
    }
}
