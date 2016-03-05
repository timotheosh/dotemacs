(use-package jdee
  :mode ("\\.java\\'" . jdee-mode)
  :config
  (require 'auto-complete)
  (add-to-list 'ac-modes 'jdee-mode)
  (require 'programming-init)
  (require 'jdee)
  (require 'java-imports)
  (require 'javadoc-lookup)
  (setq jde-complete-add-space-after-method t)
  (dolist (func '(my-programming-hooks
                  auto-complete-mode)
                (add-hook 'jdee-mode-hook func)))
  (javadoc-add-roots "/usr/lib/jvm/java-1.8.0-openjdk-amd64/docs/api/")
  (add-hook 'jdee-mode-hook 'auto-complete-mode))
(provide 'java-init)
