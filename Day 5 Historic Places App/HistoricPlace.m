//
//  HistoricPlace.m
//  Day 5 Historic Places App
//
//  Created by Daniyar Mukhanov on 6/24/15.
//  Copyright (c) 2015 Daniyar Mukhanov. All rights reserved.
//

#import "HistoricPlace.h"

@implementation HistoricPlace

-(NSString *)title{
    return self.name;
}

-(NSString *)subtitle{
    return self.desc;
}
-(instancetype) initWithName:(NSString *)name andLocation:(CLLocationCoordinate2D)coordinate andDescription:(NSString *)description{
    self =[super init];
    if (self) {
        
    self.name=name;
    self.coordinate=coordinate;
    self.desc=description;
    }
    return self;
}
@end
