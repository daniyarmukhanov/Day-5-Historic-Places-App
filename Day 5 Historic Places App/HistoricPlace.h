//
//  HistoricPlace.h
//  Day 5 Historic Places App
//
//  Created by Daniyar Mukhanov on 6/24/15.
//  Copyright (c) 2015 Daniyar Mukhanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface HistoricPlace : NSObject<MKAnnotation>
@property (nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *desc;
@property (nonatomic) UIImage *picture;

-(instancetype) initWithName: (NSString *)name andLocation:(CLLocationCoordinate2D )coordinate andDescription:(NSString *) description;
@end
