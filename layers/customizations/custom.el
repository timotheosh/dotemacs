(add-hook 'before-save-hook 'delete-trailing-whitespace)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(flymake-google-cpplint-command "/usr/local/bin/cpplint")
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(ido-enable-tramp-completion nil)
 '(package-selected-packages
   (quote
    (isortify flycheck-pycheck flycheck-pycheckers kanban epresent javadoc-lookup java-imports ein jdee ob-sagemath company-ansible ido-completing-read+ org-jira cyphon-mode flycheck-cython cython-mode aggressive-indent org-projectile elnode quack yaml-mode impatient-mode dr-racket-like-unicode flymake-racket epc jedi virtualenvwrapper elpy org darktooth-theme pymacs flymake-google-cpplint company-c-headers column-enforce-mode column-marker paradox use-package)))
 '(paradox-github-token t)
 '(powerline-default-separator (quote contour))
 '(powerline-height 18)
 '(quack-default-program "racket")
 '(safe-local-variable-values (quote ((eval ansible 1))))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(mode-line-buffer-id ((t (:weight normal :family "Ubuntu Mono"))))
 '(mode-line-buffer-id-inactive ((t (:family "Ubuntu Mono"))))
 '(powerline-active1 ((t (:background "#504945" :family "Ubuntu Mono"))))
 '(powerline-active2 ((t (:background "#3C3836" :family "Ubuntu Mono"))))
 '(powerline-inactive1 ((t (:background "#928374" :family "Ubuntu Mono"))))
 '(powerline-inactive2 ((t (:background "#504945" :family "Ubuntu Mono")))))
