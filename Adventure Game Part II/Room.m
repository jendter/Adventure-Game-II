//
//  Room.m
//  Adventure Game
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import "Room.h"

@implementation Room

- (instancetype)init
{
    self = [super init];
    if (self) {
        _coordinates = [[Coordinates alloc] init];
    }
    return self;
}


- (BOOL) isCurrentPossibleDirection:(Direction)attemptedDirection {
    
    if (attemptedDirection == north) {
        if (self.north) {
            return YES;
        } else {
            return NO;
        }
    } else if (attemptedDirection == south) {
        if (self.south) {
            return YES;
        } else {
            return NO;
        }
    } else if (attemptedDirection == east) {
        if (self.east) {
            return YES;
        } else {
            return NO;
        }
    } else if (attemptedDirection == west) {
        if (self.west) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

- (Room *) roomInDirection:(Direction)attemptedDirection {
    if (attemptedDirection == north) {
        return self.north;
    } else if (attemptedDirection == south) {
        return self.south;
    } else if (attemptedDirection == east) {
        return self.east;
    } else if (attemptedDirection == west) {
        return self.west;
    }
    
    return nil;
}


+ (Coordinates *) getRandomRoomCoordinatesWithMaxX:(int)maxX maxY:(int)maxY {
    Coordinates *roomCoordinates = [[Coordinates alloc] init];
    roomCoordinates.x = arc4random_uniform(maxX);
    roomCoordinates.y = arc4random_uniform(maxY);
    
    return roomCoordinates;
}


@end
