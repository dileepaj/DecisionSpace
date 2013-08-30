//
//  DSSystem.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSSystem.h"
#import "DSRule.h"
#import "DSShadow.h"
#import "DSParam.h"
#import "DSDomain.h"
#import "DSPermute.h"
#import "DSCompoundStatement.h"
#include <stdlib.h>
#import "DSCompoundStatementSet.h"

@implementation DSSystem

- (id) init {
    self = [super init];
    if (self) {
        params = [NSMutableArray array];
        paramAssymetricRelations = [NSMutableArray array];
        shadows = [NSMutableArray array];
    }
    return self;
    
}

- (void)addParam:(DSParam *)param {
    [params addObject:param];
}

- (void)addParamRelationWithLessParam:(NSNumber *)lessParamIndex andHighParam:(NSNumber *)highParamIndex {
    NSArray *relationArray = [NSArray arrayWithObjects:lessParamIndex, highParamIndex, nil];
    [paramAssymetricRelations addObject:relationArray];
}

- (void)addSymmetricParamRelationWithParam1:(NSNumber *)param1Index andParam2:(NSNumber *)param2Index {
    NSArray *relationArray = [NSArray arrayWithObjects:param1Index, param2Index, nil];
    [paramSymmetricRelations addObject:relationArray];
}

- (BOOL)addRule:(DSRule *)rule {
    if ([self isRuleInclusive:rule]) {
        return NO;
    }
    DSShadow *shadow = [DSShadow new];
    [shadow setRule:rule withAsymmetricParamRelations:paramAssymetricRelations andSymmetricParamRelations:paramSymmetricRelations];
    [shadows addObject:shadow];
    return YES;
}

- (BOOL) isRuleInclusive : (DSRule *) rule {
    for (DSShadow *shadow in shadows) {
        if ([shadow isPatternPresent:rule.statement]) {
            return YES;
        }
    }
    return NO;
}

- (DSRuleEvaluationResult)evaluate:(DSCompoundStatement *)statement {
    for (DSShadow *shadow in shadows) {
        DSRuleEvaluationResult res = [shadow evaluate:statement];
        if (res == DSRuleEvaluationResult_Indeterminate) {
            continue;
        }
        return res;
    }
    return DSRuleEvaluationResult_Indeterminate;
}

- (NSUInteger)getParamPermutationCount {
    NSUInteger ret = 1;
    for (DSParam *param in params) {
        ret *= ([[param.domain getDomainValues] count]);
    }
    return ret;
}

- (NSUInteger)getCoveredParamPermutationCount {
    DSCompoundStatementSet *set = [DSCompoundStatementSet new];
    for (DSShadow *shadow in shadows) {
        [shadow addEntireShadowToStatementSet:set];
    }
    return [set getStatementCount];
}

- (double)getCoveredFraction {
    return ((double) [self getCoveredParamPermutationCount]) / [self getParamPermutationCount];
}

- (DSCompoundStatement *)getQuestion {
    NSArray *statements = [self getAllUncertainScenarios];
    NSUInteger count = [statements count];
    if (count == 0) {
        return nil;
    }
    int index = arc4random() % count;
    return [statements objectAtIndex:index];
}

- (NSArray *) getAllUncertainScenarios {
    // returns an array containing all compound statements that are not in any existing shadow
    NSMutableArray *res = [NSMutableArray array];
    NSMutableArray *arr = [NSMutableArray array];
    for (DSParam *param in params) {
        [arr addObject:[param getAllParamValueCombinations]];
    }
    DSPermute *permute = [DSPermute new];
    [permute initializeWithData:arr];
    do {
        NSArray *sequence = [permute getCurrentCombination];
        DSCompoundStatement *cs = [DSCompoundStatement new];
        cs.statements = sequence;
        BOOL csAlreadyIn = NO;
        for (DSShadow *shadow in shadows) {
            if ([shadow isPatternPresent:cs]) {
                csAlreadyIn = YES;
                break;
            }
        }
        if (!csAlreadyIn) {
            [res addObject:cs];
        }
    } while ([permute advance]);
    return res;
}

- (NSArray *)getShadows {
    return [NSArray arrayWithArray:shadows];
}

@end
