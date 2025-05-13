import Foundation

extension Double {
    /// Converts a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// ```
    func formatAsCurrency(decimalPlaces: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = decimalPlaces
        
        // Edge case for low value coins
        if self < 0.01 {
            formatter.maximumFractionDigits = 6
        }
        
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    /// Converts a Double into string representation with K, M, Bn, Tr abbreviations
    /// ```
    /// Convert 1234.56 to "1.23K"
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(self)
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            return sign + "\(formatted.reduceScale(to: 2))T"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            return sign + "\(formatted.reduceScale(to: 2))B"
        case 1_000_000...:
            let formatted = num / 1_000_000
            return sign + "\(formatted.reduceScale(to: 2))M"
        case 1_000...:
            let formatted = num / 1_000
            return sign + "\(formatted.reduceScale(to: 2))K"
        case 0...:
            return sign + "\(self)"
        default:
            return "\(sign)\(self)"
        }
    }
    
    /// Formats a double into percentage string
    /// ```
    /// Convert 1234.56 to "1,234.56%"
    /// ```
    func formatAsPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self / 100)) ?? "0.00%"
    }
    
    /// Reduces the scale of a double to specified decimal places
    /// ```
    /// Convert 1.23456 to 1.23
    /// ```
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        return Darwin.round(self * multiplier) / multiplier
    }
}
