# ekyc-ios
Welcome to the ekyc-ios wiki!

# Dependencies

##### Installation system: [Cocoapods](https://cocoapods.org).

## Library name: 
> 
> pod 'MisFitSDK', '1.1.17'
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


# How to use

### Intial SDK in every class like this
>
> import MisFitSDK

* For Production initialize object this way

`    let ekyc = EkycMisfit(token: self.token)`

* For Non Production initialize object this way

`    let ekyc = EkycMisfitNonprod(token: self.token)`

**Send image as string base64 for all api**

> ### For NRC/OCR Detect Using Ekyc api
Use this way to get NRC/OCR details
```
ekyc.get_cardinfo(media1: base64String, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
    print(jsonData ?? "nil")
}
```
**Example** 

If everything ok then you will get response like this

```
{"json":{"success":true,"data":{"side":"front","nrc_id":{"mm":"၁၂\/လမန(နိုင်)၁၅၃၈၈၃","en":"12\/LaMaNa(N)153883"},"issue_date":{"mm":"၂၃.၂.၂၀၁၇","en":"23.2.2017"},"name":{"mm":"မောင်ကျော်လှိုင်ဘွား","en":"Mg Kyaw Hlaing Bwar"},"fathers_name":{"mm":"ဦးမောင်မောင်ကောင်","en":"U Maung Maung Kaung"},"birth_date":{"mm":"၁၅.၁၂.၁၉၉၇","en":"15.12.1997"},"religion":{"mm":"တရုတ်၊ဗုဒ္ဓဘာသာ","en":"Chinese ၊Buddhism "},"height":{"mm":"၅'၈\"","en":"5'8\""},"blood_group":{"mm":"အို","en":"O"}},"ref_id":132558054,"status_code":200}}
```

If image is not a NRC or not supported then you will get this

````
{"json":{"error":{"message":"The image is not supported \/ unreadable by OCR"},"success":false,"ref_id":132555588,"status_code":422}}
````

***


> ### For NRC/OCR details with detect layer Using Ekyc api

Use this way to get NRC/OCR details with detect layer

```
ekyc.get_cardinfo_with_face(media1: base64String, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
    print(jsonData ?? "response = nil")
}
```
**Example** 

If everything ok then you will get response like this

```
{"json":{"success":true,"data":{"side":"front","nrc_id":{"mm":"၁၂\/လမန(နိုင်)၁၅၃၈၈၃","en":"12\/LaMaNa(N)153883"},"issue_date":{"mm":"၂၃.၂.၂၀၁၇","en":"23.2.2017"},"name":{"mm":"မောင်ကျော်လှိုင်ဘွား","en":"Mg Kyaw Hlaing Bwar"},"fathers_name":{"mm":"ဦးမောင်မောင်ကောင်","en":"U Maung Maung Kaung"},"birth_date":{"mm":"၁၅.၁၂.၁၉၉၇","en":"15.12.1997"},"religion":{"mm":"တရုတ်၊ဗုဒ္ဓဘာသာ","en":"Chinese ၊Buddhism "},"height":{"mm":"၅'၈\"","en":"5'8\""},"blood_group":{"mm":"အို","en":"O"}},"ref_id":132558054,"status_code":200}}
```

If image is not a NRC or not supported then you will get this

````
{"success":false,"message":"The image is not supported \/ unreadable by OCR","status_code":406}
````

***


> ### For NRC Side detect
```
ekyc.get_cardside(media1: base64String) { jsonData in
    print(jsonData ?? "nil")
}
```
**Example** 

If everything ok then you will get response like this

```
{"json":{"type":"front","success":true,"ref_id":132165790}}
```

If image is not a NRC or not supported then you will get this

````
{"json":{"type":"not_recognized","success":false,"ref_id":132165795}}
````

***


> ### For Facial liveness detection**
```
ekyc.get_face_detect(File: filee) { jsonData in
    print(jsonData ?? "nil")
}
```
or
```
ekyc.get_face_detect(String: base64String) { jsonData in
    print(jsonData ?? "nil")
}
```
**Example** 

If everything ok then you will get response like this

