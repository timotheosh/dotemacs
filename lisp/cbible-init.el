(use-package cbible
    :load-path "~/src/sources/cbible/elisp/"
    :init
    (add-hook 'org-mode-hook 'cbible-mode))
