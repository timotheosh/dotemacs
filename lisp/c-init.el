;;

(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu/c++/4.8")
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.8/backward")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include")
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/4.8/include-fixed")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu")
  (add-to-list 'achead:include-directories '"/usr/include")
  ;; Sword Development
  (add-to-list 'achead:include-directories '"/usr/include/sword"))

(add-hook 'c++-mode 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


; start flymake-google-cpplint-load
(defun my:flymake-google-init()
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (require 'flymake-google-cpplint)
  (flymake-google-cpplint-load))
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode 'my:flymake-google-init)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; CC-mode
(add-hook 'c-mode-common-hook '(lambda ()
  ;(setq ac-sources (append '(ac-source-semantic) ac-sources))
  (linum-mode 1)
  (local-set-key [f5] #'compile)
  (local-set-key [f6] #'gdb)
))

;; Sword
(setq sword-includes "/usr/include/sword")
;; Projects
(ede-cpp-root-project "cbible"
                :name "CBible Project"
                :file "~/src/sources/cbible/CMakeLists.txt"
                :include-path '("/")
                :system-include-path '(sword-includes))
(semantic-add-system-include sword-includes 'c++-mode)

;; Enforce 80 columns
(require 'column-marker)
(add-hook 'c-mode-hook
          (lambda()
            (interactive)
            (column-enforce 80)
            (column-marker-1 80)))
(add-hook 'c++-mode
          (lambda()
            (interactive)
            (column-enforce 80)
            (column-marker-1 80)))
