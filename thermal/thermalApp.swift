//
//  thermalApp.swift
//  thermal
//
//  Created by timko on 18/08/2021.
//

import SwiftUI

func IOHIDEventFieldBase(type: Int) -> Int {
    return type << 16
}

let kIOHIDEventTypeTemperature  = 15
let kIOHIDEventTypePower        = 25

@main
struct thermalApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(macOS 12.0, *) {
                Table(thingthing3()) {
                    TableColumn("Sensor", value: \.sensor)
                    TableColumn("Temperature", value: \.temperature)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    struct Data: Identifiable {
        var id = UUID()
        let sensor: String
        let temperature: String
    }
    
    func thingthing3() -> Array<Data> {
        let data = thingthing2()
        
        var return_data = Array<Data>()
        
        for elem in data {
            let obj = Data(sensor: elem.key, temperature: String(Int(elem.value)) + " °C")
            return_data.append(obj)
        }
        
        return return_data
    }
    
    // helper
    func thingthing2() -> Dictionary<String, Double> {
        let sensors = [ "PrimaryUsagePage" : 0xff00, "PrimaryUsage" : 5 ]
        
        let system = IOHIDEventSystemClientCreate(
            CFAllocatorGetDefault().takeRetainedValue()
        ).takeRetainedValue()
        
        IOHIDEventSystemClientSetMatching(system, sensors as CFDictionary)
        
        let matching_srvs = IOHIDEventSystemClientCopyServices(system)!
        
        // print(CFArrayGetCount(matching_srvs))
        
        var dict: [String : Double] = [:]
        for i in 0...CFArrayGetCount(matching_srvs)-1 {
            let sc = unsafeBitCast(CFArrayGetValueAtIndex(matching_srvs, i), to:  IOHIDServiceClient.self)
            let name = (IOHIDServiceClientCopyProperty(sc, __CFStringMakeConstantString("Product")
            ) as! CFString)
            
            let event = IOHIDServiceClientCopyEvent(sc, Int64(kIOHIDEventTypeTemperature), 0, 0)
            
            if ((name != nil) && (event != nil)) {
                let temp = IOHIDEventGetFloatValue(event, Int32(IOHIDEventFieldBase(type: kIOHIDEventTypeTemperature)));
                dict[name as String] = temp;
               }
               // CFRelease(event);
        }
        
        print(dict)
        
        //return dict["SOC MTR Temp Sensor0"]!
        return dict
    }
}
