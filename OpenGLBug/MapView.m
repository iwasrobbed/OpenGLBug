//
//  MapView.m
//  OpenGLBug
//
//  Created by Rob Phillips on 12/23/15.
//  Copyright © 2015 GMaps Bugs. All rights reserved.
//

#import "MapView.h"

@interface MapView ()
@property (nonatomic) GMSMapView *mapView;
@end

@implementation MapView

#pragma mark - Lifecycle

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupMapView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupMapView];
    }
    return self;
}

#pragma mark - View Setup

- (void)setupMapView
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:37.429167 longitude:-122.138056];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:12];
    self.mapView = [GMSMapView mapWithFrame:self.bounds camera:camera];
    self.mapView.buildingsEnabled = NO;
    self.mapView.myLocationEnabled = YES;

    self.mapView.settings.indoorPicker = NO;
    self.mapView.settings.consumesGesturesInView = NO;

    self.mapView.settings.scrollGestures = YES;
    self.mapView.settings.rotateGestures = NO;
    self.mapView.settings.tiltGestures = NO;
    self.mapView.settings.zoomGestures = NO;

    [self.mapView setMinZoom:3.0 maxZoom:16.0];
    [self addSubview:self.mapView];
}

@end
