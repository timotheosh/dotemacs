;; PHP init file
;;
;; Some keys that are bound for this mode:
;; M-<ENTER> Runs the sync_webdx command for WebDx Development
;; [f5]      Debugs the PHP in the current buffer with Xdebug and Geben
;; <ENTER>   New line at the next indentation level.
;;
(use-package php-mode
  :mode (("\\.php\\'" . php-mode)
         ("\\.php5\\'" . php-mode)
	 ("\\.inc\\'" . php-mode))
  :config
  (add-to-list 'ac-modes 'php-mode)
  :init
  (require 'programming-init)
  (use-package flymake)
  (autoload 'php-mode "php-mode" "Major mode for editing php code." t)

  ;;This is the error format for : php -f somefile.php -l
  (add-to-list 'flymake-err-line-patterns
               '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

  (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

  (defun my-php-mode-hook ()
    "My PHP mode configuration."
    (c-set-style "linux")
    (setq php-mode-force-pear nil
          indent-tabs-mode nil
          c-basic-offset 4))

  ;; Pear coding standards : http://pear.php.net/manual/en/standards.indenting.php
  (defun pear/php-mode-init ()
    "Set some buffer-local variables."
    (setq case-fold-search t)
    (setq indent-tabs-mode nil)
    (setq fill-column 78)
    (setq c-basic-offset 4)
    (c-set-offset 'arglist-cont 0)
    (c-set-offset 'arglist-intro '+)
    (c-set-offset 'case-label 2)
    (c-set-offset 'arglist-close 0))

  (defun my-php-hook-function ()
    (set (make-local-variable 'compile-command) (format "php_lint %s" (buffer-file-name))))

  (defun flymake-php-init ()
    "Use php and phpcs to check the syntax and code compliance of the current file."
    (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
           (local (file-relative-name temp (file-name-directory buffer-file-name))))
      (list "php_lint" (list local))))

  ;; Debug a simple PHP script. Use geben with xdebug for PHP
  ;; Change the session key my-php-53 to any session key text you like
  (defun my-php-debug ()
    "Run current PHP script for debugging with geben"
    (interactive)
    (call-interactively 'geben)
    (shell-command
     (concat "XDEBUG_CONFIG='idekey=my-php-53' /usr/bin/php "
             (buffer-file-name) " &"))
    )

  (dolist (func '(my-programming-hooks
                  pear/php-mode-init
		  my-php-hook-function
		  (lambda ()
		    "Debugger key binding"
		    (local-set-key [f5] 'my-php-debug))
                  (lambda () (flymake-mode 1))
                  (lambda ()
                    "Indent when I press <RETURN>"
                    (local-set-key (kbd "RET") 'newline-and-indent))
                  php-boris-minor-mode))
    (add-hook 'php-mode-hook func)))
(provide 'php-init)
