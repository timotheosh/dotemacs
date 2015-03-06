(add-hook 'puppet-mode-hook (lambda () (flymake-puppet-load)))
(eval-after-load "flymake-puppet"
    '(defun flymake-puppet-command (filename)
	     "Construct a command that flymake can use to check puppet source."
		       (list flymake-puppet-executable
					 "--no-80chars-check"
					 "--no-autoloader_layout-check"
					 filename)))

(add-hook 'puppet-mode-hook
	'(lambda ()
	    (local-set-key (kbd "RET")
            (lambda () (interactive)
			  (newline-and-indent)
			  (puppet-align-block)))))
