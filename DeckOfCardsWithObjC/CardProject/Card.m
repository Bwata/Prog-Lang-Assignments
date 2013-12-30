//
//  Card.m
//  CardProject
//
//  Created by Phil Webster on 11/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize rank = _rank;
@synthesize suit = _suit;
//
-(NSString*)rank{
    return _rank;
}

-(void)setRank:(NSString*)rank{
    NSArray * ranks = @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"A", @"J", @"Q", @"K"];
    if ([ranks containsObject:rank]) {
        _rank = rank;
    } else {
        NSException *e = [NSException exceptionWithName:@"InvalidCardRank" reason:@"Invalid value for rank." userInfo:nil];
        @throw e;
    }
}

-(NSString*)suit{
    return _suit;
}

-(void)setSuit:(NSString*)suit{
    NSArray * suits = @[@"c", @"d", @"h", @"s"];
    if ([suits containsObject:suit]) {
        _suit = suit;
    } else {
        NSException *e = [NSException exceptionWithName:@"InvalidCardSuit" reason:@"Invalid value for suit." userInfo:nil];
        @throw e;
    }
}


-(id)initWithRank:(NSString*)rank andSuit:(NSString*)suit {
//    NSArray * ranks = @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"A", @"J", @"Q", @"K"];
//    NSArray * suits = @[@"c", @"d", @"h", @"s"];

    [self setRank:rank];
    [self setSuit:suit];
//    _rank = rank;
//    _suit = suit;

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"%@%@", [self.rank stringByReplacingOccurrencesOfString:@"10" withString:@"T"], self.suit];
}

@end
