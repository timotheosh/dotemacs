(require 'org)
(require 'ox-wk)
(require 'ox-odt)
(require 'ox-publish)
(require 'ox-gfm)
(require 'ox-nikola)
(require 'ox-asciidoc)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
(add-hook 'org-mode-hook
		  (lambda ()
			(set-fill-column 80)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;; Blogging with Pelican ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun pelican-time ()
  (format-time-string "%Y-%m-%d %R"))

(setq pelican-md-header (concat
                         "#+OPTIONS: toc:nil tex:verbatim\n"
                         "Title:\n"
                         "Date: %(pelican-time)\n"
                         "Category:\n"
                         "Tags:\n"
                         "Slug:\n"
                         "Author: %n\n"
                         "Summary:\n"
                         "%?"))

(defun capture-pelican-draft-file (dir-path)
  (let ((name (read-string "File Name: ")))
    (expand-file-name (format "%s-%s.org"
                              (format-time-string "%Y-%m-%d")
                              name) dir-path)))

(global-set-key "\C-cc" 'org-capture)
(setq org-capture-templates
      `(("p" "New blog post" plain
               (file (capture-pelican-draft-file (expand-file-name "~/src/sources/selfdidactic/org")))
                ,pelican-md-header)))

;; Code Blocks
(setq pygments-synonym-alist
      '(("emacs-lisp" . "common-lisp")))

(defun get-pygments-synonym (lang)
  (let ((synonym (cdr (assoc lang pygments-synonym-alist))))
    (if synonym synonym lang)))

(defun pelican-src (src-block contents info)
  (let ((lang (get-pygments-synonym
               (org-element-property :language src-block)))
        (caption (org-export-get-caption src-block))
        (code (org-element-property :value src-block)))
    (concat (format "    :::%s\n" lang)
            (replace-regexp-in-string
             "^" "    " code))))

;; Links
(defun pelican-link (link desc info)
  (let* ((type (org-element-property :type link))
         (raw-path (org-element-property :path link))
         (base-filename (file-name-sans-extension raw-path)))
    (cond ((and (string= type "file")
                (string= (downcase (file-name-extension raw-path)) "org"))
           (format "[%s](|filename|%s.md)" desc base-filename))
          (t (org-export-with-backend 'md link desc info)))))

;; Project Definition
(defun org-pelican-md-publish-to-md (plist filename pub-dir)
  (org-publish-org-to 'pelican-md filename ".md" plist pub-dir))

(setq org-publish-project-alist
      `(("org-selfdidactic"
         ;; Path to your org files.
         :base-directory "/home/thawes/src/sources/selfdidactic/org"
         :base-extension "org"

         ;; Path to your Pelican project.
         :publishing-directory "/home/thawes/src/sources/selfdidactic/content"
         :recursive t
         :publishing-function org-pelican-md-publish-to-md
         )
        ("org-static-selfdidactic"
         :base-directory "/home/thawes/blog/org"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "/home/thawes/blog/pelican/content"
         :recursive t
         :publishing-function org-publish-attachment)

        ("selfdidactic" :components ("org-selfdidactic" "org-static-selfdidactic"))))


