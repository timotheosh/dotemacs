(use-package jdee
  :ensure t
  :mode ("\\.java\\'" . jdee-mode)
  :config
  (require 'auto-complete-init)
  (add-to-list 'ac-modes 'jdee-mode)
  (use-package java-imports
    :ensure t)
  (use-package javadoc-lookup
    :ensure t)
  (setq jde-complete-add-space-after-method t)
  (dolist (func '(auto-complete-mode)
                (add-hook 'jdee-mode-hook func)))
  (javadoc-add-roots "/usr/lib/jvm/java-1.8.0-openjdk-amd64/docs/api/")
  (add-hook 'jdee-mode-hook 'auto-complete-mode)
  :init
  (use-package programming-init
    :init
    (require 'smartparens)
    ;; FIXME: this doesn't work!
    (sp-local-pair '(jdee-mode)
                   "{" nil :post-handlers
                   '((my/create-newline-format "RET")))
    (add-hook 'jdee-mode-hook 'my-programming-hooks)))
(provide 'java-init)
