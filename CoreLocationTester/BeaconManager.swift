//
//  BeaconManager.swift
//  CoreLocationTester
//
//  Created by zhangzhihua on 2017/3/21.
//  Copyright © 2017年 zhangzhihua. All rights reserved.
//

import Foundation
import CoreLocation

struct BeaconID{
    let uuid: UUID
    let major: CLBeaconMajorValue
    let minor: CLBeaconMinorValue
    
    init(uuid:UUID,major:CLBeaconMajorValue,minor:CLBeaconMinorValue)
    {
        self.uuid = uuid
        self.major = major
        self.minor = minor
    }
    
    init(uuidString:String,major:CLBeaconMajorValue,minor:CLBeaconMinorValue)
    {
        self.init(uuid:UUID(uuidString: uuidString)!,major: major, minor:minor)
    }
    
    var asString: String{
        get{
            return "\(uuid.uuidString):\(major):\(minor)"
        }
    }
    
    var asBeaconRegion: CLBeaconRegion{
        get{
            return CLBeaconRegion(proximityUUID: self.uuid, major: self.major, minor: self.minor, identifier: self.asString)
        }
    }
    
    var description: String{
        get{
            return self.asString
        }
    }
    
    var hashValue: Int{
        get{
            return self.asString.hashValue
        }
    }
}

func ==(lhs:BeaconID,rhs:BeaconID)->Bool{
    return lhs.uuid == rhs.uuid
        && lhs.major == rhs.major
        && lhs.minor == rhs.minor
}
extension CLBeacon{
    var beaconID : BeaconID{
        get{
            return BeaconID(uuid: proximityUUID, major: major.uint16Value, minor: minor.uint16Value)
        }
    }
}
