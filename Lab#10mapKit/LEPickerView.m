//
//  LEPickerView.m
//  Lab#10mapKit
//
//  Created by Evgheny on 12.12.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "LEPickerView.h"

@interface LEPickerView (){
    
    NSMutableArray *dataArray;
}
@end

static NSInteger componentsNumb = 2;

@implementation LEPickerView

-(void)startController{
    
    dataArray = [NSMutableArray arrayWithObjects: @"London",@"New York",@"Berlin",@"Pekin",nil];
    _pickerView = [UIPickerView new];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _textField.inputView = self.pickerView;
    _textField.placeholder = @"Input the city";
    [self.pickerView reloadAllComponents];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    [toolBar setItems:[NSArray arrayWithObjects:doneButton, nil]];
    
    self.textField.inputAccessoryView = toolBar;
    
    //////////////////////
    
 
    
    
}



-(void)doneTouched:(id)sender{
   
    
    [self.textField resignFirstResponder];

}

#pragma mark - PickerSetup

-(NSArray*)leftComponents{
    
    NSArray *component = @[@"Destination"];
    return component;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return componentsNumb;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return  [[self leftComponents]count];
    }
    else return dataArray.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0 ) return [[self leftComponents]objectAtIndex:0];
    if (component == 1)  return [dataArray objectAtIndex:row];
    return 0;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==1) {
        //NSString *dataString =[dataArray objectAtIndex:row];
        self.textField.text = [dataArray objectAtIndex:row];
       /* if ([dataString isEqualToString:@"Berlin"]) {
            [self showMessage:@"Berlin" andTitle:@"Destination had been chosen"];
        }
        */
    }
}

-(void)showMessage:(NSString*)message andTitle:(NSString*)title{
    [[[UIAlertView alloc]initWithTitle:title message:message
                    delegate:nil
                     cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
}

@end
