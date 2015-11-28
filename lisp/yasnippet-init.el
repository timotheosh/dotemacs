;; Initialize yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
  '("~/.emacs.d/yasnippets/snippets" ;; My personal snippets
    "~/.emacs.d/yasnippets/yasnippet-snippets" ;; Andrea Crotti's snippets
    "~/.emacs.d/yasnippets/yasnippet-licenses"   ;; Atkinson's license snippets
))
(yas-global-mode 1)

