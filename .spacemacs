;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     csv
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     emacs-packages
     ;; auto-completion
     better-defaults
     emacs-lisp
     git
     markdown
     org
     html
     javascript
     c-c++
     python
     lua
     ;; emacs-lisp
     latex
     shell-scripts
     colors
     gtags
     github
     mu4e
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     spell-checking
     syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(processing-mode
                                      wc-goal-mode
                                      arduino-mode
                                      sws-mode
                                      stylus-mode
                                      minimap
                                      neotree
                                      jazz-theme
                                      simple-httpd
                                      htmlize
                                      impatient-mode
                                      markdown-mode
                                      nginx-mode
                                      yaml-mode
                                      column-enforce-mode
                                      adaptive-wrap
                                      prettier-js
                                      haskell-mode
                                      intero
                                      emms
                                      org-ref
                                      writeroom-mode
                                      realgud)))
(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update t
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner nil
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 5
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(jazz)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("ypn-envypn"
                               :size 12
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling nil
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."

  (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
  (require 'mu4e)
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; (defun my-org-inline-css-hook (exporter)
  ;;   "Insert custom inline css"
  ;;   (when (eq exporter 'html)
  ;;     (let* ((dir (ignore-errors (file-name-directory (buffer-file-name))))
  ;;            (path (concat dir "style.css"))
  ;;            (homestyle (or (null dir) (null (file-exists-p path))))
  ;;            (final (if homestyle "~/.emacs.d/org-style.css" path))) ;; <- set your own style file path
  ;;       (setq org-html-head-include-default-style nil)
  ;;       (setq org-html-head (concat
  ;;                            "<style type=\"text/css\">\n"
  ;;                            "<!--/*--><![CDATA[/*><!--*/\n"
  ;;                            (with-temp-buffer
  ;;                              (insert-file-contents final)
  ;;                              (buffer-string))
  ;;                            "/*]]>*/-->\n"
  ;;                            "</style>\n")))))

  ;; (add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)

  ;; yay haskell
  (intero-global-mode 1)

  (setq org-element-use-cache nil)

  ;; set maximum indentation for description lists
  (setq org-list-description-max-indent 5)

  (advice-add 'org-latex--inline-image :around
              (lambda (orig link info)
                (concat
                 "\\begin{center}"
                 (funcall orig link info)
                 "\\end{center}")))

  ;; prevent demoting heading also shifting text inside sections
  (setq org-adapt-indentation nil)

  (setq prettier-js-args '("--bracket-spacing" "false"))
  (setq js-indent-level 2)

  (add-hook 'js2-mode-hook 'prettier-js-mode)

  ;; Reverse colors for the border to have nicer line
  (set-face-inverse-video-p 'vertical-border nil)
  (set-face-background 'vertical-border (face-background 'default))

  ;; Set symbol for the border
  (set-display-table-slot standard-display-table
                          'vertical-border
                          (make-glyph-code ?│))

  (setq dotspacemacs-elpa-https 'nil)
  (setq flyspell-issue-message-flag 'nil)

  (setq redisplay-dont-pause t)

  ;; (require 'w3m-load)

  (spaceline-toggle-window-number-off)

  (setq powerline-default-separator 'nil)
  (setq linum-format " %d ")

  (autoload 'artist-mode "artist" "Enter artist-mode" t)

  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.styl\\'" . stylus-mode))

  (setq-default header-line-format mode-line-format)
  (setq-default mode-line-format nil)

  (require 'sws-mode)

  (add-to-list 'auto-mode-alist '("\\.styl\\'" . sws-mode))

  (set-face-attribute 'default nil :height 180)

  (add-hook 'markdown-mode-hook 'wc-goal-mode)
  (add-hook 'markdown-mode-hook 'writeroom-mode)
  (add-hook 'markdown-mode-hook 'flyspell-mode)

  ;; (defun disable-company-mode ()
  ;;   (company-mode -1))

  (add-hook 'markdown-mode-hook 'disable-company-mode)

  (setq processing-location "/usr/bin/processing-java")
  (setq processing-application-dir "/usr/bin/processing")
  (setq processing-sketchbook-dir "~/sketchbook")

  (defun nolinum ()
    (linum-mode 0)
  )

  (add-hook 'markdown-mode-hook 'nolinum)

  (setq-default dotspacemacs-mode-line-unicode-symbols nil)

  (add-hook 'minibuffer-setup-hook
            (lambda ()
              (make-local-variable 'face-remapping-alist)
              (add-to-list 'face-remapping-alist '(default (:background "#111111")))))

  (global-set-key (kbd "C-s") 'helm-swoop)
  (global-set-key (kbd "M-s s") 'replace-string)

  (require 'org-ref)

  ;; End of config
  (spaceline-compile)

)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-use-header-line nil)
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(ansi-term-color-vector
   [unspecified "#272822" "#f92672" "#a6e22e" "#f4bf75" "#66d9ef" "#ae81ff" "#66d9ef" "#f8f8f2"] t)
 '(async-bytecomp-package-mode t)
 '(blink-cursor-mode nil)
 '(compilation-message-face 'default)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(jazz))
 '(custom-safe-themes
   '("eb7be1648009af366d83f855191057bdc09348a2d9353db31da03b1cdec50cc5" "12ced60b9eec2ec25d781a556c1ecf2c582700439f56ca18c281b3fb7670e5e6" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "8936325181ad91e3c0a4292f9912fa28da358c159b5dae2af3728bbcfa07ae9e" "e03bebe267c8599b02112a1aa7f9a0ab0a2f47048bfb6a8ab67bd9e1a44085c4" "c39ae5721fce3a07a27a685c08e4b856a13780dbc755a569bb4393c932f226d7" default))
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(emms-mode-line-icon-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };"))
 '(evil-want-Y-yank-to-eol t)
 '(fci-rule-character 32)
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "dim gray" t)
 '(fringe-mode 6 nil (fringe))
 '(global-linum-mode t)
 '(global-vi-tilde-fringe-mode nil)
 '(gnus-logo-colors '("#528d8d" "#c0c0c0") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #1fb3b3\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };") t)
 '(haskell-interactive-popup-errors nil)
 '(haskell-mode-hook
   '(haskell-indent-mode haskell-indentation-mode highlight-uses-mode interactive-haskell-mode))
 '(helm-display-header-line nil t)
 '(helm-echo-input-in-header-line nil t)
 '(helm-swoop-use-line-number-face t)
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   '(("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100)))
 '(hl-paren-background-colors '("#2492db" "#95a5a6" nil))
 '(hl-paren-colors '("#ecf0f1" "#ecf0f1" "#c0392b") t)
 '(hl-sexp-background-color "#121212")
 '(inhibit-startup-screen t)
 '(linum-format " %2d ")
 '(linum-relative-current-symbol "")
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style 'chamfer)
 '(menu-bar-mode nil)
 '(notmuch-search-line-faces
   '(("unread" :foreground "#aeee00")
     ("flagged" :foreground "#0a9dff")
     ("deleted" :foreground "#ff2c4b" :bold t)))
 '(nrepl-message-colors
   '("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c"))
 '(org-agenda-files '("~/work/eeng/aaaaaaaaaaaaa.org"))
 '(org-bullets-bullet-list '("‣" "•" "◦" "⁃"))
 '(package-archives
   '(("marmalade" . "https://marmalade-repo.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(realgud test-simple loc-changes load-relative visual-fill-column csv-mode org-projectile org-plus-contrib yapfify winum uuidgen unfill sws-mode powerline py-isort pug-mode org-category-capture org-mime org-download mwim mu4e-maildirs-extension mu4e-alert alert log4e gntp markdown-mode magit-popup livid-mode skewer-mode live-py-mode link-hint json-snatcher json-reformat yasnippet multiple-cursors js2-mode insert-shebang impatient-mode hydra dash-functional parent-mode projectile haml-mode github-search gh marshal logito pcache ht flyspell-correct-helm flyspell-correct pos-tip flycheck pkg-info epl flx eyebrowse evil-visual-mark-mode evil-unimpaired highlight magit git-commit with-editor transient smartparens iedit evil-ediff anzu evil goto-chg undo-tree dumb-jump diminish color-identifiers-mode bind-map bind-key packed auctex arduino-mode spinner anaconda-mode pythonic f dash s helm avy helm-core popup async org-ref pdf-tools key-chord ivy helm-bibtex biblio parsebib biblio-core lv tablist emms intero company haskell-mode helm-flyspell auto-dictionary olivetti prettier-js vue-mode ssass-mode vue-html-mode column-marker column-enforce-mode synosaurus yaml-mode nginx-mode markdown-mode+ simple-httpd helm-gitignore request ws-butler writeroom-mode which-key web-mode web-beautify wc-goal-mode volatile-highlights vi-tilde-fringe use-package toc-org tagedit stylus-mode spacemacs-theme spaceline smooth-scrolling smeargle slim-mode scss-mode sass-mode restart-emacs rainbow-mode rainbow-identifiers rainbow-delimiters quelpa pyvenv pytest pyenv-mode py-yapf processing-mode popwin pip-requirements persp-mode pcre2el paradox page-break-lines orgit org-repo-todo org-present org-pomodoro org-bullets open-junk-file neotree move-text mmm-mode minimap markdown-toc magit-gitflow magit-gh-pulls macrostep lua-mode lorem-ipsum linum-relative leuven-theme less-css-mode latex-preview-pane json-mode js2-refactor js-doc jazz-theme jade-mode info+ indent-guide ido-vertical-mode hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gtags helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitignore-mode github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gist gh-md ggtags flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery expand-region exec-path-from-shell evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav disaster define-word cython-mode company-web company-tern company-statistics company-quickhelp company-auctex company-arduino company-anaconda coffee-mode cmake-mode clean-aindent-mode clang-format buffer-move bracketed-paste auto-yasnippet auto-highlight-symbol auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))
 '(pos-tip-background-color "#262626")
 '(pos-tip-foreground-color "#272822")
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(powerline-default-separator nil)
 '(processing-application-dir "/usr/bin/processing" t)
 '(processing-location "/usr/bin/processing-java" t)
 '(rainbow-identifiers-cie-l*a*b*-lightness 70 t)
 '(rainbow-identifiers-cie-l*a*b*-saturation 20 t)
 '(safe-local-variable-values
   '((eval setq org-latex-default-packages-alist
           (cons
            '("mathletters" "ucs" nil)
            org-latex-default-packages-alist))
     (org-latex-inputenc-alist
      ("utf8" . "utf8x"))))
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(tool-bar-mode nil)
 '(undo-tree-visualizer-diff nil)
 '(use-package-inject-hooks t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(when
      (or
       (not
        (boundp 'ansi-term-color-vector))
       (not
        (facep
         (aref ansi-term-color-vector 0)))))
 '(window-numbering-mode nil)
 '(writeroom-mode-line t)
 '(writeroom-width 110)
 '(xterm-color-names
   ["#262626" "#D66F84" "#D79887" "#D49A8A" "#94B1A3" "#A8938C" "#989584" "#E8DACC"])
 '(xterm-color-names-bright
   ["#333333" "#E47386" "#CC816B" "#769188" "#7D6F6A" "#9C8772" "#E8DACC"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#111111" :foreground "#c6a57b" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "ypn" :family "ypn envypn"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(fringe ((((class color) (min-colors 89)) (:foreground "#888888" :background "#111111"))))
 '(header-line ((t (:background "#101010" :foreground "#909737" :box nil))))
 '(helm-swoop-line-number-face ((t (:foreground "dim gray"))))
 '(helm-swoop-target-line-block-face ((t (:background "firebrick1" :foreground "#222222"))))
 '(helm-swoop-target-line-face ((t (:background "firebrick3" :foreground "#ffffff"))))
 '(helm-swoop-target-word-face ((t (:background "OrangeRed1" :foreground "#ffffff"))))
 '(linum ((t (:background "#111111" :foreground "#383838"))))
 '(mode-line ((t (:background "#0e0e0e" :foreground "#c6a57b" :box nil))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#0e0e0e" :foreground "#c6a57b" :box (:line-width 5 :color "#101010")))))
 '(powerline-active1 ((t (:inherit mode-line :background "#0e0e0e"))))
 '(powerline-active2 ((t (:inherit mode-line :background "#0e0e0e"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "#0e0e0e"))))
 '(powerline-inactive2 ((t (:inherit font-lock-comment-face :background "#0e0e0e")))))
