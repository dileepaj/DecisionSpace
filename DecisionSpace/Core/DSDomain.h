//
//  DSDomain.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSValue;

@interface DSDomain : NSObject {
    NSMutableDictionary *prev;      // key = nsvalue      value = previous nsvalue
    NSMutableDictionary *next;      // key = nsvalue      value = next nsvalue
    NSArray *values;
}

@property NSString *name;

- (void) setDomainValues : (NSArray *) valuesAscending;
- (NSArray *) getDomainValues;
- (DSValue *) getPrevValueFor : (DSValue *) value;
- (DSValue *) getNextValueFor : (DSValue *) value;
- (BOOL) isTheSameDomainAs : (DSDomain *) domain;
- (NSComparisonResult) compareValue : (DSValue *) val1 withValue : (DSValue *) val2;

@end
