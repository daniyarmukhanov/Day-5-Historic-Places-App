//
//  AddPlaceViewController.h
//  Day 5 Historic Places App
//
//  Created by Daniyar Mukhanov on 6/24/15.
//  Copyright (c) 2015 Daniyar Mukhanov. All rights reserved.
//

#import "ViewController.h"
#import "HistoricPlace.h"

@protocol AddPlaceViewControllerDelegate <NSObject>

-(void)didAddPlace:(HistoricPlace *)place;

@end

@interface AddPlaceViewController : ViewController
@property (weak)id <AddPlaceViewControllerDelegate> delegate;
@end
