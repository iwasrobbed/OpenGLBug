//
//  MapView.h
//  OpenGLBug
//
//  Created by Rob Phillips on 12/23/15.
//  Copyright © 2015 GMaps Bugs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMapsM4B/GMSMapView.h"

@interface MapView : UIView

/**
 *  Underlying map instance
 */
@property (nonatomic, readonly) GMSMapView *map;

@end
