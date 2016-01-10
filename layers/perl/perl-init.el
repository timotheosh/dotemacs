;; Perl Development Environment (PDE)
(use-package cperl
  :mode ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
  :config
  (defalias 'perl-mode 'cperl-mode)
  :init
  (progn
    (add-hook 'cperl-mode-hook
              (lambda ()
                (abbrev-mode t)
                (cperl-set-style "C++")))
    (load "pde-load")))
(provide 'perl-init)
