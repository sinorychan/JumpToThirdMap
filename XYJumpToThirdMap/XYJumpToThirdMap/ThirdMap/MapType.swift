//
//  MapType.swift
//  WisdomGuide
//
//  Created by chan on 2019/8/26.
//  Copyright © 2019 BJMHBT. All rights reserved.
//
import UIKit

 enum MapType {
    
    //百度
    case baiduMap
    //高德
    case gaodeMap
    //苹果
    case appleMap
    //谷歌
    case googleMap
    //腾讯
    case qqMap
    
    
    var  URI : String {
        switch self {
        case .baiduMap:
            return "baidumap://"
        case .gaodeMap:
            return "iosamap://"
        case .appleMap:
            return "http://maps.apple.com/"
        case .googleMap:
            return "comgooglemaps://"
        case .qqMap:
            return "qqmap://"
        }
    }
    
    /// 地图名称
    var Name : String {
        switch self {
        case .baiduMap:
            return "百度地图"
        case .gaodeMap:
            return "高德地图"
        case .appleMap:
            return "苹果地图"
        case .googleMap:
            return "谷歌地图"
        case .qqMap:
            return "腾讯地图"
        }
    }
    
    /// 本地是否安装地图软件
    var canOpen : Bool {
        guard let url = URL(string:URI),
            UIApplication.shared.canOpenURL(url) else {
                return false
        }
        return true
    }
    
    /// 已安装到本地的地图软件类型数组
    static var openMaps : [MapType] {
        let allMaps : [MapType] = [.baiduMap,
                                   .gaodeMap,
                                   .appleMap,
                                   .googleMap,
                                   .qqMap]
        var canOpenMaps = [MapType]()
        for map in allMaps {
            if map.canOpen {
                canOpenMaps.append(map)
            }
        }
        return canOpenMaps
    }
    
    /// 组装跳转三方app 需要的url
    func AssembleUrl(_ targetLatitude : Double,targetLongitute:Double, toName: String)-> String? {
        var urlString = ""
        switch self {
        case .baiduMap:
            
            urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\(targetLatitude),\(targetLongitute)|name:\(toName)&mode=driving&coord_type=bd09ll"
        case .gaodeMap:
            urlString = "iosamap://path?sourceApplication=applicationName&sid=BGVIS1&did=BGVIS2&dlat=\(targetLatitude)&dlon=\(targetLongitute)&dname=\(toName)&dev=0&m=0&t=0"
        case .appleMap:
            break
        case .googleMap:
            let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
            let urlScheme = "wisdomGuide://"
            urlString = "comgooglemaps://?x-source=\(appName)&x-success=\(urlScheme)&saddr=&daddr=\(targetLatitude),\(targetLongitute)&directionsmode=driving"
        case .qqMap:
            urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\(targetLatitude),\(targetLongitute)&to=\(toName)&coord_type=1&policy=0"
            
        }
        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}


