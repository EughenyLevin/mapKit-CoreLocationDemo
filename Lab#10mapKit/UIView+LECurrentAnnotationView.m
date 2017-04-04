//
//  UIView+LECurrentAnnotationView.m
//  Lab#10mapKit
//
//  Created by Evgheny on 12.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "UIView+LECurrentAnnotationView.h"
#import <MapKit/MapKit.h>
@implementation UIView (LECurrentAnnotationView)

-(MKAnnotationView*)currentView{
    
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView*)self;
    }
    else return [self.superview currentView];
    
}
@end
