//
//  CardDeck.h
//  CardProject
//
//  Created by Phil Webster on 11/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Card.h"

@interface CardDeck : NSObject
@property NSMutableArray * deck;

- (id)initDeck;
- (void)shuffle;
- (BOOL)isEmpty;
- (long)size;
- (NSArray *)deal;
- (NSArray *)deal: (int)nCards;
+ (NSMutableArray *)symmetricDifferenceOf:(NSMutableArray *)arr1 and:(NSMutableArray*)arr2; // The plus means it's a class method
- (NSString *)deckToString: (NSArray *)adeck; // Prints the passed in CardDeck
- (NSString *)description; // This is like the to_string method. It prints the deck itself by calling printDeck

@end
