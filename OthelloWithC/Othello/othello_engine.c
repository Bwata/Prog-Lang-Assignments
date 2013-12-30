//
//  othello_engine.c
//  Othello
//
//  Created by Thomas Verstraete on 9/16/13.
//  Copyright (c) 2013 Thomas Verstraete. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>


/*****************************************************************
 Inicializes the board of the given size and places starter
 tokens in the middle of the board.
 
 Parameters:
    int: size of the board;
    char**: 2d array of the board;
 *****************************************************************/
void create_board (int size, char board[][size]) {
    
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            board[i][j] = '-';
        }
    }
    
    //set center pieces
    board[size/2-1][size/2-1] = 'B';
    board[size/2-1][size/2] = 'W';
    board[size/2][size/2] = 'B';
    board[size/2][size/2-1] = 'W';
}


/*****************************************************************
 Prints out the game board in a fancy legable way.
 
 Parameters:
    int: size of the board;
    char**: 2d array of the board;
 *****************************************************************/
void print_board (int size, char board[][size]) {
    
    //adds top number line
    for (int i = 0; i <= size; i++) {
        printf("%2d", i);
    }
    printf("\n");
    
    //moves through each row of array
    for (int i = 0; i < size; i++) {
        
        //add number at beginning of line
        printf("%2d ", (i+1));
        
        //moves through each column of array
        for (int j = 0; j < size; j++) {
            printf("%c ",board[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
}


/*****************************************************************
 I was not able to figure out how to use regular expressions to 
 check the strings so this is the next best thing. It is a bit
 hacky but it works. The Regex I am looking for is .B+W or .W+B
 
 Parameters:
    char *: string to check for validity;
    char: terminating token to look for;
 
 Returns:
    0: if the string is not valid;
    1: if the string is valid;
 *****************************************************************/
int check_string_dir (char *str, char token) {
    
    /*looks for the set string to indicate if that direction has
     a valid move*/
    
    int i = 1;
    
    if (token == 'W') {
        
        //loop through string
        for (; i < 10; i ++) {
            
            //checks what char is in the string
            switch (str[i])
            {
                //need to stop and check validity
                case 'W':
                    i = i + 30;
			 		break;
                    
                //keep moving, still may be valid
                case 'B':
					break;
                    
                //in no way is this a valid move
                case '-':
                    i = i + 20;
					break;
                    
                //in no way is this a valid move
                default:
                    i = i + 10;
					break;
            }
        }
        
    } else {
        
        //loop through string
        for (; i < 10; i ++) {
            switch (str[i])
            {
                //need to stop and check validity
                case 'B':
                    i = i + 30;
			 		break;
                    
                //keep moving, still may be valid
                case 'W':
					break;
                    
                //in no way is this a valid move
                case '-':
                    i = i + 20;
					break;
                    
                //in no way is this a valid move
                default:
                    i = i + 10;
					break;
            }
        }
    }
    
    //trust me if it is over 32 it is a valid string
    if (i > 32) {
        return 1;
    
    }
    //anything less then or equal to 32 is invalid
    else {
        return 0;
    }
}


/*****************************************************************
 Checks the board in a given direction from a starting point.
 Direction is determined by the row_dir and col_dir parameter 
 which gets added to the current row and column ever cycle. 
 
 Parameters:
    char: either 'B' or 'W';
    int: the row num to start the search;
    int: the column num to start the search;
    int: value to add to row every cycle to move on the board;
    int: value to add to column every cycle to move on the board;
    int: size of the board;
    char**: 2d array of the board;
 
 returns:
    1: if direction is valid;
    0: if direction is not valid;
 *****************************************************************/
int check_direction(char token, int start_row, int start_col,
                      int row_dir, int col_dir,
                      int size, char board[][size]) {
    
    //Reset check string.
    char str[10] = "";
    int count = 0;
    
    
    
    /*travel through the board until it reaches an edge
     along the way concat a string of chars it comes accross.*/
    while ((start_row >= 0 && start_row < size) &&
           (start_col >= 0 && start_col < size)) {
        str[count] = board[start_row][start_col];
        start_row = start_row + row_dir;
        start_col = start_col + col_dir;
        count++;
    }
    
    return check_string_dir(str, token);
}


/*****************************************************************
 Direction must be checked to be valid ahead of time!!
 this will fill in the line of char's with the passed token.
 
 Parameters:
    char: either 'B' or 'W', token to fill in line with;
    int: the row num to start the search;
    int: the column num to start the search;
    int: value to add to row every cycle to move on the board;
    int: value to add to column every cycle to move on the board;
    int: size of the board;
    char**: 2d array of the board;
 *****************************************************************/
void fill_direction(char token, int start_row, int start_col,
                    int row_dir, int col_dir,
                    int size, char board[][size]) {
    
    /*In case there were previous fills the first spot needs 
     to be reset.*/
    board[start_row][start_col] = '-';
    
    /*travels through the board in a single direction untill
        it reaches the passed token.*/
    while (board[start_row][start_col] != token) {
        board[start_row][start_col] = token;
        start_row = start_row + row_dir;
        start_col = start_col + col_dir;
    }
}


/*****************************************************************
 Checks to see if passed token has a valid move at that location.
 
 Parameters:
    char: either 'B' or 'W', token of player to check for;
    int: the row num of move;
    int: the column num of move;
    int: size of the board;
    char**: 2d array of the board;
 
 Returns:
    0: if move is invalid;
    < 1: if move is valid, number indicates num of valid directions;
 *****************************************************************/
int check_location(char token, int row, int col,
                   int size, char board[][size]) {
    
    int move_num = 0;
    
    //Check north
    if (check_direction(token, row, col, 0, -1, size, board) == 1) {
        move_num++;
    }
    
    //Check northeast
    if (check_direction(token, row, col, 1, -1, size, board) == 1) {
        move_num++;
    }
    
    //Check east
    if (check_direction(token, row, col, 1, 0, size, board) == 1) {
        move_num++;
    }
    
    //Check southeast
    if (check_direction(token, row, col, 1, 1, size, board) == 1) {
        move_num++;
    }
    
    //Check south
    if (check_direction(token, row, col, 0, 1, size, board) == 1) {
        move_num++;
    }
    
    //Check southwest
    if (check_direction(token, row, col, -1, 1, size, board) == 1) {
        move_num++;
    }
    
    //Check west
    if (check_direction(token, row, col, -1, 0, size, board) == 1) {
        move_num++;
    }
    
    //Check northwest
    if (check_direction(token, row, col, -1, -1, size, board) == 1) {
        move_num++;
    }
    
    return move_num;
}


/*****************************************************************
 Checks to see if passed token has a valid move, and if it is it
 fills in the tokens for the move.
 
 Parameters:
    char: either 'B' or 'W', token of player who made move;
    int: the row num of move;
    int: the column num of move;
    int: size of the board;
    char**: 2d array of the board;

 Returns:
    0: if move is invalid;
    < 1: if move is valid, number indicates num of valid directions;
 *****************************************************************/
int make_move (char token, int row, int col,
               int size, char board[][size]) {
    
    int move_num = 0;
    //travel clockwise around the location
    
    //Check north
    if (check_direction(token, row, col, 0, -1, size, board) == 1) {
        fill_direction(token, row, col, 0, -1, size, board);
        move_num++;
    }
    
    //Check northeast
    if (check_direction(token, row, col, 1, -1, size, board) == 1) {
        fill_direction(token, row, col, 1, -1, size, board);
        move_num++;
    }
    
    //Check east
    if (check_direction(token, row, col, 1, 0, size, board) == 1) {
        fill_direction(token, row, col, 1, 0, size, board);
        move_num++;
    }
    
    //Check southeast
    if (check_direction(token, row, col, 1, 1, size, board) == 1) {
        fill_direction(token, row, col, 1, 1, size, board);
        move_num++;
    }
    
    //Check south
    if (check_direction(token, row, col, 0, 1, size, board) == 1) {
        fill_direction(token, row, col, 0, 1, size, board);
        move_num++;
    }
    
    //Check southwest
    if (check_direction(token, row, col, -1, 1, size, board) == 1) {
        fill_direction(token, row, col, -1, 1, size, board);
        move_num++;
    }
    
    //Check west
    if (check_direction(token, row, col, -1, 0, size, board) == 1) {
        fill_direction(token, row, col, -1, 0, size, board);
        move_num++;
    }
    
    //Check northwest
    if (check_direction(token, row, col, -1, -1, size, board) == 1) {
        fill_direction(token, row, col, -1, -1, size, board);
        move_num++;
    }
    
    return move_num;
}


/*****************************************************************
 checks to see if passed token has a valid move
 
 Parameters:
    char: either 'B' or 'W', token of player to check for;
    int: size of the board;
    char**: 2d array of the board;
 
 Returns:
    0: if no moves;
    1: if has valid moves;
 *****************************************************************/
int check_valid_moves(char token, int size, char board[][size]) {
    
    //move through each row
    for (int i = 0; i < size; i++) {
        
        //move through each column
        for (int j = 0; j < size; j++) {
            
            //check if location has been played
            if (board[i][j] == '-') {
                
                /*check if there is a valid move from this location
                 if there is one valid more for this token stop
                 looking and return true*/
                if (check_location(token, i, j, size, board) > 0) {
                    return 1;
                }
            }
        }
    }
    return 0;
}


/*****************************************************************
 Checks if there are any valid moves for either charactor
 
 Parameters:
    char: current player to check first for valid moves;
    char: first player to compare to find other player;
    char: second player to compare to find other player;
    int: size of the board;
    har**: 2d array of the board;
 
 Returns:
    1: if the current player has a valid move;
    -1: if the current player has no valid moves but not current
        does have a valid move;
    0: if there are no valid moves for either player;
 
 *****************************************************************/
int check_game_end(char current_player, char first_player, char second_player, int size, char board[][size]) {
    
    if (check_valid_moves(current_player, size, board) == 0) {
        
        //checks to see who the not current_player is
        if (current_player == first_player) {
            
            if (check_valid_moves(second_player, size, board) == 0) {
                //no players have valid moves
                return 0;
            }
            
            
        } else {
            
            if (check_valid_moves(first_player, size, board) == 0) {
                //no players have valid moves
                return 0;
            }
        }
        
        //return player does not have valid moves
        //but not current does.
        return -1;
    }
    
    //current player has valid moves
    return 1;
}


/*****************************************************************
 Counts the number of times the passed token is on the board
 
 Parameters:
    char: either 'B' or 'W', token of player to check for;
    int: size of the board;
    char**: 2d array of the board;
 
 Returns:
    int: number of instances of the taken on the board;
 
 *****************************************************************/
int token_count (char token, int size, char board[][size]) {
    
    int count = 0;
    
    //move through each row
    for (int i = 0; i < size; i++) {
        
        //move through each column
        for (int j = 0; j < size; j++) {
            
            //count location matching token
            if (board[i][j] == token) {
                count++;
            }
        }
    }

    return count;
}