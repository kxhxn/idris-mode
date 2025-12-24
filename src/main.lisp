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


(defun tree-sitter-query-path ()
  "Return the path ot the tree-sitter highlight query for Idris."
  (asdf:system-relative-pathname :idris-mode "src/tree-sitter/highlights.scm"))

;; Define major mode
(define-major-mode idris-mode ()
    (:name "Idris"
     ;; :keymap *idris-mode-keymap*
     :mode-hook *idris-mode-hook*
     )
  (lem-tree-sitter:enable-tree-sitter-for-mode 
   *idris-syntax-table* "idris" (tree-sitter-query-path))
  (setf (variable-value 'enable-syntax-highlight) t
        (variable-value 'tab-width) 2))

(define-file-type ("idr" "lidr" "ipkg") idris-mode)


;; Add this inside your idris-mode body or after activation:
;; (let ((enabled (and (fboundp 'lem:tree-sitter-enabled-p)
;; (lem:tree-sitter-enabled-p (lem:current-buffer)))))
;; (lem:message "Tree-sitter for Idris: ~A" (if enabled "ENABLED ✅" "DISABLED ❌")))


;; (defun idris-ts-status ()
;; (interactive)
;; (lem:message "Tree-sitter status: ~A"
;; (if (lem:tree-sitter-enabled-p (lem:current-buffer))
;; "ENABLED ✅"
;; "DISABLED ❌")))
