;; Perl Development Environment (PDE)
(use-package cperl
  :mode ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
  :config
  (progn
    (defalias 'perl-mode 'cperl-mode)
    (add-hook 'cperl-mode-hook
              (lambda ()
                (abbrev-mode t)
                (cperl-set-style "C++")))
    (use-package pde
      :ensure t
      :init
      (load "pde-load"))))
(provide 'perl-init)
