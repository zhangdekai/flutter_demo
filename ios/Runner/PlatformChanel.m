//
//  PlatformChanel.m
//  Runner
//
//  Created by zhang dekai on 2024/2/28.
//

#import "PlatformChanel.h"
#import "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>

@interface PlatformChanel()

@property (nonatomic, strong) FlutterMethodChannel *methodChannl;
@property (nonatomic, strong) FlutterViewController *mainvc;


@end

const NSString *methodChanelName = @"method_channel_trigger_name";

@implementation PlatformChanel



- (void)registeChannel:(FlutterViewController *) mainVC{
    
    self.mainvc = mainVC;
    
    self.methodChannl = [FlutterMethodChannel methodChannelWithName:methodChanelName binaryMessenger:mainVC];
    
//    [self.methodChannl ]

    
    
}

- (FlutterMethodCall *)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult *)result {
 
    if ([call.method isEqualToString:@"my_method"]) {
    NSString *param1 = call.arguments[@"param1"];
    // ...
    result(@{@"result": @"value"});
  } else {
    result(FlutterMethodNotImplemented);
  }
  return nil;
}



@end
