//
//  DSCompoundStatement.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/11/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSCompoundStatement.h"
#import "DSAtomicStatement.h"

@implementation DSCompoundStatement

+ (DSCompoundStatement *)createStmWithAtomicStmArray:(NSArray *)stms {
    DSCompoundStatement *stm = [DSCompoundStatement new];
    stm.statements = [NSArray arrayWithArray:stms];
    return stm;
}

- (DSCompoundStatement *)getCopy {
    DSCompoundStatement *newObj = [DSCompoundStatement new];
    NSMutableArray *arr = [NSMutableArray array];
    for (DSAtomicStatement *as in _statements) {
        [arr addObject:[as getCopy]];
    }
    newObj.statements = arr;
    return newObj;
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString new];
    for (DSAtomicStatement *stm in _statements) {
        [str appendString:[stm description]];
        [str appendString:@" , "];
    }
    return str;
}

- (BOOL)isStatement:(DSCompoundStatement *)statement containedWithRespectToAction:(BOOL)action {
    NSUInteger count = [_statements count];
    if ([statement.statements count] != count) {
        return NO;
    }
    for (int index = 0; index < count; ++index) {
        DSAtomicStatement *atom = [_statements objectAtIndex:index];
        DSAtomicStatement *atom2 = [statement.statements objectAtIndex:index];
        BOOL stronger = [atom isStrongerThanStatement:atom2];
        if (action && stronger) {
            return NO;
        }
        if ((!action) && (!stronger)) {
            return NO;
        }
    }
    return YES;
}

@end
