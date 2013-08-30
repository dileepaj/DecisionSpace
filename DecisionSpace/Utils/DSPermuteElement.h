//
//  DSPermuteElement.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/13/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSPermuteElement : NSObject {
    NSArray *sequence;
    NSUInteger currPos;
    NSUInteger maxPos;
    DSPermuteElement *next;
}

- (void) reset;
- (void) setSequence : (NSArray *) arr;
- (BOOL) advance;
- (void) setNext : (DSPermuteElement *) elem;
- (id) getCurrent;

@end
