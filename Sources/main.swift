import Kitura
import HeliumLogger
import Foundation

// Initialize HeliumLogger
HeliumLogger.use()

// Create a new router
let router = Router()

// MARK: - Handle HTTP GET requests

router.get("/shipments") { request, response, next in
    let json: [Any] = [
        Shipment(company: "Acme Inc.", description: "Plastic", price: 1020.99, weight: 20.0).json,
        Shipment(company: "PNG Delivbery LLC", description: "Gas tank", price: 3480.99, weight: 40.0).json,
        Shipment(company: "John Metal Corp.", description: "Metal rolls", price: 7640.99, weight: 70.0).json
    ]
    let data = try! JSONSerialization.data(withJSONObject: json, options: [])
    
    response.send(data: data)
    next()
}

router.get("/drivers") { request, response, next in
    let json: [Any] = [
        Driver(name: "Miguel", rate: 120.0, available: true).json,
        Driver(name: "Ana", rate: 220.0, available: true).json,
        Driver(name: "Noah", rate: 320.0, available: false).json
    ]
    let data = try! JSONSerialization.data(withJSONObject: json, options: [])
    
    response.send(data: data)
    next()
}

// MARK: - Handle HTTP POST requests

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
