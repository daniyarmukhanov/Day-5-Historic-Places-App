//
//  ViewController.m
//  Day 5 Historic Places App
//
//  Created by Daniyar Mukhanov on 6/24/15.
//  Copyright (c) 2015 Daniyar Mukhanov. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "HistoricPlace.h"
#import <Parse/Parse.h>

@interface ViewController ()<MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic) NSMutableArray *places;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocation *initialLoc=[[CLLocation alloc]initWithLatitude:43.255926 longitude:76.942732];
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(initialLoc.coordinate, 2000.0, 2000.0);
   
    [self.mapView setRegion:region];
    self.mapView.delegate=self;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.places=[[NSMutableArray alloc]init];


    [self getDataFromParse];
    [self showMap];
}

-(void) getDataFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Place"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
          
            for (PFObject *object in objects) {
                NSString *name=object[@"name"];
                NSString *desc=object[@"desc"];
                PFGeoPoint *point =object[@"location"];
                HistoricPlace *place =[[HistoricPlace alloc]initWithName:name andLocation:CLLocationCoordinate2DMake(point.latitude, point.longitude) andDescription:desc];
                [self.places addObject:place];
                [self.mapView addAnnotation:place];
                [self.tableView reloadData];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

#pragma mark -MKMapView delegate methods

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKAnnotationView *annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if(!annotationView){
        annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
        annotationView.canShowCallout=YES;
        annotationView.calloutOffset=CGPointMake(-5.0, 5.0);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView =button;
        
    }else{
        annotationView.annotation=annotation;
    }
    return annotationView;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    HistoricPlace *place=view.annotation;
    [self alertHistoricPlace:place];
}
-(void) alertHistoricPlace: (HistoricPlace *) place{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:place.name message:place.desc delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}
- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    if(self.segmentedControl.selectedSegmentIndex==0){
        [self showMap];
    }else{
        [self showList];
    }
}

#pragma mark - tableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.places.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
    }
    HistoricPlace *place=self.places[indexPath.row];
    cell.textLabel.text=place.name;
    cell.detailTextLabel.text=place.desc;

    return cell;
}
-(void)showMap{
    self.mapView.hidden=NO;
    self.tableView.hidden=YES;
}
-(void)showList{
    self.mapView.hidden=YES;
    self.tableView.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
