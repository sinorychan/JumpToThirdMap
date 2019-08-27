//
//  ViewController.swift
//  XYJumpToThirdMap
//
//  Created by chan on 2019/8/27.
//  Copyright © 2019 BJMHBT. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let lat : Double = 39.904961
    let long: Double = 116.427106
    let name : String = "北京站"
    
    lazy var button1 : UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.setTitle("导航", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()
    
    lazy var button2 : UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 180, height: 50))
        button.setTitle("百度地图导航", for: .normal)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(toBaiduMap), for: .touchUpInside)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(button1)
        view.addSubview(button2)
        
        
    }

    //alert 列表展示
    @objc func showAlert() {
        MapNavigation.showMapsAlert(self,
                                    targetLat: lat,
                                    targetLong: long,
                                    targetName: name)
    }
    
    
    //单个地图用法展示
    @objc func toBaiduMap() {
        //将火星坐标转化为百度坐标
        let baiduLocation = CLLocation(latitude: lat, longitude: long).locationBaiduFromMars()
        //调用百度地图
        if MapType.baiduMap.canOpen { //判断是否能打开 或者安装了 百度地图
            MapNavigation.openThirdMaps(baiduLocation.coordinate.latitude, baiduLocation.coordinate.longitude, name, mapType: .baiduMap)
        }else {
            print("打开失败")
        }
    }
    
}

