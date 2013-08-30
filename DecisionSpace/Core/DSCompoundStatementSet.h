//
//  DSCompoundStatementSet.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/11/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSCompoundStatement;
@class DSTree;

@interface DSCompoundStatementSet : NSObject {
    DSTree *tree;
    NSMutableArray *statements;
}

- (void) addCompoundStatement : (DSCompoundStatement *) statement;
- (BOOL) isCompoundStatementPresent : (DSCompoundStatement *) statement;
- (NSUInteger) getStatementCount;
- (NSArray *) getAllStatements;

@end
