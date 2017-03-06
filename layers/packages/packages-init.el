(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
        "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
    '("melpa" .
        "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
     '("gnu" .
       "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
      '("org" .
        "http://orgmode.org/elpa/"))
(defun my-install-all ()
    (interactive)
    (package-refresh-contents)
    (package-initialize)
    (package-install-selected-packages))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(provide 'packages-init)
