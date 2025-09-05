(defpackage idris-mode/tests/main
  (:use :cl
        :idris-mode
        :rove))
(in-package :idris-mode/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :idris-mode)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
