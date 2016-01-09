(use-package jdee
  :mode ("\\.java\\'" . jdee-mode)
  :init
  (require 'jdee)
  (require 'auto-complete)
  (require 'java-imports)
  (require 'javadoc-lookup)
  (setq jde-complete-add-space-after-method t)
  (add-hook 'jdee-mode-hook
            (lambda()
              (add-to-list 'ac-modes 'jdee-mode)))
  (javadoc-add-roots "/usr/lib/jvm/java-1.8.0-openjdk-amd64/docs/api/"))
(provide 'java-init)
