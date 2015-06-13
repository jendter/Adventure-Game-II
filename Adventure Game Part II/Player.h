//
//  Player.h
//  Adventure Game
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Room.h"

@interface Player : NSObject

@property (strong, nonatomic) Room *currentRoom;
@property (strong, nonatomic) NSNumber *startingHealth;
@property (strong, nonatomic) NSNumber *currentHealth;
@property (nonatomic) BOOL isPlayingGame;

- (void) goDirection:(Direction)direction;
- (void) goToRoom:(Room *)roomToGoto;
- (void) status;

@end
