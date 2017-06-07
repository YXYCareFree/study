//
//  ViewController.m
//  Location
//
//  Created by beyondSoft on 16/8/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(int, alertViewState) {

    alertViewDismiss,
    alertViewShow
};

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;

@property (nonatomic, assign) alertViewState alertState;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 60, 100, 100)];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(updateLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    _locationManager = [[CLLocationManager alloc] init];

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isFirstLaunch"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isFirstLaunch"];
    }
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] < 3) {

        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
    }
}

- (void)updateLocation{
    _locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    CLLocation * currentLocation = [locations lastObject];

    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    //根据经纬度得出当前城市信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {

        if (placemarks.count > 0) {
            CLPlacemark * placeMark = placemarks[0];

            if (placeMark.locality) {

//                NSLog(@"%@", placeMark.locality);
//               NSLog(@"%@", placeMark.administrativeArea);
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"test" message:placeMark.locality delegate:self cancelButtonTitle:@"11" otherButtonTitles: nil];
                [alert show];
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

    switch (status) {
            //用户第一次启动APP//用户拒绝授权
        case kCLAuthorizationStatusDenied:
            //未选择定位方式
        case kCLAuthorizationStatusNotDetermined:

        case kCLAuthorizationStatusRestricted:

           if (_alertState == alertViewDismiss){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"打开定位开关" message:@"定位服务未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许友鲸使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
            [alert show];
            _alertState = alertViewShow;
            NSLog(@"%s", __FUNCTION__);

           }
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSString * errorStr;
    switch (error.code) {
        case kCLErrorLocationUnknown:
            errorStr = @"无法定位当前位置";

            break;
       case kCLErrorNetwork:
            errorStr = @"网络错误";
            break;
            case kCLErrorDenied:
        { errorStr = @"当前应用未经授权";
            if (_alertState == alertViewDismiss) {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"打开定位开关" message:@"定位服务未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许友鲸使用定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开启", nil];
                [alert show];
                _alertState = alertViewShow;
                NSLog(@"%s", __FUNCTION__);

            }
         }
        default:
            break;
    }

    NSLog(@"****%@", errorStr);

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    }
    _alertState = alertViewDismiss;
}


@end
