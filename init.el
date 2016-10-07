;; set keys for Apple keyboard, for emacs in OS X
;;(setq mac-command-modifier 'meta) ; make cmd key do Meta
;;(setq mac-option-modifier 'super) ; make opt key do Super
;;(setq mac-control-modifier 'control) ; make Control key do Control
;;(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

;; Dvorak nicety, regardless of loading settings
(define-key key-translation-map "\C-t" "\C-x")

;; Keep track of loading time
(defconst emacs-start-time (current-time))

;; initalize all ELPA packages
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
        '((cider                             . "melpa-stable")
          (company-cider                     . "melpa-stable")
          (malabar-mode                      . "melpa-stable"))))

(package-initialize)
(setq package-enable-at-startup nil)
(let ((elapsed (float-time (time-subtract (current-time)
                                          emacs-start-time))))
  (message "Loaded packages in %.3fs" elapsed))

;; keep customize settings in their own file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(require 'cl-lib)

(defvar my/install-packages
  '(
    ;; package management
    use-package

    ;; themeing
    rainbow-mode leuven-theme dakrone-theme color-identifiers-mode
    moe-theme nyan-mode color-theme-sanityinc-tomorrow powerline
    volatile-highlights apropospriate-theme material-theme
    visible-mark smart-mode-line

    ;; misc
    diminish gist scpaste async sx exec-path-from-shell bbdb

    ;; es-mode is run from a  git checkout

    ;; IRC/ERC and social stuff
    erc-hl-nicks ercn alert twittering-mode

    ;; for auto-complete
    fuzzy popup company

    ;; editing utilities
    expand-region smex windresize ag undo-tree iedit ido-ubiquitous
    ido-vertical-mode yasnippet smart-tab anzu smartparens flx-ido projectile
    smooth-scrolling ace-jump-mode multiple-cursors easy-kill
    simple-call-tree 
    editorconfig ggtags bookmark+
    fill-column-indicator golden-ratio wc-mode eyebrowse vlf hydra

    ;; external process things
    prodigy vkill

    ;; logs
    log4j-mode logstash-conf

    ;; infrastructure stuff
    restclient company-restclient

    ;; highlighting
    idle-highlight-mode

    ;; LaTeX
    ;;auctex

    ;; org-mode
    org htmlize gnuplot-mode gnuplot ox-reveal ox-gfm

    ;; buffer utils
    popwin dired+

    ;; haskell
    ;;haskell-mode ghc ghci-completion

    ;; config
    ssh-config-mode

    ;; flycheck
    flycheck flycheck-tip flycheck-haskell

    ;; clojure
    ;;clojure-mode 
    ;;clojure-mode-extra-font-locking 
    cider paredit paren-face

    ;; perl
    cperl-mode

    ;; python
    ;;hy-mode jedi

    ;; ruby
    ruby-mode ruby-test-mode inf-ruby puppet-mode rbenv chruby

    ;; rust
    ;;rust-mode

    ;; go
    ;;go-mode

    ;; java
    ;;malabar-mode groovy-mode javap-mode emacs-eclim

    ;; javascript
    ;;tern json-mode js2-mode

    ;; emacs-lisp
    elisp-slime-nav paredit

    ;; racket
    ;;racket-mode

    ;; markup language
    ;;markdown-mode markdown-mode+ yaml-mode zencoding-mode adoc-mode

    ;; helm
    ;;helm helm-descbinds helm-ag helm-projectile helm-swoop
    ;;helm-gtags helm-ls-git helm-flycheck helm-flyspell helm-dash

    ;; git
    magit git-gutter git-timemachine magit-gh-pulls with-editor git-annex
    diff-hl

    ;; eshell
    eshell-prompt-extras

    ;; gnus
    gnus-x-gm-raw

    ;; eww
    eww-lnum
    ))

(defvar packages-refreshed? nil)

(dolist (pack my/install-packages)
  (unless (package-installed-p pack)
    (unless packages-refreshed?
      (package-refresh-contents)
      (setq packages-refreshed? t))
    (package-install pack)))

;; Load use-package, used for loading packages everywhere else
(require 'use-package)
;; Set to t to debug package loading
(setq use-package-verbose nil)

(setq debug-on-error t)
(setq debug-on-quit t)

;;(defvar my/background 'light)
(defvar my/background 'dark)

(setq user-full-name "Mc Cheung"
      user-mail-address "mc.cheung@aol.com")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(global-font-lock-mode t)

(setq gc-cons-threshold (* 100 1024 1024)) ;; 100 mb
;; Allow font-lock-mode to do background parsing
(setq jit-lock-stealth-time 1
      ;; jit-lock-stealth-load 200
      jit-lock-chunk-size 1000
      jit-lock-defer-time 0.05)

(setq line-number-display-limit-width 10000)

(setq gnutls-min-prime-bits 4096)

(setq scroll-conservatively 10000
      scroll-preserve-screen-position t)

(setq echo-keystrokes 0.4)

(setq large-file-warning-threshold (* 25 1024 1024))

(transient-mark-mode 1)

(setq-default indicate-empty-lines nil)
(setq-default indicate-buffer-boundaries nil)

(when (functionp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (functionp 'set-scroll-bar-mode)
  (set-scroll-bar-mode 'nil))
(when (functionp 'mouse-wheel-mode)
  (mouse-wheel-mode -1))
(when (functionp 'tooltip-mode)
  (tooltip-mode -1))
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (functionp 'blink-cursor-mode)
  (blink-cursor-mode -1))

(setq ring-bell-function (lambda ()))
(setq inhibit-startup-message t
      initial-major-mode 'fundamental-mode)

(line-number-mode 1)
(column-number-mode 1)

(setq read-file-name-completion-ignore-case t)

(defalias 'yes-or-no-p 'y-or-n-p)

(when (window-system)
  (setq confirm-kill-emacs 'yes-or-no-p))

(setq line-move-visual t)

(setq make-pointer-invisible t)

(setq-default fill-column 80)
(setq-default default-tab-width 2)
(setq-default indent-tabs-mode nil)

(setq system-uses-terminfo nil)

(setq-default find-file-visit-truename t)

(setq require-final-newline t)

(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)

(setq sentence-end-double-space nil)

(setq split-height-threshold nil)
(setq split-width-threshold 180)

(set-default 'imenu-auto-rescan t)

(random t)

(setq diff-switches "-u")

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(use-package diminish
  :init
  (progn
    (diminish 'auto-fill-function "")))

(setq calc-display-sci-low -5)

(defadvice kill-buffer (around kill-buffer-around-advice activate)
  (let ((buffer-to-kill (ad-get-arg 0)))
    (if (equal buffer-to-kill "*scratch*")
        (bury-buffer)
      ad-do-it)))

(global-auto-revert-mode 1)
;; be quiet about reverting files
(setq auto-revert-verbose nil)

(use-package server
  :config
  (progn
    (when (not (window-system))
      (if (server-running-p server-name)
          nil
        (server-start)))))

(when (window-system)
  (setenv "EMACS_GUI" "t"))

(when (boundp 'global-prettify-symbols-mode)
  (add-hook 'emacs-lisp-mode-hook
            (lambda ()
              (push '("lambda" . ?λ) prettify-symbols-alist)))
  (add-hook 'clojure-mode-hook
            (lambda ()
              (push '("fn" . ?ƒ) prettify-symbols-alist)))
  (global-prettify-symbols-mode +1))

(setq load-prefer-newer t)

(use-package winner
  :init (winner-mode 1))

(setq
 ;; don't display info about mail
 display-time-mail-function (lambda () nil)
 ;; update every 15 seconds instead of 60 seconds
 display-time-interval 15)
(display-time-mode 1)

(defun my/quit-emacs-unconditionally ()
  (interactive)
  (my-quit-emacs '(4)))

(define-key special-event-map (kbd "<sigusr1>") #'my/quit-emacs-unconditionally)

(setq tls-program
      ;; Defaults:
      ;; '("gnutls-cli --insecure -p %p %h"
      ;;   "gnutls-cli --insecure -p %p %h --protocols ssl3"
      ;;   "openssl s_client -connect %h:%p -no_ssl2 -ign_eof")
      '("gnutls-cli -p %p %h"
        "openssl s_client -connect %h:%p -no_ssl2 -no_ssl3 -ign_eof"))

(when (eq system-type 'gnu/linux)

  (defun my/max-fullscreen ()
    (interactive)
    (toggle-frame-maximized))

  ;; fullscreen
  (add-hook 'after-init-hook #'my/max-fullscreen)

  (setq dired-listing-switches "-lFaGh1v --group-directories-first")
  (defun yank-to-x-clipboard ()
    (interactive)
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!")))

  (global-set-key (kbd "C-M-w") 'yank-to-x-clipboard)
  ;; suspend-frame isn't working on Linux?
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-x C-z")))

(when (eq system-type 'darwin)
  (setq ns-use-native-fullscreen nil)
  ;; brew install coreutils
  (if (executable-find "gls")
      (progn
        (setq insert-directory-program "gls")
        (setq dired-listing-switches "-lFaGh1v --group-directories-first"))
    (setq dired-listing-switches "-ahlF"))
  (defun copy-from-osx ()
    "Handle copy/paste intelligently on osx."
    (let ((pbpaste (purecopy "/usr/bin/pbpaste")))
      (if (and (eq system-type 'darwin)
               (file-exists-p pbpaste))
          (let ((tramp-mode nil)
                (default-directory "~"))
            (shell-command-to-string pbpaste)))))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "/usr/bin/pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))
  (setq interprogram-cut-function 'paste-to-osx
        interprogram-paste-function 'copy-from-osx)

  (defun move-file-to-trash (file)
    "Use `trash' to move FILE to the system trash.
When using Homebrew, install it using \"brew install trash\"."
    (call-process (executable-find "trash")
                  nil 0 nil
                  file))

  ;; Trackpad scrolling
  (global-set-key [wheel-up] 'previous-line)
  (global-set-key [wheel-down] 'next-line))

(when (eq window-system 'mac)

  (defun my/max-fullscreen ()
    (interactive)
    (set-frame-parameter nil 'fullscreen 'fullboth))

  ;; fullscreen
  (add-hook 'after-init-hook #'my/max-fullscreen)
  ;; use alt as hyper
  (setq mac-option-modifier 'meta)
  ;; use command as meta
  (setq mac-command-modifier 'hyper))

(setq x-select-enable-clipboard t)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(setq save-interprogram-paste-before-kill t)

;; savehist
(setq savehist-additional-variables
      ;; also save my search entries
      '(search-ring regexp-search-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)
(setq-default save-place t)

;; delete-auto-save-files
(setq delete-auto-save-files t)
(setq make-backup-files nil)
;; (setq backup-directory-alist
;;      '(("." . "~/.emacs_backups")))

;; delete old backups silently
(setq delete-old-versions t)

(setenv "PAGER" "cat")

(custom-set-variables
 '(comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
 '(comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
 '(comint-scroll-show-maximum-output t) ; scroll to show max possible output
 ;; '(comint-completion-autolist t)     ; show completion list when ambiguous
 '(comint-input-ignoredups t)           ; no duplicates in command history
 '(comint-completion-addsuffix t)       ; insert space/slash after file completion
 '(comint-prompt-read-only nil)         ; if this is t, it breaks shell-command
 '(comint-get-old-input (lambda () "")) ; what to run when i press enter on a
                                        ; line above the current prompt
 )

(defun my/shell-kill-buffer-sentinel (process event)
  (when (memq (process-status process) '(exit signal))
    (kill-buffer)))

(defun my/kill-process-buffer-on-exit ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'my/shell-kill-buffer-sentinel))

(dolist (hook '(ielm-mode-hook term-exec-hook comint-exec-hook))
  (add-hook hook 'my/kill-process-buffer-on-exit))

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))

(defadvice comint-previous-matching-input
    (around suppress-history-item-messages activate)
  "Suppress the annoying 'History item : NNN' messages from shell history isearch.
If this isn't enough, try the same thing with
comint-replace-by-expanded-history-before-point."
  (let ((old-message (symbol-function 'message)))
    (unwind-protect
        (progn (fset 'message 'ignore) ad-do-it)
      (fset 'message old-message))))

(add-hook 'shell-mode-hook 'set-scroll-conservatively)
;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)
;; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun my/setup-eshell ()
  (interactive)
  ;; turn off semantic-mode in eshell buffers
  (semantic-mode -1)
  ;; turn off hl-line-mode
  (hl-line-mode -1)
  (define-key eshell-mode-map (kbd "M-l")
    'helm-eshell-history))

(use-package eshell
  :config
  (progn
    (defalias 'emacs 'find-file)
    (defalias 'ec 'find-file)
    (setenv "PAGER" "cat")
    (use-package esh-opt
      :config
      (progn
        (use-package em-cmpl)
        (use-package em-prompt)
        (use-package em-term)

        (setq eshell-cmpl-cycle-completions nil
              ;; auto truncate after 12k lines
              eshell-buffer-maximum-lines 12000
              ;; history size
              eshell-history-size 500
              ;; buffer shorthand -> echo foo > #'buffer
              eshell-buffer-shorthand t
              ;; my prompt is easy enough to see
              eshell-highlight-prompt nil
              ;; treat 'echo' like shell echo
              eshell-plain-echo-behavior t)

        ;; Visual commands
        (setq eshell-visual-commands '("vi" "screen" "top" "less" "more" "lynx"
                                       "ncftp" "pine" "tin" "trn" "elm" "vim"
                                       "nmtui" "alsamixer" "htop" "el" "elinks"
                                       ))
        (setq eshell-visual-subcommands '(("git" "log" "diff" "show")))

        (defun my/truncate-eshell-buffers ()
          "Truncates all eshell buffers"
          (interactive)
          (save-current-buffer
            (dolist (buffer (buffer-list t))
              (set-buffer buffer)
              (when (eq major-mode 'eshell-mode)
                (eshell-truncate-buffer)))))

        ;; After being idle for 5 seconds, truncate all the eshell-buffers if
        ;; needed. If this needs to be canceled, you can run `(cancel-timer
        ;; my/eshell-truncate-timer)'
        (setq my/eshell-truncate-timer
              (run-with-idle-timer 5 t #'my/truncate-eshell-buffers))

        (when (not (functionp 'eshell/rgrep))
          (defun eshell/rgrep (&rest args)
            "Use Emacs grep facility instead of calling external grep."
            (eshell-grep "rgrep" args t)))

        (defun eshell/cds ()
          "Change directory to the project's root."
          (eshell/cd (locate-dominating-file default-directory ".git")))

        (defun eshell/l (&rest args) "Same as `ls -lh'"
               (apply #'eshell/ls "-lh" args))
        (defun eshell/ll (&rest args) "Same as `ls -lh'"
               (apply #'eshell/ls "-lh" args))
        (defun eshell/la (&rest args) "Same as `ls -alh'"
               (apply #'eshell/ls "-alh" args))

        (defun eshell/clear ()
          "Clear the eshell buffer"
          (interactive)
          (let ((eshell-buffer-maximum-lines 0))
            (eshell-truncate-buffer)))))
 
    (add-hook 'eshell-mode-hook #'my/setup-eshell)

    ;; See eshell-prompt-function below
    (setq eshell-prompt-regexp "^[^#$\n]* [#$] ")

    ;; So the history vars are defined
    (require 'em-hist)
    (if (boundp 'eshell-save-history-on-exit)
        ;; Don't ask, just save
        (setq eshell-save-history-on-exit t))

    ;; See: https://github.com/kaihaosw/eshell-prompt-extras
    (use-package eshell-prompt-extras
      :init
      (progn
        (setq eshell-highlight-prompt nil
              epe-git-dirty-char " Ϟ"
              ;; epe-git-dirty-char "*"
              eshell-prompt-function 'epe-theme-dakrone)))

    (defun eshell/magit ()
      "Function to open magit-status for the current directory"
      (interactive)
      (magit-status default-directory)
      nil)))

(defun my/create-or-switch-to-delta-buffer ()
  "Switch to the *eshell delta* buffer, or create it"
  (interactive)
  (if (get-buffer "*eshell-delta*")
      (switch-to-buffer "*eshell-delta*")
    (let ((eshell-buffer-name "*eshell-delta*"))
      (eshell))))

(global-set-key (kbd "C-x d") 'my/create-or-switch-to-delta-buffer)

(defun my/create-or-switch-to-eshell-1 ()
  "Switch to the *eshell* buffer, or create it"
  (interactive)
  (if (get-buffer "*eshell*")
      (switch-to-buffer "*eshell*")
    (let ((eshell-buffer-name "*eshell*"))
      (eshell))))

(defun my/create-or-switch-to-eshell-2 ()
  "Switch to the *eshell*<2> buffer, or create it"
  (interactive)
  (if (get-buffer "*eshell*<2>")
      (switch-to-buffer "*eshell*<2>")
    (let ((eshell-buffer-name "*eshell*<2>"))
      (eshell))))

(defun my/create-or-switch-to-eshell-3 ()
  "Switch to the *eshell*<3> buffer, or create it"
  (interactive)
  (if (get-buffer "*eshell*<3>")
      (switch-to-buffer "*eshell*<3>")
    (let ((eshell-buffer-name "*eshell*<3>"))
      (eshell))))

(defun my/create-or-switch-to-eshell-4 ()
  "Switch to the *eshell*<4> buffer, or create it"
  (interactive)
  (if (get-buffer "*eshell*<4>")
      (switch-to-buffer "*eshell*<4>")
    (let ((eshell-buffer-name "*eshell*<4>"))
      (eshell))))

(global-set-key (kbd "H-1") 'my/create-or-switch-to-ebshell-1)
(global-set-key (kbd "H-2") 'my/create-or-switch-to-eshell-2)
(global-set-key (kbd "H-3") 'my/create-or-switch-to-eshell-3)
(global-set-key (kbd "H-4") 'my/create-or-switch-to-eshell-4)
(global-set-key (kbd "s-1") 'my/create-or-switch-to-eshell-1)
(global-set-key (kbd "s-2") 'my/create-or-switch-to-eshell-2)
(global-set-key (kbd "s-3") 'my/create-or-switch-to-eshell-3)
(global-set-key (kbd "s-4") 'my/create-or-switch-to-eshell-4)
(global-set-key (kbd "M-1") 'my/create-or-switch-to-eshell-1)
(global-set-key (kbd "M-2") 'my/create-or-switch-to-eshell-2)
(global-set-key (kbd "M-3") 'my/create-or-switch-to-eshell-3)
(global-set-key (kbd "M-4") 'my/create-or-switch-to-eshell-4)

(use-package tramp
  :defer t
  :config
  (progn
    (with-eval-after-load 'tramp-cache
      (setq tramp-persistency-file-name "~/.emacs.d/etc/tramp"))
    (setq tramp-default-user-alist '(("\\`su\\(do\\)?\\'" nil "root"))
          tramp-adb-program "/Users/hinmanm/android-sdk-macosx/platform-tools/adb"
          ;; use the settings in ~/.ssh/config instead of Tramp's
          tramp-use-ssh-controlmaster-options nil
          backup-enable-predicate
          (lambda (name)
            (and (normal-backup-enable-predicate name)
                 (not (let ((method (file-remote-p name 'method)))
                        (when (stringp method)
                          (member method '("su" "sudo"))))))))

    (use-package tramp-sh
      :config
      (progn
        (add-to-list 'tramp-remote-path "/usr/local/sbin")
        ;;(add-to-list 'tramp-remote-path "/opt/java/current/bin")
        (add-to-list 'tramp-remote-path "~/bin")))))

;; Standard location of personal dictionary
(setq ispell-personal-dictionary "~/.flydict")

;; Mostly taken from
;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;; if (aspell installed) { use aspell }
;; else if (hunspell installed) { use hunspell }
;; whatever spell checker I use, I always use English dictionary
(setq ispell-program-name (executable-find "aspell"))
(setq ispell-extra-args
      (list "--sug-mode=fast" ;; ultra|fast|normal|bad-spellers
            "--lang=en_US"
            "--ignore=3"))

;; hunspell
;; (setq ispell-program-name "hunspell")
;; ;; just reset dictionary to the safe one "en_US" for hunspell.
;; ;; if we need use different dictionary, we specify it in command line arguments
;; (setq ispell-local-dictionary "en_US")
;; (setq ispell-local-dictionary-alist
;;       '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil nil nil utf-8)))

(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(defun my/enable-flyspell-prog-mode ()
  (interactive)
  (flyspell-prog-mode))

(use-package flyspell
  :defer t
  :diminish ""
  :init (add-hook 'prog-mode-hook #'my/enable-flyspell-prog-mode)
  :config
  (use-package helm-flyspell
    :init
    (define-key flyspell-mode-map (kbd "M-S") 'helm-flyspell-correct)))

(use-package view
  :defer t
  :bind
  (("C-M-n" . View-scroll-half-page-forward)
   ("C-M-p" . View-scroll-half-page-backward))
  :config
  (progn
    ;; When in view-mode, the buffer is read-only:
    (setq view-read-only t)

    (defun View-goto-line-last (&optional line)
      "goto last line"
      (interactive "P")
      (goto-line (line-number-at-pos (point-max))))

    ;; less like
    (define-key view-mode-map (kbd "N") 'View-search-last-regexp-backward)
    (define-key view-mode-map (kbd "?") 'View-search-regexp-backward?)
    (define-key view-mode-map (kbd "g") 'View-goto-line)
    (define-key view-mode-map (kbd "G") 'View-goto-line-last)
    ;; vi/w3m like
    (define-key view-mode-map (kbd "h") 'backward-char)
    (define-key view-mode-map (kbd "j") 'next-line)
    (define-key view-mode-map (kbd "k") 'previous-line)
    (define-key view-mode-map (kbd "l") 'forward-char)))

(use-package doc-view
  :config
  (define-key doc-view-mode-map (kbd "j")
    #'doc-view-next-line-or-next-page)
  (define-key doc-view-mode-map (kbd "k")
    #'doc-view-previous-line-or-previous-page)
  ;; use 'q' to kill the buffer, not just hide it
  (define-key doc-view-mode-map (kbd "q")
    #'kill-this-buffer))

(defun my/dired-open ()
  "Use the OSX `open' command to open a file with the correct editor"
  (interactive)
  (save-window-excursion
    (dired-do-async-shell-command
     "~/bin/open" current-prefix-arg
     (dired-get-marked-files t current-prefix-arg))))

(defun my/dired-mode-hook ()
  (my/turn-on-hl-line-mode)
  (toggle-truncate-lines 1))

(use-package dired
  :bind ("C-x C-j" . dired-jump)
  :config
  (progn
    (use-package dired-x
      :init (setq-default dired-omit-files-p t)
      :config
      (add-to-list 'dired-omit-extensions ".DS_Store"))
    (customize-set-variable 'diredp-hide-details-initially-flag nil)
    (use-package dired+)
    (use-package dired-aux
      :init (use-package dired-async))
    (put 'dired-find-alternate-file 'disabled nil)
    (setq ls-lisp-dirs-first t
          dired-recursive-copies 'always
          dired-recursive-deletes 'always
          dired-dwim-target t
          ;; -F marks links with @
          dired-ls-F-marks-symlinks t
          delete-by-moving-to-trash t
          ;; Auto refresh dired
          global-auto-revert-non-file-buffers t
          wdired-allow-to-change-permissions t)
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
    (define-key dired-mode-map (kbd "C-M-u") 'dired-up-directory)
    (define-key dired-mode-map (kbd "M-o") #'my/dired-open)
    (define-key dired-mode-map (kbd "C-x C-q") 'wdired-change-to-wdired-mode)
    (add-hook 'dired-mode-hook #'my/dired-mode-hook)))

(use-package saveplace
  :defer t
  :init
  (setq-default save-place t)
  (setq save-place-file (expand-file-name ".places" user-emacs-directory)))

(use-package recentf
  :defer t
  :init
  (progn
    (setq recentf-max-saved-items 300
          recentf-exclude '("/auto-install/" ".recentf" "/repos/" "/elpa/"
                            "\\.mime-example" "\\.ido.last" "COMMIT_EDITMSG"
                            ".gz"
                            "~$" "/tmp/" "/ssh:" "/sudo:" "/scp:")
          recentf-auto-cleanup 600)
    (when (not noninteractive) (recentf-mode 1))

    (defun recentf-save-list ()
      "Save the recent list.
Load the list from the file specified by `recentf-save-file',
merge the changes of your current session, and save it back to
the file."
      (interactive)
      (let ((instance-list (cl-copy-list recentf-list)))
        (recentf-load-list)
        (recentf-merge-with-default-list instance-list)
        (recentf-write-list-to-file)))

    (defun recentf-merge-with-default-list (other-list)
      "Add all items from `other-list' to `recentf-list'."
      (dolist (oitem other-list)
        ;; add-to-list already checks for equal'ity
        (add-to-list 'recentf-list oitem)))

    (defun recentf-write-list-to-file ()
      "Write the recent files list to file.
Uses `recentf-list' as the list and `recentf-save-file' as the
file to write to."
      (condition-case error
          (with-temp-buffer
            (erase-buffer)
            (set-buffer-file-coding-system recentf-save-file-coding-system)
            (insert (format recentf-save-file-header (current-time-string)))
            (recentf-dump-variable 'recentf-list recentf-max-saved-items)
            (recentf-dump-variable 'recentf-filter-changer-current)
            (insert "\n \n;;; Local Variables:\n"
                    (format ";;; coding: %s\n" recentf-save-file-coding-system)
                    ";;; End:\n")
            (write-file (expand-file-name recentf-save-file))
            (when recentf-save-file-modes
              (set-file-modes recentf-save-file recentf-save-file-modes))
            nil)
        (error
         (warn "recentf mode: %s" (error-message-string error)))))))

(setq whitespace-line-column 140)

(setq whitespace-style '(tabs newline space-mark
                         tab-mark newline-mark
                         face lines-tail))

(setq whitespace-display-mappings
      ;; all numbers are Unicode codepoint in decimal. e.g. (insert-char 182 1)
      ;; 32 SPACE, 183 MIDDLE DOT
      '((space-mark nil)
        ;; 10 LINE FEED
        ;;(newline-mark 10 [172 10])
        (newline-mark nil)
        ;; 9 TAB, MIDDLE DOT
        (tab-mark 9 [183 9] [92 9])))

(setq whitespace-global-modes '(not org-mode
                                    eshell-mode
                                    shell-mode
                                    web-mode
                                    log4j-mode
                                    "Web"
                                    dired-mode
                                    emacs-lisp-mode
                                    clojure-mode
                                    lisp-mode))

;; turn on whitespace mode globally
(global-whitespace-mode 1)
(diminish 'global-whitespace-mode "")

(set-default 'indicate-empty-lines t)
(setq show-trailing-whitespace t)

(defun my/setup-semantic-mode ()
  (interactive)
  (use-package semantic)
  (require 'semantic/ia)
  (require 'semantic/wisent)
  ;; Use a better (though slower) parser for java, if it exists
  ;; (autoload 'wisent-java-default-setup "semantic/wisent/java")
  (setq semantic-default-submodes
        '(global-semantic-idle-scheduler-mode
          global-semanticdb-minor-mode
          global-semantic-idle-summary-mode
          global-semantic-stickyfunc-mode))
  (semantic-mode t)
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c?" 'semantic-analyze-proto-impl-toggle))

(add-hook 'c-mode-hook #'my/setup-semantic-mode)
;;(add-hook 'java-mode-hook #'my/setup-semantic-mode)

(setq vc-handled-backends '(SVN Git))

(defun my/add-watchwords ()
  "Highlight FIXME, TODO, and NOCOMMIT in code"
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|NOCOMMIT\\)\\>"
          1 '((:foreground "#d7a3ad") (:weight bold)) t))))

(defun my/turn-on-hl-line-mode ()
  "Turn on hl-line-mode"
  (interactive)
  (hl-line-mode 1))

(add-hook 'prog-mode-hook #'my/add-watchwords)
(add-hook 'prog-mode-hook #'my/turn-on-hl-line-mode)
(add-hook 'org-mode-hook #'my/turn-on-hl-line-mode)

;; custom test locations instead of foo_test.clj, use test/foo.clj
(defun clojure-test-for-without-test (namespace)
  (interactive)
  (let* ((namespace (clojure-underscores-for-hyphens namespace))
         (segments (split-string namespace "\\."))
         (before (subseq segments 0 1))
         (after (subseq segments 1))
         (test-segments (append before (list "test") after)))
    (format "%stest/%s.clj"
            (locate-dominating-file buffer-file-name "src/")
            (mapconcat 'identity test-segments "/"))))

(defun clojure-test-implementation-for-without-test (namespace)
  (interactive)
  (let* ((namespace (clojure-underscores-for-hyphens namespace))
         (segments (split-string namespace "\\."))
         (before (subseq segments 0 1))
         (after (subseq segments 2))
         (impl-segments (append before after)))
    (format "%s/src/%s.clj"
            (locate-dominating-file buffer-file-name "src/")
            (mapconcat 'identity impl-segments "/"))))

(defun my/clojure-things-hook ()
  "Set up clojure-y things"
  (eldoc-mode 1)
  (subword-mode t)
  ;; use my test layout fns
  ;; (setq clojure-test-for-fn 'my-clojure-test-for)
  ;; (setq clojure-test-implementation-for-fn 'my-clojure-test-implementation-for)
  ;; compile faster
  (setq font-lock-verbose nil)
  (global-set-key (kbd "C-c t") 'clojure-jump-between-tests-and-code)
  (paredit-mode 1))

(use-package clojure-mode
  :config
  (progn
    (add-hook 'clojure-mode-hook 'my/clojure-things-hook)))

(defun my/setup-cider ()
  (lambda ()
    (setq cider-history-file "~/.nrepl-history"
          cider-hide-special-buffers t
          cider-repl-history-size 10000
          cider-prefer-local-resources t
          cider-popup-stacktraces-in-repl t)
    (paredit-mode 1)
    (eldoc-mode 1)))

(use-package cider
  :init
  (progn
    (add-hook 'cider-mode-hook 'my/setup-cider)
    (add-hook 'cider-repl-mode-hook 'my/setup-cider)
    (add-hook 'cider-mode-hook 'my/clojure-things-hook)
    (add-hook 'cider-repl-mode-hook 'my/clojure-things-hook)))

(add-hook 'sh-mode-hook
          (lambda ()
            (show-paren-mode -1)
            (flycheck-mode -1)
            (setq blink-matching-paren nil)))

(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))

(defun my/turn-on-paredit-and-eldoc ()
  (interactive)
  (paredit-mode 1)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook #'my/turn-on-paredit-and-eldoc)
(add-hook 'ielm-mode-hook #'my/turn-on-paredit-and-eldoc)

(use-package eldoc
  :config
  (progn
    (use-package diminish
      :init
      (progn (diminish 'eldoc-mode "")))
    (setq eldoc-idle-delay 0.3)
    (set-face-attribute 'eldoc-highlight-function-argument nil
                        :underline t :foreground "green"
                        :weight 'bold)))

(set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
(set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")

(defun ielm-other-window ()
  "Run ielm on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*ielm*"))
  (call-interactively 'ielm))

(define-key emacs-lisp-mode-map (kbd "C-c C-z") 'ielm-other-window)
(define-key lisp-interaction-mode-map (kbd "C-c C-z") 'ielm-other-window)

(use-package elisp-slime-nav
  :init (add-hook 'emacs-lisp-mode-hook #'elisp-slime-nav-mode))

(bind-key "M-:" 'pp-eval-expression)

(defun sanityinc/eval-last-sexp-or-region (prefix)
 "Eval region from BEG to END if active, otherwise the last sexp."
 (interactive "P")
 (if (and (mark) (use-region-p))
 (eval-region (min (point) (mark)) (max (point) (mark)))
 (pp-eval-last-sexp prefix)))

(bind-key "C-x C-e" 'sanityinc/eval-last-sexp-or-region emacs-lisp-mode-map)

(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

(use-package python
  :defer t
  :config
  (progn
    (define-key python-mode-map (kbd "C-c C-z") 'run-python)
    (define-key python-mode-map (kbd "<backtab>") 'python-back-indent)
    (defun my/setup-jedi ()
      (interactive)
      (use-package jedi
        :config
        (progn

          (jedi:setup)
          (jedi:ac-setup)
          (setq jedi:setup-keys t)
          (setq jedi:complete-on-dot t)
          (define-key python-mode-map (kbd "C-c C-d") 'jedi:show-doc)
          (setq jedi:tooltip-method nil)
          (set-face-attribute 'jedi:highlight-function-argument nil
                              :foreground "green")
          (define-key python-mode-map (kbd "C-c C-l") 'jedi:get-in-function-call))))
    (add-hook 'python-mode-hook #'my/setup-jedi)))

;; (defun java-line-up-only-constructor-or-dont (thing)
;;   "If at a class constructor, line up with the paren, if not, use
;;  ++ indentation"
;;   (interactive)
;;   (save-excursion
;;     (beginning-of-line)
;;     (backward-up-list 1)
;;     (backward-word 2)
;;     ;; Now at either "new" or something else
;;     (let* ((sym (semantic-ctxt-current-symbol)))
;;       (if (eq '("new") sym)
;;           '++
;;         (c-lineup-arglist-intro-after-paren thing)))))
;; 
;; (defconst intellij-java-style
;;   '((c-basic-offset . 4)
;;     (c-comment-only-line-offset . (0 . 0))
;;     ;; the following preserves Javadoc starter lines
;;     (c-offsets-alist
;;      .
;;      ((inline-open . 0)
;;       (topmost-intro-cont    . +)
;;       (statement-block-intro . +)
;;       (knr-argdecl-intro     . +)
;;       (substatement-open     . +)
;;       (substatement-label    . +)
;;       (case-label            . +)
;;       (label                 . +)
;;       (statement-case-open   . +)
;;       (statement-cont        . ++)
;;       (arglist-intro         . 0)
;;       ;; (arglist-intro         . c-lineup-arglist-intro-after-paren)
;;       (arglist-cont-nonempty . ++)
;;       ;; (arglist-cont-nonempty . java-line-up-only-constructor-or-dont)
;;       (arglist-close         . --)
;;       ;; (arglist-close         . c-lineup-arglist)
;;       (inexpr-class          . 0)
;;       (access-label          . 0)
;;       (inher-intro           . ++)
;;       (inher-cont            . ++)
;;       ;; (brace-list-intro      . ++)
;;       (brace-list-intro      . +)
;;       (func-decl-cont        . ++))))
;;   "Elasticsearch's Intellij Java Programming Style")
;; 
;; (c-add-style "intellij" intellij-java-style)
;; (customize-set-variable 'c-default-style
;;                         '((java-mode . "intellij")
;;                           (awk-mode . "awk")
;;                           (other . "gnu")))

;; I've never write for java codes.
;; (defun setup-java ()
;;   (interactive)
;;   (define-key java-mode-map (kbd "M-,") 'pop-tag-mark)
;;   (c-set-style "intellij" t)
;;   (subword-mode 1)
;;   ;; Generic java stuff things
;;   (setq-local fci-rule-column 99)
;;   ;; remove the stupid company-eclim backend
;;   (when (boundp 'company-backends)
;;     (delete 'company-eclim company-backends)))
;; 
;; (add-hook 'java-mode-hook 'setup-java)

(use-package emacs-eclim
  :init
  (progn
    ;; only show errors
    (setq-default eclim--problems-filter "e")
    (global-eclim-mode))
  :config
  (progn
    (use-package company-emacs-eclim
      :init (company-emacs-eclim-setup))))

(use-package rbenv
  :disabled t
  :init (global-rbenv-mode t))

(use-package chruby
  :defer t
  :init (chruby "ruby-2.1.3"))

(use-package haskell-mode
  :defer t
  :init
  (progn
    (add-hook 'haskell-mode-hook #'haskell-indentation-mode)
    (add-hook 'haskell-mode-hook #'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook #'subword-mode))
  :config
  (progn
    (let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
      (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
      (add-to-list 'exec-path my-cabal-path))
    (custom-set-variables '(haskell-tags-on-save t))

    (custom-set-variables
     '(haskell-process-suggest-remove-import-lines t)
     '(haskell-process-auto-import-loaded-modules t)
     '(haskell-process-log t))
    (define-key haskell-mode-map (kbd "C-c C-l")
      'haskell-process-load-or-reload)
    (define-key haskell-mode-map (kbd "C-c C-z")
      'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-n C-t")
      'haskell-process-do-type)
    (define-key haskell-mode-map (kbd "C-c C-n C-i")
      'haskell-process-do-info)
    (define-key haskell-mode-map (kbd "C-c C-n C-c")
      'haskell-process-cabal-build)
    (define-key haskell-mode-map (kbd "C-c C-n c")
      'haskell-process-cabal)
    (define-key haskell-mode-map (kbd "SPC")
      'haskell-mode-contextual-space)

    (eval-after-load 'haskell-cabal
      '(progn
         (define-key haskell-cabal-mode-map (kbd "C-c C-z")
           'haskell-interactive-switch)
         (define-key haskell-cabal-mode-map (kbd "C-c C-k")
           'haskell-interactive-mode-clear)
         (define-key haskell-cabal-mode-map (kbd "C-c C-c")
           'haskell-process-cabal-build)
         (define-key haskell-cabal-mode-map (kbd "C-c c")
           'haskell-process-cabal)))

    (custom-set-variables '(haskell-process-type 'cabal-repl))

    (autoload 'ghc-init "ghc" nil t)
    (autoload 'ghc-debug "ghc" nil t)
    (add-hook 'haskell-mode-hook (lambda () (ghc-init)))))

(use-package js2-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    (defalias 'javascript-generic-mode 'js2-mode))
  :config
  (progn
    (js2-imenu-extras-setup)
    (setq-default js-auto-indent-flag nil
                  js-indent-level 2)))

(use-package tern
  :init ;;(add-hook 'js-mode-hook (lambda () (tern-mode t)))
  )

(if (file-exists-p "~/src/elisp/es-mode")
    (progn
      (add-to-list 'load-path "~/src/elisp/es-mode")
      (use-package es-mode
        :init (use-package ob-elasticsearch)
        ;; Don't warn me about delete statements
        :config (setq es-warn-on-delete-query nil)))
  (progn
    (use-package es-mode
      :ensure t
      :init (use-package ob-elasticsearch)
      ;; Don't warn me about delete statements
      :config (setq es-warn-on-delete-query nil))))

(setq-default TeX-engine 'luatex)

(setq ns-use-srgb-colorspace t)

(defun dakrone-dark ()
  (interactive)
  ;; (use-package color-theme-sanityinc-tomorrow
  ;;   :init (color-theme-sanityinc-tomorrow-night))
  (use-package material-theme
    :init (load-theme 'material t))
  (use-package apropospriate-theme
    :disabled t
    :init (load-theme 'apropospriate-dark t))
  (use-package color-theme-sanityinc-tomorrow
    :disabled t
    :init (load-theme 'sanityinc-tomorrow-night t)))

(defun dakrone-light ()
  (interactive)
  (use-package leuven-theme
    :init (load-theme 'leuven t)
    :config (set-background-color "#f0f0f0"))
  (use-package material-theme
    :disabled t
    :init (load-theme 'material-light t)))

(if (eq my/background 'dark)
    (dakrone-dark)
  (dakrone-light))

(defun my/setup-osx-fonts ()
  (interactive)
  (when (eq system-type 'darwin)
    (set-fontset-font "fontset-default" 'symbol "Monaco")
    ;;(set-default-font "Fantasque Sans Mono")
    ;;(set-default-font "Monaco")
    ;;(set-default-font "Anonymous Pro")
    ;;(set-default-font "Inconsolata")
    (set-default-font "Bitstream Vera Sans Mono")
    ;;(set-default-font "Menlo")
    ;;(set-default-font "Source Code Pro")
    ;;(set-default-font "Mensch")
    (set-face-attribute 'default nil :height 120)
    (set-face-attribute 'fixed-pitch nil :height 120)

    ;; Anti-aliasing
    (setq mac-allow-anti-aliasing t)))

(when (eq system-type 'darwin)
  (add-hook 'after-init-hook #'my/setup-osx-fonts))

(defun my/setup-x11-fonts ()
  (interactive)
  (when (eq window-system 'x)
    ;; Font family
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))
    ;; Font size
    ;;(set-face-attribute 'default nil :height 90)
    ))

(when (eq window-system 'x)
  (add-hook 'after-init-hook #'my/setup-x11-fonts))

(use-package powerline
  :disabled t
  :init (powerline-default-theme))

(use-package smart-mode-line
  :init (sml/setup)
  :config
  (setq sml/shorten-directory t
        sml/shorten-modes t)
  (add-to-list 'sml/replacer-regexp-list '("^~/src/elasticsearch/" ":ES:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/es/x-plugins/" ":x-plugins:") t))

(defun my/set-fringe-background ()
  "Set the fringe background to the same color as the regular background."
  (interactive)
  (setq my/fringe-background-color
        (face-background 'default))
  (custom-set-faces
   `(fringe ((t (:background ,my/fringe-background-color))))))

(add-hook 'after-init-hook #'my/set-fringe-background)

;; Indicate where a buffer stars and stops
(setq-default indicate-buffer-boundaries 'right)
(toggle-indicate-empty-lines)

(defun my/org-mode-hook ()
  (interactive)
  (turn-on-auto-fill)
  (turn-on-flyspell)
  (yas-minor-mode-on)
  (when (fboundp 'my/enable-abbrev-mode)
    (my/enable-abbrev-mode))

  ;; fix some bindings that org-mode overwrites
  (define-key org-mode-map [C-tab] 'other-window)
  (define-key org-mode-map [C-S-tab]
    (lambda ()
      (interactive)
      (other-window -1)))
  (define-key org-mode-map (kbd "C-'")
    'eyebrowse-next-window-config)
  (define-key org-mode-map (kbd "C-c C-x C-f") 'org-refile)
  (define-key org-mode-map (kbd "C-S-<left>") 'org-table-delete-column)
  (define-key org-mode-map (kbd "C-S-<right>") 'org-table-insert-column)
  (define-key org-mode-map (kbd "C-S-<down>") 'org-table-insert-row)
  (define-key org-agenda-mode-map (kbd "C-c C-x C-f") 'org-agenda-refile))

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c c" . org-capture)
         ("C-c M-p" . org-babel-previous-src-block)
         ("C-c M-n" . org-babel-next-src-block)
         ("C-c S" . org-babel-previous-src-block)
         ("C-c s" . org-babel-next-src-block))
  :config
  (progn
    (use-package org-install)
    (use-package org-babel)
    ;; org-export
    (use-package ox)
    ;; Enable archiving things
    (use-package org-archive)
    (add-hook 'org-mode-hook #'my/org-mode-hook)
    (setq org-directory (file-truename "~/org")
          ;; follow links by pressing ENTER on them
          org-return-follows-link t
          ;; allow changing between todo stats directly by hotkey
          org-use-fast-todo-selection t
          ;; syntax highlight code in source blocks
          org-src-fontify-natively t
          ;; for the leuven theme, fontify the whole heading line
          org-fontify-whole-heading-line t
          ;; force UTF-8
          org-export-coding-system 'utf-8
          ;; use ido completion when I can
          org-completion-use-ido t
          ;; don't indent source code
          org-edit-src-content-indentation 0
          ;; don't adapt indentation
          org-adapt-indentation nil
          ;; preserve the indentation inside of source blocks
          org-src-preserve-indentation t
          ;; Imenu should use 3 depth instead of 2
          org-imenu-depth 3
          ;; always start the agenda on today
          org-agenda-start-on-weekday nil
          ;; Use sticky agenda's so they persist
          org-agenda-sticky t
          ;; show 4 agenda days
          org-agenda-span 4
          ;; special begin/end of line to skip tags and stars
          org-special-ctrl-a/e t
          ;; special keys for killing a headline
          org-special-ctrl-k t
          ;; don't adjust subtrees that I copy
          org-yank-adjusted-subtrees nil
          ;; try to be smart when editing hidden things
          org-catch-invisible-edits 'smart
          ;; blank lines are removed when exiting the code edit buffer
          org-src-strip-leading-and-trailing-blank-lines t
          ;; how org-src windows are set up when hitting C-c '
          org-src-window-setup 'current-window
          ;;org-src-window-setup 'other-window
          ;; Overwrite the current window with the agenda
          org-agenda-window-setup 'current-window
          ;; Use full outline paths for refile targets - we file directly with IDO
          org-refile-use-outline-path t
          ;; Targets complete directly with IDO
          org-outline-path-complete-in-steps nil
          ;; Allow refile to create parent tasks with confirmation
          org-refile-allow-creating-parent-nodes (quote confirm)
          ;; never leave empty lines in collapsed view
          org-cycle-separator-lines 0
          ;; Use cider as the clojure backend
          org-babel-clojure-backend 'cider
          ;; don't run stuff automatically on export
          org-export-babel-evaluate nil
          ;; export tables as CSV instead of tab-delineated
          org-table-export-default-format "orgtbl-to-csv"
          ;; always enable noweb, results as code and exporting both
          org-babel-default-header-args
          (cons '(:noweb . "yes")
                (assq-delete-all :noweb org-babel-default-header-args))
          org-babel-default-header-args
          (cons '(:exports . "both")
                (assq-delete-all :exports org-babel-default-header-args))
          ;; I don't want to be prompted on every code block evaluation
          org-confirm-babel-evaluate nil
          ;; Do not dim blocked tasks
          org-agenda-dim-blocked-tasks nil
          ;; Compact the block agenda view
          org-agenda-compact-blocks t
          ;; Mark entries as done when archiving
          org-archive-mark-done nil
          ;; Where to put headlines when archiving them
          org-archive-location "%s_archive::* Archived Tasks"
          ;; Sorting order for tasks on the agenda
          org-agenda-sorting-strategy
          (quote ((agenda habit-down
                          time-up
                          priority-down
                          user-defined-up
                          effort-up
                          category-keep)
                  (todo priority-down category-up effort-up)
                  (tags priority-down category-up effort-up)
                  (search priority-down category-up)))

          ;; Enable display of the time grid so we can see the marker for the current time
          org-agenda-time-grid (quote ((daily today remove-match)
                                       #("----------------" 0 16 (org-heading t))
                                       (0900 1100 1300 1500 1700)))
          ;; Include the diary file in the agenda
          org-agenda-include-diary t
          org-agenda-diary-file "~/org-notes/diary"
          org-agenda-insert-diary-extract-time t
          ;; keep the agenda filter until manually removed
          org-agenda-persistent-filter t
          org-agenda-repeating-timestamp-show-all t
          ;; Show all agenda dates - even if they are empty
          org-agenda-show-all-dates t
          ;; Agenda org-mode files
          org-agenda-files `(,(file-truename "~/org-notes/")
                             ;;,(file-truename "~/org-notes/pantuo/Pantuo.org")
                             ;;,(file-truename "~/org-notes/joirs/Joris.org")
                             ;;,(file-truename "~/org-notes/book/")
                             ))

    ;; Save all org-mode buffers every hour at :59
    (run-at-time "00:59" 3600 'org-save-all-org-buffers)

    ;; Org todo keywords
    (setq org-todo-keywords
          (quote
           ((sequence "SOMEDAY(s)" "TODO(t)" "INPROGRESS(i)" "WAITING(w@/!)" "NEEDSREVIEW(n@/!)"
                      "|" "DONE(d)")
            (sequence "WAITING(w@/!)" "HOLD(h@/!)"
                      "|" "CANCELLED(c@/!)"))))
    ;; Org faces
    (setq org-todo-keyword-faces
          (quote (("TODO" :foreground "red" :weight bold)
                  ("INPROGRESS" :foreground "deep sky blue" :weight bold)
                  ("SOMEDAY" :foreground "purple" :weight bold)
                  ("NEEDSREVIEW" :foreground "#edd400" :weight bold)
                  ("DONE" :foreground "forest green" :weight bold)
                  ("WAITING" :foreground "orange" :weight bold)
                  ("HOLD" :foreground "magenta" :weight bold)
                  ("CANCELLED" :foreground "forest green" :weight bold))))
    ;; add or remove tags on state change
    (setq org-todo-state-tags-triggers
          (quote (("CANCELLED" ("CANCELLED" . t))
                  ("WAITING" ("WAITING" . t))
                  ("HOLD" ("WAITING") ("HOLD" . t))
                  (done ("WAITING") ("HOLD"))
                  ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                  ("INPROGRESS" ("WAITING") ("CANCELLED") ("HOLD"))
                  ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
    ;; refile targets all level 1 and 2 headers in current file and agenda files
    (setq org-refile-targets '((nil :maxlevel . 2)
                               (org-agenda-files :maxlevel . 2)))
    ;; quick access to common tags
    (setq org-tag-alist
          '(("oss" . ?o)
            ("home" . ?h)
            ("work" . ?w)
            ("book" . ?b)
            ("support" . ?s)
            ("docs" . ?d)
            ("export" . ?e)
            ("noexport" . ?n)))
    ;; capture templates
    (setq org-capture-templates
          (quote
           (("t" "Todo" entry (file "~/org-notes/Refile.org")
             "* TODO %?\n%U\n")
            ("n" "Notes" entry (file+headline "~/org-notes/Notes.org" "Notes")
             "* %? :NOTE:\n%U\n")
            ("j" "Journal" entry (file+datetree "~/org-notes/Journal.org")
             "* %?\n%U\n")
            ("b" "Book/Bibliography" entry
             (file+headline "~/org-notes/Bibliography.org" "Refile")
             "* %?%^{TITLE}p%^{AUTHOR}p%^{TYPE}p"))))
    ;; Custom agenda command definitions
    (setq org-agenda-custom-commands
          (quote
           (("N" "Notes" tags "NOTE"
             ((org-agenda-overriding-header "Notes")
              (org-tags-match-list-sublevels t)))
            (" " "Agenda"
             ((agenda "" nil)
              ;; All items with the "REFILE" tag, everything in refile.org
              ;; automatically gets that applied
              (tags "REFILE"
                    ((org-agenda-overriding-header "Tasks to Refile")
                     (org-tags-match-list-sublevels nil)))
              ;; All "INPROGRESS" todo items
              (todo "INPROGRESS"
                    ((org-agenda-overriding-header "Current work")))
              ;; All headings with the "support" tag
              (tags "support/!"
                    ((org-agenda-overriding-header "Support cases")))
              ;; All "NEESREVIEW" todo items
              (todo "NEEDSREVIEW"
                    ((org-agenda-overriding-header "Waiting on reviews")))
              ;; All "WAITING" items without a "support" tag
              (tags "WAITING-support"
                    ((org-agenda-overriding-header "Waiting for feedback")))
              ;; All TODO items
              (todo "TODO"
                    ((org-agenda-overriding-header "Task list")
                     (org-agenda-sorting-strategy
                      '(time-up priority-down category-keep))))
              ;; Everything on hold
              (todo "HOLD"
                    ((org-agenda-overriding-header "On-hold")))
              ;; Everything that's done and archivable
              ;; (todo "DONE"
              ;;       ((org-agenda-overriding-header "Tasks for archive")
              ;;        (org-agenda-skip-function 'my/skip-non-archivable-tasks)))
              )
             nil))))

    ;; Exclude DONE state tasks from refile targets
    (defun my/verify-refile-target ()
      "Exclude todo keywords with a done state from refile targets"
      (not (member (nth 2 (org-heading-components)) org-done-keywords)))
    (setq org-refile-target-verify-function 'my/verify-refile-target)

    ;; org-mode bindings
    (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
    (define-key org-mode-map (kbd "C-c t") 'org-todo)
    (define-key org-mode-map (kbd "M-G") 'org-plot/gnuplot)
    (define-key org-mode-map (kbd "RET") 'org-return-indent)
    ;; swap C-RET and M-RET
    (define-key org-mode-map (kbd "C-<return>") 'org-insert-heading)
    (define-key org-mode-map (kbd "M-<return>")
      'org-insert-heading-after-current)

    (local-unset-key (kbd "M-S-<return>"))

    ;; org-babel stuff
    ;;(require 'ob-clojure)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (elasticsearch . t)
       ;;(clojure . t)
       (dot . t)
       (sh . t)
       (ruby . t)
       (python . t)
       (gnuplot . t)
       (plantuml . t)
       (latex . t)))

    ;; plantuml jar path
    (setq org-plantuml-jar-path
          "/usr/local/Cellar/plantuml/8002/plantuml.8002.jar")

    ;; Use org.css from the :wq website for export document stylesheets
    (setq org-html-head-extra
          "<link rel=\"stylesheet\" href=\"http://dakrone.github.io/org.css\" type=\"text/css\" />")
    (setq org-html-head-include-default-style nil)

    ;; ensure this variable is defined
    (unless (boundp 'org-babel-default-header-args:sh)
      (setq org-babel-default-header-args:sh '()))

    ;; add a default shebang header argument shell scripts
    (add-to-list 'org-babel-default-header-args:sh
                 '(:shebang . "#!/usr/bin/env zsh"))

    ;; add a default shebang header argument for python
    (add-to-list 'org-babel-default-header-args:python
                 '(:shebang . "#!/usr/bin/env python"))

    ;; Clojure-specific org-babel stuff
    ;;(defvar org-babel-default-header-args:clojure
    ;;  '((:results . "silent")))

    ;;(defun org-babel-execute:clojure (body params)
    ;;  "Execute a block of Clojure code with Babel."
    ;;  (let ((result-plist
    ;;         (nrepl-send-string-sync
    ;;          (org-babel-expand-body:clojure body params) nrepl-buffer-ns))
    ;;        (result-type  (cdr (assoc :result-type params))))
    ;;    (org-babel-script-escape
    ;;    (cond ((eq result-type 'value) (plist-get result-plist :value))
    ;;           ((eq result-type 'output) (plist-get result-plist :value))
    ;;           (t (message "Unknown :results type!"))))))

    ;; Function declarations
    (defun my/skip-non-archivable-tasks ()
      "Skip trees that are not available for archiving"
      (save-restriction
        (widen)
        ;; Consider only tasks with done todo headings as archivable candidates
        (let ((next-headline (save-excursion
                               (or (outline-next-heading) (point-max))))
              (subtree-end (save-excursion (org-end-of-subtree t))))
          (if (member (org-get-todo-state) org-todo-keywords-1)
              (if (member (org-get-todo-state) org-done-keywords)
                  (let* ((daynr (string-to-int
                                 (format-time-string "%d" (current-time))))
                         (a-month-ago (* 60 60 24 (+ daynr 1)))
                         (this-month
                          (format-time-string "%Y-%m-" (current-time)))
                         (subtree-is-current
                          (save-excursion
                            (forward-line 1)
                            (and (< (point) subtree-end)
                                 (re-search-forward this-month
                                                    subtree-end t)))))
                    (if subtree-is-current
                        subtree-end     ; Has a date in this month, skip it
                      nil))             ; available to archive
                (or subtree-end (point-max)))
            next-headline))))

    (defun my/save-all-agenda-buffers ()
      "Function used to save all agenda buffers that are
   currently open, based on `org-agenda-files'."
      (interactive)
      (save-current-buffer
        (dolist (buffer (buffer-list t))
          (set-buffer buffer)
          (when (member (buffer-file-name)
                        (mapcar 'expand-file-name (org-agenda-files t)))
            (save-buffer)))))

    ;; save all the agenda files after each capture
    (add-hook 'org-capture-after-finalize-hook 'my/save-all-agenda-buffers)

    (use-package org-id
      :config
      (progn
        (setq org-id-link-to-org-use-id t)

        (defun my/org-custom-id-get (&optional pom create prefix)
          "Get the CUSTOM_ID property of the entry at point-or-marker POM.
   If POM is nil, refer to the entry at point. If the entry does
   not have an CUSTOM_ID, the function returns nil. However, when
   CREATE is non nil, create a CUSTOM_ID if none is present
   already. PREFIX will be passed through to `org-id-new'. In any
   case, the CUSTOM_ID of the entry is returned."
          (interactive)
          (org-with-point-at pom
            (let ((id (org-entry-get nil "CUSTOM_ID")))
              (cond
               ((and id (stringp id) (string-match "\\S-" id))
                id)
               (create
                (setq id (org-id-new prefix))
                (org-entry-put pom "CUSTOM_ID" id)
                (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
                id)))))

        (defun my/org-add-ids-to-headlines-in-file ()
          "Add CUSTOM_ID properties to all headlines in the
   current file which do not already have one."
          (interactive)
          (org-map-entries (lambda () (my/org-custom-id-get (point) 'create))))

        ;; automatically add ids to captured headlines
        (add-hook 'org-capture-prepare-finalize-hook
                  (lambda () (my/org-custom-id-get (point) 'create)))))

    (defun my/org-inline-css-hook (exporter)
      "Insert custom inline css to automatically set the
   background of code to whatever theme I'm using's background"
      (when (eq exporter 'html)
        (let* ((my-pre-bg (face-background 'default))
               (my-pre-fg (face-foreground 'default)))
          ;;(setq org-html-head-include-default-style nil)
          (setq
           org-html-head-extra
           (concat
            org-html-head-extra
            (format "<style type=\"text/css\">\n pre.src {background-color: %s; color: %s;}</style>\n"
                    my-pre-bg my-pre-fg))))))

    (add-hook 'org-export-before-processing-hook #'my/org-inline-css-hook)))

(defun my/org-clock-in ()
  (interactive)
  (org-clock-in '(4)))

(global-set-key (kbd "<f11>") #'my/org-clock-in)
(global-set-key (kbd "<f12>") 'org-clock-out)

(use-package org
  :bind (("C-c C-x C-i" . my/org-clock-in)
         ("C-c C-x C-o" . org-clock-out))
  :config
  (progn
    ;; Insinuate it everywhere
    (org-clock-persistence-insinuate)
    ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
    (setq org-clock-history-length 23
          ;; Resume clocking task on clock-in if the clock is open
          org-clock-in-resume t
          ;; Separate drawers for clocking and logs
          org-drawers '("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "HIDDEN")
          ;; Save clock data and state changes and notes in the LOGBOOK drawer
          org-clock-into-drawer t
          ;; Sometimes I change tasks I'm clocking quickly -
          ;; this removes clocked tasks with 0:00 duration
          org-clock-out-remove-zero-time-clocks t
          ;; Clock out when moving task to a done state
          org-clock-out-when-done t
          ;; Save the running clock and all clock history when exiting Emacs, load it on startup
          org-clock-persist t
          ;; Prompt to resume an active clock
          org-clock-persist-query-resume t
          ;; Enable auto clock resolution for finding open clocks
          org-clock-auto-clock-resolution #'when-no-clock-is-running
          ;; Include current clocking task in clock reports
          org-clock-report-include-clocking-task t
          ;; don't use pretty things for the clocktable
          org-pretty-entities nil
          ;; some default parameters for the clock report
          org-agenda-clockreport-parameter-plist
          '(:maxlevel 10 :fileskip0 t :score agenda :block thismonth :compact t :narrow 60))))

(use-package org
  :config
  (setq org-publish-project-alist
        `(;; Main website at http://writequit.org
          ("writequit-org"
           :base-directory ,(file-truename "~/www")
           :base-extension "org\\|html"
           :publishing-directory
           "/ssh:writequit.org:~/www/"
           :publishing-function org-html-publish-to-html
           :with-toc nil
           :html-preamble t)
          ("writequit-images"
           :base-directory ,(file-truename  "~/www/images")
           :base-extension "png\\|jpg\\|gif"
           :publishing-directory
           "/ssh:writequit.org:~/www/images"
           :publishing-function org-publish-attachment)
          ("writequit-files"
           :base-directory ,(file-truename  "~/www/files")
           :base-extension "*"
           :publishing-directory
           "/ssh:writequit.org:~/www/files/"
           :publishing-function org-publish-attachment)
          ("writequit" :components ("writequit-org"
                                    "writequit-images"
                                    "writequit-files"))

          ;; Org-mode files for ~/.emacs.d/settings.org
          ("dotfiles"
           :base-directory ,(file-truename "~/.emacs.d/../")
           :base-extension "org\\|html"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/"
           :publishing-function org-html-publish-to-html
           :with-toc t
           :html-preamble t)

          ;; Org-mode files for ~/org files
          ("org-org"
           :base-directory ,(file-truename "~/org-notes/")
           :base-extension "org\\|html"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/"
           :publishing-function org-html-publish-to-html
           :with-toc t
           :html-preamble t)
          ("org-images"
           :base-directory ,(file-truename "~/org-notes/images")
           :base-extension "png\\|jpg"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/images"
           :publishing-function org-publish-attachment)
          ("org" :components ("org-org" "org-images"))

          ;; Org-mode for the ~/org-notes/es files
          ("org-es-org"
           :base-directory ,(file-truename "~/org-notes/es/")
           :base-extension "org\\|html"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/es"
           :publishing-function org-html-publish-to-html
           :with-toc t
           :html-preamble t)
          ("org-es-files"
           :base-directory ,(file-truename "~/org-notes/es/")
           :base-extension "css\\|pdf\\|sh\\|es\\|zsh\\|py\\|org"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/es"
           :publishing-function org-publish-attachment)
          ("org-es-images"
           :base-directory ,(file-truename "~/org-notes/es/images")
           :base-extension "png\\|jpg"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/es/images"
           :publishing-function org-publish-attachment)
          ("org-es"
           :components ("org-es-org" "org-es-files" "org-es-images"))

          ;; Org-mode for the ~/org-notes/es/design files
          ("org-es-design-org"
           :base-directory ,(file-truename "~/org-notes/es/design")
           :base-extension "org\\|html"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/es/design"
           :publishing-function org-html-publish-to-html
           :with-toc t
           :html-preamble t)
          ("org-es-design-files"
           :base-directory ,(file-truename "~/org-notes/es/design")
           :base-extension "css\\|pdf\\|sh\\|es\\|zsh\\|py\\|org"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/es/design"
           :publishing-function org-publish-attachment)
          ("org-es-designs-images"
           :base-directory ,(file-truename "~/org-notes/es/design/images")
           :base-extension "png\\|jpg"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/es/design/images"
           :publishing-function org-publish-attachment)
          ("org-es-design"
           :components ("org-es-design-org"
                        "org-es-design-files"
                        "org-es-design-images"))

          ;; Org-mode files for the book
          ("org-book-pastebin"
           :base-directory ,(file-truename "~/org-notes/book/")
           :base-extension "org\\|zsh\\|html\\|png"
           :publishing-directory
           "/ssh:writequit.org:~/www/org/book/"
           :publishing-function org-html-publish-to-html
           :with-toc t
           :html-preamble t))))

(use-package ox-reveal
  :defer t
  :config
  (progn
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/2.5.0/")))

(use-package exec-path-from-shell
  :defer t
  :init
  (progn
    (setq exec-path-from-shell-variables '("JAVA_HOME"
                                           "PATH"
                                           "MANPATH"))
    (exec-path-from-shell-initialize)))

(use-package vkill
  :defer t
  :commands vkill
  :bind ("C-x L" . vkill-and-helm-occur)
  :init
  (defun vkill-and-helm-occur ()
    (interactive)
    (vkill)
    (my/turn-on-hl-line-mode)
    (call-interactively #'helm-occur)))

(use-package alert
  :defer t
  :config
  (progn
    (when (eq system-type 'darwin)
      (setq alert-default-style 'notifier))
    (when (eq system-type 'gnu/linux)
      (setq alert-default-style 'notifications))))

(defun start-irc ()
  (interactive)
  (when (file-exists-p "~/.ercpass")
    (load-file "~/.ercpass"))

  (use-package erc
    :config
    (progn
      (setq erc-fill-column 78
            erc-server-coding-system '(utf-8 . utf-8)
            erc-hide-list '("JOIN" "PART" "QUIT" "NICK")
            erc-track-exclude-types (append '("324" "329" "332" "333"
                                              "353" "477" "MODE")
                                            erc-hide-list)
            erc-nick '("dakrone" "dakrone_" "dakrone__")
            erc-flood-protect nil
            erc-pals '("hiredman" "danlarkin" "drewr" "pjstadig" "scgilardi"
                       "joegallo" "jimduey" "leathekd" "zkim" "imotov"
                       "technomancy" "yazirian" "danielglauser")
            erc-pal-highlight-type 'nil
            erc-keywords '("dakrone" "dakrone_" "clj-http" "cheshire"
                           ;;"clojure-opennlp" 
                           "opennlp" "circuit breaker"
                           "simple_query_string")
            erc-ignore-list '()
            erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                      "324" "329" "332" "333" "353" "477")
            erc-log-matches-types-alist
            '((keyword . "ERC keywords")
              (current-nick . "ERC messages for me"))
            erc-prompt-for-nickserv-password nil
            erc-server-reconnect-timeout 5
            erc-fill-function 'erc-fill-static
            erc-fill-static-center 18
            ;; update ERC prompt with room name
            erc-prompt (lambda ()
                         (if (and (boundp 'erc-default-recipients)
                                  (erc-default-target))
                             (erc-propertize (concat (erc-default-target) ">")
                                             'read-only t 'rear-nonsticky t
                                             'front-nonsticky t)
                           (erc-propertize (concat "ERC>") 'read-only t
                                           'rear-nonsticky t
                                           'front-nonsticky t))))

      ;; Turn on company-mode in ERC
      (add-hook 'erc-mode-hook 'company-mode)

      ;; other random services (spelling)
      (use-package erc-services
        :init
        (progn
          (add-to-list 'erc-modules 'spelling)
          (erc-services-mode 1)
          (erc-spelling-mode 1)))
      (erc-update-modules)))

  (use-package ercn
  :config
  (progn
    (setq ercn-notify-rules
          '((current-nick . all)
            (keyword . all)
            (pal . ("#84115"))
            (query-buffer . all)))
    (defun do-notify (nickname message)
      (alert message :title (concat (buffer-name) ": " nickname)))
    (add-hook 'ercn-notify-hook #'do-notify)))

  (let ((tls-program
         '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof -cert ~/host.pem"
           "gnutls-cli --priority secure256 --x509certfile ~/host.pem -p %p %h"
           "gnutls-cli --priority secure256 -p %p %h")))
    (erc-tls :server "freenode" :port 31425
             :nick "dakrone" :password freenode-znc-pass)
    (erc-tls :server "oftc" :port 31425
             :nick "dakrone" :password oftc-znc-pass)))

(use-package ace-jump-mode
  :defer t
  :bind (("C-c SPC" . ace-jump-mode)
         ("C-c M-SPC" . ace-jump-line-mode)))

(defun my/setup-ediff ()
  (interactive)
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" #'ediff-next-difference)
  (define-key ediff-mode-map "k" #'ediff-previous-difference))

(use-package ediff
  :defer t
  :init (add-hook 'ediff-mode-hook 'my/setup-ediff)
  :config
  (progn
    (setq
     ;; Always split nicely for wide screens
     ediff-split-window-function 'split-window-horizontally
     ;; Ignore whitespace
     ediff-diff-options "-w")))

(use-package smooth-scrolling
  :defer t
  :config
  (setq smooth-scroll-margin 4))

(use-package paredit
  :defer t
  :diminish "()"
  :config
  (progn
    (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
    (define-key paredit-mode-map (kbd "C-(") 'paredit-forward-barf-sexp)
    (define-key paredit-mode-map (kbd "C-)") 'paredit-forward-slurp-sexp)
    (define-key paredit-mode-map (kbd ")") 'paredit-close-parenthesis)
    (define-key paredit-mode-map (kbd "M-\"") 'my/other-window-backwards)))

(use-package smartparens
  :defer t
  :diminish ""
  :bind (("M-9" . sp-backward-sexp)
         ("M-0" . sp-forward-sexp))
  :init
  (progn
    (add-hook 'prog-mode-hook #'turn-on-smartparens-mode)
    ;; turn on showing the match for clojure and elisp
    ;;(add-hook 'clojure-mode-hook #'turn-on-show-smartparens-mode)
    (add-hook 'emacs-lisp-mode-hook #'turn-on-show-smartparens-mode)
    ;;(add-hook 'java-mode-hook #'turn-on-show-smartparens-mode)
    (add-hook 'c-mode-hook #'turn-on-show-smartparens-mode))
  :config
  (progn
    (add-to-list 'sp-sexp-suffix '(json-mode regex ""))
    (add-to-list 'sp-sexp-suffix '(es-mode regex ""))

    (use-package smartparens-config)
    (add-hook 'sh-mode-hook
              (lambda ()
                ;; Remove when https://github.com/Fuco1/smartparens/issues/257
                ;; is fixed
                (setq sp-autoescape-string-quote nil)))

    ;; Remove the M-<backspace> binding that smartparens adds
    (let ((disabled '("M-<backspace>")))
      (setq sp-smartparens-bindings
            (cl-remove-if (lambda (key-command)
                            (member (car key-command) disabled))
                          sp-smartparens-bindings)))

    (define-key sp-keymap (kbd "C-(") 'sp-forward-barf-sexp)
    (define-key sp-keymap (kbd "C-)") 'sp-forward-slurp-sexp)
    (define-key sp-keymap (kbd "M-(") 'sp-forward-barf-sexp)
    (define-key sp-keymap (kbd "M-)") 'sp-forward-slurp-sexp)
    (define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
    (define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)
    (define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
    (define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)
    (define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
    (define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)
    (define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
    (define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)
    (define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
    (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
    (define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)
    (define-key sp-keymap (kbd "C-M-t") 'sp-transpose-sexp)
    ;; (define-key sp-keymap (kbd "C-M-n") 'sp-next-sexp)
    ;; (define-key sp-keymap (kbd "C-M-p") 'sp-previous-sexp)
    (define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)
    (define-key sp-keymap (kbd "C-M-w") 'sp-copy-sexp)
    (define-key sp-keymap (kbd "M-D") 'sp-splice-sexp)
    (define-key sp-keymap (kbd "C-]") 'sp-select-next-thing-exchange)
    (define-key sp-keymap (kbd "C-<left_bracket>") 'sp-select-previous-thing)
    (define-key sp-keymap (kbd "C-M-]") 'sp-select-next-thing)
    (define-key sp-keymap (kbd "M-F") 'sp-forward-symbol)
    (define-key sp-keymap (kbd "M-B") 'sp-backward-symbol)
    (define-key sp-keymap (kbd "H-t") 'sp-prefix-tag-object)
    (define-key sp-keymap (kbd "H-p") 'sp-prefix-pair-object)
    (define-key sp-keymap (kbd "H-s c") 'sp-convolute-sexp)
    (define-key sp-keymap (kbd "H-s a") 'sp-absorb-sexp)
    (define-key sp-keymap (kbd "H-s e") 'sp-emit-sexp)
    (define-key sp-keymap (kbd "H-s p") 'sp-add-to-previous-sexp)
    (define-key sp-keymap (kbd "H-s n") 'sp-add-to-next-sexp)
    (define-key sp-keymap (kbd "H-s j") 'sp-join-sexp)
    (define-key sp-keymap (kbd "H-s s") 'sp-split-sexp)

    (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
    ;; Remove '' pairing in elisp because quoting is used a ton
    (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

    (sp-with-modes '(html-mode sgml-mode)
      (sp-local-pair "<" ">"))

    (sp-with-modes sp--lisp-modes
      (sp-local-pair "(" nil :bind "C-("))))

(use-package golden-ratio
  :diminish golden-ratio-mode
  :defer t
  :config
  (progn
    (defun my/helm-alive-p ()
      (if (boundp 'helm-alive-p)
          (symbol-value 'helm-alive-p)))

    ;; Inhibit helm
    (add-to-list 'golden-ratio-inhibit-functions #'my/helm-alive-p)
    ;; Inhibit ERC and mu4e
    (setq golden-ratio-auto-scale t
          golden-ratio-exclude-modes
          '(erc-mode mu4e-headers-mode mu4e-view-mode))))

(defun my/flycheck-customize ()
  (interactive)
  (global-set-key (kbd "C-c C-n") 'flycheck-tip-cycle)
  (global-set-key (kbd "C-c C-p") 'flycheck-tip-cycle-reverse))

(use-package flycheck
  :defer t
  :bind (("M-g M-n" . flycheck-next-error)
         ("M-g M-p" . flycheck-previous-error)
         ("M-g M-=" . flycheck-list-errors))
  :init (global-flycheck-mode)
  :diminish ""
  :config
  (progn
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
    (use-package flycheck-tip
      :config (add-hook 'flycheck-mode-hook #'my/flycheck-customize))
    (use-package helm-flycheck
      :init (define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
    (use-package flycheck-haskell
      :init (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))))

(defun my/setup-helm-gtags ()
  (interactive)
  ;; this variables must be set before load helm-gtags
  ;; you can change to any prefix key of your choice
  (setq helm-gtags-prefix-key "\C-cg")
  (setq helm-gtags-ignore-case t
        helm-gtags-auto-update t
        helm-gtags-use-input-at-cursor t
        helm-gtags-pulse-at-cursor t
        helm-gtags-suggested-key-mapping t)
  (use-package helm-gtags
    :init (helm-gtags-mode t)
    :diminish "")
  ;; key bindings
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history))

(defun my/setup-ggtags ()
  (interactive)
  (ggtags-mode 1)
  ;; turn on eldoc with ggtags
  (setq-local eldoc-documentation-function #'ggtags-eldoc-function)
  ;; add ggtags to the hippie completion
  (setq-local hippie-expand-try-functions-list
              (cons 'ggtags-try-complete-tag
                    hippie-expand-try-functions-list))
  ;; use helm for completion
  (setq ggtags-completing-read-function nil))

(use-package ggtags
  :defer t
  :init
  (progn
    (add-hook 'c-mode-common-hook
              (lambda ()
                ;;(when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
                (when (derived-mode-p 'c-mode 'c++-mode 'asm-mode)
                  (my/setup-semantic-mode)
                  (my/setup-helm-gtags) ;; helm-gtags
                  ;;(my/setup-ggtags) ;; regular gtags
                  )))))

(use-package expand-region
  :defer t
  :bind (("C-c e" . er/expand-region)
         ("C-M-@" . er/contract-region)))

(use-package with-editor
  :init
  (progn
    (add-hook 'shell-mode-hook  'with-editor-export-editor)
    (add-hook 'eshell-mode-hook 'with-editor-export-editor)))

(use-package magit
  :defer t
  :bind ("M-g M-g" . magit-status)
  :init (defvar magit-emacsclient-executable nil) ;; fix for emacs-mac
  :config
  (progn
    (if (file-exists-p  "/usr/local/bin/emacsclient")
        (setq magit-emacsclient-executable "/usr/local/bin/emacsclient")
      (setq magit-emacsclient-executable (executable-find "emacsclient")))
    (defun my/magit-browse ()
      "Browse to the project's github URL, if available"
      (interactive)
      (let ((url (with-temp-buffer
                   (unless (zerop (call-process-shell-command
                                   "git remote -v" nil t))
                     (error "Failed: 'git remote -v'"))
                   (goto-char (point-min))
                   (when (re-search-forward
                          "github\\.com[:/]\\(.+?\\)\\.git" nil t)
                     (format "https://github.com/%s" (match-string 1))))))
        (unless url
          (error "Can't find repository URL"))
        (browse-url url)))

    (define-key magit-mode-map (kbd "C-c C-b") #'my/magit-browse)
    ;; Magit has its own binding, so re-bind them
    (define-key magit-mode-map (kbd "M-1") #'my/create-or-switch-to-eshell-1)
    (define-key magit-mode-map (kbd "M-2") #'my/create-or-switch-to-eshell-2)
    (define-key magit-mode-map (kbd "M-3") #'my/create-or-switch-to-eshell-3)
    (define-key magit-mode-map (kbd "M-4") #'my/create-or-switch-to-eshell-4)
    (define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)
    (setq magit-completing-read-function 'magit-ido-completing-read)))

(use-package projectile
  :defer t
  :bind (("C-c p a" . projectile-ag)
         ("C-c p g" . projectile-grep)
         ("C-c p b" . projectile-switch-to-buffer)
         ("C-c p K" . projectile-kill-buffers))
  :init (projectile-global-mode 1)
  :diminish ""
  :config
  (progn
    (use-package helm
      :init
      (progn
        (use-package grep) ;; required for helm-ag to work properly
        (setq projectile-completion-system 'helm)
        (helm-projectile-on)))))

(use-package prodigy
  :defer t
  :bind ("C-x P" . prodigy)
  :config
  (progn
    (prodigy-define-service
      :name "ES 1.6, 10 nodes"
      :cwd "~/ies/"
      :command "esvm"
      :args '("10node")
      :tags '(work test es)
      :port 9200)

    (prodigy-define-service
      :name "ES 1.6, 3 nodes"
      :cwd "~/ies/"
      :command "esvm"
      :args '("3node")
      :tags '(work test es)
      :port 9200)

    (prodigy-define-service
      :name "ES 1.6, 2 nodes"
      :cwd "~/ies/"
      :command "esvm"
      :args '("2node")
      :tags '(work test es)
      :port 9200)

    (prodigy-define-service
      :name "Elasticsearch 1.6.0"
      :cwd "~/ies/elasticsearch-1.6.0"
      :command "~/ies/elasticsearch-1.6.0/bin/elasticsearch"
      :tags '(work test es)
      :port 9200)

    (prodigy-define-service
      :name "Elasticsearch 1.5.2"
      :cwd "~/ies/elasticsearch-1.5.2"
      :command "~/ies/elasticsearch-1.5.2/bin/elasticsearch"
      :tags '(work test es)
      :port 9200)

    (prodigy-define-service
      :name "Elasticsearch 1.4.5"
      :cwd "~/ies/elasticsearch-1.4.5"
      :command "~/ies/elasticsearch-1.4.5/bin/elasticsearch"
      :tags '(work test es)
      :port 9200)))

(use-package git-gutter
  :defer t
  :bind (("C-x =" . git-gutter:popup-hunk)
         ("C-c P" . git-gutter:previous-hunk)
         ("C-c N" . git-gutter:next-hunk)
         ("C-x p" . git-gutter:previous-hunk)
         ("C-x n" . git-gutter:next-hunk)
         ("C-c G" . git-gutter:popup-hunk))
  :diminish ""
  :init
  (progn
    ;; Only a few programming modes
    ;;(add-hook 'java-mode-hook 'git-gutter-mode)
    (add-hook 'org-mode-hook 'git-gutter-mode)
    ;;(add-hook 'clojure-mode-hook 'git-gutter-mode)
    (add-hook 'ruby-mode-hook 'git-gutter-mode)
    (add-hook 'python-mode-hook 'git-gutter-mode)))

(use-package git-annex)

(use-package diff-hl
  :disabled t
  :defer t
  :bind (("C-c G" . diff-hl-diff-goto-hunk))
  :init
  (if (window-system)
      (global-diff-hl-mode 1)
    (diff-hl-margin-mode 1)))

(use-package anzu
  :defer t
  :bind ("M-%" . anzu-query-replace-regexp)
  :config
  (progn
    (use-package thingatpt)
    (setq anzu-mode-lighter "")
    (set-face-attribute 'anzu-mode-line nil :foreground "yellow")))

(add-hook 'prog-mode-hook #'anzu-mode)

(defun isearch-yank-symbol ()
  (interactive)
  (isearch-yank-internal (lambda () (forward-symbol 1) (point))))

(define-key isearch-mode-map (kbd "C-M-w") 'isearch-yank-symbol)

(use-package easy-kill
  :defer t
  :init (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package helm
  :bind
  (("C-M-z" . helm-resume)
   ("C-x C-f" . helm-find-files)
   ("C-h b" . helm-descbinds)
   ("C-x C-r" . helm-mini)
   ("C-x M-o" . helm-occur)
   ("M-y" . helm-show-kill-ring)
   ("C-h a" . helm-apropos)
   ("C-h m" . helm-man-woman)
   ("C-h SPC" . helm-all-mark-rings)
   ("M-g >" . helm-ag-this-file)
   ("M-g ," . helm-ag-pop-stack)
   ("M-g ." . helm-do-grep)
   ("C-x C-i" . helm-semantic-or-imenu)
   ("M-x" . helm-M-x)
   ("C-x C-b" . helm-buffers-list)
   ("C-x C-r" . helm-mini)
   ("C-x b" . helm-mini)
   ("C-h t" . helm-world-time))
  :init (progn
          (helm-mode 1)
          (helm-autoresize-mode 1))
  :diminish ""
  :config
  (progn
    (use-package helm-config)
    (use-package helm-files
      :config
      (progn
        (setq helm-ff-file-compressed-list '("gz" "bz2" "zip" "7z" "tgz"))))
    (use-package helm-grep
      :config
      (progn
        (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
        (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
        (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)))
    (use-package helm-man)
    (use-package helm-misc)
    (use-package helm-aliases)
    (use-package helm-elisp)
    (use-package helm-imenu)
    (use-package helm-semantic)
    (use-package helm-ring)
    (use-package helm-bookmark
      :bind (("C-x M-b" . helm-bookmarks)))
    (use-package helm-projectile
      :bind (("C-x f" . helm-projectile)
             ("C-c p f" . helm-projectile-find-file)
             ("C-c p s" . helm-projectile-switch-project)))
    (use-package helm-eshell
      :init (add-hook 'eshell-mode-hook
                      (lambda ()
                        (define-key eshell-mode-map (kbd "M-l")
                          'helm-eshell-history))))
    (use-package helm-descbinds
      :init (helm-descbinds-mode t))
    (use-package helm-ag
      :bind ("C-M-s" . helm-ag-this-file))

    ;; Via: http://www.reddit.com/r/emacs/comments/3asbyn/new_and_very_useful_helm_feature_enter_search/
    (setq helm-echo-input-in-header-line t)
    (defun helm-hide-minibuffer-maybe ()
      (when (with-helm-buffer helm-echo-input-in-header-line)
        (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
          (overlay-put ov 'window (selected-window))
          (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                                  `(:background ,bg-color :foreground ,bg-color)))
          (setq-local cursor-type nil))))

    (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)

    ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
    ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
    ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-unset-key (kbd "C-x c"))

    (setq helm-idle-delay 0.01
          helm-exit-idle-delay 0.1
          helm-input-idle-delay 0.01
          ;; truncate long lines in helm completion
          helm-truncate-lines t
          ;; may be overridden if 'ggrep' is in path (see below)
          helm-grep-default-command
          "grep -a -d skip %e -n%cH -e %p %f"
          helm-grep-default-recurse-command
          "grep -a -d recurse %e -n%cH -e %p %f"
          ;; do not display invisible candidates
          helm-quick-update t
          ;; be idle for this many seconds, before updating in delayed sources.
          helm-idle-delay 0.01
          ;; use 40% of the window for things
          helm-autoresize-max-height 40
          helm-autoresize-min-height 40
          ;; wider buffer name in helm-buffers-list
          helm-buffer-max-length 25 ;; default is 20
          ;; be idle for this many seconds, before updating candidate buffer
          helm-input-idle-delay 0.01
          ;; open helm buffer in another window
          helm-split-window-default-side 'other
          ;; open helm buffer inside current window, don't occupy whole other window
          helm-split-window-in-side-p t
          ;; limit the number of displayed canidates
          helm-candidate-number-limit 200
          ;; don't use recentf stuff in helm-ff, I use C-x C-r for this
          helm-ff-file-name-history-use-recentf nil
          ;; move to end or beginning of source when reaching top or bottom
          ;; of source
          helm-move-to-line-cycle-in-source t
          ;; don't displace the header line
          helm-display-header-line nil
          ;; fuzzy matching
          helm-recentf-fuzzy-match t
          helm-locate-fuzzy-match t
          helm-M-x-fuzzy-match t
          helm-buffers-fuzzy-matching t
          helm-semantic-fuzzy-match t
          helm-apropos-fuzzy-match t
          helm-imenu-fuzzy-match t
          helm-lisp-fuzzy-completion t
          helm-completion-in-region-fuzzy-match t
          ;; Here are the things helm-mini shows, I add `helm-source-bookmarks'
          ;; here to the regular default list
          helm-mini-default-sources '(helm-source-buffers-list
                                      helm-source-recentf
                                      helm-source-bookmarks
                                      helm-source-buffer-not-found))

    ;; List of times to show in helm-world-time
    (setq display-time-world-list '(("PST8PDT" "Los Altos")
                                    ("America/Denver" "Denver")
                                    ("EST5EDT" "Boston")
                                    ("UTC" "UTC")
                                    ("Europe/London" "London")
                                    ("Europe/Amsterdam" "Amsterdam")
                                    ("Asia/Bangkok" "Bangkok")
                                    ("Asia/Tokyo" "Tokyo")
                                    ("Australia/Sydney" "Sydney")))

    (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
    (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
    (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

    (define-key helm-map (kbd "C-p")   'helm-previous-line)
    (define-key helm-map (kbd "C-n")   'helm-next-line)
    (define-key helm-map (kbd "C-M-n") 'helm-next-source)
    (define-key helm-map (kbd "C-M-p") 'helm-previous-source)
    ;; The normal binding is C-c h M-g s which is insane
    (global-set-key (kbd "C-c h g")    'helm-do-grep)
    (global-set-key (kbd "C-c h a")    'helm-do-ag)

    (when (executable-find "curl")
      (setq helm-google-suggest-use-curl-p t))

    ;; ggrep is gnu grep on OSX
    (when (executable-find "ggrep")
      (setq helm-grep-default-command
            "ggrep -a -d skip %e -n%cH -e %p %f"
            helm-grep-default-recurse-command
            "ggrep -a -d recurse %e -n%cH -e %p %f"))

    (define-key helm-map (kbd "C-x 2") 'helm-select-2nd-action)
    (define-key helm-map (kbd "C-x 3") 'helm-select-3rd-action)
    (define-key helm-map (kbd "C-x 4") 'helm-select-4rd-action)

    ;; helm-mini instead of recentf
    (define-key 'help-command (kbd "C-f") 'helm-apropos)
    (define-key 'help-command (kbd "r") 'helm-info-emacs)

    ;; use helm to list eshell history
    (add-hook 'eshell-mode-hook
              #'(lambda ()
                  (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

    ;; Save current position to mark ring
    ;; (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

    (defvar helm-httpstatus-source
      '((name . "HTTP STATUS")
        (candidates . (("100 Continue") ("101 Switching Protocols")
                       ("102 Processing") ("200 OK")
                       ("201 Created") ("202 Accepted")
                       ("203 Non-Authoritative Information") ("204 No Content")
                       ("205 Reset Content") ("206 Partial Content")
                       ("207 Multi-Status") ("208 Already Reported")
                       ("300 Multiple Choices") ("301 Moved Permanently")
                       ("302 Found") ("303 See Other")
                       ("304 Not Modified") ("305 Use Proxy")
                       ("307 Temporary Redirect") ("400 Bad Request")
                       ("401 Unauthorized") ("402 Payment Required")
                       ("403 Forbidden") ("404 Not Found")
                       ("405 Method Not Allowed") ("406 Not Acceptable")
                       ("407 Proxy Authentication Required") ("408 Request Timeout")
                       ("409 Conflict") ("410 Gone")
                       ("411 Length Required") ("412 Precondition Failed")
                       ("413 Request Entity Too Large")
                       ("414 Request-URI Too Large")
                       ("415 Unsupported Media Type")
                       ("416 Request Range Not Satisfiable")
                       ("417 Expectation Failed") ("418 I'm a teapot")
                       ("422 Unprocessable Entity") ("423 Locked")
                       ("424 Failed Dependency") ("425 No code")
                       ("426 Upgrade Required") ("428 Precondition Required")
                       ("429 Too Many Requests")
                       ("431 Request Header Fields Too Large")
                       ("449 Retry with") ("500 Internal Server Error")
                       ("501 Not Implemented") ("502 Bad Gateway")
                       ("503 Service Unavailable") ("504 Gateway Timeout")
                       ("505 HTTP Version Not Supported")
                       ("506 Variant Also Negotiates")
                       ("507 Insufficient Storage") ("509 Bandwidth Limit Exceeded")
                       ("510 Not Extended")
                       ("511 Network Authentication Required")))
        (action . message)))

    (defvar helm-clj-http-source
      '((name . "clj-http options")
        (candidates
         .
         ((":accept - keyword for content type to accept")
          (":as - output coercion: :json, :json-string-keys, :clojure, :stream, :auto or string")
          (":basic-auth - string or vector of basic auth creds")
          (":body - body of request")
          (":body-encoding - encoding type for body string")
          (":client-params - apache http client params")
          (":coerce - when to coerce response body: :always, :unexceptional, :exceptional")
          (":conn-timeout - timeout for connection")
          (":connection-manager - connection pooling manager")
          (":content-type - content-type for request")
          (":cookie-store - CookieStore object to store/retrieve cookies")
          (":cookies - map of cookie name to cookie map")
          (":debug - boolean to print info to stdout")
          (":debug-body - boolean to print body debug info to stdout")
          (":decode-body-headers - automatically decode body headers")
          (":decompress-body - whether to decompress body automatically")
          (":digest-auth - vector of digest authentication")
          (":follow-redirects - boolean whether to follow HTTP redirects")
          (":form-params - map of form parameters to send")
          (":headers - map of headers")
          (":ignore-unknown-host? - whether to ignore inability to resolve host")
          (":insecure? - boolean whether to accept invalid SSL certs")
          (":json-opts - map of json options to be used for form params")
          (":keystore - file path to SSL keystore")
          (":keystore-pass - password for keystore")
          (":keystore-type - type of SSL keystore")
          (":length - manually specified length of body")
          (":max-redirects - maximum number of redirects to follow")
          (":multipart - vector of multipart options")
          (":oauth-token - oauth token")
          (":proxy-host - hostname of proxy server")
          (":proxy-ignore-hosts - set of hosts to ignore for proxy")
          (":proxy-post - port for proxy server")
          (":query-params - map of query parameters")
          (":raw-headers - boolean whether to return raw headers with response")
          (":response-interceptor - function called for each redirect")
          (":retry-handler - function to handle HTTP retries on IOException")
          (":save-request? - boolean to return original request with response")
          (":socket-timeout - timeout for establishing socket")
          (":throw-entire-message? - whether to throw the entire response on errors")
          (":throw-exceptions - boolean whether to throw exceptions on 5xx & 4xx")
          (":trust-store - file path to trust store")
          (":trust-store-pass - password for trust store")
          (":trust-store-type - type of trust store")))
        (action . message)))

    (defun helm-httpstatus ()
      (interactive)
      (helm-other-buffer '(helm-httpstatus-source) "*helm httpstatus*"))

    (defun helm-clj-http ()
      (interactive)
      (helm-other-buffer '(helm-clj-http-source) "*helm clj-http flags*"))

    (global-set-key (kbd "C-c M-C-h") 'helm-httpstatus)
    (global-set-key (kbd "C-c M-h") 'helm-clj-http)

    (use-package helm-swoop
      :bind (("M-i" . helm-swoop)
             ("M-I" . helm-swoop-back-to-last-point)
             ("C-c M-i" . helm-multi-swoop))
      :config
      (progn
        ;; When doing isearch, hand the word over to helm-swoop
        (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
        ;; From helm-swoop to helm-multi-swoop-all
        (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
        ;; Save buffer when helm-multi-swoop-edit complete
        (setq helm-multi-swoop-edit-save t
              ;; If this value is t, split window inside the current window
              helm-swoop-split-with-multiple-windows nil
              ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
              helm-swoop-split-direction 'split-window-vertically
              ;; If nil, you can slightly boost invoke speed in exchange for text color
              helm-swoop-speed-or-color nil)))
    ))

(use-package helm-ls-git
  :defer t
  :bind ("C-x C-d" . helm-browse-project))

(use-package helm-dash
  :init
  (progn
    ;; Use the Java and Elasticsearch common docsets everywhere
    (setq helm-dash-common-docsets
          '(Java
            ElasticSearch))))

(use-package hydra
  :init
  (progn
    (defhydra hydra-toggle-map nil
      "
^Toggle^
^^^^^^^^--------------------
_d_: debug-on-error
_D_: debug-on-quit
_f_: auto-fill-mode
_l_: toggle-truncate-lines
_h_: hl-line-mode
_r_: read-only-mode
_v_: viewing-mode
_n_: narrow-or-widen-dwim
_g_: golden-ratio-mode
_q_: quit
"
      ("d" toggle-debug-on-error :exit t)
      ("D" toggle-debug-on-quit :exit t)
      ("g" golden-ratio-mode :exit t)
      ("f" auto-fill-mode :exit t)
      ("l" toggle-truncate-lines :exit t)
      ("r" read-only-mode :exit t)
      ("h" hl-line-mode :exit t)
      ("v" my/turn-on-viewing-mode :exit t)
      ("n" my/narrow-or-widen-dwim :exit t)
      ("q" nil :exit t))

    (global-set-key (kbd "C-x t") 'hydra-toggle-map/body)

    ;; Jump between errors in a buffer:
    (defhydra hydra-next-error (global-map "C-x")
      "next-error"
      ("`" next-error "next")
      ("j" next-error "next" :bind nil)
      ("n" next-error "next" :bind nil)
      ("k" previous-error "previous" :bind nil)
      ("p" previous-error "previous" :bind nil)
      ("l" flycheck-list-errors "list-errors" :exit t))))

(use-package yasnippet
  :defer t
  :diminish yas-minor-mode
  :init (progn
          (yas-global-mode 1)
          (yas-reload-all)))

(use-package helm-config
  :defer t
  :config
  (use-package yasnippet
    :bind ("M-=" . yas-insert-snippet)
    :config
    (progn
      (defun my-yas/prompt (prompt choices &optional display-fn)
        (let* ((names (loop for choice in choices
                            collect (or (and display-fn
                                             (funcall display-fn choice))
                                        choice)))
               (selected (helm-other-buffer
                          `(((name . ,(format "%s" prompt))
                             (candidates . names)
                             (action . (("Insert snippet" . (lambda (arg)
                                                              arg))))))
                          "*helm yas/prompt*")))
          (if selected
              (let ((n (position selected names :test 'equal)))
                (nth n choices))
            (signal 'quit "user quit!"))))
      (custom-set-variables '(yas/prompt-functions '(my-yas/prompt))))))

(use-package markdown-mode)

(use-package log4j-mode
  :init (add-hook 'log4j-mode-hook #'my/turn-on-viewing-mode))

(use-package bookmark+
  :config
  (progn
    (setq bookmark-version-control t
          ;; auto-save bookmarks
          bookmark-save-flag 1)))

(use-package editorconfig)

(use-package company
  :defer t
  :diminish ""
  :bind ("C-." . company-complete)
  :init (add-hook 'prog-mode-hook 'company-mode)
  :config
  (progn
    (setq company-idle-delay 0.1
          ;; min prefix of 1 chars
          company-minimum-prefix-length 1
          company-selection-wrap-around t
          company-show-numbers t
          company-dabbrev-downcase nil
          company-transformers '(company-sort-by-occurrence))
    (bind-keys :map company-active-map
               ("C-n" . company-select-next)
               ("C-p" . company-select-previous)
               ("C-d" . company-show-doc-buffer)
               ("<tab>" . company-complete))))

(use-package smart-tab
  :defer t
  :diminish ""
  :init (global-smart-tab-mode 1)
  :config
  (progn
    (add-to-list 'smart-tab-disabled-major-modes 'mu4e-compose-mode)
    (add-to-list 'smart-tab-disabled-major-modes 'erc-mode)
    (add-to-list 'smart-tab-disabled-major-modes 'shell-mode)))

(use-package undo-tree
  :init (global-undo-tree-mode t)
  :defer t
  :diminish ""
  :config
  (progn
    (define-key undo-tree-map (kbd "C-x u") 'undo-tree-visualize)
    (define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)))

(use-package popwin
  :commands popwin-mode
  :init (popwin-mode 1)
  :config
  (progn
    (defvar popwin:special-display-config-backup popwin:special-display-config)
    (setq display-buffer-function 'popwin:display-buffer)

    ;; basic
    (push '("*Help*" :stick t :noselect t) popwin:special-display-config)
    (push '("*helm world time*" :stick t :noselect t) popwin:special-display-config)
    (push '("*Pp Eval Output*" :stick t) popwin:special-display-config)

    ;; magit
    (push '("*magit-process*" :stick t) popwin:special-display-config)

    ;; quickrun
    (push '("*quickrun*" :stick t) popwin:special-display-config)

    ;; dictionaly
    (push '("*dict*" :stick t) popwin:special-display-config)
    (push '("*sdic*" :stick t) popwin:special-display-config)

    ;; popwin for slime
    (push '(slime-repl-mode :stick t) popwin:special-display-config)

    ;; man
    (push '(Man-mode :stick t :height 20) popwin:special-display-config)

    ;; Elisp
    (push '("*ielm*" :stick t) popwin:special-display-config)
    (push '("*eshell pop*" :stick t) popwin:special-display-config)

    ;; pry
    (push '(inf-ruby-mode :stick t :height 20) popwin:special-display-config)

    ;; python
    (push '("*Python*"   :stick t) popwin:special-display-config)
    (push '("*Python Help*" :stick t :height 20) popwin:special-display-config)
    (push '("*jedi:doc*" :stick t :noselect t) popwin:special-display-config)

    ;; Haskell
    (push '("*haskell*" :stick t) popwin:special-display-config)
    (push '("*GHC Info*") popwin:special-display-config)

    ;; sgit
    (push '("*sgit*" :position right :width 0.5 :stick t)
          popwin:special-display-config)

    ;; git-gutter
    (push '("*git-gutter:diff*" :width 0.5 :stick t)
          popwin:special-display-config)

    ;; es-results-mode
    (push '(es-result-mode :stick t :width 0.5)
          popwin:special-display-config)
    
    ;; direx
    (push '(direx:direx-mode :position left :width 40 :dedicated t)
          popwin:special-display-config)

    (push '("*Occur*" :stick t) popwin:special-display-config)

    ;; prodigy
    (push '("*prodigy*" :stick t) popwin:special-display-config)

    ;; malabar-mode
    (push '("*Malabar Compilation*" :stick t :height 30)
          popwin:special-display-config)

    ;; org-mode
    (push '("*Org tags*" :stick t :height 30)
          popwin:special-display-config)

    ;; Completions
    (push '("*Completions*" :stick t :noselect t) popwin:special-display-config)

    ;; ggtags
    (push '("*ggtags-global*" :stick t :noselect t :height 30) popwin:special-display-config)

    ;; async shell commands
    (push '("*Async Shell Command*" :stick t) popwin:special-display-config)

    (defun my/popup-downloads ()
      "Pop up the downloads buffer (4th eshell buffer for me"
      (interactive)
      (popwin:popup-buffer "*eshell*<4>"))

    ;; eshell 4 is always my "download stuff" buffer
    (global-set-key (kbd "C-x M-d") #'my/popup-downloads)
    (global-set-key (kbd "C-h e") 'popwin:messages)))

(use-package paren-face
  :init (global-paren-face-mode))

(use-package ido
  :config
  (progn
    (setq ido-use-virtual-buffers nil
          ;; this setting causes weird TRAMP connections, don't set it!
          ;;ido-enable-tramp-completion nil
          ido-enable-flex-matching t
          ido-auto-merge-work-directories-length nil
          ido-create-new-buffer 'always
          ido-use-filename-at-point 'guess
          ido-max-prospects 10)))

(use-package flx-ido
  :init (flx-ido-mode 1)
  :config
  (setq ido-use-faces nil))

(use-package ido-vertical-mode
  :init (ido-vertical-mode t))

(use-package ido-ubiquitous)

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(use-package twittering-mode
  :defer t
  :config
  (progn
    (setq twittering-icon-mode t
          twittering-use-master-password t)))

(use-package scpaste
  :defer t
  :config
  (setq scpaste-http-destination "http://p.writequit.org"
        scpaste-scp-destination "writequit:public_html/wq/paste/"))

(use-package smex
  :disabled t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)))

(defun my/turn-on-volatile-highlights ()
  (interactive)
  (volatile-highlights-mode t)
  (diminish 'volatile-highlights-mode))

(use-package volatile-highlights
  :defer t
  :init
  (progn
    (require 'volatile-highlights) ;; vh has a problem with autoloads
    (add-hook 'org-mode-hook #'my/turn-on-volatile-highlights)
    (add-hook 'prog-mode-hook #'my/turn-on-volatile-highlights)))

(use-package color-identifiers-mode)

(use-package iedit
  :bind ("C-;" . iedit-mode))

(use-package eyebrowse
  :diminish eyebrowse-mode
  :init
  (progn
    (defun my/create-eyebrowse-setup ()
      (interactive)
      "Create a default window config, if none is present"
      (when (not (eyebrowse--window-config-present-p 2))
        ;; there's probably a better way to do this, creating two workspaces
        (eyebrowse-switch-to-window-config-2)
        (eyebrowse-switch-to-window-config-1)))
    (setq eyebrowse-wrap-around t
          eyebrowse-new-workspace t)
    (eyebrowse-mode 1)
    (global-set-key (kbd "C-'") 'eyebrowse-next-window-config)
    (add-hook 'after-init-hook #'my/create-eyebrowse-setup)))

(use-package hideshow
  :bind (("C-c TAB" . hs-toggle-hiding)
         ("C-\\" . hs-toggle-hiding)
         ("M-\\" . hs-hide-all)
         ("M-+" . hs-show-all))
  :init
  (progn
    (defun my/enable-hs-minor-mode ()
      (interactive)
      (hs-minor-mode t))

    ;; (add-hook 'javascript-mode-hook 'my/enable-hs-minor-mode)
    ;; (add-hook 'js-mode-hook 'my/enable-hs-minor-mode)
    ;; (add-hook 'java-mode-hook 'my/enable-hs-minor-mode)
    (add-hook 'prog-mode-hook 'my/enable-hs-minor-mode))
  :config
  (progn
    (defvar hs-special-modes-alist
      (mapcar 'purecopy
              '((c-mode "{" "}" "/[*/]" nil nil)
                (c++-mode "{" "}" "/[*/]" nil nil)
                (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
                (java-mode "{" "}" "/[*/]" nil nil)
                (js-mode "{" "}" "/[*/]" nil)
                (javascript-mode  "{" "}" "/[*/]" nil))))))

(use-package abbrev
  :diminish ""
  :config
  (progn
    (define-key ctl-x-map "\C-a" 'my/ispell-word-then-abbrev)

    (defun my/ispell-word-then-abbrev (p)
      "Call `ispell-word'. Then create an abbrev for the correction made.
With prefix P, create local abbrev. Otherwise it will be global."
      (interactive "P")
      (let ((bef (downcase (or (thing-at-point 'word) ""))) aft)
        (call-interactively 'ispell-word)
        (setq aft (downcase (or (thing-at-point 'word) "")))
        (unless (string= aft bef)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob"))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft))))

    (setq save-abbrevs t)
    (setq-default abbrev-mode t)))

(defun my/enable-abbrev-mode ()
  (interactive)
  (abbrev-mode t))

(add-hook 'prog-mode-hook #'my/enable-abbrev-mode)

(defun sanityinc/dabbrev-friend-buffer (other-buffer)
 (< (buffer-size other-buffer) (* 1 1024 1024)))
(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)

(use-package vlf-setup)

(use-package eww
  :defer t
  :init
  (progn
    (define-prefix-command 'my/eww-map)
    (define-key ctl-x-map "w" 'my/eww-map)

    (define-key my/eww-map "t" 'eww)
    (define-key my/eww-map "o" 'eww)
    (define-key my/eww-map "w" 'my/eww-wiki)
    (define-key my/eww-map "e" 'my/search-es-docs)

    (defun my/eww-wiki (text)
      "Function used to search wikipedia for the given text."
      (interactive (list (read-string "Wiki for: ")))
      (eww (format "https://en.m.wikipedia.org/wiki/Special:Search?search=%s"
                   (url-encode-url text)))))
  :config
  (progn
    (define-key eww-mode-map "o" 'eww)
    (define-key eww-mode-map "O" 'eww-browse-with-external-browser)
    (use-package eww-lnum
      :init
      (eval-after-load "eww"
        '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)
                (define-key eww-mode-map "F" 'eww-lnum-universal))))))

(defface visible-mark-active ;; put this before (use-package visible-mark)
  '((((type tty) (class mono)))
    (t (:background "magenta"))) "")

(use-package visible-mark
  :disabled t
  :init (global-visible-mark-mode 1)
  :config
  (progn
    (setq visible-mark-max 2)
    (setq visible-mark-faces `(visible-mark-face1 visible-mark-face2))))

(defun my/turn-on-fill-column-indicator ()
  (interactive)
  (fci-mode 1))

(use-package fill-column-indicator
  :disabled t
  :init (add-hook 'prog-mode-hook #'my/turn-on-fill-column-indicator)
  :config
  (progn
    (setq fci-rule-column 80)))

(use-package idle-highlight-mode
  :init
  (progn
    (defun turn-on-idle-highlight-mode ()
      (interactive)
      (idle-highlight-mode 1))
    (add-hook 'java-mode-hook #'turn-on-idle-highlight-mode)
    (add-hook 'emacs-lisp-mode-hook #'turn-on-idle-highlight-mode)
    ;;(add-hook 'clojure-lisp-mode-hook #'turn-on-idle-highlight-mode)
    ))

(global-set-key (kbd "C-x +") 'balance-windows-area)

(global-set-key (kbd "C-x C-l") 'toggle-truncate-lines)

(defun my/turn-on-viewing-mode ()
  "Turn on the viewing mode, to make looking through logs easier"
  (interactive)
  (read-only-mode 1)
  (view-mode 1)
  (hl-line-mode 1))

;; join on killing lines
(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
Deletes whitespace at join."
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)))

(global-set-key (kbd "C-k") 'kill-and-join-forward)

;; You know, like Readline.
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") #'cleanup-buffer)

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)

(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x C-m") 'shell)

;; If you want to be able to M-x without meta (phones, etc)
(global-set-key (kbd "C-c C-x") 'execute-extended-command)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; ==== Window switching ====
(defun my/other-window-backwards ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "M-'") 'other-window)
(global-set-key (kbd "M-\"") 'my/other-window-backwards)
(global-set-key (kbd "H-'") 'other-window)
(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-tab] 'my/other-window-backwards)

;; ==== transpose buffers ====
(defun transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))

(global-set-key (kbd "C-x 4 t") 'transpose-buffers)

(defun find-agent ()
  (first (split-string
          (shell-command-to-string
           (concat
            "ls -t1 "
            "$(find /tmp/ -uid $UID -path \\*ssh\\* -type s 2> /dev/null)"
            "|"
            "head -1")))))

(defun fix-agent ()
  (interactive)
  (let ((agent (find-agent)))
    (setenv "SSH_AUTH_SOCK" agent)
    (message agent)))

(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
                             "python -mjson.tool" (current-buffer) t)))

(defun byte-recompile-init-files ()
  "Recompile all of the startup files"
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0))

(defun add-to-path (path-element)
  "Add the specified path element to the Emacs PATH"
  (interactive "DEnter directory to be added to path: ")
  (if (file-directory-p path-element)
      (setenv "PATH"
              (concat (expand-file-name path-element)
                      path-separator (getenv "PATH")))))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun browse-last-url-in-brower ()
  (interactive)
  (save-excursion
    (let ((ffap-url-regexp
           (concat
            "\\("
            "news\\(post\\)?:\\|mailto:\\|file:"
            "\\|"
            "\\(ftp\\|https?\\|telnet\\|gopher\\|www\\|wais\\)://"
            "\\).")))
      (ffap-next t t))))

(global-set-key (kbd "C-c u") 'browse-last-url-in-brower)

(defun number-rectangle (start end format-string from)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Number rectangle: "
                      (if (looking-back "^ *") "%d. " "%d"))
         (read-number "From: " 1)))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (delete-rectangle start end)
    (goto-char start)
    (loop with column = (current-column)
          while (and (<= (point) end) (not (eobp)))
          for i from from   do
          (move-to-column column t)
          (insert (format format-string i))
          (forward-line 1)))
  (goto-char start))

(global-set-key (kbd "C-x r N") 'number-rectangle)

(defun my/insert-lod ()
  "Well. This is disappointing."
  (interactive)
  (insert "ಠ_ಠ"))

(global-set-key (kbd "C-c M-d") 'my/insert-lod)

(defun my/search-es-docs (text)
  "Search ES docs for `text'."
  (interactive (list (read-string "Search for: ")))
  (eww
   (url-encode-url
    (format "http://www.elastic.co/?q=%s" text))))

(global-set-key (kbd "C-c d") 'my/search-es-docs)

(defun my/narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, org-src-block, org-subtree, or defun,
whichever applies first.
Narrowing to org-src-block actually calls `org-edit-src-code'.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         ;; `org-edit-src-code' is not a real narrowing command.
         ;; Remove this first conditional if you don't want it.
         (cond ((org-in-src-block-p)
                (org-edit-src-code)
                (delete-other-windows))
               ((org-at-block-p)
                (org-narrow-to-block))
               (t (org-narrow-to-subtree))))
        (t (narrow-to-defun))))

(defun xah-forward-block (&optional φn)
  "Move cursor forward to the beginning of next text block.
A text block is separated by blank lines. In most major modes,
this is similar to `forward-paragraph', but this command's
behavior is the same regardless of syntax table."
  (interactive "p")
  (search-forward-regexp "\n[\t\n ]*\n+" nil "NOERROR" φn))

(defun xah-backward-block (&optional φn)
  "Move cursor backward to previous text block.
See: `xah-forward-block'"
  (interactive "p")
  (dotimes (ξn φn) (if (search-backward-regexp "\n[\t\n ]*\n+" nil "NOERROR")
                       (progn
                         (skip-chars-backward "\n\t "))
                     (progn (goto-char (point-min))))))

(global-set-key (kbd "<C-up>") 'xah-backward-block)
(global-set-key (kbd "<C-down>") 'xah-forward-block)

(defun my/quick-view-file-at-point ()
  "Preview the file at point then jump back after some idle time.

In order for this to work you need to bind this function to a key combo,
you cannot call it from the minibuffer and let it work.

The reason it works is that by holding the key combo down, you inhibit
idle timers from running so as long as you hold the key combo, the
buffer preview will still display."
  (interactive)
  (setq-local lexical-binding t)
  (let* ((buffer (current-buffer))
         (file (thing-at-point 'filename t))
         (file-buffer-name (format "*preview of %s*" file)))
    (if (and file (file-exists-p file))
        (let ((contents))
          (if (get-buffer file)
              (setq contents (save-excursion
                               (with-current-buffer (get-buffer file)
                                 (font-lock-fontify-buffer)
                                 (buffer-substring (point-min) (point-max)))))
            (let ((new-buffer (find-file-noselect file)))
              (with-current-buffer new-buffer
                (font-lock-mode t)
                (font-lock-fontify-buffer)
                (setq contents (buffer-substring (point-min) (point-max))))
              (kill-buffer new-buffer)))
          (switch-to-buffer (get-buffer-create file-buffer-name))
          (setq-local header-line-format "%60b")
          (delete-region (point-min) (point-max))
          (save-excursion (insert contents))
          (local-set-key (kbd "C-M-v") (lambda () (interactive) (sit-for .2)))
          (run-with-idle-timer
           .7
           nil
           (lambda ()
             (switch-to-buffer buffer)
             (kill-buffer file-buffer-name))))
      (message "no file to preview at point!"))))

(global-set-key (kbd "C-M-v") 'my/quick-view-file-at-point)

(defcustom smart-to-ascii '(("\x201C" . "\"")
                            ("\x201D" . "\"")
                            ("\x2018" . "'")
                            ("\x2019" . "'")
                            ;; en-dash
                            ("\x2013" . "-")
                            ;; em-dash
                            ("\x2014" . "-"))
  "Map of smart quotes to their replacements"
  :type '(repeat (cons (string :tag "Smart Character  ")
                       (string :tag "Ascii Replacement"))))

(defun my/smart-to-ascii (beg end)
  "Replace smart quotes and dashes with their ASCII equivalents"
  (interactive "r")
  (format-replace-strings smart-to-ascii
                          nil beg end))

(defun my/change-replica-count (index replicas)
  (interactive (list (read-string "Index (_all for all): ")
                     (read-string "Number of replicas: ")))
  (async-shell-command
   (concat
    "curl -XPUT 'localhost:9200/"
    index
    "/_settings' -d'{\"index\": {\"number_of_replicas\": "
    replicas
    "}}'")))

(setq debug-on-error nil)
(setq debug-on-quit nil)

;; Message how long it took to load everything (minus packages)
(let ((elapsed (float-time (time-subtract (current-time)
                                          emacs-start-time))))
  (message "Loading settings...done (%.3fs)" elapsed))
(put 'narrow-to-region 'disabled nil)

;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org>                               
(defalias 'perl-mode 'cperl-mode)

(mapc
     (lambda (pair)
       (if (eq (cdr pair) 'perl-mode)
           (setcdr pair 'cperl-mode)))
     (append auto-mode-alist interpreter-mode-alist))



(set-frame-parameter nil 'alpha 80)
(defun change-alpha (alpha)
  (interactive
    (list (read-number "Input ratio: " 100)))
  (unless (and (>= alpha 0) (<= alpha 100))
    (error "Please input from 0 to 100"))
  (set-frame-parameter nil 'alpha alpha))


;; popup
;; add some shotcuts in popup menu mode
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))
