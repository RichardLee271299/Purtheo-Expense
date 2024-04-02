//
//  UltityExtentions.swift
//  Purtheo Expense
//
//  Created by Lê Ngọc Phương Đông on 16/03/2023.
//

import Foundation
import SwiftUI
import UIKit

extension String {
    func encodeCustomizedURL() -> String {
        return (self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? "").replacingOccurrences(of: "%3A", with: ":")
    }
}
extension Color
{
    init(rgb: String, alpha: Double = 1) {
        let rgbHex = rgb.suffix(rgb.count - 1)
        let red = Double(Int(rgbHex.prefix(2), radix: 16) ?? 0) / 255
        let green = Double(Int(rgbHex.prefix(4).suffix(2), radix: 16) ?? 0) / 255
        let blue = Double(Int(rgbHex.suffix(2), radix: 16) ?? 0) / 255
        self.init(
            red: red,
            green: green,
            blue: blue,
            opacity: alpha
        )
    }
}

struct CrescentShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Add the upper part of the crescent
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY),
                    radius: rect.width / 2.1,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.closeSubpath()
        
        return path
    }
}

extension Date
{
     func DateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension Int
{
    func formatVND() -> String
    {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))?.replacingOccurrences(of: "₫", with: "") ?? ""
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
