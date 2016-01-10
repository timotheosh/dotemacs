(use-package ruby-mode
  :mode (("\\.capfile\\'" . ruby-mode)
         ("\\.erbsql\\'"  . ruby-mode)
         ("\\.gemfile\\'" . ruby-mode)
         ("\\.gemspec\\'" . ruby-mode)
         ("\\.irbrc\\'"   . ruby-mode)
         ("\\.rake\\'"    . ruby-mode)
         ("\\.rakefile\\'" . ruby-mode)
         ("\\.rb\\'"      . ruby-mode)
         ("\\.rbx\\'"     . ruby-mode)
         ("\\.rhtml\\'"   . ruby-mode)
         ("\\.rjs\\'"     . ruby-mode))
  :config
  (require 'inf-ruby)
  (require 'auto-complete)
  (add-to-list 'ac-modes 'ruby-mode)
  :init
  (dolist (func '(my-programming-hooks
                  inf-ruby-minor-mode)
    (add-hook 'ruby-mode-hook func))))
(provide 'ruby-init)
