/*
 * driver.c
 *
 *  Created on: Sep 22, 2013
 *      Author: Nandigam
 */

#include <stdio.h>
#include "polynomial.h"

void displayMenu();

int main() {
    
    
	int choice, value;
	polynomial p1, p2, p3;
    
	for (;;) {
		displayMenu();
		scanf("%d",&choice);
        
		if (choice == 6) {
			break;
		}
        
		if (choice < 1 || choice > 10) {
			printf("Invalid selection. Try again...\n");
			continue;
		}
        
		switch (choice) {
			case 1:	// add
				printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
				printf("Polynomial 1: ");
				display(p1);
				printf("**** Data for Polynomial 2 ****\n");
				p2 = create();
				printf("Polynomial 2: ");
				display(p2);
				p3 = add(p1,p2);
				printf("Result of Addition: ");
				display(p3);
				break;
			case 2:	// subtract
				printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
				printf("Polynomial 1: ");
				display(p1);
				printf("**** Data for Polynomial 2 ****\n");
				p2 = create();
				printf("Polynomial 2: ");
				display(p2);
				p3 = subtract(p1,p2);
				printf("Result of Subtraction: ");
				display(p3);
				break;
			case 3:	// multiply
				printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
				printf("Polynomial 1: ");
				display(p1);
				printf("**** Data for Polynomial 2 ****\n");
				p2 = create();
				printf("Polynomial 2: ");
				display(p2);
				p3 = multiply(p1,p2);
				printf("Result of Multiplication: ");
				display(p3);
				break;
			case 4:	// scalar multiply
				printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
				printf("Polynomial 1: ");
				display(p1);
				printf("Enter an integer for scalar multiplication? ");
				scanf("%d", &value);
				p2 = scalarmultiply(p1,value);
				printf("Result of Scalar Multiplication: ");
				display(p2);
				break;
			case 5:	// evaluate
				printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
				printf("Polynomial 1: ");
				display(p1);
				printf("Evaluate polynomial at integer value? ");
				scanf("%d", &value);
				printf("Result of Evaluation: %d\n", evaluate(p1, value));
				break;
            case 7: //testing condense polynomial
                printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
                printf("Polynomial 1: ");
				display(p1);
                condense_polynomial(p1);
                display(p1);
                break;
            case 8:
                printf("**** Data for Polynomial 1 ****\n");
				p1 = create();
				printf("Polynomial 1: ");
				display(p1);
				printf("**** Data for Polynomial 2 ****\n");
				p2 = create();
				printf("Polynomial 2: ");
				display(p2);
				p3 = add(p1,p2);
				printf("Result of Addition: ");
				display(p3);
				break;

		}
	}
    
	printf("Good bye.\n");
	return 0;
}

void displayMenu()
{
	printf("\n****** Polynomial (univariate) Operations ******\n");
	printf("1. Add polynomials (p1 + p2)\n");
	printf("2. Subtract polynomials (p1 - p2)\n");
	printf("3. Multiply polynomials (p1 * p2)\n");
	printf("4. Multiply polynomial by scalar value (scalar * p1)\n");
	printf("5. Evaluate polynomial at a given value\n");
	printf("6. Quit\n");
	printf("Enter your selection (1,2,3,4,5,6)? ");
}


