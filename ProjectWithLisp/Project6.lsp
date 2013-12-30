;
; CIS 343, Fall 2013, Project 6
;
; Thomas Verstraete:
;

(defun my-gcd(a b)
    (if (or (equal a 0) (equal b 0))
    	(+ a b)
    	(my-gcd b (mod a b))
	)
)

(defun is-palindrome(l)
	(case (length l) 
		(0 T)
		(1 T)
		(2 (equal (first l) (nth (- (length l) 1) l)))
		(T (if (equal (first l) (nth (- (length l) 1) l))
				(is-palindrome (rest (butlast l)))
				nil
			)
		)
	)

)

(defun intlist(n)
	(if (< 0 n)	
		(if (< 1 n)								
			(append (intlist2 (- n 1)) (list n))
			(list 1)							
		)
		nil
	)
)

(defun analyze(l)
	(if (< 0 (length l))
		(if (< 1 (length l))
			(if (listp (first l))
				(append (analyze (rest l)) '(list))
				(append (analyze (rest l)) '(atom))
			)
			(if (listp (first l))
				(append '(list))
				(append '(atom))
			)
		)
		nil
	)
		
)

(defun only-atoms(l)
	(if (< 0 (length l))
		(if (eql 1 (length l))
			(if (atom (first l))
				t
				nil
			)
			(if (atom (first l))
				(only-atoms (rest l))
				nil
			)
		)
	)
)

(defun only-atoms-iter(l)
	(if (< 0 (length l))
		(let ((result t))
			(dolist (element l result)
				(when (not(atom element)) (setf result nil))
			)
		)
		nil
	)
)

(defun quad-roots(a b c)
	(list 
		(/ 
			(+ (- 0 b) 
				(sqrt (- (expt b 2) (* 4 a c)))
			)
			(* 2 a)
		)
		
		(/ 
			(- (- 0 b) 
				(sqrt (- (expt b 2) (* 4 a c)))
			)
			(* 2 a)
		)
	)
	
)

(defun rotate-left(l n)
	(if (> n 0) (progn
		(setf n (mod n (length l)))
		(append 
			(nthcdr n l) 
			(butlast l (- (length l) n))))
		l
	)
)

(defun evens(l)
	(if (> (length l) 0)
		(cons (if (> (length l) 1)
				(evens (
				
				
				)))))
)

(defun evens-iter(l)
	(let ((nl (list '(nil))))
		(dotimes (count (length l) result)
			(if (eql (mod count 2) 0)
				(cons nl (list (nth count l)))
			)
		)
	)
	'(nil)
)


;
; DO NOT MODIFY: Test driver function that calls functions defined above
;
(defun test()
    ; tests for my-gcd
	(if (equal (my-gcd 42 56) 14) (print "my-gcd-t1: PASS") (print "my-gcd-t1: FAIL"))
	(if (equal (my-gcd 12 18) 6) (print "my-gcd-t2: PASS") (print "my-gcd-t2: FAIL"))
	(if (equal (my-gcd 3 5) 1) (print "my-gcd-t3: PASS") (print "my-gcd-t3: FAIL"))
	(if (equal (my-gcd 12 60) 12) (print "my-gcd-t4: PASS") (print "my-gcd-t4: FAIL"))
	(if (equal (my-gcd 12 90) 6) (print "my-gcd-t5: PASS") (print "my-gcd-t5: FAIL"))
	
	; tests for is-palindrome
	(if (equal (is-palindrome '(a b b a)) t) (print "is-palindrome-t1: PASS") (print "is-palindrome-t1: FAIL"))
	(if (equal (is-palindrome '(a b c)) nil) (print "is-palindrome-t2: PASS") (print "is-palindrome-t2: FAIL"))
	(if (equal (is-palindrome '(a b a)) t) (print "is-palindrome-t3: PASS") (print "is-palindrome-t3: FAIL"))
	(if (equal (is-palindrome '(a b)) nil) (print "is-palindrome-t4: PASS") (print "is-palindrome-t4: FAIL"))
	(if (equal (is-palindrome '(a)) t) (print "is-palindrome-t5: PASS") (print "is-palindrome-t5: FAIL"))
	(if (equal (is-palindrome '()) t) (print "is-palindrome-t6: PASS") (print "is-palindrome-t6: FAIL"))
	
	; tests for intlist	
	(if (equal (intlist 8) '(1 2 3 4 5 6 7 8)) (print "intlist-t1: PASS") (print "intlist-t1: FAIL"))
	(if (equal (intlist 0) nil) (print "intlist-t2: PASS") (print "intlist-t2: FAIL"))
	(if (equal (intlist -5) nil) (print "intlist-t3: PASS") (print "intlist-t3: FAIL"))
	
	; tests for analyze
	(if (equal (analyze '(a b c)) '(atom atom atom)) (print "analyze-t1: PASS") (print "analyze-t1: FAIL"))
	(if (equal (analyze '(a b (c d) e f)) '(atom atom list atom atom)) (print "analyze-t2: PASS") (print "analyze-t2: FAIL"))
	(if (equal (analyze '(a)) '(atom)) (print "analyze-t3: PASS") (print "analyze-t3: FAIL"))
	(if (equal (analyze '((a))) '(list)) (print "analyze-t4: PASS") (print "analyze-t4: FAIL"))
	(if (equal (analyze '()) nil) (print "analyze-t5: PASS") (print "analyze-t5: FAIL"))
		
	; tests for only-atoms
	(if (equal (only-atoms '(a b c)) t) (print "only-atoms-t1: PASS") (print "only-atoms-t1: FAIL"))
	(if (equal (only-atoms '(a)) t) (print "only-atoms-t2: PASS") (print "only-atoms-t2: FAIL"))
	(if (equal (only-atoms '(a (b) c)) nil) (print "only-atoms-t3: PASS") (print "only-atoms-t3: FAIL"))
	(if (equal (only-atoms '()) nil) (print "only-atoms-t4: PASS") (print "only-atoms-t4: FAIL"))
	
	; tests for only-atoms-iter
	(if (equal (only-atoms-iter '(a b c)) t) (print "only-atoms-iter-t1: PASS") (print "only-atoms-iter-t1: FAIL"))
	(if (equal (only-atoms-iter '(a)) t) (print "only-atoms-iter-t2: PASS") (print "only-atoms-iter-t2: FAIL"))
	(if (equal (only-atoms-iter '(a (b) c)) nil) (print "only-atoms-iter-t3: PASS") (print "only-atoms-iter-t3: FAIL"))
	(if (equal (only-atoms-iter '()) nil) (print "only-atoms-iter-t4: PASS") (print "only-atoms-iter-t4: FAIL"))
	
	; tests for quad-roots
	(print (quad-roots 2 4 -30))			; should print (3 -5) or (-5 3)
	(print (quad-roots 1 3 -4))				; should print (1 -4) or (-4 1)
	(print (quad-roots 2 -4 -3))			; should print (-0.58 2.58) or (2.58 -0.58)
	
	;tests for rotate-left
	(if (equal (rotate-left '(a b c d e) 3) '(d e a b c)) (print "rotate-left-t1: PASS") (print "rotate-left-t1: FAIL"))
	(if (equal (rotate-left '(a b c d e) 2) '(c d e a b)) (print "rotate-left-t2: PASS") (print "rotate-left-t2: FAIL"))
	(if (equal (rotate-left '(a b c d e) 1) '(b c d e a)) (print "rotate-left-t3: PASS") (print "rotate-left-t3: FAIL"))
	(if (equal (rotate-left '(a b c d e) 4) '(e a b c d)) (print "rotate-left-t4: PASS") (print "rotate-left-t4: FAIL"))
	(if (equal (rotate-left '(a b c d e) 5) '(a b c d e)) (print "rotate-left-t5: PASS") (print "rotate-left-t5: FAIL"))
	(if (equal (rotate-left '(a b c d e) 7) '(c d e a b)) (print "rotate-left-t6: PASS") (print "rotate-left-t6: FAIL"))
	(if (equal (rotate-left '(a b c d e) 0) '(a b c d e)) (print "rotate-left-t7: PASS") (print "rotate-left-t7: FAIL"))
	(if (equal (rotate-left '(a b c d e) -2) '(a b c d e)) (print "rotate-left-t8: PASS") (print "rotate-left-t8: FAIL"))
	
	; tests for evens
	(if (equal (evens '(a b c d e)) '(b d)) (print "evens-t1: PASS") (print "evens-t1: FAIL"))
	(if (equal (evens '(a)) nil) (print "evens-t2: PASS") (print "evens-t2: FAIL"))
	(if (equal (evens '(a b)) '(b)) (print "evens-t3: PASS") (print "evens-t3: FAIL"))
	(if (equal (evens '()) nil) (print "evens-t4: PASS") (print "evens-t4: FAIL"))
	(if (equal (evens '(a b c d e f g)) '(b d f)) (print "evens-t5: PASS") (print "evens-t5: FAIL"))
	
	; tests for evens-iter
	(if (equal (evens-iter '(a b c d e)) '(b d)) (print "evens-iter-t1: PASS") (print "evens-iter-t1: FAIL"))
	(if (equal (evens-iter '(a)) nil) (print "evens-iter-t2: PASS") (print "evens-iter-t2: FAIL"))
	(if (equal (evens-iter '(a b)) '(b)) (print "evens-iter-t3: PASS") (print "evens-iter-t3: FAIL"))
	(if (equal (evens-iter '()) nil) (print "evens-iter-t4: PASS") (print "evens-iter-t4: FAIL"))
	(if (equal (evens-iter '(a b c d e f g)) '(b d f)) (print "evens-iter-t5: PASS") (print "evens-iter-t5: FAIL"))
	
	t	; return true when done with testing
)
