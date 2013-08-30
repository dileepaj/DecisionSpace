//
//  DSShadow.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSShadow.h"
#import "DSRule.h"
#import "DSCompoundStatementSet.h"
#import "DSPermute.h"
#import "DSCompoundStatement.h"
#import "DSAtomicStatement.h"
#import "DSParam.h"
#import "DSDomain.h"

@implementation DSShadow

- (void) setRule:(DSRule *)theRule withAsymmetricParamRelations : (NSArray *) asymmetricRelations andSymmetricParamRelations : (NSArray *) symmetricRelations {
    rule = theRule;
    //statementSet = [DSCompoundStatementSet new];
    pivotalStatements = [NSMutableArray arrayWithObject:theRule.statement];
    [self addShadowWithAsymmetricParamRelations:asymmetricRelations andSymmetricParamRelations:symmetricRelations];
}

- (BOOL) isPatternPresent : (DSCompoundStatement *) pattern {
    for (DSCompoundStatement *pivotalStatement in pivotalStatements) {
        if ([pivotalStatement isStatement:pattern containedWithRespectToAction:rule.action]) {
            return YES;
        }
    }
    return NO;
}

- (void) addShadowWithAsymmetricParamRelations : (NSArray *) asymmetricRelations andSymmetricParamRelations : (NSArray *) symmetricRelations {
    //[self addShadowForStatement:rule.statement];
    if (asymmetricRelations) {
        for (NSArray *arr in asymmetricRelations) {
            [self addShadowForStatement:[rule.statement getCopy] whenParam:[arr objectAtIndex:0] isLessImportantThanParam:[arr objectAtIndex:1]];
        }
    }
    if (symmetricRelations) {
        for (NSArray *arr in symmetricRelations) {
            [self addShadowForStatement:[rule.statement getCopy] whenParam:[arr objectAtIndex:0] isSymmetricWithParam:[arr objectAtIndex:1]];
        }
    }
}

- (void) addShadowForStatement : (DSCompoundStatement *) statement whenParam : (NSNumber *) lessIndex isLessImportantThanParam : (NSNumber *) highIndex {
    DSAtomicStatement *stLess = [statement.statements objectAtIndex:[lessIndex intValue]];
    DSAtomicStatement *stHigh = [statement.statements objectAtIndex:[highIndex intValue]];
    if (![stLess.param.domain isTheSameDomainAs:stHigh.param.domain]) {
        return;
    }
    if (stLess.param.positive != stHigh.param.positive) {
        return;
    }
    BOOL existsValidAlteredStatement = NO;
    if (rule.action == stLess.param.positive) {
        if ([stLess.param.domain compareValue:stLess.value withValue:stHigh.value] == NSOrderedDescending) {
            existsValidAlteredStatement = YES;
        }
    } else {
        if ([stLess.param.domain compareValue:stLess.value withValue:stHigh.value] == NSOrderedAscending) {
            existsValidAlteredStatement = YES;
        }
    }
    if (existsValidAlteredStatement) {
        DSValue *temp = stLess.value;
        stLess.value = stHigh.value;
        stHigh.value = temp;
        //[self addShadowForStatement:statement];
        [pivotalStatements addObject:statement];
    }
}

- (void) addShadowForStatement : (DSCompoundStatement *) statement whenParam : (NSNumber *) param1Index isSymmetricWithParam : (NSNumber *) param2Index {
    DSAtomicStatement *st1 = [statement.statements objectAtIndex:[param1Index intValue]];
    DSAtomicStatement *st2 = [statement.statements objectAtIndex:[param2Index intValue]];
    if (![st1.param.domain isTheSameDomainAs:st2.param.domain]) {
        return;
    }
    if (st1.param.positive != st2.param.positive) {
        return;
    }
    if ([st1.param.domain compareValue:st1.value withValue:st2.value] == NSOrderedSame) {
        return;
    }
    
    DSValue *temp = st1.value;
    st1.value = st2.value;
    st2.value = temp;
    //[self addShadowForStatement:statement];
    [pivotalStatements addObject:statement];
}

- (void)addEntireShadowToStatementSet:(DSCompoundStatementSet *)set {
    for (DSCompoundStatement *statement in pivotalStatements) {
        [set addCompoundStatement:statement];
        NSMutableArray *arr = [NSMutableArray array];
        for (DSAtomicStatement *atom in statement.statements) {
            NSArray *elemArray = rule.action ? [atom getYesSet] : [atom getNoSet];
            [arr addObject:elemArray];
        }
        DSPermute *permute = [DSPermute new];
        [permute initializeWithData:arr];
        while ([permute advance]) {
            NSArray *sequence = [permute getCurrentCombination];
            DSCompoundStatement *cs = [DSCompoundStatement new];
            cs.statements = sequence;
            [set addCompoundStatement:cs];
        }
    }
}

- (DSRuleEvaluationResult)evaluate:(DSCompoundStatement *)statement {
    if ([self isPatternPresent:statement]) {
        return rule.action ? DSRuleEvaluationResult_Yes : DSRuleEvaluationResult_No;
    }
    return DSRuleEvaluationResult_Indeterminate;
}

- (NSArray *)getPivotalStatements {
    return [NSArray arrayWithArray:pivotalStatements];
}

- (BOOL)getAction {
    return rule.action;
}

@end
