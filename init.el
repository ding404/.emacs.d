(package-initialize)
;; set package list url
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/") t)
  (add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
  (add-to-list 'package-archives '("marmalade" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/") t)
  (add-to-list 'package-archives '("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/") t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-diff-options "-w")
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(org-plus-contrib eglot yasnippet-snippets treemacs-evil treemacs-icons-dired treemacs-magit treemacs-projectile treemacs lsp-treemacs yasnippet lsp-ui lsp-mode f clang-format importmagic json-mode tide js2-refactor js2-mode web-mode ein aggressive-indent ivy-hydra imenu-list smex bing-dict p4 elpy psvn monky bash-completion magit browse-kill-ring+ counsel-projectile projectile expand-region multiple-cursors ace-window back-button ace-jump-mode highlight-symbol highlight-parentheses rainbow-delimiters indent-guide smartparens undo-tree all-the-icons-ivy flycheck fancy-battery spaceline all-the-icons neotree company-quickhelp which-key company counsel async swiper paradox material-theme))
 '(paradox-github-token t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; set default font
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (when (member "Consolas" (font-family-list))
    (set-frame-font "Consolas" t t)))
 ((string-equal system-type "darwin") ; macOS
  (when (member "Menlo" (font-family-list))
    (set-frame-font "Menlo" t t)))
 ((string-equal system-type "gnu/linux") ; linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (set-frame-font "DejaVu Sans Mono" t t))))
;; set font for emoji
(set-fontset-font
 t
 '(#x1f300 . #x1fad0)
 (cond
  ((member "Noto Color Emoji" (font-family-list)) "Noto Color Emoji")
  ((member "Noto Emoji" (font-family-list)) "Noto Emoji")
  ((member "Segoe UI Emoji" (font-family-list)) "Segoe UI Emoji")
  ((member "Symbola" (font-family-list)) "Symbola")
  ((member "Apple Color Emoji" (font-family-list)) "Apple Color Emoji"))
 ;; Apple Color Emoji should be before Symbola, but Richard Stallman disabled it.
 ;; GNU Emacs Removes Color Emoji Support on the Mac
 ;; http://ergoemacs.org/misc/emacs_macos_emoji.html
 ;;
 )
;; set font for chinese characters
(set-fontset-font
 t
 '(#x4e00 . #x9fff)
 (cond
  ((string-equal system-type "windows-nt")
   (cond
    ((member "Microsoft YaHei" (font-family-list)) "Microsoft YaHei")
    ((member "Microsoft JhengHei" (font-family-list)) "Microsoft JhengHei")
    ((member "SimHei" (font-family-list)) "SimHei")))
  ((string-equal system-type "darwin")
   (cond
    ((member "Hei" (font-family-list)) "Hei")
    ((member "Heiti SC" (font-family-list)) "Heiti SC")
    ((member "Heiti TC" (font-family-list)) "Heiti TC")))
  ((string-equal system-type "gnu/linux")
   (cond
    ((member "WenQuanYi Micro Hei" (font-family-list)) "WenQuanYi Micro Hei")))))

