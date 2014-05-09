;; PHP init file
(require 'php-mode)
(require 'flymake)

(defun my-php-mode-hook ()
    "My PHP mode configuration."
	(c-set-style "linux")
	(setq php-mode-force-pear nil
		  indent-tabs-mode nil
		  c-basic-offset 4
	)
	(local-set-key (kbd "M-RET")
				   (lambda ()
					 (interactive)
					 (shell-command "sync_webdx")))
)

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
(add-hook 'php-mode-hook 'pear/php-mode-init)

(defun my-php-hook-function ()
  (set (make-local-variable 'compile-command) (format "php_lint %s" (buffer-file-name))))
(add-hook 'php-mode-hook 'my-php-hook-function)

(defun flymake-php-init ()
  "Use php and phpcs to check the syntax and code compliance of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
     (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php_lint" (list local))))

;;This is the error format for : php -f somefile.php -l 
(add-to-list 'flymake-err-line-patterns
  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))
(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))


(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(add-hook 'php-mode-hook
		  (lambda ()
			(require 'ggtags)
			(ggtags-mode t)))

;; Indent when I press <RETURN>
(add-hook 'php-mode-hook '(lambda ()
    (local-set-key (kbd "RET") 'newline-and-indent)))

;; PHP REPL
(add-hook 'php-mode-hook 'php-boris-minor-mode)
