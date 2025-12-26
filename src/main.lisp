(uiop:define-package idris-mode
  (:use :cl :lem :lem/language-mode-tools)
  (:export :idris-mode
           :*idris-mode-hook*))
(in-package :idris-mode)

(defun make-tmlanguage-idris ()
  (let ((patterns
          (make-tm-patterns
           (make-tm-line-comment-region "--"))))
    (make-tmlanguage :patterns patterns)))

(defvar *idris-syntax-table*
  (let ((table (make-syntax-table
                ;; :space-chars '(#\space #\tab #\newline)
                ))
        (tmlanguage (make-tmlanguage-idris)))
    (set-syntax-parser table tmlanguage)
    table))


;; Define major mode
(define-major-mode idris-mode ()
    (:name "Idris"
     ;; :keymap *idris-mode-keymap*
     :mode-hook *idris-mode-hook*
     )
  (setf (variable-value 'enable-syntax-highlight) t
        (variable-value 'tab-width) 2))

(define-file-type ("idr" "lidr" "ipkg") idris-mode)
