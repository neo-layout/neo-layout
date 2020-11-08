#lang racket

;;Helper functions and datatypes
;;String functions
(define (uncomment-line line)
  (car (regexp-match #rx"^[^#\\!\n]*" line)))

(define (empty-line? line)
  (equal? line ""))

;;Line-list
(define (line-list? line-list)
  (and (pair? line-list)
       (and (number? (car line-list))
            (andmap (lambda (e)
                      (and (string? (cdr e))
                           (number? (car e))))
                    (cdr line-list)))))

(define (keycode-line-list ll)
  (car ll))

(define (keysymbols-line-list ll)
  (cdr ll))

(define (line-str->line-list line-str)
  (let ([line-str (uncomment-line line-str)])
    (let ([reg1 (regexp-match #px"^[[:blank:]]*keycode[[:blank:]]+(\\d+)[[:blank:]]*=[[:blank:]]*((?:(?:U\\+(?:\\p{L}|\\d)+|\\+?(?:\\p{L}|_)+)(?:[[:blank:]]+|$))+)[[:blank:]]*$" ;Matches lines like "      keycode  12 = enene ennnn U+1E9E blub plus  "
                              line-str)]
          [reg2 (regexp-match #px"^[[:blank:]]*((?:[a-z]+[[:blank:]]+)+)keycode[[:blank:]]+(\\d+)[[:blank:]]*=[[:blank:]]*(U\\+(?:\\p{L}|\\d)+|\\+?(?:\\p{L}|_)+)\\s*$"
                              line-str)] ;Matches lines like "   altgr    shiftl  keycode  26 = w"
          )
      (cond [reg1
             (cons (string->number (cadr reg1))
                   (let iter ([groups (regexp-match* #px"U\\+(?:\\p{L}|\\d)+|\\+?(?:\\p{L}|_)+"
                                                     (caddr reg1))]
                              [counter 0])
                     (cond [(null? groups) '()]
                           [else (cons (cons counter
                                             (car groups))
                                       (iter (cdr groups)
                                             (add1 counter)))])))]
            [reg2
             (list (string->number (caddr reg2))
                   (cons (foldl +
                                0
                                (map (lambda (e)
                                       (expt 2
                                             (index-of modifier
                                                       e)))
                                     (regexp-match* #px"\\S+"
                                                    (cadr reg2))))
                         (cadddr reg2)))]
            [else (error "Error: Unrecognized line:" line-str)]))))

(define (accumulater combiner initial-value f l)
  (foldr combiner
         initial-value
         (map f l)))

(define (accumulatel combiner initial-value f l)
  (foldl combiner
         initial-value
         (map f l)))

(define (line-list->lines-str line-l)
  (define (num->modifier n)
    (let iter ([n n]
               [counter 0])
      (cond [(= n 0) '()]
            [(even? n)
             (iter (/ n 2)
                   (add1 counter))]
            [else (cons (list-ref modifier
                                  counter)
                        (iter (/ (- n 1)
                                 2)
                              (add1 counter)))])))
  (accumulater ~a ""
               (lambda (e)
                 (~a (~a (accumulater  ~a ""
                                      (lambda (mod)
                                        (~a mod
                                            #:min-width 8
                                            #:align 'left))
                                      (let ([hui (num->modifier (car e))])
                                        hui))
                         #:min-width 16
                         #:align 'right)
                     (~a "keycode"
                         (~a (car line-l)
                             #:min-width 4
                             #:align 'right)
                         " = "
                         (cdr e)
                         "\n")))
               (cdr line-l)))

(define (contains-line-list ll e)
  (ormap (lambda (x)
           (equal? (car x) e))
         ll))

(define (combine-line-lists ll1 ll2)
  (if (= (car ll1)
         (car ll2))
      (cons (car ll1)
            (let iter ([ll1 (cdr ll1)]
                       [ll2 (cdr ll2)])
              (if (null? ll2)
                  ll1
                  (iter (if (contains-line-list ll1
                                                (caar ll2))
                            (error "Unable to combine line lists. Same keycode in both present:\n"
                                   ll1
                                   "and"
                                   ll2)
                            (append ll1 (list (car ll2))))
                        (cdr ll2)))))
      (error "Expected equal keycodes. Got: " (car ll1) " and " (car ll2))))

;;Keylist
(define (keylist? keylist)
  (andmap line-list? keylist))

(define (make-keylist . line-lists)
  (if (keylist? line-lists)
      line-lists
      (error "Wrong type of" line-lists "\n Should be: keylist?")))

(define (first-keylist keylist)
  (car keylist))

(define (rest-keylist keylist)
  (cdr keylist))

(define (append-keylists-without-check . kl)
  (append* kl))

(define (push-end-keylist keylist ll)
  (append keylist (list ll)))

(define (find-keycode-keylist keylist keycode)
  (let iter ([keylist keylist]
             [counter 0])
    (if (empty-keylist? keylist)
        #f
        (or (and (= (keycode-line-list (first-keylist keylist))
                    keycode)
                 counter)
            (iter (rest-keylist keylist)
                  (add1 counter))))))

(define (split-keylist keylist index)
  (let-values ([(a b) (split-at keylist index)])
    (cons a b)))

(define empty-keylist (make-keylist))

(define (append-keylists kl1 kl2)
  (if (empty-keylist? kl2)
      kl1
      (append-keylists (let* ([ll (first-keylist kl2)]
                              [rs (find-keycode-keylist kl1
                                                         (keycode-line-list ll))])
                         (if rs
                             (let ([split (split-keylist kl1 rs)])
                               (append-keylists-without-check (car split)
                                                              (make-keylist (combine-line-lists (cadr split)
                                                                                                ll))
                                                              (cddr split)))
                             (push-end-keylist kl1 ll)))
                       (rest-keylist kl2))))

(define (empty-keylist? keylist)
  (equal? empty-keylist keylist))

;misc
(define (number->bits num)
  (cond [(= num 0) '()]
        [(even? num) (cons 0
                           (number->bits (/ num
                                            2)))]
        [else (cons 1
                    (number->bits (/ (sub1 num)
                                     2)))]))

(define (enumerate n)
  (let iter ([a 0])
    (if (> a n)
        '()
        (cons a
              (iter (add1 a))))))

(define (add-pair c1 c2)
  (list (+ (car c1)
           (car c2))
        (+ (cadr c1)
           (cadr c2))))

(define (iterate-keylist keylist f)
  (map (λ (line-list)
         (cons (car line-list)
               (map (λ (leaf)
                      (f leaf))
                    (cdr line-list))))
       keylist))

;;Actual program
(define modifier '("shift" "altgr" "control" "alt" "shiftl" "shiftr" "ctrll" "ctrlr" "capsshift"))

(define (keylist->keymap keylist)
  (if (empty-keylist? keylist)
      ""
      (~a (line-list->lines-str (first-keylist keylist)) ;~a without arguments is equivalent to string-append
          "\n"
          (keylist->keymap (rest-keylist keylist)))))

(define (keymap->keylist keymap)
  (foldl (lambda (line rest-lines)
           (append-keylists rest-lines
                            (make-keylist (line-str->line-list line))))
         empty-keylist
         (filter (lambda (line)
                   (not (empty-line? line)))
                 (map (lambda (line)
                        (uncomment-line line))
                      (regexp-match* #px"[^\n]*\n|.+$"
                                     keymap)))))

(define (convert keylist)
  (define c-map
    '([1 16]
      [2 2]
      [16 64]))
  (define convert-map
          (map (λ (x)
                 (let iter ([c-map c-map]
                            [x x])
                   (cond [(null? x) ; x is shorter than c-map
                          (list 0 0)]
                         [(= (car x) 0) (iter (cdr c-map)
                                              (cdr x))]
                         [else (add-pair (car c-map)
                                         (iter (cdr c-map)
                                               (cdr x)))])))
               (map number->bits
                    (enumerate (- (expt 2 (length c-map))
                                  1)))))
  (iterate-keylist keylist
                   (λ (leaf)
                     (cons (car (dict-ref convert-map
                                          (car leaf)))
                           (cdr leaf)))))

(define (myfilter-input keymap)
  (define shift-input "shift")
  (regexp-replaces (regexp-replace* #px"([[:blank:]]*)(keycode[[:blank:]]+\\d+[[:blank:]]*=[[:blank:]]*)([a-z])([[:blank:]]+(?:\n|$))"
                                   keymap
                                   (λ (all blank middle keysymbol end)
                                     (~a all "\n"
                                         shift-input " "
                                         middle
                                         "+" (string-upcase keysymbol)
                                         end)))
                   '([#px"KP_1" "one"]
                     [#px"KP_2" "two"]
                     [#px"KP_3" "three"]
                     [#px"KP_4" "four"]
                     [#px"KP_5" "five"]
                     [#px"KP_6" "six"]
                     [#px"KP_7" "seven"]
                     [#px"KP_8" "eight"]
                     [#px"KP_9" "nine"]
                     [#px"KP_0" "zero"]
                     [#px"KP_Multiply" "asterisk"]
                     [#px"KP_Divide" "slash"]
                     [#px"KP_Substract" "minus"]
                     [#px"KP_Addition" "plus"]
                     [#px"KP_Comma" "comma"])))

(define (myfilter-output keymap)
  (regexp-replaces keymap
                   '([#px"((?:[[:blank:]]|[a-z])*)shiftl((?:[[:blank:]]|[a-z])*[[:blank:]]+keycode[[:blank:]]+\\d+[[:blank:]]*=[[:blank:]]*(?:U\\+(?:\\p{L}|\\d)+|\\+?(?:\\p{L}|_)+)[[:blank:]]*\n)"
                      "\\1shiftl\\2\\1shiftr\\2"]
                     [#px"(?:^|\n)[[:blank:]]*(keycode[[:blank:]]+\\d+[[:blank:]]*=[[:blank:]]*[a-z][[:blank:]]*\n)"
                      "\n                \\1shift   shiftl  \\1shift   shiftr  \\1"])))

(define (main head-file body-file tail-file output-file)
  (display-to-file (~a (file->string head-file)
                       (myfilter-output (keylist->keymap (convert (keymap->keylist (myfilter-input (file->string body-file))))))
                       (file->string tail-file))
                   output-file))

(define (shell)
  (let ([body-file (make-parameter null)]
        [output-file (make-parameter null)]
        [head-file (make-parameter null)]
        [tail-file (make-parameter null)])
    (command-line
     #:program "better-keymap"
     #:once-each
     [("-b" "--body-file") body
                           ""
                           (body-file body)]
     [("-o" "--output-file") output
                             ""
                             (output-file output)]
     [("--head") head
                 ""
                 (head-file head)]
     [("-t" "--tail") tail
                      ""
                      (tail-file tail)]
     #:args rest
     (main (tail-file)
           (body-file)
           (head-file)
           (output-file)))))
