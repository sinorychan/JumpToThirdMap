//
//  MapNavigation.swift
//  WisdomGuide
//
//  Created by chan on 2019/8/26.
//  Copyright © 2019 BJMHBT. All rights reserved.
//

import UIKit
import MapKit

public struct MapNavigation {
    
    ///  打开第三方地图alert (已检测是否安装第三方地图 未安装不在弹出视图展示 火星坐标系)
    ///
    /// (若传入其他坐标系 请参看 CLLocation+Extension 文件的坐标系转换方法)
    /// - Parameters:
    ///   - viewController: 用于弹出当前alert
    ///   - targetLat:  纬度
    ///   - targetLong: 经度
    ///   - targetName: 目的地
    static func showMapsAlert(_ viewController: UIViewController ,
                              targetLat: Double,
                              targetLong: Double ,
                              targetName: String) {
        let alert = UIAlertController.init(title: "导航到\(targetName)", message:nil, preferredStyle: .actionSheet)
        for  mapType in MapType.openMaps {
            let action = UIAlertAction(title: mapType.Name, style: .default) { (_) in
                if mapType == .baiduMap {
                    let marsLoction = CLLocation(latitude: targetLat, longitude: targetLong)
                    let baiduLocation = marsLoction.locationBaiduFromMars()
                    openThirdMaps(baiduLocation.coordinate.latitude, baiduLocation.coordinate.longitude, targetName, mapType: mapType)
                }else {
                    openThirdMaps(targetLat, targetLong, targetName, mapType: mapType)
                }
            }
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// 打开第三方地图
    ///
    /// 请传入地图对应的坐标系
    /// - Parameters:
    ///   - targetLat: 纬度
    ///   - targetLong: 经度
    ///   - targetName: 目的地
    ///   - mapInfo: 地图类型
    static func openThirdMaps(_ targetLat: Double,
                              _ targetLong: Double,
                              _ targetName: String ,
                              mapType: MapType) {
        if mapType == .appleMap {
            openSystemMaps(targetLat, targetLong, targetName)
            return
        }
        guard let url = mapType.AssembleUrl(targetLat, targetLongitute: targetLong, toName: targetName),
            let openURL = URL(string: url) else {
                return
        }
        UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
    }
    
   
    /// 打开系统的apple地图
    ///
    /// - Parameters:     (火星坐标系)
    ///   - targetLat:   纬度
    ///   - targetLong:  经度
    ///   - targetName:  目的地名称
    static func openSystemMaps(_ targetLat: Double,
                               _ targetLong: Double,
                               _ targetName: String ) {
        let currentItem = MKMapItem.forCurrentLocation()
        currentItem.name = "我的位置"
        let toLoction = CLLocationCoordinate2DMake(targetLat, targetLong)
        let toItem = MKMapItem(placemark: MKPlacemark(coordinate:toLoction, addressDictionary: nil))
        toItem.name = targetName
        let items = [currentItem,toItem]
        let options :[String : Any] = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey:true]
        if !MKMapItem.openMaps(with: items, launchOptions: options){
            print("打开失败")
        }
    }
}


