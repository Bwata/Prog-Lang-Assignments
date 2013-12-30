/*
 * Polynomial.h
 *
 *  Created on: Sep 22, 2013
 *      Author: Nandigam
 */

#ifndef POLYNOMIAL_H_
#define POLYNOMIAL_H_

struct term {
	int coef;
	int exp;
	struct term  *next;
};

typedef struct term term;

typedef term * polynomial;

void add_to_list(polynomial * head, polynomial addition);
void flip_signs(polynomial p);
void condense_polynomial (polynomial p);




/*
 * Function that prompts the user for information on terms in a polynomial,
 * constructs a polynomial (as a linked list of terms)
 * and returns a pointer to the first (head) term in the polynomial.
 */
polynomial create();


/*
 * Function that takes two polynomials, constructs and returns
 * a new polynomial that is the result of adding polynomials p1 and p2.
 * Returns NULL if either p1 or p2 is NULL
 */
polynomial add(polynomial p1, polynomial p2);


/*
 * Function that takes two polynomials, constructs and returns
 * a new polynomial that is the result of subtracting polynomial p2 from p1.
 * Returns return NULL if either p1 or p2 is NULL
 */
polynomial subtract(polynomial p1, polynomial p2);


/*
 * Function that takes two polynomials, constructs and returns
 * a new polynomial that is the result of multiplying polynomials p1 and p2.
 * Returns NULL if either p1 or p2 is NULL
 */
polynomial multiply(polynomial p1, polynomial p2);


/*
 * Function that takes a polynomial and scalar value, constructs and returns
 * a new polynomial that is the result of multiplying p1 by scalar.
 * Return NULL if either p1 is NULL
 */
polynomial scalarmultiply(polynomial p, int scalar);


/*
 * Function that takes a polynomial, evaluates that polynomial at
 * a given value and returns the result of evaluation
 * Return 0 if p is NULL
 */
int evaluate(polynomial p, int value);


/*
 * Function that displays the polynomial to the standard output
 * in a mathematical form.
 */
void display(polynomial p);

#endif /* POLYNOMIAL_H_ */
