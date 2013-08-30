//
//  DSTree.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/12/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSTree.h"
#import "DSAtomicStatement.h"
#import "DSParam.h"
#import "DSValue.h"

@implementation DSTree

- (id) init {
    self = [super init];
    if (self) {
        tree = [NSMutableDictionary dictionary];
        count = 0;
    }
    return self;
}

- (NSUInteger)getCount {
    return count;
}

- (BOOL)addPattern:(NSArray *)pattern {
    NSMutableDictionary *dic = tree;
    BOOL duplicate = YES;
    for (id obj in pattern) {
        NSString *key = [self getKey:obj];
        NSMutableDictionary *next = [dic objectForKey:key];
        if (next) {
            dic = next;
        } else {
            next = [NSMutableDictionary dictionary];
            [dic setObject:next forKey:key];
            dic = next;
            duplicate = NO;
        }
    }
    if (!duplicate) {
        ++count;
    }
    return (!duplicate);
}

- (BOOL)isPatternPresent:(NSArray *)pattern {
    NSDictionary *dic = tree;
    for (id obj in pattern) {
        NSString *key = [self getKey:obj];
        NSDictionary *next = [dic objectForKey:key];
        if (!next) {
            return NO;
        }
        dic = next;
    }
    return YES;
}

- (NSString *) getKey : (DSAtomicStatement *)stm {
    return [NSString stringWithFormat:@"%@=%@", stm.param.name, stm.value.name];
}

@end
