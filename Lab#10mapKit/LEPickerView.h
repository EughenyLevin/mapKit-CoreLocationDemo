//
//  LEPickerView.h
//  Lab#10mapKit
//
//  Created by Evgheny on 12.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LEPickerView : NSObject<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong,nonatomic) UIPickerView*pickerView;
@property (strong,nonatomic) UITextField *textField;

-(void)startController;

@end
