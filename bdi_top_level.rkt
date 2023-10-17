#lang racket

;;; See README.md for documentation of the operations of basic actions
;;; - assert
;;; - retract
;;; - query
;;; - achieve

;; just a list to start with
;; what it eventually becomes needs thought...

(define *beliefs* '())

(define (ground? belief) #t)

(define (print-beliefs)
  (format "Beliefs: ~a" *beliefs*))

(define (add-belief belief)
  (unless (ground? belief)
    (error "Assertion FAIL. Belief: ~a not ground" belief))
  (set! *beliefs* (cons belief *beliefs*)))

(struct event (action term env) #:transparent #:mutable)

(define (make-event action term env)
  (event action term env))


(define (sig term)
  (if (pair? term)
  (format "~a/~a" (car term) (- (length term) 1))
  (format  "~a/0" term)))

(define (bdi-assert event)
  (let* ((term (event-term event))
         (s (sig term)))
    (add-belief term)))

(define (bdi-retract event) (printf "Retracting ~a in env: ~a\n" (event-env event)))
(define (bdi-query event) (printf "Query ~a in env: ~a\n" event (event-env event)))
(define (bdi-achieve event) (printf "Achieve ~a in env: ~a\n"  event (event-env event)))

(define (handle-event event)
    (match (event-action event)
      ['assert  (bdi-assert event)]
      ['retract (bdi-retract event)]
      ['query (bdi-query event)]
      ['achieve (bdi-achieve event)]
      [_ (printf "WTF: ~a\n" event)]))
;;
;; REPL
;; 
(define (test)
  (let/ec return
    (let loop ()
      (let ((input (read)))
        (printf "Read: ~a\n" input)
        (if (eq? input 'quit)
            (return "Quit received")
            (let ((a (car input))
                  (t (cadr  input))
                  (e (caddr input)))
              (let ((ev (make-event a t e)))
                (printf "Action: ~a Term: ~a Env: ~a Event: ~a" (event-action ev) (event-term ev) (event-env ev) ev)))))
      (loop))))

(define event-1 (event 'assert '(foo-bar) 'env))
(handle-event event-1)

