//
//  DSPermute.m
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DSPermute.h"
#import "DSPermuteElement.h"

@implementation DSPermute

- (void)initializeWithData:(NSArray *)data {
    elements = [NSMutableArray array];
    DSPermuteElement *prevElement = nil;
    for (NSArray *sequence in data) {
        DSPermuteElement *element = [DSPermuteElement new];
        [element setSequence:sequence];
        [elements addObject:element];
        if (prevElement) {
            [prevElement setNext:element];
        }
        prevElement = element;
    }
}

- (NSArray *)getCurrentCombination {
    NSMutableArray *ret = [NSMutableArray new];
    for (DSPermuteElement *element in elements) {
        [ret addObject:[element getCurrent]];
    }
    return ret;
}

- (BOOL) advance {
    DSPermuteElement *first = [elements objectAtIndex:0];
    return [first advance];
}

@end
