(require 'package)
(setq package-archives
      '(("org" .
         "https://orgmode.org/elpa/")
        ("melpa-stable" .
         "https://stable.melpa.org/packages/")
        ("marmalade" .
         "https://marmalade-repo.org/packages/")
        ("gnu" .
         "http://elpa.gnu.org/packages/")
        ("melpa" .
         "https://melpa.milkbox.net/packages/"))
      package-archive-priorities
      '(("org"          . 40)
        ("melpa-stable" . 30)
        ("marmalade"    . 20)
        ("gnu"          . 10)
        ("melpa"        . 0)))

(defun my-install-all ()
  (interactive)
  (package-refresh-contents)
  (package-initialize)
  (package-install-selected-packages))

(unless (package-installed-p 'gnu-elpa-keyring-update)
  (setq package-check-signature nil)
  (package-refresh-contents)
  (package-install 'gnu-elpa-keyring-update)
  (setq package-check-signature 'allow-unsigned))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(progn
 (setq package-check-signature nil)
 (require 'gnu-elpa-keyring-update)
    (gnu-elpa-keyring-update)
  (setq package-check-signature 'allow-unsigned))

(provide 'packages-init)
