### Flutter分享到 Reddit & SnapChat

不接入reddit and snapchat SDK, 主要采用系统分享和 scheme URL 跳转到对应平台。

安卓： 主要采用 Intent `context.startActivity(shareIntent);`分享

iOS：采用scheme URL（使用 `UIApplication.shared.open()`）和 `UIActivityViewController` 系统弹窗

```
安卓：
 
private final String REDDIT_PACKAGE = "com.reddit.frontpage";
private final String SNAPCHAT_PACKAGE = "com.snapchat.android";
```

```
iOS：

urlSchema = "https://www.reddit.com/submit?text=\(content)&url=\(fileUrl)"

snapchat 采用 UIActivityViewController

```

#### iOS ：UIActivityViewController

```
public func shareToSystem(args : [String: Any?],result: @escaping FlutterResult, excludedTypes : [UIActivity.ActivityType] = []) {
        let text = args[argMessage] as? String
        let filePaths = args[argImagePaths] as? [String]
        var data : [Any] = [text!];
        if filePaths != nil{
            for filePath in filePaths!{
                data.append(URL(fileURLWithPath: filePath))
            }
        }
        let videoPath = args[argVideoFile] as? String
        if(videoPath != nil){
            data.append(URL(fileURLWithPath: videoPath!))
        }

        let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = excludedTypes
        
        UIApplication.topViewController()?.present(activityViewController, animated: true, completion: nil)
        
        result(SUCCESS)
    }
```

#### iOS： UIApplication.shared.open

```
func shareToReddit(args : [String: Any?],result: @escaping FlutterResult) {
        
        let text = args[argMessage] as? String
        
        var urlSchema = "https://www.reddit.com"
        
        if let content = text {
        
            urlSchema = "https://www.reddit.com/submit?text=\(content)"
            
//            let imagePaths = args[argImagePaths] as? [String]
//            if let images = imagePaths, !images.isEmpty, let image = images.first {
//                /// &url=\(imageUrl) :  imageUrl must be network url, it canbe load image in Reddit submit post Page in ios.
//                urlSchema = "https://www.reddit.com/submit?text=\(content)&url=\(image)"
//            }
        } else {
            result(ERROR)
        }
        
        launchURL(hookUrl: urlSchema, result: result)
                
    }
    
    func launchURL(hookUrl: String, result: @escaping FlutterResult) {
        if let urlString = hookUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let url = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                    result(SUCCESS)
                } else {
                    result(ERROR_APP_NOT_AVAILABLE)
                }
            }
        }
        
    }
```
