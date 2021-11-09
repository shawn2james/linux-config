;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(
        ;; USER INFO
 setq user-full-name "Shawn James"
      user-mail-address "shawn2james@gmail.com"

        ;; GENERAL APPEARANCE
      doom-font (font-spec :family "Mononoki Nerd Font Mono" :size 17)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "UbuntuMono Nerd Font" :size 24)
      doom-theme 'doom-tomorrow-night

        ;; GENERAL SETTINGS
      org-directory "~/org/"
      display-line-numbers-type 'relative
      undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t
      scroll-margin 5
      evil-vsplit-window-right t
      evil-split-window-below t
      evil-insert-state-cursor '(bar "#00FF00")
      evil-visual-state-cursor '(box "#FF00FF")
      evil-normal-state-cursor '(box "#E2E8EF")
)

(global-subword-mode 1)
(menu-bar--wrap-long-lines-window-edge)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (project-find-file))

(use-package emojify
  :hook (after-init . global-emojify-mode))

(setq display-line-numbers-type t)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Comment or uncomment lines" "/" #'comment-line
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines)
      (:prefix ("o" . "open")
       :desc "Open magit" "m" #'magit)
      )

