//
//  DecisionSpaceTests.m
//  DecisionSpaceTests
//
//  Created by Dileepa Jayathilake on 4/10/13.
//  Copyright (c) 2013 99XTechnology. All rights reserved.
//

#import "DecisionSpaceTests.h"
#import "DSIncludes.h"

@implementation DecisionSpaceTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testAskQuestion {
    DSValue *low = [DSValue new];
    low.name = @"low";
    DSValue *medium = [DSValue new];
    medium.name = @"medium";
    DSValue *high = [DSValue new];
    high.name = @"high";
    DSValue *veryhigh = [DSValue new];
    veryhigh.name = @"veryhigh";
    
    DSDomain *domain = [DSDomain new];
    [domain setDomainValues:@[low, medium, high, veryhigh]];
    
    DSParam *experience = [DSParam new];
    experience.domain = domain;
    experience.name = @"experience";
    experience.positive = YES;
    
    DSParam *education = [DSParam new];
    education.domain = domain;
    education.name = @"education";
    education.positive = YES;
    
    DSParam *salary_expectation = [DSParam new];
    salary_expectation.domain = domain;
    salary_expectation.name = @"salary_expectation";
    salary_expectation.positive = NO;
    
    DSSystem *system = [DSSystem new];
    [system addParam:experience];
    [system addParam:education];
    [system addParam:salary_expectation];
    
    DSRule *rule1 = [DSRule new];
    rule1.statement = [DSCompoundStatement createStmWithAtomicStmArray:@[[DSAtomicStatement createStmWithParam:experience andValue:medium], [DSAtomicStatement createStmWithParam:education andValue:high], [DSAtomicStatement createStmWithParam:salary_expectation andValue:high]]];
    rule1.action = YES;
    [system addRule:rule1];
    
    DSRule *rule2 = [DSRule new];
    rule2.statement = [DSCompoundStatement createStmWithAtomicStmArray:@[[DSAtomicStatement createStmWithParam:experience andValue:low], [DSAtomicStatement createStmWithParam:education andValue:medium], [DSAtomicStatement createStmWithParam:salary_expectation andValue:medium]]];
    rule2.action = NO;
    [system addRule:rule2];
    
    DSRule *rule3 = [DSRule new];
    rule3.statement = [DSCompoundStatement createStmWithAtomicStmArray:@[[DSAtomicStatement createStmWithParam:experience andValue:veryhigh], [DSAtomicStatement createStmWithParam:education andValue:medium], [DSAtomicStatement createStmWithParam:salary_expectation andValue:veryhigh]]];
    rule3.action = YES;
    [system addRule:rule3];
    
    NSLog(@"Learned percentage is %.2f", [system getCoveredFraction] * 100);
    
    for (int index = 0; index < 10; ++index) {
        DSCompoundStatement *question = [system getQuestion];
        NSLog([question description]);
    }
    
    STAssertTrue(YES, @"");
}

@end
