//
//  DSParam.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSDomain;

@interface DSParam : NSObject

@property NSString *name;
@property DSDomain *domain;
@property BOOL positive;

- (NSArray *) getAllParamValueCombinations; // returns an array of atomic statements containing all statements with all possible values for this param

@end