```
{"json":{"id":30,"code":0,"message":"OK","data":{"userId":563,"requestId":14755,"imageId":null,"createdAt":"2022-03-15T11:07:00.902Z","label":"LIVE","confidence":0.9999532699584961,"framesProcessed":1,"processingTime":0.5489649772644043,"faces":[{"label":"LIVE","liveConfidence":0.9999532699584961,"spoofConfidence":4.6744109567953274E-5}]},"timestamp":"2022-03-15T11:07:00.902Z"}}
```

If image is not a NRC or not supported then you will get this

````
 {"json":{"id":31,"code":8030,"message":"No face detected","data":"500 INTERNAL SERVER ERROR: [{\"code\": 1, \"message\": \"No face detected\", \"payload\": {\"label\": null, \"confidence\": null, \"frames_processed\": null, \"processing_time\": null, \"faces\": null}}\n]","timestamp":"2022-03-15T11:08:57.698Z"}}
````

***

> ### For Facial Comparison
```
ekyc.get_face_comparison(File1: file1, File2: file2, File2Tpe: "nrc") { jsonData in
    print(jsonData ?? "nil")
}
```
or
```
ekyc.get_face_comparison(String1: base64String1, String2: base64String2, Image2Type: "nrc") { jsonData in
    print(jsonData ?? "nil")
}
```
**Example** 

If everything ok then you will get response like this

```
{"json":{"id":33,"code":0,"message":"OK","data":{"userId":563,"requestId":14760,"imageId":null,"createdAt":"2022-03-15T11:12:32.542Z","label":"LIVE","confidence":0.9999364614486694,"framesProcessed":1,"processingTime":0.3569798469543457,"faces":[{"label":"LIVE","liveConfidence":0.9999364614486694,"spoofConfidence":6.353484786814079E-5}]},"timestamp":"2022-03-15T11:12:32.542Z"}}
```

If image is not a NRC or not supported then you will get this

````
{"json":{"id":32,"code":8020,"message":"Face matching server error","data":"500 INTERNAL SERVER ERROR: [{\"code\": 1, \"message\": \"No face found in the 1st image\", \"payload\": {\"label\": null, \"confidence\": null, \"distance\": null, \"processing_time\": null}}\n]","timestamp":"2022-03-15T11:11:20.445Z"}}
````

***

> ### For Passport detection

****Send base64 string for image

````
ekyc.get_passportdetails(media1: base64String, check_expiry: false, check_age: false) { jsonData in
    print(jsonData ?? "response = nil")
}
````

**Example** 

If everything ok then you will get response like this

```
{"json":{"data":{"country_code":"MMR","surname":"KYAW","given_name":"HLAING BWAR","passport_number":"MC309646","date_of_birth":"1997-12-15","sex":"M","date_of_expiry":"2022-08-16","machine_code":"PEMMRKYAW<HLAING<BWAR<<<<<<<<<<<<<<<<<<<<<<<","machine_code2":"MC309646<2MMR9712157M2208165<<<<<<<<<<<<<<<4"},"success":true}}
```

If image is not a passport or not supported then you will get this

````
{"json":{"error":{"message":"The image is not supported \/ unreadable by OCR"},"success":false}}
````

***

> ### For MM NRC with face detection method

Use this way to get MM NRC with face detection

```
ekyc.get_cardinfo_with_face(media1: base64String, cbm: false, filter: true, source: "other", check_age: false) { jsonData in
    print(jsonData ?? "response = nil")
}
```

> ### For passport with face detection method

Use this way to get passport with face detection

```
ekyc.get_passportinfo_with_face(media1: base64String, source: "other", check_age: false) { jsonData in
    print(jsonData ?? "response = nil")
}
```


## Error code 
| Code | Description |
| --- | --- |
| 200 | OK |
| 400 | Image parameter not present |
| 401 | Wrong auth token |
| 403 | If age < 18 |
| 406 | Invalid image |
| 417 | If length of digit number of nrc_id not equal to 6 |
| 418 | If region code of nrc_id not in between 1 to 14 |
| 419 | If township code of nrc_id not matches the region |
| 422 | Unprocurable entity |
| 500 | Other exceptions except invalid image |
| 502 | Bad gateway/server may be down |
