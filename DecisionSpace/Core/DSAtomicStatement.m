//
//  DSAtomicStatement.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/11/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSAtomicStatement.h"
#import "DSParam.h"
#import "DSDomain.h"
#import "DSValue.h"

@implementation DSAtomicStatement

+ (DSAtomicStatement *)createStmWithParam:(DSParam *)param andValue:(DSValue *)value {
    DSAtomicStatement *stm = [DSAtomicStatement new];
    stm.param = param;
    stm.value = value;
    return stm;
}

- (DSAtomicStatement *)getCopy {
    DSAtomicStatement *newObj = [DSAtomicStatement new];
    newObj.param = _param;
    newObj.value = _value;
    return newObj;
}

- (NSArray *)getYesSet {
    NSMutableArray *ret = [NSMutableArray arrayWithObject:self];
    SEL operation = _param.positive ? NSSelectorFromString(@"getNextValueFor:") : NSSelectorFromString(@"getPrevValueFor:");
    DSValue *curr = _value;
    while (curr) {
        curr = [_param.domain performSelector:operation withObject:curr];
        if (curr) {
            DSAtomicStatement *newElem = [DSAtomicStatement new];
            newElem.param = _param;
            newElem.value = curr;
            [ret addObject:newElem];
        }
    }
    return ret;
}

- (NSArray *)getNoSet {
    NSMutableArray *ret = [NSMutableArray arrayWithObject:self];
    SEL operation = _param.positive ? NSSelectorFromString(@"getPrevValueFor:") : NSSelectorFromString(@"getNextValueFor:");
    DSValue *curr = _value;
    while (curr) {
        curr = [_param.domain performSelector:operation withObject:curr];
        if (curr) {
            DSAtomicStatement *newElem = [DSAtomicStatement new];
            newElem.param = _param;
            newElem.value = curr;
            [ret addObject:newElem];
        }
    }
    return ret;
}

- (BOOL)isStrongerThanStatement:(DSAtomicStatement *)statement {
    if (_param.positive) {
        return ([_param.domain compareValue:_value withValue:statement.value] == NSOrderedDescending);
    } else {
        return ([_param.domain compareValue:_value withValue:statement.value] == NSOrderedAscending);
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@=%@", _param.name, _value.name];
}

@end
