//
//  WheelView.swift
//  WheelView
//
//  Created by Dathan Wong on 4/10/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct WheelView: View {
    private var options: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @State var angle = 0.0
    var offset = 0.0
    //Color array to change colors of each wheel segment
    var colors = [Color.red, Color.blue, Color.yellow, Color.green, Color.purple, Color.orange, Color.pink, Color.white, Color.gray]
    
    var body: some View {
        VStack{
            ZStack{
                ForEach((0..<options.count),id: \.self){ n in
                    //Generate wheel by looping through each segment
                    WheelSegment(numSegments: self.options.count, text: self.options[n])
                        .foregroundColor(self.colors[n%(self.colors.count)])
                        .rotationEffect(Angle(degrees:Double(n)*360/Double(self.options.count)+self.angle), anchor: .bottom)
                }
            }.animation(.easeInOut(duration:5))
        }
    }
    
}

struct WheelSegment: View {
    let numSegments: Int
    let text: String
    
    var body: some View{
        
        VStack{
            GeometryReader{ geometry in
                ZStack{
                    //Add one segment
                    Slice(numSegments: self.numSegments)
                    //Add stroke segment to get a background effect
                    Slice(numSegments: self.numSegments).stroke(lineWidth: 4)
                        .foregroundColor(.black)
                    VStack{
                        Text(self.text)
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .lineLimit(nil)
                        .rotationEffect(Angle(degrees: 90.0))
                            .frame(width:geometry.size.height/2, height: geometry.size.width/4, alignment: .center)
                            .offset(y: 160)
                        Spacer()
                    }
                    
                }
            }
        }
        
    }
}

struct Slice: Shape{
    let numSegments: Int
    //Draw the slice
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //Calculate the angle based on the number of segments
        let segmentAngle = 360.0/Double(self.numSegments);
        let radius = Double(rect.size.height)
        let center = CGPoint(x:rect.size.width/2, y: rect.size.height)
        path.move(to: center)
        path.addArc(center: center, radius: CGFloat(radius),startAngle: .degrees(270-(segmentAngle/2)), endAngle: .degrees(270+(segmentAngle/2)), clockwise: false)
        return path
    }
    
}

struct Wheel_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            WheelView()
        }
        
    }
}

