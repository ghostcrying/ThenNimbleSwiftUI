import SwiftUI

struct BookButtonStyle: ButtonStyle {

    var foreground = Color.white
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.appBookingBlue)
            .overlay(configuration.label.foregroundColor(foreground))
    }
}

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}
