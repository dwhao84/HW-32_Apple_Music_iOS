import UIKit


//enum CaseIterable
//https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/讓-enum-變成-array-的-caseiterable-allcases-swift-4-2-新功能-bc52f475e6c7

//Practice about enum CaseIterable
//enum CaseIterable
enum Food: CaseIterable {
    case apple, banana, pineApple
}

let foodNames = Food.allCases

print(foodNames[0])

for _ in foodNames {
    print(foodNames)
}


//避免出現[__lldb_expr_1.]，帶入CustomStringConvertible
//enum CaseIterable, CustomStringConvertible practice
enum Name: CaseIterable, CustomStringConvertible {
     case Doris, John, Willy

    var description: String {
        switch self {
            case .Doris : return "Doris"
            case .John  : return "John"
            case .Willy : return "Willy"
        }
    }
}


let names = Name.allCases

names[0]


names.last         //last name in the enum to an array.


for _ in names {   //Using for loop calls array 3 times.
    print(names)
}

//Associated value(相關值)
//store the value
//https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/enum-儲存相關聯資料的-associated-value-26ab3e061a16

enum CarBrand {
    case benz(type: String, price: Int)
    case tesla(model: String, price: Int)
}

let myCarType = CarBrand.tesla(model: "3", price: 100000)

//associated value & switch
func carTypeChoose(carName: CarBrand) {
    switch carName {
        case .benz(type:"A303", price: 10000):
            print("Benz")
        case .tesla(model: "3", price: 100000):
            print("Telsa")
        default:
            print("Unknown car type")
    }
}

carTypeChoose(carName: myCarType)
//Call function


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
//enum apple's associated value sample

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}


enum WeekDay: Int {
    case Monday = 1
    case Tuesday = 2
    case Wednesday = 3
    case Thursday = 4
    case Friday = 5
    case Saturday = 6
    case Sunday = 7
}
//enum rawValue(原始值)
//ex: WeekDay


let today = WeekDay.Thursday
//Create a constant "today" stored the WeekDay of enum.

print(today.rawValue)
//Print the today's original value stored in enum.
