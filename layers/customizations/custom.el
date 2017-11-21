(add-hook 'before-save-hook 'delete-trailing-whitespace)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(ido-enable-tramp-completion nil)
 '(package-selected-packages
   (quote
    (emr yaml-mode web-mode virtualenvwrapper use-package sr-speedbar smartparens rainbow-delimiters racket-mode quack python-mode powerline php-mode persp-projectile paradox ox-gfm org-projectile org-plus-contrib org-jira org-bullets multi-term magit json-mode jedi jdee javadoc-lookup java-imports hy-mode helm-projectile haskell-mode google-c-style geiser geben flymake-racket flycheck-rust flycheck-cython flycheck-clojure exec-path-from-shell epresent elpy dr-racket-like-unicode darktooth-theme cython-mode company-irony company-ansible column-marker column-enforce-mode cmake-ide clojure-mode-extra-font-locking chicken-scheme cargo ansible aggressive-indent ac-slime 4clojure)))
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
