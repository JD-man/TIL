import Foundation

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())")
print(customersInLine.count)

func serve(customer customerProvide: () -> String) {
    print("Now serving \(customerProvider())")
}

serve(customer: { customersInLine.remove(at: 0) })

func serve(customer customerProvide: @autoclosure () -> String) {
    print("Now serving \(customerProvider())")
}

serve(customer: customersInLine.remove(at: 0))

var customerProviders: [() -> String] = []
func collectionCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

collectionCustomerProviders(customersInLine.remove(at:0))
collectionCustomerProviders(customersInLine.remove(at:0))
print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())")
}
