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
(add-hook 'c++-mode 'my:flymake-google-init)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)


;; Sword
(setq sword-includes "/usr/include/sword")
;; Projects
(ede-cpp-root-project "cbible"
                :name "CBible Project"
                :file "~/src/sources/cbible/README.md"
                :include-path '("/include")
                :system-include-path '(sword-includes))
(semantic-add-system-include sword-includes 'c++-mode)
