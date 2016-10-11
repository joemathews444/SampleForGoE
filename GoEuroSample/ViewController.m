//
//  ViewController.m
//  GoEuroSample
//
//  Created by Ben Joe Mathews on 06/10/16.
//  Copyright © 2016 Ben Joe Mathews. All rights reserved.
//

#import "ViewController.h"
#import "ListCell.h"

@interface ViewController ()
{
    int TrainFlag, BusFlag, FlightFlag, SortButtonFlag;
    NSMutableArray * ListArray, *BusListArray, *FlightListArray, *Samplearray, *ListArray1, *BusListArray1, *FlightListArray1;
    NSMutableDictionary *temp;
    NSString * imagestring, *dep, *totaljourneytime;
}

@end

@implementation ViewController

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TrainFlag = 1;
    BusFlag = 1;
    FlightFlag = 1;
    SortButtonFlag = 1;
    [self CallAPi];

    
    _RateButtonOutlet.layer.cornerRadius = 10;
    _RateButtonOutlet.layer.borderWidth = 2;
    _RateButtonOutlet.layer.borderColor = [UIColor redColor].CGColor;
    
    _DepartureButonOutlet.layer.cornerRadius = 10;
    _DepartureButonOutlet.layer.borderWidth = 2;
    _DepartureButonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _ArrivalButtonOutlet.layer.cornerRadius = 10;
    _ArrivalButtonOutlet.layer.borderWidth = 2;
    _ArrivalButtonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UITapGestureRecognizer *recognizer1;
    recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    recognizer1.numberOfTouchesRequired=1;
    [self.ListViewOutlet addGestureRecognizer:recognizer1];
    recognizer1.delegate = self;

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
             _SortViewOutlet.frame =  CGRectMake(1600, 0, 125, _SortViewOutlet.frame.size.width);
         } completion:nil];
     }completion:nil];
    [self.view endEditing:YES];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark User Defined Fuctions

// To Call the URL and parse the json file

-(void)CallAPi
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UIActivityIndicatorView *activityIndicator;
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge
                         ];
    activityIndicator.frame = CGRectMake(0.0, 0.0, 768.0, 1024.0);
    activityIndicator.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    activityIndicator.center = self.view.center;
    [self.view addSubview: activityIndicator];
    
    [activityIndicator startAnimating];
    
    
    
    
    if ( TrainFlag == 1)
    {
        dispatch_queue_t queue = dispatch_get_global_queue(0,0);
        
        dispatch_async(queue, ^{
            NSURL * url;
            url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"https://api.myjson.com/bins/3zmcy"]];
            NSError *errors;
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (data == nil)
            {
                Samplearray = [userDefaults objectForKey:@"SavedListArray"];
                if ([Samplearray count] != 0)
                {
                    ListArray = Samplearray;
                    ListArray1 = ListArray;
                }
            }
            else
            {
                NSArray *json = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errors]];
                //        NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errors];
                //        NSString *status = json[@"status"];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (json.count != 0)
                    {
                        ListArray = [NSMutableArray arrayWithArray:json];
                        [self ArraySorter:@"price_in_euros"];
                        ListArray1 = ListArray;
                        [userDefaults setObject:ListArray forKey:@"SavedListArray"];
                        [userDefaults synchronize];
                        
                    }
                    else
                    {
                        [self AlertMessage:@"No Network Connectivity" :@"Dismiss"];
                    }
                    [_ListViewOutlet reloadData];
                    [activityIndicator stopAnimating];
                });
            }
            
        });
        
    }
    if (BusFlag == 1)
    {
        dispatch_queue_t queue = dispatch_get_global_queue(0,0);
        
        dispatch_async(queue, ^{
            NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"https://api.myjson.com/bins/37yzm"]];
            NSError *errors;
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (data == nil)
            {
                Samplearray = [userDefaults objectForKey:@"SavedBusListArray"];
                if ([Samplearray count] != 0)
                {
                    BusListArray = Samplearray;
                    BusListArray1 = BusListArray;
                }
            }
            else
            {
                NSArray *json = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errors]];
                //        NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errors];
                //        NSString *status = json[@"status"];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (json.count != 0)
                    {
                        BusListArray = [NSMutableArray arrayWithArray:json];
                        [self ArraySorter:@"price_in_euros"];
                        BusListArray1 = BusListArray;
                        [userDefaults setObject:BusListArray forKey:@"SavedBusListArray"];
                        [userDefaults synchronize];
                    }
                    else
                    {
                        [self AlertMessage:@"No Network Connectivity" :@"Dismiss"];
                    }
                    [_ListViewOutlet reloadData];
                    [activityIndicator stopAnimating];
                });
                
            }
        });
    }
    if (FlightFlag == 1)
    {
        dispatch_queue_t queue = dispatch_get_global_queue(0,0);
        
        dispatch_async(queue, ^{
            NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"https://api.myjson.com/bins/w60i"]];
            NSError *errors;
            NSData *data = [NSData dataWithContentsOfURL:url];
            if (data == nil)
            {
                Samplearray = [userDefaults objectForKey:@"SavedFlightListArray"];
                if ([Samplearray count] != 0)
                {
                    FlightListArray = Samplearray;
                    FlightListArray1 = FlightListArray;
                }
            }
            else
            {
                NSArray *json = [[NSArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errors]];
                //        NSDictionary *json = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errors];
                //        NSString *status = json[@"status"];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    if (json.count != 0)
                    {
                        FlightListArray = [NSMutableArray arrayWithArray:json];
                        [self ArraySorter:@"price_in_euros"];
                        FlightListArray1 = FlightListArray;
                        [userDefaults setObject:FlightListArray forKey:@"SavedFlightListArray"];
                        [userDefaults synchronize];
                    }
                    else
                    {
                        [self AlertMessage:@"No Network Connectivity" :@"Dismiss"];
                    }
                    [_ListViewOutlet reloadData];
                    [activityIndicator stopAnimating];
                });
            }
            
        });
    }
    
}

