;;; Installation:
;;
;; Copy multi-term.el to your load-path and add to your ~/.emacs
;;
;;  (require 'multi-term)
;;
;; And setup program that `multi-term' will need:
;;
;; (setq multi-term-program "/bin/bash")
;;
;;      or setup like me "/bin/zsh" ;)
;;
;; Below are the commands you can use:
;;
;;      `multi-term'                    Create a new term buffer.
;;      `multi-term-next'               Switch to next term buffer.
;;      `multi-term-prev'               Switch to previous term buffer.
;;      `multi-term-dedicated-open'     Open dedicated term window.
;;      `multi-term-dedicated-close'    Close dedicated term window.
;;      `multi-term-dedicated-toggle'   Toggle dedicated term window.
;;      `multi-term-dedicated-select'   Select dedicated term window.
;;
;; Tips:
;;
;;      You can type `C-u' before command `multi-term' or `multi-term-dedicated-open'
;;      then will prompt you shell name for creating terminal buffer.
(require 'multi-term)
(setq multi-term-program "/bin/bash")
