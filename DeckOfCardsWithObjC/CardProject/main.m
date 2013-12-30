//
//  main.m
//  CardProject
//
//  Created by Phil Webster on 11/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "CardDeck.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        Card* c = [[Card alloc] initWithRank:@"A" andSuit:@"s"];
        NSLog(@"%@", c.rank);
        NSLog(@"%@", c.suit);
        NSLog(@"%@", c);

        c = [[Card alloc] initWithRank:@"10" andSuit:@"s"];
        NSLog(@"%@", c.rank);
        NSLog(@"%@", c.suit);
        NSLog(@"%@", c);
        
        @try {
            [c setRank:@"15"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }

        @try {
            [c setSuit:@"z"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }

        @try {
            Card* temp = [[Card alloc] initWithRank:@"15" andSuit:@"s"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }

        @try {
            Card* temp2 = [[Card alloc] initWithRank:@"4" andSuit:@"z"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
        
        @try {
            Card* temp3 = [[Card alloc] initWithRank:@"b" andSuit:@"z"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
        
        CardDeck* d = [[CardDeck alloc] initDeck];
        NSLog(@"New deck of 52 cards: %@", d);
        NSLog(@"Deck size: %ld", [d size]);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");

        [d shuffle];
        NSLog(@"Shuffled deck of 52 cards: %@", d);
        NSLog(@"Deck size: %ld", [d size]);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        
        NSLog(@"Deal one card from the deck: %@", [d deckToString:[d deal]]);
        NSLog(@"Deal one card from the deck: %@", [d deckToString:[d deal:1]]);
        NSLog(@"Deal ten cards from the deck: %@", [d deckToString:[d deal:10]]);
        NSLog(@"Deck size after dealing: %ld", [d size]);

        d = [[CardDeck alloc] initDeck];
        NSLog(@"New deck of 52 cards: %@", d);
        NSLog(@"Deck size: %ld", [d size]);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        NSLog(@"Deal all cards from the deck: %@", [d deckToString:[d deal:52]]);
        NSLog(@"Deck after dealing all cards: %@", d);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        NSLog(@"Deck size after dealing: %ld", [d size]);
        
        d = [[CardDeck alloc] initDeck];
        NSLog(@"New deck of 52 cards: %@", d);
        NSLog(@"Deck size: %ld", [d size]);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        NSLog(@"Dealing 55 cards from a new deck will return null: %@", [d deckToString:[d deal:55]]);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        NSLog(@"Deck size after dealing: %ld", [d size]);
        
        NSLog(@"Deal 20 cards from the deck: %@", [d deckToString:[d deal:20]]);
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        NSLog(@"Deck size after dealing: %ld", [d size]);
        
        NSLog(@"Dealing 35 cards from the deck now will return null: %s", [d deckToString:[d deal:35]] ? "false" : "true");
        NSLog(@"Dealing -10 cards from the deck will return null: %s", [d deckToString:[d deal:-10]] ? "false" : "true");
        NSLog(@"Dealing 1.5 cards from the deck will return null: %s", [d deckToString:[d deal:1.5]] ? "false" : "true"); // Not working, should return null. Instead 1.5 is truncated as 1.
        NSLog(@"Dealing junk cards from the deck will return null: %s", [d deckToString:[d deal:@"junk"]] ? "false" : "true");
        NSLog(@"Deck empty? %s", [d isEmpty] ? "true" : "false");
        NSLog(@"Deck size after dealing: %ld", [d size]);
        
        // In the original tests there's an array with various types here that won't work
        
        NSMutableArray* test_a = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9];
        NSMutableArray* test_b = @[@1, @3, @5, @7, @7, @11, @13, @15];
        NSMutableArray* test_c = @[@2, @4, @6, @8, @10, @12, @14, @16];
        NSArray* test_d = @[];
        
//        NSLog(@"a^b: %@", [[CardDeck symmetricDifferenceOf:test_a and:test_b] sortedArrayUsingSelector:(SEL));
        
        
        return 0;
    }
    return 0;
}

