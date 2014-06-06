;; Perl Development Environment (PDE)
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook
		  (lambda ()
              (abbrev-mode t)
              (cperl-set-style "C++")))
(load "pde-load")
