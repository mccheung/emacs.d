;;;
;;; Org Mode
;;;
(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Disable Ctrl + c [ & Ctrl + c ] & Ctrl + c ;
(global-set-key "\C-c[" nil)
(global-set-key "\C-c]" nil)
(global-set-key "\C-c;" nil)


;;;
;;; Agenda Setup
(setq org-agenda-files (quote ("~/org-notes"
                               "~/org-notes/pantuo"
                               "~/org-notes/joris"
                               )))
