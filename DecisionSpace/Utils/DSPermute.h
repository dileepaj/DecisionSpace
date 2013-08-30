//
//  DSPermute.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSPermute : NSObject {
    NSMutableArray *elements;
}

- (void) initializeWithData : (NSArray *) data;
- (NSArray *) getCurrentCombination;
- (BOOL) advance;

@end
