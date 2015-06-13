//
//  Room.h
//  Adventure Game
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ObjectInRoom.h"
#import "Coordinates.h"

typedef enum {
    north,
    south,
    east,
    west,
    none
} Direction;

@interface Room : NSObject

@property (weak, nonatomic) Room *north;
@property (weak, nonatomic) Room *east;
@property (weak, nonatomic) Room *south;
@property (weak, nonatomic) Room *west;

@property (nonatomic) Coordinates *coordinates;
@property (strong, nonatomic) ObjectInRoom *roomContents;


- (BOOL) isCurrentPossibleDirection:(Direction)attemptedDirection;
- (Room *) roomInDirection:(Direction)attemptedDirection;

+ (Coordinates *) getRandomRoomCoordinatesWithMaxX:(int)maxX maxY:(int)maxY;


@end
