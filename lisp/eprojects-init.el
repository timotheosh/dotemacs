(require 'eproject)
(require 'eproject-extras)

;; eproject global bindings
(defmacro .emacs-curry (function &rest args)
  `(lambda () (interactive)
     (,function ,@args)))

(defmacro .emacs-eproject-key (key command)
  (cons 'progn
    (loop for (k . p) in (list (cons key 4) (cons (upcase key) 1))
      collect
      `(global-set-key
        (kbd ,(format "C-x p %s" k))
        (.emacs-curry ,command ,p)))))

(.emacs-eproject-key "k" eproject-kill-project-buffers)
(.emacs-eproject-key "v" eproject-revisit-project)
(.emacs-eproject-key "b" eproject-ibuffer)
(.emacs-eproject-key "o" eproject-open-all-project-files)

(define-project-type c++ (generic) (look-for "CMakeLists.txt"))
(add-hook 'c++-project-file-visit-hook
  (lambda ()
    (set (make-local-variable 'compile-command)
         (format "cd %sbuild; cmake ../; make" (eproject-root)))))
