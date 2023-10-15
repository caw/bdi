#lang racket

;;; See README.md for documentation of the operations of basic actions
;;; - assert
;;; - retract
;;; - query
;;; - achieve

(struct event (action term env) #:transparent #:mutable)

(define-syntax make-event
  (syntax-rules ()
  ((_ action term env)
   (event 'action 'term 'env))))

(define ev-1 (make-event achieve (factorial 10 $r) ()))

;; this needs to be a mutable HASH or something for retrieval speed
(define *beliefs* (make-hash))

(define (sig term)
  (if (pair? term)
  (format "~a/~a" (car term) (- (length term) 1))
  (format  "~a/0" term)))

(define (bdi-assert event)
  (let* ((term (event-form event))
         (s (sig term)))

    (display s)
    (set-add! *beliefs* )))

(define (bdi-assert event) (printf "Asserting ~a in env: ~a\n" event (event-env event)))
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

(define (test)
  (define event-1 (event 'assert '(foo-bar) 'env))
  (handle-event event-1))

(test)
