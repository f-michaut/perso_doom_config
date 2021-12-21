;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-theme 'doom-palenight)
(setq python-shell-interpreter "python3")

;; This line is not working ?
(let ((default-directory (expand-file-name "lisp" doom-private-dir)))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.local/share/icons-in-terminal/")

(add-to-list 'load-path "~/.doom.d/lisp")
(add-to-list 'load-path "~/.doom.d/lisp/sidebar.el")

(require 'fold-this)
(global-set-key (kbd "C-t") 'fold-this)
(fold-this-persistent-mode t)

(require 'icons-in-terminal)
(require 'sidebar)
(global-set-key (kbd "C-x C-q") 'sidebar-open)
(global-set-key (kbd "C-x C-a") 'sidebar-buffers-open)
;; (remove-hook 'server-after-make-frame-hook 'sidebar-open)
;(save-selected-window (sidebar-open))

(map!
 ;; "C-c <C-right>" #'evil-window-right
 ;; "C-c <C-left>" #'evil-window-left
 ;; "C-c <C-up>" #'evil-window-up
 ;; "C-c <C-down>" #'evil-window-down
 "C-c <C-right>" #'windmove-right
 "C-c <C-left>" #'windmove-left
 "C-c <C-up>" #'windmove-up
 "C-c <C-down>" #'windmove-down
 "C-c C-g" #'magit-stage
 "C-x C-g" #'magit-commit
 "C-c C-r" #'clang-rename
 "C-c C-f" #'+fold/toggle
 "<C-M-up>" #'backward-sexp
 "<C-M-down>" #'forward-sexp
 )

;; (mouse-wheel-mode -1)
;; (global-set-key [wheel-up] 'ignore)
;; (global-set-key [wheel-down] 'ignore)
;; (global-set-key [double-wheel-up] 'ignore)
;; (global-set-key [double-wheel-down] 'ignore)
;; (global-set-key [triple-wheel-up] 'ignore)
;; (global-set-key [triple-wheel-down] 'ignore)

(global-git-gutter-mode)
(global-display-line-numbers-mode)

(require 'multiple-cursors)
(setq mc/always-run-for-all t)

(remove-hook 'tty-setup-hook #'xterm-mouse-mode)
(global-display-fill-column-indicator-mode)
(set-fill-column 80)

(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (delete-region
   (point)
   (progn
     (forward-word arg)
     (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push text to `kill-ring'."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-delete-line ()
  "Delete text from current position to end of line char.
This command does not push text to `kill-ring'."
  (interactive)
  (delete-region
   (point)
   (progn (end-of-line 1) (point)))
  (delete-char 1))

(require 'tramp)
(setq tramp-default-method "scp")

(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position.
This command does not push text to `kill-ring'."
  (interactive)
  (let (p1 p2)
    (setq p1 (point))
    (beginning-of-line 1)
    (setq p2 (point))
    (delete-region p1 p2)))


; bind them to emacs's default shortcut keys:
(global-set-key (kbd "C-S-k") 'my-delete-line-backward) ; Ctrl+Shift+k
(global-set-key (kbd "C-k") 'my-delete-line)
(global-set-key (kbd "M-d") 'my-delete-word)
(global-set-key (kbd "M-DEL") 'my-backward-delete-word)

(require 'multiple-cursors)
(global-set-key (kbd "C-c C-v") 'mc/edit-lines)
(require 'flycheck)
(global-set-key (kbd "C-c e") 'flycheck-first-error)
(global-set-key (kbd "C-c n") 'flycheck-next-error)
(add-hook 'after-init-hook #'global-flycheck-mode)


(require 'js2-mode)
(setq js2-strict-missing-semi-warning nil)
(setq js2-strict-inconsistent-return-warning nil)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

;; (require 'evil)
;; (evil-mode 0)

;(add-hook 'doom-restore-session-handler (lambda () (neotree-show)))
;(add-hook 'projectile-find-file-hook (lambda () (neotree-show)))
;(add-hook 'neotree-projectile-action (lambda () (neotree-show)))
(require 'neotree)
(setq neo-theme 'arrow)
;(setq neo-autorefresh t)

;; (defun my_neotree_hook ()
;;   "my"
;;   (neotree-show)
;;   (remove-hook 'doom-switch-buffer-hook 'my_neotree_hook))
;; (add-hook 'doom-switch-buffer-hook 'my_neotree_hook)
;(neotree-mode t)

(add-to-list 'auto-mode-alist '("\\.ejs\\'" . html-mode))


(eval-after-load 'company
  '(add-to-list 'company-backends 'company-jedi))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'c/c++-clang-tidy))

(require 'flycheck)
(eval-after-load 'flycheck
   '(add-to-list 'flycheck-checkers 'c/c++-clang-tidy))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook (lambda () (flycheck-add-next-checker 'irony '(warning . c/c++-clang-tidy)))))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook (lambda () (flycheck-add-next-checker 'c/c++-clang-tidy 'clang-analyzer))))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-clang-analyzer-setup))

;; (defun flycheck-irony-and-clang-tidy-setup ()
;;    (flycheck-clang-tidy-setup)
;;    (flycheck-irony-setup)
;;    (flycheck-add-next-checker 'irony '(warning . c/c++-clang-tidy)))

;; (with-eval-after-load 'flycheck
;;    (add-hook 'flycheck-mode-hook #'flycheck-irony-and-clang-tidy-setup))

;; (with-eval-after-load 'flycheck
;;    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
;;    (add-hook 'flycheck-mode-hook #'flycheck-clang-tidy-setup)
;;    (flycheck-add-next-checker 'irony '(warning . c/c++-clang-tidy)))

(require 'flycheck-clang-analyzer)
(flycheck-clang-analyzer-setup)
;; (eval-after-load 'flycheck
;;   '(flycheck-add-next-checker 'irony 'c/c++-clang-tidy)
;; )


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Unity stuff
(defun unity-compile-game ()
  (interactive)
  (let ((cmd (concat "python " (project:project-root project:active-project) "make.py fast " (project:project-root project:active-project))))
    (compile cmd)))

(defun unity-recompile-game ()
  (interactive)
  (let ((cmd (concat “python ” (project:project-root project:active-project) “make.py slow ” (project:project-root project:active-project))))
    (compile cmd)))

(require 'flycheck)
(flycheck-define-checker csharp-unity
  "Custom checker for Unity projects"
  :modes (csharp-mode)
  :command ("python" (eval (concat (project:active-project-root) "make.py")) "fast" (eval (project:active-project-root)) source-original source)
  :error-patterns((warning line-start (file-name) "(" line (zero-or-more not-newline) "): " (message) line-end)
                  (error line-start (file-name) "(" line (zero-or-more not-newline) "): " (message) line-end)))

(setq csharp-want-imenu nil)
(add-hook 'csharp-mode
          (lambda ()
            (local-set-key (kbd "{") 'csharp-insert-open-brace)
            )
          )


;; (require 'lsp)
;; (lsp)
;; (lsp-ui-sideline-mode 0)
;; (lsp-ui-peek-enable 1)

;; (xterm-mouse-mode -1)
(require 'elcord)
(elcord-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(neo-hidden-regexp-list
   (quote
    ("^\\.\\(?:git\\|hg\\|svn\\)$" "\\.\\(?:pyc\\|o\\|elc\\|lock\\|css.map\\|class\\)$" "^\\(?:node_modules\\|vendor\\|.\\(project\\|cask\\|yardoc\\|sass-cache\\)\\)$" "^\\.\\(?:sync\\|export\\|attach\\)$" "~$" "^#.*#$" "^.*\\.meta$")))
 '(neo-show-hidden-files nil)
 '(tab-width 4)
 '(c-basic-offset 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
