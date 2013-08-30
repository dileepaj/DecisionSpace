//
//  DSSystem.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definitions.h"

@class DSParam;
@class DSRule;
@class DSCompoundStatement;

@interface DSSystem : NSObject {
    NSMutableArray *params;
    NSMutableArray *paramAssymetricRelations;    // each element of array is another NSArray with exactly 2 elements of type DSParam. First element is the low priority param.
    NSMutableArray *paramSymmetricRelations;    // each element of array is another NSArray with exactly 2 elements of type DSParam. They are the two symmetric (and hence interchangeable) params.
    NSMutableArray *shadows;
}

- (void) addParam : (DSParam *) param;
- (void) addParamRelationWithLessParam : (NSNumber *) lessParamIndex andHighParam : (NSNumber *) highParamIndex;
- (void) addSymmetricParamRelationWithParam1 : (NSNumber *) param1Index andParam2 : (NSNumber *) param2Index;
- (BOOL) addRule : (DSRule *) rule;
- (DSRuleEvaluationResult) evaluate : (DSCompoundStatement *) statement;
- (NSUInteger) getParamPermutationCount;
- (NSUInteger) getCoveredParamPermutationCount;
- (double) getCoveredFraction;
- (DSCompoundStatement *) getQuestion;  // picks a question randomly from the available space outside existing shadows
- (NSArray *) getShadows;

@end
