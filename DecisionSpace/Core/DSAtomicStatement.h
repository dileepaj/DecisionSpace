//
//  DSAtomicStatement.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/11/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSParam;
@class DSValue;

@interface DSAtomicStatement : NSObject

// represents the statement (param is value)    e.g. Skill_Level   is   High
@property DSParam *param;
@property DSValue *value;

+ (DSAtomicStatement *) createStmWithParam : (DSParam *) param andValue : (DSValue *) value;

- (NSArray *) getYesSet;
- (NSArray *) getNoSet;
- (DSAtomicStatement *) getCopy;
- (BOOL) isStrongerThanStatement : (DSAtomicStatement *) statement;

@end
