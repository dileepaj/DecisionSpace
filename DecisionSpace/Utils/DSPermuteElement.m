//
//  DSPermuteElement.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSPermuteElement.h"

@implementation DSPermuteElement

- (id) init {
    self = [super init];
    if (self) {
        currPos = 0;
        maxPos = 0;
        next = nil;
        sequence = nil;
    }
    return self;
}

- (void)reset {
    currPos = 0;
    if (next) {
        [next reset];
    }
}

- (void)setSequence:(NSArray *)arr {
    sequence = [arr copy];
    maxPos = [arr count] - 1;
    currPos = 0;
}

- (BOOL)advance {
    if (next && ([next advance])) {
        return YES;
    }
    if (currPos < maxPos) {
        ++currPos;
        [next reset];
        return YES;
    }
    return NO;
}

- (void)setNext:(DSPermuteElement *)elem {
    next = elem;
}

- (id)getCurrent {
    return [sequence objectAtIndex:currPos];
}

@end
