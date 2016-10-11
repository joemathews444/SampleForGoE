//
//  ListCell.h
//  GoEuroSample
//
//  Created by Ben Joe Mathews on 07/10/16.
//  Copyright © 2016 Ben Joe Mathews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *LogoOutlet;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *DepartureTimeLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *NoofStopsLAbelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *JourneyTime;

@end
