(uiop:define-package idris-mode
    (:use :cl :lem :lem/language-mode :lem/language-mode-tools)
  (:export :idris-mode
           :*idris-mode-hook*))
(in-package :idris-mode)


(defvar *idris-keywords*
  '("abstract" "case" "covering" "default" "do" "dsl" "else" "export" "if"
    "implementation" "implicit" "import" "in" "infix" "infixl" "infixr"
    "module" "mutual" "namespace" "of" "let" "parameters" "partial"
    "pattern" "prefix" "private" "proof" "public" "rewrite" "syntax"
    "tactics" "then" "total" "using" "where" "with"))

(defvar *idris-operators*
  '(".." ":" "::" "=" "\\" "|" "<-" "->" "@" "~" "=>"))

(defvar *integer-literals* 
  "\\b(([0-9]+)|(0(o|O)[0-7]+)|(0(x|X)[0-9a-fA-F]+))\\b")

(defvar *float-literals* 
  "\\b(([0-9]+\\.[0-9]+([eE](\\+|\\-)?[0-9]+)?)|([0-9]+[eE](\\+|\\-)?[0-9]+))\\b")

(defun tokens (boundary strings)
  (let ((alternation
         `(:alternation ,@(sort (copy-list strings) #'> :key #'length))))
    (if boundary
        `(:sequence ,boundary ,alternation ,boundary)
        alternation)))

(defun make-tmlanguage-idris ()
  (let ((patterns
         (make-tm-patterns
          (make-tm-line-comment-region "--")
          (make-tm-block-comment-region "{-" "-}")
          (make-tm-string-region "\"")
          (make-tm-match (tokens :word-boundary *idris-keywords*)
                         :name 'syntax-keyword-attribute)
          (make-tm-match *integer-literals*
                         :name 'syntax-constant-attribute)
          (make-tm-match *float-literals*
                         :name 'syntax-constant-attribute)
          )))
    (make-tmlanguage :patterns patterns)))

(defvar *idris-syntax-table*
  (let ((table (make-syntax-table
                :space-chars '(#\space #\tab #\newline)
                :symbol-chars '(#\_)
                :paren-pairs '((#\( . #\))
                               (#\{ . #\})
                               (#\[ . #\]))
                :string-quote-chars '(#\")
                :line-comment-string "--"
                :block-comment-pairs '(("{-" . "-}"))))
        (tmlanguage (make-tmlanguage-idris)))
    (set-syntax-parser table tmlanguage)
    table))


;; Define major mode
(define-major-mode idris-mode ()
  (:name "Idris"
	 ;; :keymap *idris-mode-keymap*
	 :mode-hook *idris-mode-hook*
	 :syntax-table *idris-syntax-table*)
  (setf (variable-value 'enable-syntax-highlight) t
        (variable-value 'tab-width) 2))

(define-file-type ("idr" "lidr" "ipkg") idris-mode)
