//
//  main.c
//  Adventure Game
//
//  Created by Josh Endter on 6/10/15.
//  Copyright (c) 2015 Josh Endter. All rights reserved.
//

/*

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>


// Declare the enum



// Declare the structs


// Declare the functions
void goDirection(Direction direction);
void goToCoordinate(int x, int y);
void playerStatus(Player *player);
bool isCurrentPossibleDirection(Direction attemptedDirection);
void goToRoom(Player *player, Room *roomToGoto);


// Declare global variables


int main(int argc, const char * argv[]) {
    
    //Start the game
    
    setupNewGame();
    
    while (playingGame == true) {
        
        playerStatus(&player);
        
        printf("\nWhat direction do you want to go in? ");
        
        char buffer[20] = "";
        scanf("%s", buffer);
        if ( strcmp(buffer, "north")==0 ) {
            goDirection(north);
        } else if ( strcmp(buffer, "south")==0 ) {
            goDirection(south);
        } else if ( strcmp(buffer, "east")==0 ) {
            goDirection(east);
        } else if ( strcmp(buffer, "west")==0 ) {
            goDirection(west);
        } else {
            printf("\nPlease enter a direction.\n");
        }
        
    }
    
    
    
    
    
    return 0;
}

void setupNewGame() {
    
    // Setup the room locations
    
    // Initialize everything in the rooms to NULL
    for (int x = 0; x < 4; x++) {
        for (int y = 0; y < 4; y++) {
            playfield[x][y].north = NULL;
            playfield[x][y].east = NULL;
            playfield[x][y].south = NULL;
            playfield[x][y].west = NULL;
            playfield[x][y].roomContents = empty;
            //playfield[x][y].roomX = x; // Debugging
            //playfield[x][y].roomY = y; // Debugging
            playfield[x][y].coordinates.x = x;
            playfield[x][y].coordinates.y = y;
        }
    }
    
    // Set the rooms relative to each other
    for (int x = 0; x < 4 ; x++) {
        for (int y = 0; y < 4; y++) {
            
            // Set north unless we are at the top of the playfield
            if (y > 0) {
                playfield[x][y].north = &playfield[x][y-1];
            }
            
            // Set south unless we are all the way to the bottom of the playfield
            if (y < 3) {
                playfield[x][y].south = &playfield[x][y+1];
            }
            
            // Set west unless we are all the way to the left of the playfield
            if (x > 0) {
                playfield[x][y].west = &playfield[x-1][y];
            }
            
            // Set east unless we are all the way to the right of the playfield
            if (x < 3) {
                playfield[x][y].east = &playfield[x+1][y];
            }
        }
    }
    
    // Put the treasure and cube in different random rooms
    Coordinates treasureRoomCoordinates = getRandomRoomCoordinates(4, 4);
    Coordinates cubeRoomCoordinates = getRandomRoomCoordinates(4, 4);
    while ( (treasureRoomCoordinates.x == cubeRoomCoordinates.x) && (treasureRoomCoordinates.y == cubeRoomCoordinates.y) ) {
        // Make sure that the treasure and cube aren't in the same room
        cubeRoomCoordinates = getRandomRoomCoordinates(4, 4);
    }
    
    playfield[treasureRoomCoordinates.x][treasureRoomCoordinates.y].roomContents = treasure;
    playfield[cubeRoomCoordinates.x][cubeRoomCoordinates.y].roomContents = cube;
    
    // Set the player's health
    player.playerHealth = startingHealth;
    
    // Set the player's location
    // to a random room that isn't the treasure or cube room
    Coordinates initialPlayerRoomCoordinates = getRandomRoomCoordinates(4, 4);
    while (
           
           ( (initialPlayerRoomCoordinates.x == treasureRoomCoordinates.x) && (initialPlayerRoomCoordinates.y == treasureRoomCoordinates.y) )
           ||
           
           ( (initialPlayerRoomCoordinates.x == cubeRoomCoordinates.x) && (initialPlayerRoomCoordinates.y == cubeRoomCoordinates.y) )
           
           ) {
        
        initialPlayerRoomCoordinates = getRandomRoomCoordinates(4, 4);
    }
    
    
    player.currentRoom = &playfield[initialPlayerRoomCoordinates.x][initialPlayerRoomCoordinates.y];
    
    // List the starting coordinates of all the objects in the playfield
    printf("Treasure room coordinates: (%d, %d) \nCube Coordinates: (%d, %d)\nPlayer Coordinates: (%d, %d)\n", treasureRoomCoordinates.x, treasureRoomCoordinates.y, cubeRoomCoordinates.x, cubeRoomCoordinates.y, initialPlayerRoomCoordinates.x, initialPlayerRoomCoordinates.y);
    
    
}


 
 
 
 
 
 
 
 
 
void goDirection(Direction direction) {
    
    if ( !isCurrentPossibleDirection(direction) ) {
        printf("\nThere is currently no exit in that direction.\n");
    } else if (direction == north) {
        if ( isCurrentPossibleDirection(north) ) {
            goToRoom(&player, player.currentRoom->north);
        }
    } else if (direction == south) {
        if ( isCurrentPossibleDirection(south) ) {
            goToRoom(&player, player.currentRoom->south);
        }
    } else if (direction == east) {
        if ( isCurrentPossibleDirection(east) ) {
            goToRoom(&player, player.currentRoom->east);
        }
    } else if (direction == west) {
        if ( isCurrentPossibleDirection(west) ) {
            goToRoom(&player, player.currentRoom->west);
        }
    }
    
}

void goToRoom(Player *player, Room *roomToGoto) {
    // Go to the room
    player->currentRoom = roomToGoto;
    
    // Check to see if the treasure or cube is in the room
    if (player->currentRoom->roomContents == cube) {
        player->playerHealth = player->playerHealth - (startingHealth / 2);
        
        printf("\nOh no, it's the gelatinous cube! It viciously attacks you!\n");
        
        if (player->playerHealth > 0) {
            printf("Your health is now: %d\n", player->playerHealth);
        } else {
            printf("Sorry, you've run out of health. \n\n    ---- Game over ----    \n\n");
            playingGame = false;
        }
        
    } else if (player->currentRoom->roomContents == treasure) {
        printf("\nCongratulations, you found the treasure! \nYou win the game!\n");
        playingGame = false;
    }
}

void playerStatus(Player *player) {
    printf("\nPlayer Health: %d\n", player->playerHealth);
    
    printf("Player position is (%d, %d) \n", player->currentRoom->coordinates.x, player->currentRoom->coordinates.y);
    
    printf("Directions Available: ");
    
    if ( isCurrentPossibleDirection(north) ) {
        printf("north ");
    }
    if ( isCurrentPossibleDirection(south) ) {
        printf("south ");
    }
    if ( isCurrentPossibleDirection(east) ) {
        printf("east ");
    }
    if ( isCurrentPossibleDirection(west) ) {
        printf("west ");
    }
}


 
*/
