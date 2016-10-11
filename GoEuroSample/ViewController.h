//
//  ViewController.h
//  GoEuroSample
//
//  Created by Ben Joe Mathews on 06/10/16.
//  Copyright © 2016 Ben Joe Mathews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

- (IBAction)TrainButton:(id)sender;
- (IBAction)BusButton:(id)sender;
- (IBAction)FlightButton:(id)sender;
- (IBAction)OfferButton:(id)sender;
- (IBAction)SortButton:(id)sender;
- (IBAction)RateButton:(id)sender;
- (IBAction)DepartureButton:(id)sender;
- (IBAction)ArrivalButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *HeadViewOutlet;

@property (weak, nonatomic) IBOutlet UIView *SliderViewOutlet;
@property (weak, nonatomic) IBOutlet UIButton *TrainButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *FlightButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *BusButtonOutlet;

@property (weak, nonatomic) IBOutlet UITableView *ListViewOutlet;
@property (weak, nonatomic) IBOutlet UIView *SortViewOutlet;

@property (weak, nonatomic) IBOutlet UIButton *RateButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *ArrivalButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *DepartureButonOutlet;
@property (weak, nonatomic) IBOutlet UIView *SortBackViewOutlet;

@end

