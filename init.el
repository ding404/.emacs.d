;; set package list url
(package-initialize)
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;;'("gnu" . "http://elpa.emacs-china.org/gnu/")
   '("melpa" . "http://elpa.emacs-china.org/melpa/")
   '("marmalade" . "http://elpa.emacs-china.org/marmalade/")
   ;;'("elpy" . "http://jorgenschaefer.github.io/packages/")
   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-diff-options "-w")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (smex bing-dict p4 elpy psvn monky bash-completion magit counsel-gtags aggressive-indent browse-kill-ring+ google-c-style autodisass-java-bytecode meghanada counsel-projectile projectile expand-region multiple-cursors ace-window back-button ace-jump-mode highlight-symbol highlight-parentheses rainbow-delimiters indent-guide smartparens undo-tree all-the-icons-ivy flycheck fancy-battery spaceline all-the-icons neotree company-quickhelp which-key company ggtags counsel async swiper paradox material-theme)))
 '(paradox-github-token t)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "D2Coding for Powerline" :foundry "RIXF" :slant normal :weight normal :height 143 :width normal)))))

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
(global-set-key [f8] 'neotree-toggle)

(global-undo-tree-mode) ; undo tree branch
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; set emacs UI
(setq fancy-splash-image "~/Pictures/xyy.jpeg")
(load-theme 'material t)
;; set all the icons
(require 'all-the-icons)
(setq neo-theme 'icons)
(indent-guide-global-mode)
(global-highlight-parentheses-mode)
(setq display-time-24hr-format 't)
(display-time-mode)
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

;; set gtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1)
              (setq c-default-style "linux"
                    c-basic-offset 4)
              (indent-space-count 4)
              (aggressive-indent-mode 1))))
(add-hook 'python-mode-hook
          (lambda ()
            (when (derived-mode-p 'python-mode)
              (setq c-default-style "linux"
                    c-basic-offset 4)
              (indent-space-count 4)
              (aggressive-indent-mode 1))))
;; set gtags view as ivy
(add-hook 'c-mode-hook 'counsel-gtags-mode)
(add-hook 'c++-mode-hook 'counsel-gtags-mode)
(add-hook 'java-mode-hook 'counsel-gtags-mode)
(with-eval-after-load 'counsel-gtags
  (define-key counsel-gtags-mode-map (kbd "M-.") 'counsel-gtags-find-definition)
  (define-key counsel-gtags-mode-map (kbd "M-]") 'counsel-gtags-find-reference)
  (define-key counsel-gtags-mode-map (kbd "M-s") 'counsel-gtags-find-symbol)
  (define-key counsel-gtags-mode-map (kbd "M-,") 'counsel-gtags-go-backward))
;; set company
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-gtags))
;; set company-quickhelp
(company-quickhelp-mode 1)

;; set java tool meghanada
(use-package autodisass-java-bytecode
  :ensure t
  :defer t)
(use-package google-c-style
  :defer t
  :ensure t
  :commands
  (google-set-c-style))
(use-package meghanada
  :defer t
  :init
  (add-hook 'java-mode-hook
            (lambda ()
              (google-set-c-style)
              (google-make-newline-indent)
              (meghanada-mode t)
              (setq c-default-style "linux"
                    c-basic-offset 4)
              (indent-space-count 4)
              (aggressive-indent-mode 1)
              (add-to-list 'company-backends 'company-gtags)))
  )

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
  (projectile-mode)
  (counsel-projectile-on))

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

;; set doxymacs
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(require 'doxymacs)
(add-hook 'c-mode-hook 'doxymacs-mode)
(add-hook 'c++-mode-hook 'doxymacs-mode)
(add-hook 'java-mode-hook 'doxymacs-mode)
(add-hook 'python-mode-hook 'doxymacs-mode)

;; set elpy
(elpy-enable)

;; set bing-dict
(use-package bing-dict
  :config
  (global-set-key (kbd "C-c d") 'bing-dict-brief)
  (global-set-key (kbd "C-c f") 'bing-dict-full-in-new-window)
  (setq bing-dict-show-thesaurus 'both))

(setq tramp-default-method "sshx")
(setenv "ANDROID_NDK_ROOT" "/Nuance/Dev/DevTools/android/ndk-bundle")
;;; init.el ends here
