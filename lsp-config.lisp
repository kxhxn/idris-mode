(uiop:define-package idris-mode/lsp-config
  (:use :cl :lem-lsp-mode))

(in-package :idris-mode/lsp-config)

(define-language-spec (idris-spec idris-mode:idris-mode)
  :language-id "idris"
  :root-uri-patterns '("*.ipkg" ".git")
  :command '("idris2-lsp")
  :install-command "pack install-app idris2-lsp"
  :readme-url "https://github.com/idris-community/idris2-lsp"
  :connection-mode :stdio)


