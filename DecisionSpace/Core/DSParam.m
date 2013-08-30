//
//  DSParam.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSParam.h"
#import "DSAtomicStatement.h"
#import "DSValue.h"
#import "DSDomain.h"

@implementation DSParam

- (NSArray *)getAllParamValueCombinations {
    NSMutableArray *arr = [NSMutableArray array];
    NSArray *values = [_domain getDomainValues];
    for (DSValue *value in values) {
        DSAtomicStatement *stm = [DSAtomicStatement new];
        stm.param = self;
        stm.value = value;
        [arr addObject:stm];
    }
    return arr;
}

@end
