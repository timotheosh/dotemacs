;; CPerl mode instead of Perl mode
(setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))

;; NOTE: Smartparens conflicts with cperl.
(use-package cperl-mode
  :mode ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
  :interpreter (("perl" . cperl-mode)
                ("perl5" . cperl-mode)
                ("miniperl" . cperl-mode))
  :init
  (defun my/perl-settings ()
    (setq cperl-electric-parens t)
    (setq cperl-electric-linefeed t)
    (local-set-key (kbd "C-m") 'cperl-linefeed))
  (add-hook 'cperl-mode-hook 'my/perl-settings))
(provide 'perl-init)