(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; set key-bind
(require 'bind-key)

;; set paradox
(require 'paradox)
(paradox-enable)

;; set which-key
(require 'which-key)
(which-key-mode)

;; set neotree
(require 'neotree)
(global-set-key [f8] (lambda () (interactive) (if (neo-global--window-exists-p)
                                                  (neotree-hide)
                                                (neotree-find))))
(defun neotree-resize-window (&rest _args)
  "Resize neotree window.
https://github.com/jaypei/emacs-neotree/pull/110"
  (interactive)
  (neo-buffer--with-resizable-window
   (let ((fit-window-to-buffer-horizontally t))
     (fit-window-to-buffer))))
(add-hook 'neo-change-root-hook #'neotree-resize-window)
(add-hook 'neo-enter-hook #'neotree-resize-window)

;; set imenu list
(global-set-key [f9] #'imenu-list-smart-toggle)
(setq imenu-list-auto-resize t)

;; set undo-tree
(global-undo-tree-mode) ; undo tree branch
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; set emacs UI
(setq bidi-display-reordering nil)
(setq fancy-splash-image "~/.emacs.d/xyy.jpeg")
(load-theme 'material t)
;; set all the icons
(require 'all-the-icons)
(setq neo-theme 'icons)
(indent-guide-global-mode)
(global-highlight-parentheses-mode)
(setq display-time-24hr-format 't)
(display-time-mode)
(column-number-mode)
(use-package highlight-symbol
  :config
  (global-set-key [(control f3)] 'highlight-symbol)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace)
  )

;; show current buffer file name in title
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
            '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; set indent
(progn
  ;; make indentation commands use space only (never tab character)
  (setq-default indent-tabs-mode nil)
  ;; emacs 23.1, 24.2, default to t
  ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
  )
(defun indent-space-count (count)
  (setq tab-stop-list (number-sequence count 200 count))
  (setq tab-width count))

(add-hook 'python-mode-hook
          (lambda ()
            (when (derived-mode-p 'python-mode)
              (setq c-default-style "linux"
                    c-basic-offset 4)
              (indent-space-count 4)
              (aggressive-indent-mode 1))))
;; set company
(add-hook 'after-init-hook 'global-company-mode)
;; set company-quickhelp
(company-quickhelp-mode 1)

;; set ivy
(ivy-mode 1)
(all-the-icons-ivy-setup)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq enable-recursive-minibuffers t)
(setq ivy-extra-directories nil)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

(use-package smartparens-config
  :config
  (smartparens-global-mode)
  (delete-selection-mode)
  (define-key smartparens-mode-map (kbd "C-M-{") 'sp-backward-up-sexp)
  (define-key smartparens-mode-map (kbd "C-M-}") 'sp-down-sexp)
  (define-key smartparens-mode-map (kbd "C-M-(") 'sp-backward-down-sexp)
  (define-key smartparens-mode-map (kbd "C-M-)") 'sp-up-sexp)
  (define-key smartparens-mode-map (kbd "M-'") 'sp-copy-sexp)
  (define-key smartparens-mode-map (kbd "C-d") 'sp-kill-sexp)
  (define-key smartparens-mode-map (kbd "C-t") 'sp-transpose-sexp)
  )

(use-package back-button
  :config
  (back-button-mode)
  (global-set-key (kbd "C-x C-,") 'back-button-global-backward)
  (global-set-key (kbd "C-x C-.") 'back-button-global-forward)
  (global-set-key (kbd "C-x ,") 'back-button-local-backward)
  (global-set-key (kbd "C-x .") 'back-button-local-forward)
  )

;; C-c <left> restoring window
(winner-mode)
;; set ace window
;; x - delete window
;; m - swap (move) window
;; c - split window fairly, either vertically or horizontally
;; v - split window vertically
;; b - split window horizontally
;; n - select the previous window
;; i - maximize window (select which window)
;; o - maximize current window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-dispatch-always 't)

;;
;; ace jump mode major function
;;
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(use-package multiple-cursors
  :config
  (multiple-cursors-mode)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region)
  (global-set-key (kbd "C--") 'er/contract-region))

(use-package projectile
  :config
  (projectile-mode))

(use-package browse-kill-ring)
(use-package browse-kill-ring+)

(global-flycheck-mode)
(use-package yasnippet
  :config
  (yas-global-mode 1))

;; set magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x l") 'magit-log)
(add-hook 'magit-diff-mode-hook
          (lambda ()
            (setq magit-diff-refine-hunk t)
            (setq magit-diff-hide-trailing-cr-characters t)))

;; set monky (magit for hg)
(use-package monky
  :config
  (setq monky-process-type 'cmdserver))

;; set psvn
(use-package psvn)

;; set p4
(use-package p4)

;; set bash completion
(use-package bash-completion
  :config
  (bash-completion-setup))
(when (require 'bash-completion nil t)
  (setq eshell-default-completion-function 'eshell-bash-completion))
(defun eshell-bash-completion ()
  (while (pcomplete-here
          (nth 2 (bash-completion-dynamic-complete-nocomint (save-excursion (eshell-bol) (point)) (point))))))

;; set elpy
(elpy-enable)

;; set importmagic
(add-hook 'python-mode-hook 'importmagic-mode)

;; set bing-dict
(use-package bing-dict
  :config
  (global-set-key (kbd "C-c d") 'bing-dict-brief)
  (global-set-key (kbd "C-c f") 'bing-dict-full-in-new-window)
  (setq bing-dict-show-thesaurus 'both))

(setq tramp-default-method "sshx")
(setenv "ANDROID_NDK_ROOT" "/Nuance/Dev/DevTools/android/ndk-bundle")

;; set ipython and EIN(emacs ipython notebook)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i"
      python-shell-prompt-detect-enabled nil
      python-shell-completion-native-enable nil)
(require 'ein)

;; set web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)


;; set javascript mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(require 'js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'js2-mode-hook #'setup-tide-mode)
;; configure javascript-tide checker to run after your default javascript checker
;; (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)

;; set eshell env
(setenv "PATH"
        (concat
         (getenv "ANDROID_NDK_ROOT") "/bin" ":"
         (getenv "PATH") ; inherited from OS
  )
)

;; add org-agenda key bind
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-c C-a") 'org-agenda)))

;; set lsp-mode
(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp)
(setq lsp-prefer-flymake nil)
(add-hook 'lsp-after-open-hook
          (lambda ()
            (define-key lsp-mode-map (kbd "M-q") 'lsp-ui-peek-find-definitions)
            (define-key lsp-mode-map (kbd "M-r") 'lsp-ui-peek-find-references)
            (define-key lsp-mode-map (kbd "C-l d") 'lsp-ui-peek-find-declaration)
            (define-key lsp-mode-map (kbd "C-l i") 'lsp-ui-peek-find-implementation)
            (define-key lsp-mode-map (kbd "C-l w") 'lsp-ui-peek-find-workspace-symbol)
            (define-key lsp-mode-map (kbd "C-l c") 'lsp-ui-peek-find-custom)))
;;set lsp-treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  ;; (with-eval-after-load 'winum
  ;;   (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(require 'ox-taskjuggler)
;;; init.el ends here
