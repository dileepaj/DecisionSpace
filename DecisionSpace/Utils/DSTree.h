//
//  DSTree.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/12/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSTree : NSObject {
    NSMutableDictionary *tree;
    NSUInteger count;
}

- (BOOL) addPattern : (NSArray *) pattern;
- (BOOL) isPatternPresent : (NSArray *) pattern;
- (NSUInteger) getCount;

@end
