//
//  ViewController.m
//  OpenGLBug
//
//  Created by Rob Phillips on 12/23/15.
//  Copyright © 2015 GMaps Bugs. All rights reserved.
//

#import "ViewController.h"
#import "MapView.h"

static const CGFloat kGmapsMapHeight = 200.f;

@interface ViewController ()
@property (nonatomic) MapView *mapView;
@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // TODO: Be sure to update this API key and change the app's bundle ID to match the API key's underlying value per the Gmaps instructions
    [GMSServices provideAPIKey:@""];

    [self setupView];
}

#pragma mark - View Setup

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.tintColor = [UIColor redColor];

    UIButton *showNow = [[UIButton alloc] initWithFrame:CGRectMake(0.f, kGmapsMapHeight + 10.f, self.view.bounds.size.width, 50.f)];
    [showNow setTitle:@"Show Map In Foreground" forState:UIControlStateNormal];
    [showNow setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [showNow addTarget:self action:@selector(showMapImmediately) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showNow];

    UIButton *showLater = [[UIButton alloc] initWithFrame:CGRectMake(0.f, showNow.frame.origin.y + showNow.frame.size.height + 10.f, self.view.bounds.size.width, 50.f)];
    [showLater setTitle:@"Show Map In Background" forState:UIControlStateNormal];
    [showLater setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [showLater addTarget:self action:@selector(showHint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showLater];

    [self showMapOnceBackgrounded];
}

#pragma mark - Actions

- (IBAction)removeMap
{
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

- (IBAction)showHint
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Bug" message:@"Background the app now and we'll notify you when it's time to foreground the app to see the bug." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)showMapImmediately
{
    if (self.mapView) {
        [self removeMap];
    }

    self.mapView = [[MapView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, kGmapsMapHeight)];
    [self.view addSubview:self.mapView];
}

- (IBAction)showMapOnceBackgrounded
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].applicationState != UIApplicationStateBackground) {
            [self showMapOnceBackgrounded];
            return;
        }

        [self showMapImmediately];
        [self notifyToRelaunchApp];
    });
}

#pragma mark - Notifications

- (void)notifyToRelaunchApp
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.05];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.alertBody = @"Map Added; Relaunch app to view blank map.";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
