import SwiftUI

extension View {
   func showClearButton(_ text: Binding<String> ) -> some View {
         self.modifier(TextFieldClearButton(fieldText: text))
   }
}


struct TextFieldClearButton: ViewModifier {
   @Binding var fieldText: String

   func body(content: Content) -> some View {
       ZStack(alignment: .trailing)//so that x comes on the right not bottom
       {
           content
               .overlay{
                   HStack {
                           Spacer()
                           Button {
                               fieldText = ""
                           } label: {
                               Image(systemName: "multiply.circle.fill")
                           }
                           .foregroundColor(.secondary)
                           .padding(.trailing, 4)
                   }//hstack
               }//overlay
       }//zstack
   }
}
