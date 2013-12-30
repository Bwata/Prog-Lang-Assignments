//
//  othello_engine.h
//  Othello
//
//  Created by Thomas Verstraete on 9/16/13.
//  Copyright (c) 2013 Thomas Verstraete. All rights reserved.
//

#ifndef Othello_othello_engine_h
#define Othello_othello_engine_h

//create the board and set the initial tokens.
void create_board (int size, char board[][size]);

//Prints out the contents of the board.
void print_board (int size, char board[][size]);

//Checks to see if that location is a valid position for the current player.
int check_location(char token, int row, int col, int size, char board[][size]);

//checks to see if the string is a valid move.
int check_string_dir (char *str, char token);

//checks to see if a particular direction from a particular location.
int check_direction(char token, int start_row, int start_col, int row_dir, int col_dir, int size, char board[][size]);

//Fills in a valid direction from a given poisition with a given token.
void fill_direction(char token, int start_row, int start_col, int row_dir, int col_dir, int size, char board[][size]);

//Checks for validity and makes a move if valid.
int make_move (char token, int row, int col, int size, char board[][size]);

//Checks the whole board to see if there are any valid moves for a given palyer.
int check_valid_moves(char token, int size, char board[][size]);

//counts the number of tokens for a given player on the board.
int token_count (char token, int size, char board[][size]);

//Checks if there are any moves for any of the players. 
int check_game_end(char current_player, char first_player, char second_player, int size, char board[][size]);

#endif
