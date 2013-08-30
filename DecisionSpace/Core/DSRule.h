//
//  DSRule.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSCompoundStatement;

@interface DSRule : NSObject

@property DSCompoundStatement *statement;
@property BOOL action;

@end
