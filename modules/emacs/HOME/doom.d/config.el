;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Patrick McFarland"
      user-mail-address "pmcfarland@adterrasperaspera.com")

;; Must be decimal, because integer breaks DPI scaling
(setq doom-font (font-spec :family "Iosevka Term" :size 15.0)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 15.0))

(setq doom-theme 'doom-tomorrow-night)

(setq doom-modeline-icon nil)

(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)

;; remove bar, screwing up line height
;; https://github.com/seagle0128/doom-modeline/blob/master/doom-modeline.el#L90
(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker)))

;; make vterm open on right
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/term/vterm/config.el#L18
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/ui/popup/config.el#L143
;; (after! vterm
;;  (set-popup-rule! "*doom:vterm-popup:main" :size 0.5 :side 'right))

;; tramp: force always sshx using bash
(after! tramp
  (setenv "SHELL" "/bin/bash")
  (customize-set-variable 'tramp-default-method "sshx"))

;; vertico: re-enable which-key keys
(after! vertico
  (setq which-key-use-C-h-commands t))

;; which-key
;; launch help faster
(setq which-key-idle-delay 0.5)

;; launch in side window
(which-key-setup-side-window-right-bottom)
(setq which-key-side-window-max-width 80)

;; remove evil and evil-motion from names
(setq which-key-allow-multiple-replacements t)

(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "\\1"))))

;;
