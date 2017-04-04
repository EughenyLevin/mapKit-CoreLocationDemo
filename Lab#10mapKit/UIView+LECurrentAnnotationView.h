//
//  UIView+LECurrentAnnotationView.h
//  Lab#10mapKit
//
//  Created by Evgheny on 12.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKAnnotationView;
@interface UIView (LECurrentAnnotationView)

-(MKAnnotationView*)currentView;

@end
