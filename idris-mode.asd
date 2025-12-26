(defsystem "idris-mode"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ("lem/core" "lem-lsp-mode")
  :serial t
  :components ((:module "src"
                :components
                ((:file "main")
                 (:file "lsp-config"))))
  :description "Major mode for Idris"
  :in-order-to ((test-op (test-op "idris-mode/tests"))))

(defsystem "idris-mode/tests"
  :author ""
  :license ""
  :depends-on ("idris-mode"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for idris-mode"
  :perform (test-op (op c) (symbol-call :rove :run c)))
