//
//  LEAnntotationView.h
//  Lab#10mapKit
//
//  Created by Evgheny on 12.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface LEAnntotationView : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
