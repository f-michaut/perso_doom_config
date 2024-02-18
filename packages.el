;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! elcord)
(package! all-the-icons)
(package! multiple-cursors)

(package! puppet-mode)
(package! jenkinsfile-mode)
(package! js2-mode)
(package! company-jedi)
(package! font-lock-ext)
(package! rinari)
(package! eglot)
(package! xclip)

(package! fold-this)
(package! frame-local)
(package! ov)

;(package! srefactor) // TODO try this (but it's not maintained anymore)

(package! string-inflection)
(package! yasnippet)
(package! zoxide)

(package! flycheck-clang-analyzer)
(package! flycheck-clang-tidy)
(package! xref :pin "a82f459b37b31546bf274388baf8aca79e9c30d9")

;; (package! xterm-mouse :disable t)
(package! magit-section)

;(package! ox-reveal)
;(package! revealjs)

(package! lsp-sonarlint)
(package! activity-watch-mode)

(package! evil :disable t)
