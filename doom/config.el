;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Melinda Chang"
      user-mail-address "melindachang.hy@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

(setq doom-font (font-spec :family "CommitMono Nerd Font Mono" :size 16 :weight 'regular))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org/todos.org"))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (add-to-list 'auto-mode-alist '("\\.svelte\\'" . web-mode))

;; (setq web-mode-engines-alist '(("svelte" . "\\.svelte\\'")))

(after! org
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (setq! org-todo-keywords `((sequence "TODO" "DOIN" "|" "DONE" "CNCL"))
         org-capture-templates
         '(("g" "General To-Do" entry
            (file+headline "~/org/todos.org" "General Tasks")
            "* TODO [#B] %?\n:Created: %T\n "
            :empty-lines 0)
           ("j" "Journal" entry
            "* %<%Y-%m-%d> • ${title}\n:PROPERTIES:\n:ID: %(org-id-new nil)\n:END:%?"
            :target (file ,+org-capture-journal-file)))
         org-ellipsis " ▾"))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

(use-package! ultra-scroll
  :init (setq scroll-conservatively 101
              scroll-margin 0)
  :config (ultra-scroll-mode 1))

(use-package! org-super-agenda
  :config (org-super-agenda-mode 1))

(use-package! tree-sitter
  :config (global-tree-sitter-mode 1))

(use-package! apheleia
  :config (apheleia-global-mode +1))

(map! :leader
      :desc "Format buffer (Apheleia)"
      "c f" #'apheleia-format-buffer)

;; TREE-SITTER CUSTOM FACES
(define-advice tree-sitter-langs--hl-query-path (:before-until (lang-symbol &rest _) override-default-patterns)
  (pcase lang-symbol
    ('typescript "/home/melinda/.config/emacs/tree-sitter/queries/typescript/highlights.scm")))

(defface tree-sitter-hl-face:keyword.module
  '((t :inherit tree-sitter-hl-face:keyword))
  "Face for @keyword.module - inherits from @keyword by default.")

(defface tree-sitter-hl-face:keyword.operator
  '((t :inherit tree-sitter-hl-face:keyword))
  "Face for @keyword.operator - inherits from @keyword by default.")

(add-function :before-until tree-sitter-hl-face-mapping-function
              (lambda (capture-name)
                (pcase capture-name
                  ("keyword.module" 'tree-sitter-hl-face:keyword.module)
                  ("keyword.operator" 'tree-sitter-hl-face:keyword.operator))))
