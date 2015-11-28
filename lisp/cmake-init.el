;; Requires cmake-project
;;  recommend cmake-mode for editing cmake files.
(defun maybe-cmake-project-hook ()
    (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))

(use-package cmake-mode
    :init
    (autoload 'cmake-project-mode "cmake-project")
    (add-hook 'c-mode-hook 'maybe-cmake-project-hook)
    (add-hook 'c++-mode-hook 'maybe-cmake-project-hook))

