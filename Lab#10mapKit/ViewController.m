//
//  ViewController.m
//  Lab#10mapKit
//
//  Created by Evgheny on 12.12.16.
//MapKit - Компонент выбора региона, на карте либо с указанием его через UIPickerView, делается аналогичено HeightController

//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LEPickerView.h"
#import "LEAnntotationView.h"
#import "UIView+LECurrentAnnotationView.h"

typedef enum{
    LENewYorKChoosen,
    LEBerlinChoosen,
    LELondonChoosen,
    LEPekinChoosen,
    
}LECityEnum;

@interface ViewController ()<UITextFieldDelegate,MKMapViewDelegate>
{
    MKCircle *circle;
}
@property (weak, nonatomic) IBOutlet UISwitch *swtcher;

@property (weak, nonatomic)  IBOutlet MKMapView *mapView;
@property (weak, nonatomic)  IBOutlet UITextField *textField;
@property (strong,nonatomic) LEPickerView *pickerView;
@property (assign,nonatomic) LECityEnum chosenCity;
@property (strong,nonatomic) LEAnntotationView *anView;
@property (strong,nonatomic) NSMutableArray *annotationsArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerView = [LEPickerView new];
    _pickerView.textField = self.textField;
    [_pickerView startController];
    self.mapView.alpha = 0.1;
    _anView = [LEAnntotationView new];
    [self.swtcher addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllTouchEvents];
    //////////////////////
    

    
}

-(void)addAnnotations{
    LEAnntotationView *secondAnView = [LEAnntotationView new];
    secondAnView.title = @"NTestTitle";
    secondAnView.subtitle = [NSString stringWithFormat:@"date: %@",[NSDate date]];
    secondAnView.coordinate = self.mapView.region.center;
    [self.mapView addAnnotation:secondAnView];
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onPayTouch:)];
    tap.numberOfTapsRequired = 1;
    static NSString *viewID = @"id";
    UIImage *iconView = [UIImage new];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 32, 32)];
    [imageView setUserInteractionEnabled:YES];
    MKAnnotationView *anView = [mapView dequeueReusableAnnotationViewWithIdentifier:viewID];
    if (!anView) {
        anView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:viewID];
        anView.draggable = NO;
        anView.canShowCallout = YES;
        imageView.image = [UIImage imageNamed:@"PicturePay.png"];
        anView.leftCalloutAccessoryView = imageView;
        iconView = [UIImage imageNamed:@"aeroplane.png"];
        anView.image = iconView;
        [imageView addGestureRecognizer:tap];
        UIButton *buyAction = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [buyAction addTarget:self action:@selector(onBuyAction:) forControlEvents:UIControlEventTouchDown];
        anView.rightCalloutAccessoryView = buyAction;
    }
    else  anView.annotation = annotation;
    return anView;
    
}

-(MKOverlayView*)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{
    MKOverlayView *view = nil;
    MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:circle];
    
    circleView.fillColor = [UIColor greenColor];
    circleView.strokeColor = [UIColor blackColor];
    circleView.lineWidth = 5.;
    
    circleView.alpha = 0.5;
    
    view = circleView;
    return view;
}



#pragma mark ciry choose byComponent
- (IBAction)onCityChoosed:(id)sender {
    
    for (id <MKAnnotation> anotation in self.annotationsArray) {
        [self.mapView removeAnnotation:anotation];
    }
    
    if ([self.textField.text isEqualToString:@"London"]) {
        _chosenCity = LELondonChoosen;
        [self setAnnotationForCity:self.chosenCity];

    }
    if ([self.textField.text isEqualToString:@"New York"]) {
        _chosenCity = LENewYorKChoosen;
        [self setAnnotationForCity:self.chosenCity];

    }
    if ([self.textField.text isEqualToString:@"Berlin"]) {
        _chosenCity = LEBerlinChoosen;
        [self setAnnotationForCity:self.chosenCity];

    }
    if ([self.textField.text isEqualToString:@"Pekin"]) {
        _chosenCity = LEPekinChoosen;
        [self setAnnotationForCity:self.chosenCity];

    }
    NSLog(@"ChoosedEnum = %@",self.anView.title);
     NSLog(@"%@",self.textField.text);
    self.mapView.alpha = 1;
}
-(void)setAnnotationForCity:(LECityEnum)city{
    
    static NSInteger radius = 10000;
    [self.mapView removeAnnotations:self.annotationsArray];
    switch (city) {
        case 0:
            self.anView.title = @"New York";
            self.anView.subtitle = [self dateForFlight];
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(40.73, -73.93);
            self.anView.coordinate = coordinate;
            circle = [MKCircle circleWithCenterCoordinate:coordinate radius:radius];
            [self.mapView addOverlay:circle];
            [self.mapView addAnnotation:self.anView];
            break;
        case 1:
            self.anView.title = @"Berlin";
            self.anView.subtitle = [self dateForFlight];
            CLLocationCoordinate2D coordinateBerlin = CLLocationCoordinate2DMake(52, 13);
            self.anView.coordinate = coordinateBerlin;
            circle = [MKCircle circleWithCenterCoordinate:coordinateBerlin radius:radius];
            [self.mapView addOverlay:circle];
            break;
        case 2:
            self.anView.title = @"London";
            self.anView.subtitle = [self dateForFlight];
            CLLocationCoordinate2D coordinateLondon = CLLocationCoordinate2DMake(51.5, 0.0);
            self.anView.coordinate = coordinateLondon;
            circle = [MKCircle circleWithCenterCoordinate:coordinateLondon radius:radius];
            [self.mapView addOverlay:circle];
            break;
        case 3:
            self.anView.title = @"Pekin";
            self.anView.subtitle = [self dateForFlight];
            CLLocationCoordinate2D coordinatePekin = CLLocationCoordinate2DMake(39.9, 116.3);
            self.anView.coordinate = coordinatePekin;
            circle = [MKCircle circleWithCenterCoordinate:coordinatePekin radius:radius];
            [self.mapView addOverlay:circle];
            break;
        default:
            break;
    }
    [self.mapView addAnnotation:self.anView];
    [self zoomOnMapRect];
}

