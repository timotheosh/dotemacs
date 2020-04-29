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
 '(package-selected-packages
   (quote
    (elfeed-goodies elfeed ranger language-detection ox-jira jiralib2 ejira 0x0 shell-pop atomic-chrome skewer-mode gnu-elpa-keyring-update zenburn-theme xref-js2 which-key wgrep-ag web-mode virtualenvwrapper use-package ssh smex smartparens smart-dash restclient rainbow-delimiters racket-mode quack python-pytest python-mode python-docstring powerline pipenv pip-requirements php-mode persp-projectile paradox ox-gfm origami org-projectile org-jira org-bullets neotree multi-term multi-eshell magit lorem-ipsum lisp-extra-font-lock keychain-environment json-mode js2-refactor jedi jdee javadoc-lookup java-imports irony-eldoc impatient-mode iedit hy-mode haskell-mode groovy-mode general geiser geben flymake-racket flycheck-rust flycheck-pycheckers flycheck-pos-tip flycheck-irony flycheck-cython flycheck-clojure flycheck-clangcheck flycheck-clang-tidy flycheck-clang-analyzer exec-path-from-shell eshell-prompt-extras esh-help elpy editorconfig dr-racket-like-unicode doom-themes dockerfile-mode docker-compose-mode darktooth-theme dap-mode cython-mode counsel-projectile company-tern company-quickhelp company-irony company-c-headers company-ansible column-enforce-mode cmake-ide clojure-mode-extra-font-locking clj-refactor chicken-scheme cargo blacken basic-mode base16-theme aws-snippets auto-virtualenv ansible all-the-icons-ivy aggressive-indent ac-slime 4clojure)))
 '(paradox-github-token t)
 '(safe-local-variable-values
   (quote
    ((setenv "PYTHONPATH" "/home/thawes/.virtualenvs/purecloud/CA/")
     (eval ansible 1)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
