//
//  DSValue.h
//  DecisionSpace
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSValue : NSObject

@property NSString *name;

- (BOOL) isEqualToValue : (DSValue *) val;

@end
