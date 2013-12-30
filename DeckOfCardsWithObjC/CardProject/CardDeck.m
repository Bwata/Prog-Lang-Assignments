//
//  CardDeck.m
//  CardProject
//
//  Created by Phil Webster on 11/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "CardDeck.h"
#import "Card.h"

@implementation CardDeck

- (id)initDeck {
    NSArray * ranks = @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"A", @"J", @"Q", @"K"];
    NSArray * suits = @[@"c", @"d", @"h", @"s"];
    _deck = [[NSMutableArray alloc] init];
    for (NSString* s in suits) {
        for (NSString* r in ranks){
            [_deck addObject:[[Card alloc] initWithRank:r andSuit:s]];
        }
    }
    return self;
}

- (void)shuffle{
    // Help from Stack Overflow here: http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray?rq=1
    NSUInteger count = [_deck count];
    for (int i = 0; i < count; i++){
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [_deck exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (BOOL)isEmpty{
    return [_deck count] == 0;
}

- (long)size{
    return [_deck count];
}

- (NSArray *)deal{
    return [self deal:1];
}

- (NSArray *)deal: (int)nCards {
    if (nCards < 1 || nCards > [self size]) {
        return nil;
    }
    NSRange range = NSMakeRange(0, nCards);
    NSArray * dealtcards = [_deck objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    [_deck removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
    return dealtcards;
}

+ (NSMutableArray *)symmetricDifferenceOf:(NSMutableArray *)arr1 and:(NSMutableArray*)arr2{
    NSMutableSet *uset = [NSMutableSet setWithArray:arr1];
    NSMutableSet *iset = [NSMutableSet setWithArray:arr1];
    NSMutableSet *set1 = [NSMutableSet setWithArray:arr1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:arr2];
    [uset unionSet:set2];
    [iset intersectSet:set2];
    [uset minusSet:iset];
    NSMutableArray * difference = [NSMutableArray arrayWithArray:[uset allObjects]];
    return difference;
}

- (NSString *)deckToString: (NSArray *)adeck {
    if (adeck == nil) {
        return nil;
    }
    NSMutableString* deckString = [NSMutableString stringWithString:@"["];
    for (Card* c in adeck){
        [deckString appendFormat:@"%@, ",c];
    }
    if ([deckString length] > 1){
        // Get rid of the last ", "
        NSRange range = NSMakeRange([deckString length]-2, 2);
        [deckString deleteCharactersInRange:range];
    }
    [deckString appendString:@"]"];
    return deckString;
}

- (NSString *)description{
    return [self deckToString:_deck];
}

@end
