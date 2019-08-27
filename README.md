# JumpToThirdMap
跳转到第三方地图 （百度 谷歌 腾讯 高德 苹果） 及 坐标转换工具  CLLocation+Extension.swift

   
    info.plist 文件添加
   	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>comgooglemaps</string>
		<string>iosamap</string>
		<string>qqmap</string>
		<string>baidumap</string>
	</array>

    ///  打开第三方地图alert (已检测是否安装第三方地图 未安装不在弹出视图展示 火星坐标系)
    ///
    ///  (若传入其他坐标系 请参看 CLLocation+Extension 文件的坐标系转换方法)
    /// - Parameters:
    ///   - viewController: 用于弹出当前alert
    ///   - targetLat:  纬度 （火星坐标系）
    ///   - targetLong: 经度  火星坐标系）
    ///   - targetName: 目的地

         MapNavigation.showMapsAlert(self,
                                    targetLat: lat,
                                    targetLong: long,
                                    targetName: name)

       //将火星坐标转化为百度坐标 
       let baiduLocation = CLLocation(latitude: lat, longitude: long).locationBaiduFromMars()
 
        //调用百度地图
        if MapType.baiduMap.canOpen { //判断是否能打开 或者安装了 百度地图
            MapNavigation.openThirdMaps(blat, long, name, mapType: .baiduMap)
        }else {
            print("打开失败")
        }

 
