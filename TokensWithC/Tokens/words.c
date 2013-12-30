/*
 * words.c
 *
 *  Created on: October 6, 2013
 *      Author: Thomas Verstraete
 */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include "words.h"

#define ASCEND		1
#define DESCEND		-1

int sort_order;	// used by compare()

int compare(const void *a, const void *b);

char *inputFile;

int main(int argc, char* argv[]) {
	char **wordlist;
	int nbr_words;
    
    if (argc == 2) {
        sort_order = DESCEND;
    } else {
        sort_order = ASCEND;
    }
    
	// tokenize the input text read from standard input (or redirected from a file)
	wordlist = tokenize(&nbr_words);
    
	// sort the array of words using qsort() from <stdlib.h>
	qsort(wordlist, nbr_words, sizeof(char *), compare);
    
	// print sorted words with frequency count
    print_words_with_freq_count(wordlist, nbr_words);

    
	// free memory space allocated for the array and words
	free_memory(wordlist, nbr_words);
    
	return 0;
}

char  **tokenize(int *nbr_words) {
    int array_size = 80;
    *nbr_words = 0;
    int word_size = 20;
    int word_count = 0;
    char c;

    char **list = (char **) calloc(array_size, sizeof(char *)); //allocates space for the array

    char *word = malloc(word_size);
    
    //printf("Start Reading\n");
    
    while ((scanf("%c",&c)) != EOF) {
        
        if (isalpha(c)) //the char scanned is an alphabetic charactor
        {
            //resize word to fit more charactors
            if (word_count == word_size) {
                word_size *=2;
                word = realloc(word, word_size);
            }
            
            //add char to word
            word[word_count++] = (char) c;
        }
        
        else  //the char scanned is NOT an alphabetic charactor
        {
            if (word_count != 0) {

                //checks to see if there is enough size for the end of string char
                if (word_count == word_size) {
                    word_size +=1;
                    word = realloc(word, word_size);
                    word[word_count++] = 0;
                } else {    //enough room no make smaller
                    word = realloc(word, word_count);
                }
                
                //resize array to fit more words
                if (*nbr_words == array_size) {
                    array_size *= 2;
                    list = (char **) realloc(list, array_size * sizeof(char *));
                }
                
                //add word to array and count it
                list[*nbr_words] = word;
                *nbr_words += 1;
                
                //carve new space for new word and prep for it
                word_size = 20;
                word = malloc(word_size);
                word_count = 0;
            }
        }
    }
    
    return list;
}

void print_words_with_freq_count(char **list, int size) {
    
    for (int i = 0; i < size; i++) {
        printf("%s", list[i]);
        
        if ((i < size-1) && (strcmp(list[i], list[i+1]) == 0)) {
            int count = 1;
            while ((i < size-1) && (strcmp(list[i], list[i+1]) == 0)) {
                count++;
                i++;
            }
            
            printf(" (%d)", count);
        }
        printf("\n");
    }
}

void free_memory(char **list, int size) {
    
//      could not get to work
//    	for (int i = 0; i < size; i++) {
//            free(list[i]);
//        }
    
    free(list);
}

// function used by qsort() of <stdlib.h>
int compare(const void *a, const void *b) {
	char* *s = (char* *) a;
	char* *t = (char* *) b;
	return sort_order * strcmp(*s, *t); // sort_order is -1 or 1
}

