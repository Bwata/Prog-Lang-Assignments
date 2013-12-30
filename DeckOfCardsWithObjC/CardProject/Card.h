//
//  Card.h
//  CardProject
//
//  Created by Phil Webster on 11/22/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(readonly) NSString* rank;
@property(readonly) NSString* suit;

-(id)initWithRank:(NSString*)rank andSuit:(NSString*)suit;
-(void)setRank:(NSString*)rank;
-(void)setSuit:(NSString*)suit;
- (NSString *)description; // This is like the to_string method

@end
