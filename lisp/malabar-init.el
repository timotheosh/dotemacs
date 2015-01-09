(defun malabar-mode-bootstrap ()
	(require 'cedet)
	(require 'semantic)
	(load "semantic/loaddefs.el")
	(semantic-mode 1);;
	(require 'malabar-mode)
	(load "malabar-flycheck")

	(malabar-mode)
	(flycheck-mode))
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode-bootstrap))

;; Auto-populate an empty java file
;; http://software-ninja-ninja.blogspot.com/2014/03/using-malabar-mode-to-auto-populate-new.html
(add-hook 'malabar-mode-hook
      '(lambda ()
         (when (= 0 (buffer-size))
           (malabar-codegen-insert-class-template)))) 
