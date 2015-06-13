//
//  main.m
//  Adventure Game Part II
//
//  Created by Josh Endter on 6/13/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Room.h"
#import "Player.h"
#import "Treasure.h"
#import "Cube.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Player *player = [[Player alloc] init];
        NSMutableArray *rooms = [[NSMutableArray alloc] init];
        
        
        // Create all the rooms, and set their coordinates
        for (long x = 0; x < 4; x++) {
            for (long y = 0; y < 4; y++) {
                NSLog(@"Making new room with x:%lu, y:%lu", x, y);
                Room *newRoom = [[Room alloc] init];
                newRoom.coordinates.x = x;
                newRoom.coordinates.y = y;
                [rooms addObject:newRoom];
            }
        }
        
        for (Room *room in rooms) {
            //NSLog(@"\nTesting Room (%lu, %lu)", room.coordinates.x, room.coordinates.y);
            
            // Set north unless we are at the top of the playfield
            if (room.coordinates.y > 0) {
                //playfield[x][y].north = &playfield[x][y-1];
                for (Room *roomMatchingCoordinates in rooms) {
                    if (room.coordinates.x == roomMatchingCoordinates.coordinates.x &&
                        room.coordinates.y-1 == roomMatchingCoordinates.coordinates.y)
                    {
                        room.north = roomMatchingCoordinates;
                        NSLog(@"The room north of (%lu, %lu) is (%lu, %lu)", room.coordinates.x, room.coordinates.y, roomMatchingCoordinates.coordinates.x, roomMatchingCoordinates.coordinates.y);
                    }
                }
            }
            
            // Set south unless we are all the way to the bottom of the playfield
            if (room.coordinates.y < 3) {
                //playfield[x][y].south = &playfield[x][y+1];
                for (Room *roomMatchingCoordinates in rooms) {
                    if (room.coordinates.x == roomMatchingCoordinates.coordinates.x &&
                        room.coordinates.y+1 == roomMatchingCoordinates.coordinates.y)
                    {
                        room.south = roomMatchingCoordinates;
                        NSLog(@"The room south of (%lu, %lu) is (%lu, %lu)", room.coordinates.x, room.coordinates.y, roomMatchingCoordinates.coordinates.x, roomMatchingCoordinates.coordinates.y);
                    }
                }
            }
            
            // Set west unless we are all the way to the left of the playfield
            if (room.coordinates.x > 0) {
                //playfield[x][y].west = &playfield[x-1][y];
                for (Room *roomMatchingCoordinates in rooms) {
                    if (room.coordinates.y == roomMatchingCoordinates.coordinates.y &&
                        room.coordinates.x-1 == roomMatchingCoordinates.coordinates.x)
                    {
                        room.west = roomMatchingCoordinates;
                        NSLog(@"The room west of (%lu, %lu) is (%lu, %lu)", room.coordinates.x, room.coordinates.y, roomMatchingCoordinates.coordinates.x, roomMatchingCoordinates.coordinates.y);
                    }
                }
            }
            
            // Set east unless we are all the way to the right of the playfield
            if (room.coordinates.x < 3) {
                //playfield[x][y].east = &playfield[x+1][y];
                for (Room *roomMatchingCoordinates in rooms) {
                    if (room.coordinates.y == roomMatchingCoordinates.coordinates.y &&
                        room.coordinates.x+1 == roomMatchingCoordinates.coordinates.x)
                    {
                        room.east = roomMatchingCoordinates;
                        NSLog(@"The room east of (%lu, %lu) is (%lu, %lu)", room.coordinates.x, room.coordinates.y, roomMatchingCoordinates.coordinates.x, roomMatchingCoordinates.coordinates.y);
                    }
                }
            }
        }
        
        
        // Setup the Treasure / Cube
        // -------------------------
        
        // Get the coordinates for the treasure and cube
        Coordinates *treasureRoomCoordinates = [Room getRandomRoomCoordinatesWithMaxX:4 maxY:4];
        Coordinates *cubeRoomCoordinates = [Room getRandomRoomCoordinatesWithMaxX:4 maxY:4];
        while ( (treasureRoomCoordinates.x == cubeRoomCoordinates.x) && (treasureRoomCoordinates.y == cubeRoomCoordinates.y) ) {
            // If the treasure and cube are in the same room, get new coordinates for the cube
            cubeRoomCoordinates = [Room getRandomRoomCoordinatesWithMaxX:4 maxY:4];
        }
        
        // Get initial coordinates for the player
        Coordinates *initialPlayerRoomCoordinates = [Room getRandomRoomCoordinatesWithMaxX:4 maxY:4];
        while (
               
               ( (initialPlayerRoomCoordinates.x == treasureRoomCoordinates.x) && (initialPlayerRoomCoordinates.y == treasureRoomCoordinates.y) )
               ||
               
               ( (initialPlayerRoomCoordinates.x == cubeRoomCoordinates.x) && (initialPlayerRoomCoordinates.y == cubeRoomCoordinates.y) )
               
               ) {
            
            initialPlayerRoomCoordinates = [Room getRandomRoomCoordinatesWithMaxX:4 maxY:4];
        }
        
        // Make the treasure and cube objects, and put them (and the player) into rooms
        Treasure *treasure = [[Treasure alloc] init];
        Cube *cube = [[Cube alloc] init];
        
        for (Room *room in rooms) {
            if (
                room.coordinates.x == treasureRoomCoordinates.x &&
                room.coordinates.y == treasureRoomCoordinates.y
                )
            {
                room.roomContents = treasure;
            }
            
            if (
                room.coordinates.x == cubeRoomCoordinates.x &&
                room.coordinates.y == cubeRoomCoordinates.y
                )
            {
                room.roomContents = cube;
            }
            
            if (
                room.coordinates.x == initialPlayerRoomCoordinates.x &&
                room.coordinates.y == initialPlayerRoomCoordinates.y
                )
            {
                player.currentRoom = room;
            }
        }
        
        
        // List the starting coordinates of all the objects in the playfield
        NSLog(@"\nTreasure room coordinates: (%lu, %lu) \nCube Coordinates: (%lu, %lu)\nPlayer Coordinates: (%lu, %lu)\n", treasureRoomCoordinates.x, treasureRoomCoordinates.y, cubeRoomCoordinates.x, cubeRoomCoordinates.y, initialPlayerRoomCoordinates.x, initialPlayerRoomCoordinates.y);
        
        //Test to see if the rooms have the objects in them
        /*
        for (Room *room in rooms) {
            //NSLog(@"Room x:%lu Room y:%lu", room.coordinates.x, room.coordinates.y);
            if (room.roomContents) {
                NSLog(@"Room contents of (%lu, %lu) is: %@", room.coordinates.x, room.coordinates.y, room.roomContents);
            }
        }
        */
        
        // The main game loop
        while (player.isPlayingGame == YES) {
            
            [player status];
            
            printf("What direction do you want to go in? ");

            char buffer[20] = "";
            scanf("%s", buffer);
            if ( strcmp(buffer, "north")==0 ) {
                [player goDirection:north];
            } else if ( strcmp(buffer, "south")==0 ) {
                [player goDirection:south];
            } else if ( strcmp(buffer, "east")==0 ) {
                [player goDirection:east];
            } else if ( strcmp(buffer, "west")==0 ) {
                [player goDirection:west];
            } else {
                NSLog(@"Please enter a direction.");
            }
            
        }

        
    }
    return 0;
}

