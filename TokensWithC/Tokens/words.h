/*
 * words.h
 *
 *  Created on: Oct 8, 2013
 *      Author: Nandigam
 */

#ifndef WORDS_H_
#define WORDS_H_

/*
 * Reads text from standard input (or redirected from file), tokenizes,
 * and returns an array of strings/words found in input.
 */
char  **tokenize(int *nbr_words);

/*
 * Takes an array of words, array size, and prints each unique word.
 * If the word appears more than once, it prints the frequency next
 * to the word in parentheses.
 */
void print_words_with_freq_count(char **list, int size);

/*
 * Frees the memory allocated for the words in the array as well as
 * the memory allocated for the array itself.
 */
void free_memory(char **list, int size);

#endif /* WORDS_H_ */
