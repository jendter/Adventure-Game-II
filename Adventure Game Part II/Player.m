//
//  Player.m
//  Adventure Game
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "Player.h"
#import "Cube.h"
#import "Treasure.h"

@implementation Player

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isPlayingGame = YES;
        _startingHealth = @10;
        _currentHealth = [self.startingHealth copy];
    }
    return self;
}

- (void) status {
    NSLog(@"Player Health: %@", self.currentHealth);
    
    NSLog(@"Player Position: (%lu, %lu)", self.currentRoom.coordinates.x, self.currentRoom.coordinates.y);
    
    NSString *directionsAvailable = [NSString new];
    if ( [self.currentRoom isCurrentPossibleDirection:north] ) {
        directionsAvailable = [directionsAvailable stringByAppendingString:@"north "];
    }
    if ( [self.currentRoom isCurrentPossibleDirection:south]  ) {
        directionsAvailable = [directionsAvailable stringByAppendingString:@"south "];
    }
    if ( [self.currentRoom isCurrentPossibleDirection:east]  ) {
        directionsAvailable = [directionsAvailable stringByAppendingString:@"east "];
    }
    if ( [self.currentRoom isCurrentPossibleDirection:west]  ) {
        directionsAvailable = [directionsAvailable stringByAppendingString:@"west "];
    }
    NSLog(@"Directions Available: %@", directionsAvailable);
    
}

- (void) goDirection:(Direction)direction {
    
    // If it is possible to go in a direction, go in that direction
    if ( [self.currentRoom isCurrentPossibleDirection:direction] ) {
        [self goToRoom:[self.currentRoom roomInDirection:direction]];
    } else {
       NSLog(@"There is currently no exit in that direction.");
    }
    
}

- (void) goToRoom:(Room *)roomToGoto {
    // Go to the room
    self.currentRoom = roomToGoto;
    
    // Check to see if the treasure or cube is in the room
    if ( [self.currentRoom.roomContents isKindOfClass:[Cube class]] ) {
        NSLog(@"Oh no, there's a cube in here! It viciously attacks you!");
        self.currentHealth = @( [self.currentHealth intValue] - ([self.startingHealth intValue] / 2) );
        if ([self.currentHealth intValue] > 0) {
            NSLog(@"Your health is now: %@", self.currentHealth);
        } else {
            NSLog(@"Sorry, you've run out of health. \n\n    ---- Game over ----    \n\n");
            self.isPlayingGame = NO;
        }
    } else if ( [self.currentRoom.roomContents isKindOfClass:[Treasure class]] ) {
        NSLog(@"Congratulations, you found the treasure! \n\n    ---- You win the game! ----    \n\n");
        self.isPlayingGame = NO;
    }
    
}

@end
