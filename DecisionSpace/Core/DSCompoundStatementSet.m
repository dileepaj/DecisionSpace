//
//  DSCompoundStatementSet.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/11/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSCompoundStatementSet.h"
#import "DSTree.h"
#import "DSCompoundStatement.h"

@implementation DSCompoundStatementSet

- (id) init {
    self = [super init];
    if (self) {
        tree = [DSTree new];
        statements = [NSMutableArray array];
    }
    return self;
}

- (NSUInteger)getStatementCount {
    return [tree getCount];
}

- (NSArray *)getAllStatements {
    return statements;
}

- (void)addCompoundStatement:(DSCompoundStatement *)statement {
    if ([tree addPattern:statement.statements]) {
        [statements addObject:statement];
        // for debugging
        NSLog(@"Statement added: %@", [statement.statements description]);
    } else {
        // for debugging
        NSLog(@"Statement not added: %@", [statement.statements description]);
    }
}

- (BOOL)isCompoundStatementPresent:(DSCompoundStatement *)statement {
    return [tree isPatternPresent:statement.statements];
}

@end
