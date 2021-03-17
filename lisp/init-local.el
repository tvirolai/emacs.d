;; init-local.el --- Personal configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(setq evil-want-C-i-jump nil)
(setq evil-want-keybinding nil)

(use-package flycheck-clj-kondo
  :ensure t)

(use-package undo-tree
  :config
  (turn-on-undo-tree-mode))

(use-package tide
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package clj-refactor
  :ensure t)

(use-package clojure-mode
  :ensure t
  :config
  (require 'flycheck-clj-kondo))

(use-package doom-themes
  :ensure t)

(use-package evil-commentary
  :ensure t)

(use-package evil-collection
  :ensure t)

(use-package evil-visual-mark-mode
  :ensure t)

(use-package lsp-mode
  :ensure t)

(use-package lsp-ui
  :ensure t)

(use-package autopair
  :ensure t)

(use-package reason-mode
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package restclient
  :ensure t
  :defer t
  :mode (("\\.http\\'" . restclient-mode))
  :bind (:map restclient-mode-map
              ("C-c C-f" . json-mode-beautify)))

(use-package sparql-mode
  :ensure t
  :defer t
  :mode (("\\.sparql$" . sparql-mode)
         ("\\.rq$" . sparql-mode)))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package flx-ido
  :ensure t
  :after ido)

(desktop-save-mode-off)

(evil-collection-init 'eww)

(require 'rust-mode)
(require 'slime-autoloads)

(load-theme 'doom-gruvbox t)
;; (load-theme 'doom-dracula t)

(superword-mode 1)

(add-to-list 'load-path "~/.emacs.d/evil")
(evil-mode 1)
(evil-commentary-mode 1)
(evil-visual-mark-mode 1)
(prettify-symbols-mode 1)

(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)
(define-key evil-normal-state-map (kbd "u") 'undo-tree-undo)

(setq inferior-lisp-program "/usr/local/bin/sbcl" ; Steel Bank Common Lisp
      slime-contribs '(slime-fancy slime-asdf))

(global-company-mode)

(global-undo-tree-mode)

(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(setq default-frame-alist '((font . "Fira Code-14")))

(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

(setq sentence-end-double-space nil)

(setq backup-directory-alist `(("." . "~/.saves")))

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "C-u") #'evil-scroll-up)
  (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-ö") #'split-window-below)
  (define-key evil-normal-state-map (kbd "Ö") 'xref-find-definitions)
  (define-key evil-normal-state-map (kbd "ä") #'delete-other-windows)
  (define-key evil-normal-state-map (kbd "C-ä") #'split-window-right)
  (define-key evil-normal-state-map (kbd "ö") #'save-buffer)
  (define-key evil-normal-state-map (kbd "Ä") #'projectile-ag)
  (define-key evil-normal-state-map (kbd "¨") #'evil-search-forward)
  (define-key evil-normal-state-map (kbd "SPC ,") #'avy-goto-char)
  (define-key evil-normal-state-map (kbd "SPC .") #'avy-goto-char-2)
  (define-key evil-normal-state-map (kbd "SPC h") #'switch-to-prev-buffer)
  (define-key evil-normal-state-map (kbd "SPC l") #'switch-to-next-buffer)
  (define-key evil-normal-state-map (kbd "Q") #'kill-buffer-and-window))

(defun setup-input-decode-map ()
  (define-key input-decode-map (kbd "C-h") (kbd "C-x o"))
  (define-key input-decode-map (kbd "C-p") #'projectile-find-file)
  (define-key input-decode-map (kbd "C-l") (kbd "C-x o"))
  (define-key input-decode-map (kbd "C-b") (kbd "C-x b"))
  (define-key input-decode-map (kbd "C-n") (kbd "C-x C-f"))
  (define-key input-decode-map (kbd "C-M-<left>") (kbd "C-x <left>"))
  (define-key input-decode-map (kbd "C-M-<right>") (kbd "C-x <right>")))

(evil-set-initial-state 'term-mode 'emacs)

(defun reverse-transpose-sexps (arg)
  (interactive "*p")
  (transpose-sexps (- arg))
  ;; when transpose-sexps can no longer transpose, it throws an error and code
  ;; below this line won't be executed. So, we don't have to worry about side
  ;; effects of backward-sexp and forward-sexp.
  (backward-sexp (1+ arg))
  (forward-sexp 1))

(defun setup-global-keys ()
  (global-set-key (kbd "C-M-b") 'ibuffer)
  (global-set-key (kbd "M-<right>") 'forward-word)
  (global-set-key (kbd "M-<left>") 'backward-word)
  (global-set-key (kbd "C-<tab>") #'switch-to-prev-buffer)
  (global-set-key (kbd "<backtab>") #'switch-to-next-buffer)
  (global-set-key (kbd "´") 'kill-buffer)
  (global-set-key (kbd "C-M-ä") 'kill-buffer-and-window)
  (global-set-key (kbd "C-M-y") 'reverse-transpose-sexps)
  (global-set-key "\C-x\ \C-r" 'recentf-open-files))

(setup-global-keys)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setup-input-decode-map)

(add-hook 'tty-setup-hook #'setup-input-decode-map)

;; Spell-check
(require 'flyspell)
(setq flyspell-issue-message-flag nil
      ispell-local-dictionary "en_US"
      ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))

(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(add-hook 'markdown-mode-hook 'whitespace-cleanup)
(add-hook 'markdown-mode-hook 'flyspell-mode)

(defun latex-mappings ()
  (evil-local-set-key 'normal (kbd "°") '(lambda ()
                                           (interactive)
                                           (shell-command "make && open thesis.pdf"))))

(add-hook 'latex-mode-hook 'whitespace-cleanup)
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'latex-mappings)

;; Projectile settings

(projectile-mode +1)
(setq projectile-completion-system 'ido)
(setq projectile-sort-order 'recently-active)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(recentf-mode 1)

(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)

;; Restclient settings

(defun restclient-mappings ()
  (evil-local-set-key 'normal (kbd "§") 'restclient-http-send-current-stay-in-window))

(add-hook 'restclient-mode-hook 'restclient-mappings)

;; Clojure settings

(defun clojure-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'cider-eval-buffer)
  (evil-local-set-key 'normal (kbd "M-§") 'cider-eval-buffer)
  (evil-local-set-key 'normal (kbd "§") 'cider-eval-defun-at-point)
  (evil-local-set-key 'normal (kbd "Ö") 'cider-find-var)
  (evil-local-set-key 'normal (kbd "q") 'cider-popup-buffer-quit)
  (evil-local-set-key 'normal (kbd "K") 'cider-doc)
  (evil-local-set-key 'normal (kbd "DEL") 'paredit-splice-sexp))

(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (paredit-mode 1)
  (subword-mode 1)
  (aggressive-indent-mode 1)
  (flycheck-mode 1)
  (clojure-mappings)
  ;;(add-hook 'clojure-mode-hook #'clojure-mappings)
  )

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
;;   (setq flycheck-checkers (cons checker (delq checker flycheck-checkers))))

;; (dolist (checkers '((clj-kondo-clj . clojure-joker)
;;                     (clj-kondo-cljs . clojurescript-joker)
;;                     (clj-kondo-cljc . clojure-joker)
;;                     (clj-kondo-edn . edn-joker)))
;;   (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers))))

;; EWW

(defun eww-mappings ()
  (evil-local-set-key 'normal (kbd "M-h") 'eww-back-url)
  (evil-local-set-key 'normal (kbd "M-l") 'eww-forward-url))

(add-hook 'eww-mode-hook #'eww-mappings)
(add-hook 'eww-mode-hook #'visual-line-mode)

;; TypeScript settings

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
  (company-mode +1)
  (setq typescript-indent-level
        (or (plist-get (tide-tsfmt-options) ':indentSize) 4))
  (setq typescript-indent-level 2))

;; TSX
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Haskell settings

(defun haskell-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'haskell-interactive-bring)
  (evil-local-set-key 'normal (kbd "§") 'haskell-process-load-or-reload))

(add-hook 'haskell-mode-hook #'haskell-indent-mode)
(add-hook 'haskell-mode-hook #'interactive-haskell-mode)
(add-hook 'haskell-mode-hook #'haskell-mappings)

;; Common Lisp settings

(defun clisp-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'slime-eval-buffer)
  (evil-local-set-key 'normal (kbd "M-§") 'slime-eval-buffer)
  (evil-local-set-key 'normal (kbd "§") 'slime-eval-defun)
  (evil-local-set-key 'normal (kbd "DEL") 'paredit-splice-sexp))

(add-hook 'lisp-mode-hook #'aggressive-indent-mode)
;; (add-hook 'lisp-mode-hook #'linum-mode)
(add-hook 'lisp-mode-hook #'paredit-mode)
(add-hook 'lisp-mode-hook #'flycheck-mode)
(add-hook 'lisp-mode-hook #'clisp-mappings)

;; Scheme settings

(setq scheme-program-name "chez")

(defun scheme-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'slime-eval-buffer)
  (evil-local-set-key 'normal (kbd "M-§") 'slime-eval-buffer)
  (evil-local-set-key 'normal (kbd "§") 'scheme-send-last-sexp)
  (evil-local-set-key 'normal (kbd "DEL") 'paredit-splice-sexp))

(add-hook 'scheme-mode-hook #'aggressive-indent-mode)
(add-hook 'scheme-mode-hook #'paredit-mode)
(add-hook 'scheme-mode-hook #'flycheck-mode)
(add-hook 'scheme-mode-hook #'scheme-mappings)


;; Emacs Lisp settings

(defun elisp-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'eval-buffer)
  (evil-local-set-key 'normal (kbd "M-§") 'eval-buffer)
  (evil-local-set-key 'normal (kbd "§") 'eval-defun)
  (evil-local-set-key 'normal (kbd "DEL") 'paredit-splice-sexp))

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'flycheck-mode)
(add-hook 'emacs-lisp-mode-hook #'elisp-mappings)

;; Rust mappings

(defun rust-mappings ()
  (evil-local-set-key 'normal (kbd "Ö") 'racer-find-definition))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'rust-mode-hook #'rust-mappings)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; Python

(defun python-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'python-shell-send-buffer)
  (evil-local-set-key 'normal (kbd "M-§") 'python-shell-send-buffer)
  (evil-local-set-key 'normal (kbd "§") 'python-shell-send-defun))

(add-hook 'python-mode-hook #'flycheck-mode)
(add-hook 'python-mode-hook #'python-mappings)

;; ReasonML

;; if you want to change prefix for lsp-mode keybindings.
(setq lsp-keymap-prefix "s-l")

(require 'lsp-mode)
(add-hook 'reason-mode-hook #'lsp)

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection "/usr/local/bin/reason-language-server")
                  :major-modes '(reason-mode)
                  :notification-handlers (ht ("client/registerCapability" 'ignore))
                  :priority 1
                  :server-id 'reason-ls))

;; OCaml

(defun ocaml-mappings ()
  (evil-local-set-key 'normal (kbd "°") 'tuareg-eval-buffer)
  (evil-local-set-key 'normal (kbd "M-§") 'tuareg-eval-buffer)
  (evil-local-set-key 'normal (kbd "§") 'tuareg-eval-region))

(add-hook 'tuareg-mode-hook #'flycheck-mode)
(add-hook 'tuareg-mode-hook #'ocaml-mappings)

;; (lsp-register-client
;;  (make-lsp-client
;;   :new-connection (lsp-stdio-connection
;;                    '("opam" "exec" "--" "ocamlmerlin-lsp"))
;;   :major-modes '(caml-mode tuareg-mode)
;;   :server-id 'ocamlmerlin-lsp))

(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))
(autoload 'utop-minor-mode "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-minor-mode)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(setq merlin-use-auto-complete-mode t)
(setq merlin-error-after-save nil)

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection
                   '("opam" "exec" "--" "ocamlmerlin-lsp"))
  :major-modes '(caml-mode tuareg-mode)
  :server-id 'ocamlmerlin-lsp))

;;; esc quits

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(defun org-mode-remaps ()
  ;; Remap org-mode meta keys for convenience
  (mapcar (lambda (state)
            (evil-declare-key state org-mode-map
              (kbd "M-l") 'org-metaright
              (kbd "M-h") 'org-metaleft
              (kbd "M-k") 'org-metaup
              (kbd "M-j") 'org-metadown
              (kbd "M-L") 'org-shiftmetaright
              (kbd "M-H") 'org-shiftmetaleft
              (kbd "M-K") 'org-shiftmetaup
              (kbd "M-J") 'org-shiftmetadown))
          '(normal insert)))

(add-hook 'org-mode-hook #'(lambda ()
                             ;; make the lines in the buffer wrap around the edges of the screen.
                             ;; to press C-c q  or fill-paragraph ever again!
                             (visual-line-mode)
                             (org-mode-remaps)
                             (org-indent-mode)))

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-default-notes-file "~/Dropbox/org/index.org")

(setq org-agenda-files (list "~/Dropbox/org/index.org"))

(global-set-key (kbd "C-c o")
                (lambda ()
                  (interactive)
                  (find-file "~/Dropbox/org/organizer.org")))

;;

(defun kill-magit-diff-buffer-in-current-repo (&rest _)
  "Delete the magit-diff buffer related to the current repo."
  (let ((magit-diff-buffer-in-current-repo
         (magit-mode-get-buffer 'magit-diff-mode)))
    (kill-buffer magit-diff-buffer-in-current-repo)))
;;
;; When 'C-c C-c' is pressed in the magit commit message buffer,
;; delete the magit-diff buffer related to the current repo.
;;
(add-hook 'git-commit-setup-hook
          (lambda ()
            (add-hook 'with-editor-post-finish-hook
                      #'kill-magit-diff-buffer-in-current-repo
                      nil t)))

(with-eval-after-load 'magit
  (defun mu-magit-kill-buffers ()
    "Restore window configuration and kill all Magit buffers."
    (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'kill-buffer buffers)))

  (bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map))

(evil-set-initial-state 'cider-repl-mode 'emacs)
(add-hook 'cider-repl-mode-hook #'paredit-mode)
(evil-set-initial-state 'cider-test-report-mode 'emacs)
(evil-set-initial-state 'slime-repl-mode 'emacs)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'inferior-scheme-mode 'emacs)
(add-hook 'slime-repl-mode-hook #'paredit-mode)

(evil-set-initial-state 'profiler-report-mode 'emacs)

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; Use system tmp directory for backup files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Purge old backup files

(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))

;; Treat Emacs symbol as word in Evil mode

(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol)
  ;; make evil-search-word look for symbol rather than word boundaries
  (setq-default evil-symbol-word-search t))

(provide 'init-local)

;;; init-local.el ends here
