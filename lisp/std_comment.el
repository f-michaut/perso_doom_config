;;
;; Project Test, 2022
;;
;; Author Francois Michaut
;;
;; Started on  Sat Jan 15 01:06:41 2022 Francois Michaut
;; Last update Sat Jan 15 01:22:40 2022 Francois Michaut
;;
;; std_comment.el : Contains functions to create file headers
;;

(setq header-project    "Project "
      header-made-by    "Author "
      header-started    "Started on  "
      header-last       "Last update "
      )

(setq std-c-alist               '( (cs . "/*") (cc . "** ") (ce . "*/") )
      std-css-alist             '( (cs . "/*") (cc . "** ") (ce . "*/") )
      std-cpp-alist             '( (cs . "/*") (cc . "** ") (ce . "*/") )
      std-pov-alist             '( (cs . "//") (cc . "// ") (ce . "//") )
      std-java-alist            '( (cs . "//") (cc . "// ") (ce . "//") )
      std-latex-alist           '( (cs . "%%") (cc . "%% ") (ce . "%%") )
      std-lisp-alist            '( (cs . ";;") (cc . ";; ") (ce . ";;") )
      std-xdefault-alist        '( (cs . "!!") (cc . "!! ") (ce . "!!") )
      std-pascal-alist          '( (cs . "{ ") (cc . "   ") (ce . "}" ) )
      std-makefile-alist        '( (cs . "##") (cc . "## ") (ce . "##") )
      std-text-alist            '( (cs . "##") (cc . "## ") (ce . "##") )
      std-fundamental-alist     '( (cs . "  ") (cc . "   ") (ce . "  ") )
      std-html-alist            '( (cs . "<!--") (cc . "  -- ") (ce . "-->"))
      std-php-alist             '( (cs . "#!/usr/local/bin/php\n<?php") (cc . "// ")(ce . "//"))
      std-nroff-alist           '( (cs . "\\\"") (cc . "\\\" ") (ce . "\\\""))
      std-sscript-alist         '( (cs . "#!/bin/sh")  (cc . "## ") (ce . "##"))
      std-perl-alist            '( (cs . "#!/usr/local/bin/perl -w")  (cc . "## ")(ce . "##"))
      std-cperl-alist           '( (cs . "#!/usr/local/bin/perl -w")  (cc . "## ")(ce . "##"))
      )

(setq std-modes-alist '(("C"                    . std-c-alist)
                        ("C/l"                  . std-c-alist)
                        ("C/*l"                 . std-c-alist)
                        ("CSS"                  . std-c-alist)
                        ("PoV"                  . std-pov-alist)
                        ("C++"                  . std-cpp-alist)
                        ("C++/l"                . std-cpp-alist)
                        ("C++//l"               . std-cpp-alist)
                        ("Lisp"                 . std-lisp-alist)
                        ("Lisp Interaction"     . std-lisp-alist)
                        ("Emacs-Lisp"           . std-lisp-alist)
                        ("Elisp"                . std-lisp-alist)
                        ("Fundamental"          . std-fundamental-alist)
                        ("Shell-script"         . std-sscript-alist)
                        ("CMake"                . std-makefile-alist)
                        ("Makefile"             . std-makefile-alist)
                        ("BSDmakefile"          . std-makefile-alist)
                        ("GNUmakefile"          . std-makefile-alist)
                        ("Perl"                 . std-cperl-alist)
                        ("CPerl"                . std-cperl-alist)
                        ("xdefault"             . std-xdefault-alist)
                        ("java"                 . std-java-alist)
                        ("latex"                . std-latex-alist)
                        ("Pascal"               . stdp-ascal-alist)
                        ("Text"                 . std-text-alist)
                        ("HTML"                 . std-html-alist)
                        ("PHP"                  . std-php-alist)
                        ("Nroff"                . std-nroff-alist)
                        ("TeX"                  . std-latex-alist)
                        ("LaTeX"                . std-latex-alist))
      )

(defun std-get (a)
  (interactive)
  (cdr (assoc a (eval (cdr (assoc mode-name std-modes-alist)))))
  )

(defun update-std-header ()
  "Updates std header with last modification time & owner.\n(According to mode)"
  (interactive)
  (save-excursion
        (progn
          (goto-char (point-min))
          (if (search-forward header-last nil t)
              (progn
;               (delete-region (point-at-bol) (point-at-eol))
                (delete-region
                 (progn (beginning-of-line) (point))
                 (progn (end-of-line) (point)))
                (insert (concat (std-get 'cc)
                                header-last
                                (current-time-string)
                                " "
                                user-full-name))
                (message "Last modification header field updated."))
            )
          )
        )
  )

(defun std-file-header ()
  "Puts a standard header at the beginning of the file.\n(According to mode)"
  (interactive)
  (goto-char (point-min))
  (let ((projname "project")(filedescription "description"))
    (setq projname (read-from-minibuffer
                    (format "Type project name (RETURN to quit) : ")))
    (setq filedescription (read-from-minibuffer
                           (format "Type short file description (RETURN to quit) : ")))

    (insert (std-get 'cs))
    (newline)
    (insert (concat (std-get 'cc)
                    header-project
                    projname
                    (format-time-string ", %Y")))
    (newline)
    (insert (std-get 'cc))
    (newline)
    (insert (concat (std-get 'cc) header-made-by user-full-name))
    (newline)
    (insert (concat (std-get 'cc)))
    (newline)
    (insert (concat (std-get 'cc)
                    header-started
                    (current-time-string)
                    " "
                    user-full-name))
    (newline)
    (insert (concat (std-get 'cc)
                    header-last
                    (current-time-string)
                    " "
                    user-full-name))
    (newline)
    (insert (concat (std-get 'cc)))
    (newline)
    (insert (concat (std-get 'cc)
                    (file-name-nondirectory buffer-file-name)
                    " : "
                    filedescription))
    (newline)
    (insert (std-get 'ce))
    (newline)
    (newline)))

(defun insert-std-vertical-comments ()
  "Insert vertical comments (according to mode)."
  (interactive)
  (beginning-of-line)
  (insert (std-get 'cs))
  (newline)
  (let ((ok t)(comment ""))
    (while ok
      (setq comment (read-from-minibuffer
                     (format "Type comment (RETURN to quit) : ")))
      (if (= 0 (length comment))
          (setq ok nil)
        (progn
          (insert (concat (std-get 'cc) comment))
          (newline)))))
  (insert (std-get 'ce))
  (newline))

(provide 'std_comment)
