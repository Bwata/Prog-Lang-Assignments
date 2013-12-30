/*
 * Polynomial.c
 *
 * Author(s): Thomas Verstraete
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include "polynomial.h"

static
void add_to_list(polynomial * head, polynomial addition) {
    
    //No list yet, need to start one
    if (*head == NULL) {
        //addition->next = NULL;
        *head = addition;
    }
    
    //if there is only one item in the list
    else if ((*head)->next == NULL) {
        if ((*head)->exp > addition->exp) {
            (*head)->next = addition;
        } else {
            addition->next = (*head);
            (*head) = addition;
        }
    }
    
    //If the added should be the head
    else if ((*head)->exp < addition->exp) {
        addition->next = *head;
        *head = addition;
    }
    
    //All other possibilities, add new item in or at the end of the list.
    else {
        polynomial location = *head;
        
        while (location->next != NULL && location->next->exp > addition->exp) {
            location = location->next;
        }
        
        if (location->next == NULL) {
            location->next = addition;
        } else {
            addition->next = location->next;
            location->next = addition;
        }
    }
}

static
void flip_signs(polynomial p) {
    while (p != NULL) {
        p->coef = -(p->coef);
        p = p->next;
    }
}


static
void condense_polynomial (polynomial p) {
    while (p->next != NULL) {
        
        if (p->exp == p->next->exp) {
            p->coef = p->coef + p->next->coef;
            p->next = p->next->next;
            
            if (p->next == NULL) {
                break;
            }
            
            if (p->exp == p->next->exp) {
                continue;
            }
        }
        p = p->next;
    }
}

/*
 * Function that prompts the user for information on terms in a polynomial,
 * constructs a polynomial (as a linked list of terms)
 * and returns a pointer to the first (head) term in the polynomial.
 */
polynomial create() {
	polynomial p = NULL;
    int poly_size;
    
    printf("Enter number of terms in the polynomial: ");
    scanf("%d", &poly_size);
    
    for (int i = 0; i < poly_size; i++) {
        int input_nums[4];
        
        printf("Enter coefficient and exponent of term %d: ", i+1);
        
        scanf("%d", &input_nums[0]);
        scanf("%d", &input_nums[1]);
        
        if (input_nums[0] == 0) {
            continue;
        }
		
        polynomial temp = malloc(sizeof(term));
        temp->coef = input_nums[0];
        temp->exp = input_nums[1];
        temp->next = NULL;
        add_to_list(&p, temp);
    }
	
	return p;
}

/*
 * Function that displays the polynomial to the standard output
 * in a mathematical form.
 */
void display(polynomial p)
{
    bool head = true;
    
	while (p != NULL) {
        
        if (p->coef != 0) {
            
            // if/else to print opperator and coef
            if (head) {
                if (abs(p->coef != 1)) {
                    printf("%d", p->coef);
                }
                head = false;
            } else {
                //print opperator
                if (p->coef < 0) {
                    printf(" - ");
                } else {
                    printf(" + ");
                }
                
                //print coef
                if (abs(p->coef != 1)) {
                    printf("%d", abs (p->coef));
                }
            }
            
            //print the variable and exp
            if (p->exp != 0) {
                printf("x");
                
                //print exp
                if (p->exp !=1) {
                    printf("^%d", p->exp);
                }
            }
        }
        p = p->next;
    }
    printf("\n");
}

/*
 * Function that takes two polynomials, constructs and returns
 * a new polynomial that is the result of adding polynomials p1 and p2.
 * Returns NULL if either p1 or p2 is NULL
 */
polynomial add(polynomial p1, polynomial p2) {
	if (p1 == NULL || p2 == NULL) {
		return NULL;
	}
    
	polynomial result = NULL;

    while (p2 != NULL) {
        
        polynomial temp = malloc(sizeof(term));
        
        *temp = *p2;
        temp->next = NULL;
        add_to_list(&p1, temp);
        
        p2 = p2->next;
    }
    
    condense_polynomial(p1);
    return p1;
}


/*
 * Function that takes two polynomials, constructs and returns
 * a new polynomial that is the result of subtracting polynomial p2 from p1.
 * Returns return NULL if either p1 or p2 is NULL
 */
polynomial subtract(polynomial p1, polynomial p2) {
	if (p1 == NULL || p2 == NULL) {
		return NULL;
	}
    
    flip_signs(p2);
    
    while (p2 != NULL) {
        
        polynomial temp = malloc(sizeof(term));
        
        *temp = *p2;
        temp->next = NULL;
        add_to_list(&p1, temp);
        
        p2 = p2->next;
    }
    
    condense_polynomial(p1);
    
    return p1;
}


/*
 * Function that takes two polynomials, constructs and returns
 * a new polynomial that is the result of multiplying polynomials p1 and p2.
 * Returns NULL if either p1 or p2 is NULL
 */
polynomial multiply(polynomial p1, polynomial p2)
{
	if (p1 == NULL || p2 == NULL) {
		return NULL;
	}
    
	polynomial result = NULL;
    
    polynomial p22 = p2;
    
	// TO DO
    while (p1 != NULL) {
        
        p22 = p2;
        
        while (p22 != NULL) {
            
            polynomial temp = malloc(sizeof(term));
        
            temp->coef = p1->coef * p22-> coef;
            temp->exp = p1->exp + p22-> exp;
            temp->next = NULL;
            add_to_list(&result, temp);
        
            p22 = p22->next;
        }
        p1 = p1->next;
    }
    condense_polynomial(result);
    
	return result;
}


/*
 * Function that takes a polynomial and scalar value, constructs and returns
 * a new polynomial that is the result of multiplying p1 by scalar.
 * Return NULL if either p1 is NULL
 */
polynomial scalarmultiply(polynomial p, int scalar)
{
	if (p == NULL) {
		return NULL;
	}
    
	polynomial result = p;

    //multiply every coef
    while (p != NULL) {
        p->coef = p->coef * scalar;
        p = p->next;
    }
	return result;
}

/*
 * Function that takes a polynomial, evaluates that polynomial at
 * a given value and returns the result of evaluation
 * Return 0 if p is NULL
 */
int evaluate(polynomial p, int value)
{
	int result = 0;
    
	//evale each portion and add to total
    while (p != NULL) {
        result = result + (p->coef * (pow(value, p->exp)));
        p = p->next;
    }
    
	return result;
}