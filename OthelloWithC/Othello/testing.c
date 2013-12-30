//
//  testing.c
//  Othello
//
//  Created by Thomas Verstraete on 9/21/13.
//  Copyright (c) 2013 Thomas Verstraete. All rights reserved.
//

#include <stdio.h>

/*****************************************************************
 This tests the Check string function
 *****************************************************************/
void test1 () {
    printf ("0 is false, 1 is true\n");
    
    char *test_str = "-BBBW-";
    char test_token = 'W';
    
    printf("testing %s:\n", test_str);
    printf ("result should be 1: %d\n\n",check_string_dir(test_str, test_token));
    
    test_str = "-W-";
    printf("testing %s:\n", test_str);
    printf ("result should be 0: %d\n\n",check_string_dir(test_str, test_token));
    
    test_str = "-BBBB-";
    printf("testing %s:\n", test_str);
    printf ("result should be 0: %d\n\n",check_string_dir(test_str, test_token));
    
    test_str = "----";
    printf("testing %s:\n", test_str);
    printf ("result should be 0: %d\n\n",check_string_dir(test_str, test_token));
    
    test_str = "-BW---";
    printf("testing %s:\n", test_str);
    printf ("result should be 1: %d\n\n",check_string_dir(test_str, test_token));
}


/*****************************************************************
 
 *****************************************************************/
void print_results (int check, int expected) {
    
    if (check == expected) {
        printf("success\n");
    } else {
        printf("fail\n");
    }
    
}

void blank_board (int size, char board[][size]) {
    
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            board[i][j] = '-';
        }
    }
    
}

/*****************************************************************
 this checks the check direction function
 *****************************************************************/
void test2 () {
    
    int size = 4;
    char board[size][size];
    create_board(size, board);
    char test_token = 'W';
    
    
    print_results(check_location(test_token, 0, 0, size, board), 0);
    print_results(check_location(test_token, 0, 1, size, board), 1);
    print_results(check_location(test_token, 0, 2, size, board), 0);
    print_results(check_location(test_token, 0, 3, size, board), 0);
    print_results(check_location(test_token, 1, 0, size, board), 1);
    print_results(check_location(test_token, 1, 3, size, board), 0);
    print_results(check_location(test_token, 2, 0, size, board), 0);
    print_results(check_location(test_token, 2, 3, size, board), 1);
    print_results(check_location(test_token, 3, 0, size, board), 0);
    print_results(check_location(test_token, 3, 1, size, board), 0);
    print_results(check_location(test_token, 3, 2, size, board), 1);
    print_results(check_location(test_token, 3, 3, size, board), 0);
}

/*****************************************************************
 Checking the game complete method
 *****************************************************************/
void test3() {
    
    int size = 2;
    char board[size][size];
    create_board(size, board);
    //print_board(size, board);
    char test_token = 'W';
    char other_token = 'B';
    
    
    printf("Full board: ");
    print_results(check_game_end(test_token, test_token, other_token, size, board), 0);
    
    board[0][0] = '-';
    //print_board(size, board);
    printf("not full no moves: ");
    print_results(check_game_end(test_token, test_token, other_token, size, board), 0);
    
    size = 4;
    blank_board(size, board);
    
    board[0][0] = 'W';
    board[0][1] = 'B';
    
    printf("W has move, B does not, check W: ");
    print_results(check_game_end(test_token, test_token, other_token, size, board), 1);
    
    printf("W has move, B does not Check B: ");
    print_results(check_game_end(other_token, test_token, other_token, size, board), -1);
}