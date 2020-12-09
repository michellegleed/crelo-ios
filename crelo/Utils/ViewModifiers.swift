import SwiftUI

//struct NavigationBarModifier: ViewModifier {
//
//    var titleColor: UIColor?
//
//    init(titleColor: UIColor?) {
//        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithTransparentBackground()
//        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
//        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
//    }
//
//    func body(content: Content) -> some View {
//        ZStack{
//            content
//            VStack {
//                GeometryReader { geometry in
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//extension View {
//
//    func navigationBarColor(titleColor: UIColor?) -> some View {
//        self.modifier(NavigationBarModifier(titleColor: titleColor))
//    }
//
//}
