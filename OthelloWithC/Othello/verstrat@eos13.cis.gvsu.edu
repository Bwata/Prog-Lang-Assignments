//
//  main.c
//  Othello
//
//  Created by Thomas Verstraete on 9/16/13.
//  Copyright (c) 2013 Thomas Verstraete. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "othello_engine.h"

/*****************************************************************
 Checks to make sure the command line arguments are valid for this
 program.
 1) should be a number 6, 8 or 10 to indicate the board size.
 2) should be a number 1 or 2 to indicate the player to go first?
 3) should be B or W to indecate the first players token.
 
 Parameters:
    int: number of arguments passed to the program;
    const char *: array of the arguments passed to the program
 
 Return:
    int: number of invalid areguments.
 *****************************************************************/
int check_args (int argc, const char * argv[]) {
    
    int invalid_args = 0;
    
    //Checks to make sure the number of arguments are correct
    if (argc != 4) {
        printf("You have an invalid number of arguments, Please try again");
        return 1;
    }
    
    //Sets size and check if it is a valid input.
    int size = atoi(argv[1]);
    if ((size % 2 != 0) || ((6 > size) || (size > 10))) {
        printf("You may only play on boards sized 6, 8 or 10.\n");
        printf("You typed %s.\n", argv[1]);
        invalid_args++;
    }
    
    //checks if the player number is 1 or 2.
    int first_player = atoi(argv[2]);
    if (first_player < 1 || first_player > 2) {
        printf("You input an invalid player number to start.\n");
        printf("You typed %s.\n", argv[2]);
        
        invalid_args++;
    }
    
    //checks if the token indecator is B or W.
    if ((*argv[3] != 'B' && *argv[3] != 'W')) {
        
        printf("You may only decide B or W for player color.\n");
        printf("You typed %s.\n", argv[3]);
        
        invalid_args++;
    }
    
    //gives the user a little help along the way
    if (invalid_args > 0) {
        printf("you have %d invalid arguments, Please try again.\n", invalid_args);
    }
    
    return invalid_args;
}

/*****************************************************************
 Sets up the first players token based on the argument passed.
 
 Parameters:
    const char *: value to derive the first player's token;
 
 Returns:
    char: First Players token;
 *****************************************************************/
char set_first_player(const char * argv) {
    
    //don't know why this work but it does
    if (*argv == 'B') {
        return 'B';
        
    } else {
        return 'W';
    }
}

/*****************************************************************
 Sets up the second players token based on the argument passed.
 
 Parameters:
 const char *: value to derive the second player's token;
 
 Returns:
 char: Second Players token;
 *****************************************************************/
char set_second_player(const char * argv) {
    
    //don't know why this work but it does
    if (*argv == 'B') {
        return 'W';
        
    } else {
        return 'B';
    }
}


/*****************************************************************
 This is the primary game location. It sets up the game to play, 
 then runs through the loop of the game. And then when the game
 is done it tells the winner and ends.
 
 Parameters:
    int: number of arguments passed to the program;
    const char *: array of the arguments passed to the program

 Returns:
    0: it only returns 0;
 *****************************************************************/
//int game(int argc, const char * argv[])
int game(int size, char board[][size], char * current_player, char player_one, char player_two)
{
    int game_done = 0;
    
    //game loop
    while (game_done == 0) {
        
        //checks to see if there are any valid moves left in the game
        int game_check = check_game_end(*current_player, player_one, player_two, size, board);
        
        if (game_check == 0) {
            
            //game over, no moves for anyone
            game_done = 1;
            break;
            
        } else if (game_check == -1) {
            
            //current player has no moves, need to swap
            printf("Player %c has no valid moves.\n", *current_player);
            
            //swap players
            if (*current_player == player_one) {
                current_player = &player_two;
            } else {
                current_player = &player_one;
            }
        }
        
        
        char location;
        
        //get the row location
        printf("Player %c please select a row: ", *current_player);
        scanf("%s", &location);
        if (location == 'q') {
            return 0;
        }
        int x_coord = atoi(&location);
        x_coord--;
        
        //get the column location
        printf("Player %C please select a column: ", *current_player);
        scanf("%s", &location);
        if (location == 'q') {
            return 0;
        }

        int y_coord = atoi(&location);
        y_coord--;
        
        //check if move is valid for player
        if (check_location(*current_player, x_coord, y_coord, size, board) == 0) { //invalid move
            printf("The location (%d, %d) is not valid, please try agian\n", x_coord+1, y_coord+1);
            
        } else {//valid move
            make_move(*current_player, x_coord, y_coord, size, board);
            
            //switch players
            if (*current_player == player_one) {
                                current_player = &player_two;
            } else {
               
                current_player = &player_one;
            }
        }
        
        print_board(size, board);
    } //end game loop
    
    //Finish up game
    printf("Game over.\n");
    
    //list player 1's score
    int player_one_score = token_count(player_one, size, board);
    printf("Player %c has %d tokens.\n", player_one, player_one_score);
    
    //list player 2's score
    int player_two_score = token_count(player_two, size, board);
    printf("Player %c has %d tokens.\n", player_two, player_two_score);
    
    //declare the winner
    if (player_one_score > player_two_score) {
        printf("Player %c wins", player_one);
    } else if (player_one_score < player_two_score) {
        printf("Player %c wins", player_two);
    } else {
        printf("It is a tie, everyone loses.");
    }
    
	return 0;
}

/*****************************************************************
 Display some information to hep the players.
 *****************************************************************/
void print_info () {
    printf("I know you haven't chosen to play my game by choice");
    printf("and that you are doing so to give me a grade.\n");
    printf("I hope everything goes well for you");
    printf("but if you want to exit at any time just");
    printf("enter 'q' for quit.\n\n Enjoy!\n\n");
}


/*****************************************************************
 Game Set Up. Initialize the board, board size, first and second
 players and set the current player.
 
 Parameters:
    int: number of arguments;
    const char *: array of arguments
 
 Return:
    0: it only returns 0;
 *****************************************************************/
int game_set_up (int argc, const char * argv[]) {
    
    print_info();
    
    //checks the arguments and makes sure they are valid.
    if (check_args(argc, argv) > 0) {
        return 0;
    }
    
    //Size of the game board
    int size = atoi(argv[1]);
    
    //game board
    char board[size][size];
    create_board(size, board);
    
    //set player tokens
    char player_one = set_first_player(argv[3]);
    char player_two = set_second_player(argv[3]);
    
    //prints the initial board.
    print_board(size, board);
    
    //Use current play inside loop
    char *current_player;
    current_player = &player_one;

    //Start game
    return game(size, board, current_player, player_one, player_two);
}


/*****************************************************************
 Main function. Sets the game moving right along. Footloose and
 fancy free. Also allows me to divert to do some of the testing
 I did on the project.
 
 Parameters:
 int: number of arguments;
 const char *: array of arguments
 
 Return:
 0: it only returns 0;

 *****************************************************************/
int main(int argc, const char * argv[])
{
    return game_set_up(argc, argv);

}

