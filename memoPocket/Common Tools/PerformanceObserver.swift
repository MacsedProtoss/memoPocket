//
//  PerformanceObserver.swift
//  memoPocket
//
//  Created by Macsed on 2020/2/29.
//  Copyright © 2020 Macsed. All rights reserved.
//

import Foundation
import UIKit


class PerformanceObserver : Thread{

    private var interval : CGFloat!
    private var Semaphore : DispatchSemaphore = DispatchSemaphore(value: 0)
    private var handler : (()->Void)!

    private let lock = NSObject()
    private var _isResponse = true
    private var isResponse : Bool{
        get{
            objc_sync_enter(lock)
            let result = _isResponse
            objc_sync_exit(lock)
            return result
        }
        set{
            objc_sync_enter(lock)
            _isResponse = newValue
            objc_sync_exit(lock)
        }
    }

    init(interval : CGFloat,handler : @escaping ()->Void){
        self.interval = interval
        self.handler = handler
        super.init()
    }

    override func main() {
        while !isCancelled{

            
            autoreleasepool { () -> Result<Any, Error> in

                isResponse = false

                DispatchQueue.main.async {
                    self.isResponse = true
                    self.Semaphore.signal()
                }

                usleep(1000000/60)
                if !isResponse{
                    handler()
                }

                return Result.success("nil")
            }

        }
    }
    
}


fileprivate var lastStack : String? = nil
fileprivate var count = 0
func performanceHandle(){
    print("catch low performance")
    
    let now = BSBacktraceLogger.bs_backtraceOfAllThread()
    if now != lastStack{
        print(now)
    }
    lastStack = now
    count += 1
    print(count)
}
