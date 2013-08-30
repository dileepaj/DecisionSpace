//
//  DSDomain.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSDomain.h"
#import "DSValue.h"

@implementation DSDomain

- (void)setDomainValues:(NSArray *)valuesAscending {
    values = valuesAscending;
    prev = [NSMutableDictionary dictionary];
    next = [NSMutableDictionary dictionary];
    NSUInteger count = [valuesAscending count];
    for (int i = 0; i < count ; ++i) {
        if (i > 0) {
            [prev setObject:[valuesAscending objectAtIndex:(i - 1)] forKey:[[valuesAscending objectAtIndex:i] name]];
        }
        if (i < (count - 1)) {
            [next setObject:[valuesAscending objectAtIndex:(i + 1)] forKey:[[valuesAscending objectAtIndex:i] name]];
        }
    }
}

- (NSArray *)getDomainValues {
    return values;
}

- (DSValue *)getNextValueFor:(DSValue *)value {
    return [next objectForKey:value.name];
}

- (DSValue *)getPrevValueFor:(DSValue *)value {
    return [prev objectForKey:value.name];
}

- (BOOL)isTheSameDomainAs:(DSDomain *)domain {
    if ([_name length] == 0) {
        return NO;
    }
    return [_name isEqualToString:domain.name];
}

- (NSComparisonResult)compareValue:(DSValue *)val1 withValue:(DSValue *)val2 {
    int iVal1Index = -1;
    int iVal2Index = -1;
    int index = 0;
    for (DSValue *val in values) {
        if ([val isEqualToValue:val1]) {
            iVal1Index = index;
        }
        if ([val isEqualToValue:val2]) {
            iVal2Index = index;
        }
        ++index;
    }
    if (iVal1Index == iVal2Index) {
        return NSOrderedSame;
    } else if (iVal1Index < iVal2Index) {
        return NSOrderedAscending;
    }
    return NSOrderedDescending;
}

@end
