//
//  DSValue.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSValue.h"

@implementation DSValue

- (BOOL)isEqualToValue:(DSValue *)val {
    if ([_name length] == 0) {
        return NO;
    }
    return [_name isEqualToString:val.name];
}

@end
