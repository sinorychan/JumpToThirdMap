# JumpToThirdMap
跳转到第三方地图 （百度 谷歌 腾讯 高德 苹果）
    ///  打开第三方地图alert (已检测是否安装第三方地图 未安装不在弹出视图展示 火星坐标系)
    ///
    /// (若传入其他坐标系 请参看 CLLocation+Extension 文件的坐标系转换方法)
    /// - Parameters:
    ///   - viewController: 用于弹出当前alert
    ///   - targetLat:  纬度
    ///   - targetLong: 经度
    ///   - targetName: 目的地

         MapNavigation.showMapsAlert(self,
                                    targetLat: lat,
                                    targetLong: long,
                                    targetName: name)


 
        //调用百度地图
        if MapType.baiduMap.canOpen { //判断是否能打开 或者安装了 百度地图
            MapNavigation.openThirdMaps(baiduLocation.coordinate.latitude, baiduLocation.coordinate.longitude, name, mapType: .baiduMap)
        }else {
            print("打开失败")
        }

     地图坐标转换工具   CLLocation+Extension.swift
