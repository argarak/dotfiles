;; mail stuff
(setq user-full-name "Jakub Kukielka"
      user-mail-address "contact@argarak.me")

;; fonts!
(setq doom-font (font-spec :family "GohuNew" :size 12)
      doom-variable-pitch-font (font-spec :family "Roboto Mono" :size 13))

;; set theme
(setq doom-theme 'doom-tomorrow-night)

;; set org directory
(setq org-directory "~/org/")

;; display line numbers
(setq display-line-numbers-type t)

;; move header-line to the top
;; (setq-default header-line-format mode-line-format)
;; (setq-default mode-line-format nil)

;; show minibuffers in the buffer (because i want to access *scratch*)
(setq-default doom-unreal-buffer-functions '(minibufferp))

;; associate .njk files to web-mode
(add-to-list 'auto-mode-alist '("\\.njk\\'" . web-mode))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
