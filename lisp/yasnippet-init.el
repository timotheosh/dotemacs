;; Initialize yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
  '("~/.emacs.d/yasnippets/snippets" ;; My personal snippets
    "~/.emacs.d/yasnippets/AndreaCrotti_snippets" ;; Andrea Crotti's snippets
    "~/.emacs.d/yasnippets/jonatkinson_license"   ;; Atkinson's license snippets
))
(yas-global-mode 1)

