;; stop creating backup~ files
(setq make-backup-files nil) 

;; stop creating #autosave# files
(setq auto-save-default nil) 

;; disable menu bar
(menu-bar-mode -1) 

;; To disable the scrollbar, use the following line:
(toggle-scroll-bar -1) 

;;To disable the toolbar, use the following line:
(tool-bar-mode -1) 

;; disable welcome page
(setq inhibit-startup-screen t)


(require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (package-initialize)

(require 'evil)
(evil-mode 1)

;; Auto-complete
(ac-config-default)
(setq ac-modes
      (append ac-modes '(org-mode sql-mode text-mode)))

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)


;; 匹配括号高亮
(show-paren-mode t)

;; 自动补全括号
(require 'autopair)
(autopair-global-mode)

;; Org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
	  (lambda()(setq truncate-lines nil)))


(setq org-publish-project-alist
      '(("note-org"
	 :base-directory "~/org-notes/"
	 :publishing-directory "~/org-notes/publish"
	 :base-extension "org"
	 :recursive t
	 :publishing-function org-publish-org-to-html
	 :auto-index nil
	 :index-filename "index.org"
	 :index-title "index"
	 :link-home "index.html"
	 :section-numbers nil
	 :style "<link rel=\"stylesheet\" href=\"./style/emacs.css\" type=\"text/css\"/>")
	("note-static"
	 :base-directory "~/org-notes/org"
	 :publishing-directory "~/org-notes/publish"
	 :recursive t
	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
	 :publishing-function org-publish-attachment)
	("note"
	 :components ("note-org" "note-static")
	 :author "mc.cheung@aol.com")))


