//
//  DSShadow.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definitions.h"

@class DSRule;
@class DSCompoundStatement;
@class DSCompoundStatementSet;

@interface DSShadow : NSObject {
    DSRule *rule;
    NSMutableArray *pivotalStatements;    // contains the primary compound statement (compound statement from the rule) and other compound statements generated due to symmetric and assymmeterc param relations
    //DSCompoundStatementSet *statementSet;
}

- (void) setRule:(DSRule *)rule withAsymmetricParamRelations : (NSArray *) asymmetricRelations andSymmetricParamRelations : (NSArray *) symmetricRelations;
- (DSRuleEvaluationResult) evaluate : (DSCompoundStatement *) statement;
- (BOOL) isPatternPresent : (DSCompoundStatement *) pattern;
- (void) addEntireShadowToStatementSet : (DSCompoundStatementSet *) set;
- (NSArray *) getPivotalStatements;
- (BOOL) getAction;

@end
