# ekyc-ios
Welcome to the ekyc-ios wiki!

# Dependencies

##### Installation system: [Cocoapods](https://cocoapods.org).

## Library name: 
> 
> pod 'MisFitSDK', '1.1.3'
> 

## Terminal:
> pod install
> 
> Open ProjectName.xcworkspace
> 
> Done

## Installation system: [XCode Package Dependencies](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).
![Step 1](https://lh6.googleusercontent.com/B07C9LWkDXuLeTs-m55ZRfAKSochbHIuiFbFX2lIE8ZHEW1E7EoFsgQwohbo62-EF5ZsqT4jmb18BNJ1STpqlqSafU4SOMy1dwTuLr8jyVxWPKiMrBTCnfKj4IrDVCqw6w1Pbq8G)
![Step 2](https://lh5.googleusercontent.com/K22To8Z8IcrMdn8fxoDe7D1GAplZ4zQJfK8YBC5rSLjuZBcVJHIurkqdGfV84Gl0EJxzsNFB78To0v9F_LVvQAeYWiPl1ahfs8o1l2-CRs-utveTsWTwse6oPNr7Zy7TrD0P2Emq)

## How To Use

#### Intial SDK for every class like this

>
> import MisFitSDK

- For NRC Side detect
```
let apiNRCDetectApi = NRCDetectApi()
apiNRCDetectApi.apiRequestForNRCDetect(media1: UIImage(named: "NRC") ?? nil) { jsonData in
        print(jsonData)
}
```

- For NRC Details
```
let apiNRCDetailsApi = NRCDetailsApi()
apiNRCDetailsApi.apiRequestForNrcCDetails(media1: UIImage(named: "NRC") ?? nil) { jsonData in
    if jsonData == nil {
        print("NRC Details : error found.")
    }
    else {
        print(jsonData)
    }
}
```

- For Facial liveness detection**
```
let apiFaceDetectApi = FaceDetectApi()
apiFaceDetectApi.apiRequestForFaceDetect(media1: UIImage(named: "NRC") ?? nil) { jsonData in
    if jsonData == nil {
        print("Error: Found Nil.")
    }
    else {
        print(jsonData)
    }
}
```

- For Facial Comparison
```
let faceCompareAPIEngine = FaceCompareApi()
faceCompareAPIEngine.apiRequestForMatchCompare(
    media1: UIImage(named: "SELFI")!,
    fileName1: "image1",
    media2: UIImage(named: "NRC")!,
    fileName2: "image2") { (retValue) in
        print(retValue ?? "nil")
    }
```

- For Passport detection
```
let apiPassportDetailsApi = PassportDetailsApi()
apiPassportDetailsApi.apiRequestForPassportDetails(media1: UIImage(named: "Passport") ?? nil) { jsonData in
    if jsonData == nil {
        print("Passport Details : Found Nil.")
    }
    else {
        print(jsonData)
    }
}
```

