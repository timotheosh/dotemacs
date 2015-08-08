(add-to-list 'load-path (expand-file-name "~/src/sources/cbible/elisp/"))
(require 'cbible)
(add-hook 'org-mode-hook 'cbible-mode)
