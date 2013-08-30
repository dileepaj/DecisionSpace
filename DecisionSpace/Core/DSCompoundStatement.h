//
//  DSCompoundStatement.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/11/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSCompoundStatement : NSObject

@property NSArray *statements;      // array of atomic statements

+ (DSCompoundStatement *) createStmWithAtomicStmArray : (NSArray *) stms;

- (DSCompoundStatement *) getCopy;
- (BOOL) isStatement : (DSCompoundStatement *) statement containedWithRespectToAction : (BOOL) action;

@end
