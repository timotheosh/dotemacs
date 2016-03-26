(use-package jdee
  :mode ("\\.java\\'" . jdee-mode)
  :config
  (require 'auto-complete)
  (add-to-list 'ac-modes 'jdee-mode)
  (require 'jdee)
  (require 'java-imports)
  (require 'javadoc-lookup)
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
