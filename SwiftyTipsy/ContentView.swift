//
//  ContentView.swift
//  SwiftyTipsy
//
//  Created by Eknath Kadam on 8/3/22.
//
/*
 BEAUTIFUL!!!!!!!!!!!!!!!!!
 @State private var myValue: Int
 // ...
 TextField("number", text: Binding(
 get: { String(myValue) },
 set: { myValue = Int($0) ?? 0 }
 ))
 */
import SwiftUI

struct ContentView: View {
    var currancyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    @FocusState private var amountIsFocused: Bool
    @State private var numberOfPeople: String = ""
    @State private var tipPercentage:Int = 20
    let tipPercentages = [10,15,20,25,0]
    
    
    @State private var billAmount: String = ""
    
    private var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let bill = Double(billAmount) ?? 0.0
        let tipValue =  ( bill / 100 ) * tipSelection
        let total = bill   + tipValue
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount =  Double (Int (numberOfPeople) ?? 2 )
        let totalPerPerson = grandTotal / peopleCount
        return totalPerPerson
    }
    
    
    var body: some View {
        VStack {
            
            Text("TIP TOP")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(.mint)
                .border(.white, width:0.5)
                .padding()
            
            Form {
                
                
                
                // ideal would have been below code but the problem is it does not support placeholder, also having problems clearing a double textfield with showClearButton - problem being faced is that when the focus is in the field it is not clearing
                //and when the focus is not in the field it clears to 0.0 which is not much useful
                //TextField("Amount", value: $billAmount, format:currancyFormatter)
                
                Section {
                    TextField("Amount", text: $billAmount)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .showClearButton($billAmount)
                    
                }
                Section {
                    
                    //Picker does not work without a navigation view. Navigation view with a form + stacknavigationview style is not showing well on iPad, so will use a normal text field
                    /*
                     Picker("Number of people", selection: $numberOfPeople) {
                     ForEach(2 ..< 11) {
                     Text("\($0)")
                     }
                     }
                     */
                    TextField("Number of People (Default 2)", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .showClearButton($numberOfPeople)
                    
                }
                
                Section(header: Text("How much tip do you want to leave?"))
                {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section (header: Text("Amount with Tip")){
                    Text(grandTotal, format: currancyFormatter)
                }
                
                Section (header: Text("Amount per person")) {
                    Text(totalPerPerson, format: currancyFormatter)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .padding()//must to show background mint color of vstack -- see below
        }
        //vstack background
        .border(.white, width:2)
        .background(.mint)
        .padding()
    }
}







