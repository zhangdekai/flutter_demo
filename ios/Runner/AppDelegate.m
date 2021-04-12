#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@interface AppDelegate ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) FlutterMethodChannel *methodChannl;


@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    

    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

//********************************
#pragma mark - 使用flutter 三方库 image_picker 来换头像
// 2: 使用flutter 三方库 image_picker 来换头像。
// 1: 使用原生flutter 和 原生iOS 通信的方式 相册打开的方法，换头像
- (void)useFlutterNativeMethodToChangePhotoes {
    //获取APP VC
    FlutterViewController *vc = (FlutterViewController *)self.window.rootViewController;
    
    //显示相册
    self.methodChannl = [FlutterMethodChannel methodChannelWithName:@"mine_page" binaryMessenger:vc];
    
    UIImagePickerController *pickerVC =  [[UIImagePickerController alloc]init];
    pickerVC.delegate = self;
    
    //获取flutter 发来的消息
    [self.methodChannl setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqualToString:@"picture"]) {
            NSLog(@"argument:%@",call.arguments);
        
            
            [vc presentViewController:pickerVC animated:YES completion:nil];
        }
    }];
    
    NSLog(@"%@:",self.window.rootViewController);

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString *imagePath = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        //给flutter 发消息 传参数
        [self.methodChannl invokeMethod:@"imagePath" arguments:imagePath];
    }];
}

@end
