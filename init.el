(package-initialize)
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
    'package-archives
    '("melpa" . "http://melpa.org/packages/")
    t)
(package-initialize))


;; Fix some weird color escape sequences
(setq system-uses-terminfo nil)

;; Resolve symlinks
(setq-default find-file-visit-truename t)

;; Require a newline at the end of files
(setq require-final-newline t)

;; Search using regex by default, since that’s usually
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)

;; Single space still ends a sentence
(setq sentence-end-double-space nil)

;; Split windows a bit better (don’t split horizontally, I have a widescreen :P)
(setq split-height-threshold nil)
(setq split-width-threshold 180)

;; Bury the *scratch* buffer, never kill it
(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

;; Automatically revert file if it’s changed on disk
(global-auto-revert-mode 1)
;; be quiet about reverting files
(setq auto-revert-verbose nil)

;; Display the time and load on the modeline
(setq
 ;; don't display info about mail
 display-time-mail-function (lambda () nil)
 ;; update every 15 seconds instead of 60 seconds
 display-time-interval 15)
(display-time-mode 1)


;; Set fill-column to 80 characters and set tab width to 4
(setq-default fill-column 80)
(setq-default default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; Ignore case when using completion for file names
(setq read-file-name-completion-ignore-case t)

;; hitting the y key to confirm
(defalias 'yes-or-no-p 'y-or-n-p)

;; only on graphical Confirm before killing emacs-basic-display
(when (window-system)
  (setq confirm-kill-emacs 'yes-or-no-p))


;; Always prefer UTF-8, anything else is insanity
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; global highlighting the current row
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)

;; Turn on syntax highlighting for all buffers
(global-font-lock-mode t)


;; Don’t beep
(setq ring-bell-function (lambda ()))
(setq inhibit-startup-screen t
            initial-major-mode 'fundamental-mode)

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

;; Vim like keybind
;;(require 'evil)
;;(evil-mode 1)

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


(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; 进度记录
(setq org-log-done 'time)
(setq org-log-done 'note)

;; org tags setting
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) 
                      ("@joris" . ?j) ("@pantuo" . ?p) 
                      ("@learn" . ?l) ("@project" . ?p) 
                      ("@english" . ?e)))

;; Org-agenda config
(eval-when-compile
  (require 'org-agenda)
  (require 'cl))


;; themes
;;(require 'color-theme)
(load-theme 'spacemacs-dark t)


