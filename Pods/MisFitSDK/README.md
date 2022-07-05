# ekyc-ios
Welcome to the ekyc-ios wiki!

# Dependencies

##### Installation system: [Cocoapods](https://cocoapods.org).

## Library name: 
> 
> pod 'MisFitSDK', '1.1.4'
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

- For Production initialize object this way
> let ekyc = EkycMisfit(token: self.token)

- For Non Production initialize object this way
> let ekyc = EkycMisfitNonprod(token: self.token)

- NRC INFO
```
ekyc.get_cardinfo(media1: img, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
     print(jsonData)
     // Process the data here
}
```

- NRC SIDE INFO
```
ekyc.get_cardside(media1: img) { jsonData in
     print(jsonData)
     // Process the data here
}
```

- NRC INFO WITH LAYER
```
ekyc.get_cardinfo_with_layer(media1: UIImage(named: "NRC")) { jsonData in
  print(jsonData ?? "nil")
}
```

- FACE DETECT
```
ekyc.get_face_detect(media1: img) { jsonData in
     print(jsonData)
     // Process the data here
}
```

- FACE COMPARE
```
ekyc.get_face_comparison(media1: img1, media2: img2) { jsonData in
     print(jsonData)
     // Process the data here
}
```

- PASSPORT DETAILS      
```
ekyc.get_passportdetails(media1: img, check_expiry: false, check_age: false) { jsonData in
     print(jsonData)
     // Process the data here
}
```