-(void)zoomOnMapRect{
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint point = MKMapPointForCoordinate(location);
        static double delta = 20000;
        MKMapRect mapRect = MKMapRectMake(point.x-delta, point.y-delta, 200000,200000);
        zoomRect = MKMapRectUnion(zoomRect, mapRect);
    }
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(270, 270, 270, 270) animated:YES];
}

#pragma mark showCity's onClick
-(void)valueChanged:(UISwitch*)sender{
    
    for (id <MKAnnotation> anotation in self.annotationsArray) {
        [self.mapView removeAnnotation:anotation];
    }
    NSLog(@"Value changed!");
    if (sender.on == 1) {
        _annotationsArray = [NSMutableArray array];
        self.mapView.alpha = 1;
        NSArray *city      = @[@"New York",@"Berlin",@"London",@"Pekin"];
      
        NSArray *latitude  = [NSArray arrayWithObjects:
                              [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(40.73, -73.93)],
                              [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(52,     13)],
                              [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(51.5,   1.0)],
                              [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(39.9,  116.3)],nil];


        
        NSLog(@"%ld",[latitude count]);
        for (int i = 0; i<4; i++) {
            LEAnntotationView *secondAnView = [LEAnntotationView new];
           secondAnView.title = [city objectAtIndex:i];
             secondAnView.subtitle = @"";
            NSValue *coordinateValue = [latitude objectAtIndex:i];
            secondAnView.coordinate = [coordinateValue MKCoordinateValue];
        
            [self.annotationsArray addObject:secondAnView];
        }
        
        [self showMarkers];
        [self zoomOnMapRect];
    }
    
    
    
}

-(void)showMarkers{
    
    [self.mapView removeAnnotations:self.annotationsArray];
    NSLog(@"Annotations = %ld",self.annotationsArray.count);
    for (id <MKAnnotation> anotation in self.annotationsArray) {
        
        [self.mapView addAnnotation:anotation];
        
    }
    
}

-(void)showAllAnnotation{

    for (id <MKAnnotation> anotation in self.annotationsArray) {
    
    [self.mapView addAnnotation:anotation];
}
}


-(void)mapView:(MKMapView*)mapView didAddAnnotationViews:(nonnull NSArray*)annotations{
    
    for (MKAnnotationView *annotationView in annotations)
    {
        
        if ([annotationView.annotation isKindOfClass:[MKUserLocation class]])
        {
            continue;
        }
        
        MKMapPoint point =  MKMapPointForCoordinate(annotationView.annotation.coordinate);
        
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point))
        {
            continue;
        }
        
        
        CGRect endFrame = annotationView.frame;
        
        annotationView.frame = CGRectMake(annotationView.frame.origin.x,
                                          annotationView.frame.origin.y - self.view.frame.size.height,
                                          annotationView.frame.size.width,
                                          annotationView.frame.size.height);
        
        [UIView animateWithDuration:0.7f
                              delay:0.05f * [annotations indexOfObject:annotationView]
                            options: UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             annotationView.frame = endFrame;
                             
                         }completion:^(BOOL finished){
                             
                             if (finished)
                             {
                                 [UIView animateWithDuration:0.05f
                                                  animations:^{
                                                      
                                                      annotationView.transform = CGAffineTransformMakeScale(1.0, 0.8);
                                                      
                                                  }
                                                  completion:^(BOOL finished){
                                                      
                                                      if (finished)
                                                      {
                                                          [UIView animateWithDuration:0.1f
                                                                           animations:^{
                                                                               
                                                                               annotationView.transform = CGAffineTransformIdentity;
                                                                           }];
                                                      }
                                                  }];
                             }
                         }];
    }
    
    
}

-(void)onBuyAction:(UIButton*)sender{
    
    MKAnnotationView *anView = [sender currentView];
    NSString *destination = anView.annotation.title;
    double cost;
    
    switch (self.chosenCity) {
        case 0:
            cost = 529.9;
            break;
        case 1:
            cost = 289.1;
            break;
        case 2:
            cost = 329.9;
            break;
        case 3:
            cost = 6101.2;
            break;
        default:
            cost = 0.0;
            break;
    }

    NSString *message = [NSString stringWithFormat:@"Destination: %@\n Cost: %f",destination,cost];
    [[[UIAlertView alloc]initWithTitle:@"Ticket order"
                         message: message
                         delegate:self
                   cancelButtonTitle:@"Order"
                    otherButtonTitles:@"Cancel", nil]show];
    
    
    
    NSLog(@"%@",anView.annotation.title);
}

-(void)onPayTouch:(UIImageView*)view{
   
   // MKAnnotationView *anView = [view currentView];
    
    
}

-(NSString*)dateForFlight{
    
    NSString *dateString = nil;
    NSInteger interval =1000000;
    NSInteger numb = arc4random()%interval;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:numb];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy/MMM/dd EE hh:mm"];
    dateString = [NSString stringWithFormat:@"%@",[df stringFromDate:date]];
    return dateString;
}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
