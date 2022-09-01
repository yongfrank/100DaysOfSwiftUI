//
//  ContentView.swift
//  HealthKitTest
//
//  Created by Frank Chu on 8/22/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
//            ForEach
        }
        .onAppear {
            authorizeHealthkit()
            latestHeartRate()
        }
    }
    
    
    func authorizeHealthkit() {
        let read = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        let share = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        healthStore.requestAuthorization(toShare: share, read: read) { (chk, error) in
            if(chk) {
                print("DEBUG: permission granted")
            }
        }
    }
    
    func latestHeartRate() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            print("DEBUG: latestHeartRate guard sample type failed!")
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
          
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (sample, result, error) in
            guard error == nil else {
                print("DEBUG: query error, \(error!.localizedDescription)")
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            let latestHr = data.quantity.doubleValue(for: unit)
            print("Lastest hr \(latestHr) BPM")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/mm/yyyy hh:mm:ss"
            let startDate = dateFormatter.string(from: data.startDate)
            let endDate = dateFormatter.string(from: data.endDate)
            print("DEBUG: start \(startDate) \n end \(endDate)")
        }
        print("DEBUG: query is \(query)")
        healthStore.execute(query)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