// To Display ALert Message

-(void) AlertMessage : (NSString *)Title :(NSString *)CancelMessage
{
    UIAlertController *action_view = [UIAlertController alertControllerWithTitle:@"Alert" message:Title preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create and add the cancel button.
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CancelMessage style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
                             {
                                 NSLog(@"asdhfgjk");
                             }];
    
    // Add the action button to the alert.
    [action_view addAction:cancel];
    
    // Present the alert to the user.
    [self presentViewController:action_view animated:YES completion:nil];
}

// To Sort Array

-(void)ArraySorter :(NSString *)Key;
{
    NSArray * stories;
    NSSortDescriptor * descriptor = [[NSSortDescriptor alloc] initWithKey:Key ascending:YES];
    if (TrainFlag == 1)
    {
        stories  = ListArray;
        stories = [stories sortedArrayUsingDescriptors:@[descriptor]];
        ListArray = [stories copy];
        [_ListViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (BusFlag == 1)
    {
        stories  = BusListArray;
        stories = [stories sortedArrayUsingDescriptors:@[descriptor]];
        BusListArray = [stories copy];
        [_ListViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    if (FlightFlag == 1)
    {
        stories  = FlightListArray;
        stories = [stories sortedArrayUsingDescriptors:@[descriptor]];
        FlightListArray = [stories copy];
        [_ListViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

-(void)SetBorderColorforSortButtons
{
    _RateButtonOutlet.layer.borderColor = [UIColor redColor].CGColor;
    _DepartureButonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    _ArrivalButtonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
}



#pragma mark
#pragma mark UITableView Methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (TrainFlag == 1)
    {
        return  [ListArray count];
    }
    else if (BusFlag == 1)
    {
        return [BusListArray count];
    }
    else
    {
        return [FlightListArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId=@"ListCellIdentifier";
    ListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil)
    {
        cell=[[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.LogoOutlet.image = nil;
    if (TrainFlag == 1)
    {
        temp = [ListArray objectAtIndex:indexPath.row];
    }
    else if (BusFlag == 1)
    {
        temp = [BusListArray objectAtIndex:indexPath.row];
    }
    else
    {
        temp = [FlightListArray objectAtIndex:indexPath.row];
    }
    
    imagestring = [temp objectForKey:@"provider_logo"];
    imagestring = [imagestring stringByReplacingOccurrencesOfString:@"{size}"
                                                         withString:@"63"];
    imagestring = [imagestring stringByReplacingOccurrencesOfString:@"http"
                                                         withString:@"https"];
    if (!([imagestring isEqual:[NSNull null]]))
    {
        dispatch_queue_t myqueue = dispatch_queue_create("myqueue", NULL);
        
        dispatch_async(myqueue, ^{
            NSURL *url = [NSURL URLWithString:imagestring];
            NSData *data = [NSData dataWithContentsOfURL:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.LogoOutlet.image = [[UIImage alloc] initWithData:data];
                cell.LogoOutlet.contentMode = UIViewContentModeScaleAspectFit;
                [cell.LogoOutlet setTranslatesAutoresizingMaskIntoConstraints:YES];
            });
        });
    }
    if ([[temp objectForKey:@"number_of_stops"] intValue] > 1)
    {
        cell.NoofStopsLAbelOutlet.text = [NSString stringWithFormat:@"%@ Changes",[[temp objectForKey:@"number_of_stops"] stringValue]];
    }
    else if ([[temp objectForKey:@"number_of_stops"] intValue] == 1)
    {
        cell.NoofStopsLAbelOutlet.text = [NSString stringWithFormat:@"%@ Change",[[temp objectForKey:@"number_of_stops"] stringValue]];
    }
    else
    {
        cell.NoofStopsLAbelOutlet.text = [NSString stringWithFormat:@"Direct"];
    }
    
    dep = [temp objectForKey:@"departure_time"];
    cell.TimeLabelOutlet.text = [NSString stringWithFormat:@"%@ - %@",dep,[temp objectForKey:@"arrival_time"]];
    dep = [dep stringByReplacingOccurrencesOfString:@":"
                                         withString:@"."];
    totaljourneytime = [NSString stringWithFormat:@"%.02f h",fabsf([dep floatValue] - [[temp objectForKey:@"arrival_time"] floatValue])];
    cell.JourneyTime.text = [totaljourneytime stringByReplacingOccurrencesOfString:@"."
                                                           withString:@":"];
    cell.PriceLabelOutlet.text = [NSString stringWithFormat:@"%.02f €",[[temp objectForKey:@"price_in_euros"] floatValue]];
    
    return cell;
}

#pragma mark
#pragma mark Button Actions

- (IBAction)TrainButton:(id)sender
{
    _SliderViewOutlet.frame = CGRectMake(_TrainButtonOutlet.frame.origin.x, _SliderViewOutlet.frame.origin.y, _SliderViewOutlet.frame.size.width, _SliderViewOutlet.frame.size.height);
    [self SetBorderColorforSortButtons];
    TrainFlag = 1;
    BusFlag = 0;
    FlightFlag = 0;
    ListArray = ListArray1;
    [_ListViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
}

- (IBAction)BusButton:(id)sender
{
    _SliderViewOutlet.frame = CGRectMake(_BusButtonOutlet.frame.origin.x, _SliderViewOutlet.frame.origin.y, _SliderViewOutlet.frame.size.width, _SliderViewOutlet.frame.size.height);
    [self SetBorderColorforSortButtons];
    BusFlag = 1;
    TrainFlag = 0;
    FlightFlag = 0;
    BusListArray = BusListArray1;
    [_ListViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (IBAction)FlightButton:(id)sender
{
    _SliderViewOutlet.frame = CGRectMake(_FlightButtonOutlet.frame.origin.x, _SliderViewOutlet.frame.origin.y, _SliderViewOutlet.frame.size.width, _SliderViewOutlet.frame.size.height);
    [self SetBorderColorforSortButtons];
    FlightFlag = 1;
    BusFlag = 0;
    TrainFlag = 0;
    FlightListArray = FlightListArray1;
    [_ListViewOutlet reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
}

- (IBAction)OfferButton:(id)sender
{
    [self AlertMessage:@"Offer details are not yet implemented!" :@"Dismiss"];
}

- (IBAction)SortButton:(id)sender
{
    [self SetBorderColorforSortButtons];
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _SortViewOutlet.frame =  CGRectMake(0, 0, _HeadViewOutlet.frame.size.width,87);
        } completion:nil];
}


- (IBAction)RateButton:(id)sender
{
    [self ArraySorter:@"price_in_euros"];
    _RateButtonOutlet.layer.borderColor = [UIColor redColor].CGColor;
    _DepartureButonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    _ArrivalButtonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)DepartureButton:(id)sender
{
    [self ArraySorter:@"departure_time"];
    _RateButtonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    _DepartureButonOutlet.layer.borderColor = [UIColor redColor].CGColor;
    _ArrivalButtonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)ArrivalButton:(id)sender
{
    [self ArraySorter:@"arrival_time"];
    _RateButtonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    _DepartureButonOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    _ArrivalButtonOutlet.layer.borderColor = [UIColor redColor].CGColor;
}
@end
