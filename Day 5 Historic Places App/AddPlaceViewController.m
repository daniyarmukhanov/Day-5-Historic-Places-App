//
//  AddPlaceViewController.m
//  Day 5 Historic Places App
//
//  Created by Daniyar Mukhanov on 6/24/15.
//  Copyright (c) 2015 Daniyar Mukhanov. All rights reserved.
//

#import "AddPlaceViewController.h"

@interface AddPlaceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
@property (weak, nonatomic) IBOutlet UITextField *latField;
@property (weak, nonatomic) IBOutlet UITextField *longField;

@end

@implementation AddPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addButtonPressed:(UIButton *)sender {
    HistoricPlace *place=[HistoricPlace new];
    place.name=self.nameField.text;
    place.desc=self.descField.text;
    double lat=[self.latField.text doubleValue];
    double longit=[self.longField.text doubleValue];
    place.coordinate=CLLocationCoordinate2DMake(lat, longit);
    [self.delegate didAddPlace:place];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
