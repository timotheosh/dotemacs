;; Not compatible with vterm
;;(add-to-list 'load-path "~/.emacs.d/pde")
;;(load "pde-load")

;; CPerl mode instead of Perl mode
(setq auto-mode-alist (rassq-delete-all 'perl-mode auto-mode-alist))

;; NOTE: Smartparens conflicts with cperl.
(use-package cperl-mode
  :mode ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
  :interpreter (("perl" . cperl-mode)
                ("perl5" . cperl-mode)
                ("miniperl" . cperl-mode))
  :init
  (use-package plsense
    :ensure t
    :config
    (plsense-config-default))


  ;; perl language server is installed with `cpan Perl::LanguageServer'
  ;; and then run like `perl -MPerl::LanguageServer \
  ;;                       -e Perl::LanguageServer::run \
  ;;                       -- --port <some_port> --log-level <log_level> \
  ;;                          --version <client_version>'

  (defun my/perl-settings ()
    (setq cperl-electric-parens t)
    (setq cperl-electric-linefeed t)
    (local-set-key (kbd "C-m") 'cperl-linefeed))
  (add-hook 'cperl-mode-hook 'my/perl-settings)
  (add-hook 'cperl-mode-hook 'lsp-deferred))
(provide 'perl-init)
