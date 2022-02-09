;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq user-full-name "Patrick McFarland"
      user-mail-address "pmcfarland@adterrasperaspera.com")

(setq doom-font (font-spec :family "Iosevka Extended" :size 19)
      doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 19))

(setq doom-theme 'doom-tomorrow-night)

(setq doom-modeline-icon nil)

(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)

;; remove bar, screwing up height
(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker)))
