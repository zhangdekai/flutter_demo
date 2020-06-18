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
    
    
    //获取APP VC
    FlutterViewController *vc = (FlutterViewController *)self.window.rootViewController;
    
    //显示相册
    self.methodChannl = [FlutterMethodChannel methodChannelWithName:@"mine_page" binaryMessenger:vc];
    
    UIImagePickerController *pickerVC =  [[UIImagePickerController alloc]init];
    pickerVC.delegate = self;
    
    [self.methodChannl setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqualToString:@"picture"]) {
            NSLog(@"argument:%@",call.arguments);
        
            
            [vc presentViewController:pickerVC animated:YES completion:nil];
        }
    }];
    
    NSLog(@"%@:",self.window.rootViewController);

    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString *imagePath = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        
        [self.methodChannl invokeMethod:@"imagePath" arguments:imagePath];
    }];
}

@end
