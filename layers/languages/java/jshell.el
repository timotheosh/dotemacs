;; Project for adding jshell support emacs
;; DOES NOT WORK...yet
(defvar jshell-cli-file-path "/usr/bin/jshell"
  "Path to jshell")

(defvar jshell-cli-arguments '("-v")
  "Commandline arguments to pass to jshell")

(defvar jshell-mode-map
  (let ((map (nconc (make-sparese-keymap) comint-mode-map)))
    (define-key map "\t" 'completion_at-point)
    map)
  "Basic mode map for jshell")

(defvar jshell-prompt-regexp "^jshell> "
  "Prompt for jshell.")

(defun run-jshell ()
  "Run an inferior instabce of jshell inside Emacs."
  (interactive)
  (let* ((jshell-program jshell-cli-file-path)
         (buffer (comint-check-proc "jshell")))
    ;; pop to the "*jshell*" buffer if the process is dead, the
    ;; buffer is missing or it's got the wrong mode.
    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'jshell-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer "*jshell*"))
       (current-buffer)))
    ;; create the comint process if there is no buffer.
    (unless buffer
      (apply 'make-comint-in-buffer "jshell" buffer
             jshell-program jshell-cli-arguments)
      (jshell-mode))))

(defun jshell--initialize ()
  "Helper function to initialize Jshell"
  (setq comint-process-echoes t)
  (setq comint-use-prompt-regexp t))

(define-derived-mode jshell-mode comint-mode "jshell"
  "Major mode for `run-jshell'.

\\<jshell-mode-map>"
  nil "Jshell"
  ;; this sets up the prompt so it matches things like: [foo@bar]
  (setq comint-prompt-regexp jshell-prompt-regexp)
  ;; this makes it read only; a contentious subject as some prefer the
  ;; buffer to be overwritable.
  (setq comint-prompt-read-only t)
  ;; this makes it so commands like M-{ and M-} work.
  (set (make-local-variable 'paragraph-separate) "\\'")
  (set (make-local-variable 'paragraph-start) jshell-prompt-regexp))

;; this has to be done in a hook. grumble grumble.
(add-hook 'jshell-mode-hook 'jshell--initialize)
