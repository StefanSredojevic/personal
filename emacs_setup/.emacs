;; =============================================================================
;; STEFANS CUSTOM
;; =============================================================================

;;Package init
(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

;;MELPA
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;ELPA
(add-to-list 'package-archives '("org" ."http://orgmode.org/elpa/") t)

;;Use package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;Which key package
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;;Beacon package
(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

;;Avy package
(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

;;Rainbow mode package
(use-package rainbow-mode
  :ensure t
  :init (rainbow-mode 1))

;;Switch window package
(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts
	'("a" "s" "d" "f" "h" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

;;Org package org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

;;Hungy word package
(use-package hungry-delete
  :ensure t
  :config (global-hungry-delete-mode))

;;Rainbow delimiters package
(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

;;Dashboard package
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Sredojevic is the best !"))

;;Autocomplete package
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;;Company irony package
(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

;;;;Irony package [WONT WORK]
;;(use-package irony
;;  :ensure t
;;  :config
;;  (add-hook 'c++-mode-hook 'irony-mode)
;;  (add-hook 'c-mode-hook 'irony-mode)
;;  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
;;
;;(with-eval-after-load 'company
;;  (add-hook 'c++-mode-hook 'company-mode)
;;  (add-hook 'c-mode-hook 'company-mode))

;;Sudo edit package
;;(use-package sudo-edit
;;  :ensure t
;;  :bind ("s-e" . sudo-edit))

;;Config visit function
;;(defun config-visit ()
;;  (interactive)
;;  (find-file "~/.emacs.d/config.org"))
;;(global-set-key (kbd "C-c e") 'config-visit)

;;Auto close parenthesies
(setq electric-pair-pairs '(
			    (?\( . ?\))
			    (?\[ . ?\])
			    (?\" . ?\")
			    (?\{ . ?\})
			    ))
(electric-pair-mode t)

;;Kill whole word
(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w w") 'kill-whole-word)

;;Find .emacs file (EDIT FOR LINUX)
(defun find-dot-emacs ()
  (interactive)
  (find-file "C:/Users/Stefan/AppData/Roaming/.emacs"))

;;Split and follow horizontally
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

;;Split and follow vertically
(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;;Font
(set-face-attribute 'default nil :font "Courier New-14")

;;Other window
(global-set-key (kbd "M-.") 'other-window)

;;Beggining and end of file
(global-set-key (kbd "M-<") 'beginning-of-buffer)
(global-set-key (kbd "M->") 'end-of-buffer)

;;Set terminal
;;(defvar my-term-shell "/bin/bash")
;;(defadvice ansi-term (before force-bash)
;;  (interactive (list my-term-shell)))
;;(ad-active 'asni-term)
;;(global-set-key (kbd "<s-return>") 'ansi-term)

;;Set org template
;;(setq org-src-window-setup 'current-window)
;;(add-to-list 'org-structure-template-alist
;;	     '("el" "#+BEGIN_SRC emacs-lisp\n?\n"))

;;Remove YES instead use Y
(defalias 'yes-or-no-p 'y-or-n-p)

;;C-n scroll line by line
(setq scroll-conservatively 100)

;;Disable sound
(setq visible-bell 1)
(setq ring-bell-function 'ignore)

;;Global line highlight (Possible to not work in virtual console)
(when window-system (global-hl-line-mode t))

;;Global prettyify symbols
(when window-system (global-prettify-symbols-mode t))

;;Disable emacs auto save files
(setq make-backup-file nil)
(setq auto-save-default nil)

;;ido mode
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)
(ido-vertical-mode 1)
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;;Remove scroll bar
(scroll-bar-mode -1)

;;Disable new line after ";"
(setq verilog-auto-newline nil)

;;Leave searched words highlighted
(setq lazy-highlight-cleanup nil)

;;Remove welcome screen
(setq inhibit-startup-screen t)

;;Smoth scroll
(setq mouse-wheel-scroll-amount '(3 ((shift) .1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;;Normal delete
(delete-selection-mode 1)

;;Set tab width to 3
(setq tab-stop-list '(3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60 63 66 69 72 75 78 81 84 87 90 93 96 99 102))

;;Backtab for 3 spaces
(global-set-key (kbd "<backtab>") 'un-indent-by-removing-3-spaces)
(defun un-indent-by-removing-3-spaces ()
  "remove 3 spaces from beginning of of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;; get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
        (untabify (match-beginning 0) (match-end 0)))
      (when (looking-at "^   ")
        (replace-match "")))))

;;Move line up
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

;;Move line down
(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;;Copy line below
(defun copy-line-below ()
  "Copy down the current line."
  (interactive)
  (beginning-of-line)
  (kill-line)
  (yank)
  (end-of-line)
  (newline)
  (beginning-of-line)
  (yank)
  (previous-line 1))

(global-set-key [(meta shift up)]  'move-line-up)
(global-set-key [(meta shift down)]  'move-line-down)
(global-set-key [(control meta z)] 'copy-line-below)

;;Save all files and exit emacs
(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs)

;;Reload file
(global-set-key [(meta r)]  'revert-buffer)

;;Emacs auto
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (gruber-darker)))
 '(custom-safe-themes
   (quote
    ("47ec21abaa6642fefec1b7ace282221574c2dd7ef7715c099af5629926eb4fd7" default)))
 '(package-selected-packages
   (quote
    (company-irony company dashboard rainbow-delimiters sudo-edit hungry-delete org-bullets switch-window rainbow-mode avy magit org ido-vertical-mode beacon which-key use-package))))

;;Normal tab
(global-set-key (kbd "<C-tab>") 'tab-to-tab-stop)
;;(defun 'tab-to-tab-stop ()
;;  "Add normal space"
;;  (tab-to-tab-stop))


;; ********** VERILOG ALIGN **********

;;Align keys
(global-set-key [(control meta \[)] 'align-regexp)
(global-set-key [(control meta \])] 'exchange-point-and-mark)

;;Align aliases
(defalias  'msp	  'my-select-parameters)
(defalias  'msi	  'my-select-inputs)
(defalias  'mso	  'my-select-outputs)
(defalias  'msl	  'my-select-logic)
(defalias  'msai  'my-select-autoinput)
(defalias  'msao  'my-select-autooutput)
(defalias  'msaw  'my-select-autowire)
(defalias  'msal  'my-select-autologic)
(defalias  'msat  'my-select-autotemplate)
(defalias  'msipa 'my-select-instantiation-parameters)
(defalias  'msipo 'my-select-instantiation-ports)

(defalias  'map	  'my-align-parameters)
(defalias  'mapw  'my-align-ports-wires)
(defalias  'maat  'my-align-autotemplate)
(defalias  'maipa 'my-align-instantiation-parameters)
(defalias  'maipo 'my-align-instantiation-ports)

(defalias 'mdp	  'my-do-parameters)
(defalias 'mdi	  'my-do-inputs)
(defalias 'mdo	  'my-do-outputs)
(defalias 'mdl	  'my-do-logic)
(defalias 'mdai	  'my-do-autoinput)
(defalias 'mdao	  'my-do-autooutput)
(defalias 'mdaw	  'my-do-autowire)
(defalias 'mdal	  'my-do-autologic)
(defalias 'mdat	  'my-do-autotemplate)
(defalias 'mdipa  'my-do-instantiation-parameters)
(defalias 'mdipo  'my-do-instantiation-ports)
(defalias 'mde	  'my-do-entity)
(defalias 'mda	  'my-do-autos)
(defalias 'mdii	  'my-do-instantiation)

;; ========== ENTITY ==========

;;Select parameters
(defun my-select-parameters ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "PARAMETERS")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "USER INPUTS")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Align parameters
(defun my-align-parameters (start end)
  "Align within marked region."
  (interactive "*r")
  (align-regexp start end "\\(\\s-*\\)=" 1 1 nil)
  (exchange-point-and-mark)
  (align-regexp start end "\\(\\s-*\\)//" 1 1 nil)
  (exchange-point-and-mark)
  (electric-verilog-tab)
  )

;;Do - parameters
(defun my-do-parameters   ()
  (interactive)
  (my-select-parameters)
  (my-align-parameters (region-beginning) (region-end))
  )

;;Select user inputs
(defun my-select-inputs ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "USER INPUTS")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "USER OUTPUTS")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Select user outputs
(defun my-select-outputs ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "USER OUTPUTS")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "USER LOGIC")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Select user logic
(defun my-select-logic ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "USER LOGIC")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOINPUT*/")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Align ports and also wires
(defun my-align-ports-wires (start end)
  "Align within marked region."
  (interactive "*r")
  (align-regexp start end "\\(\\s-*\\)\\([a-z]\\|[0-9]\\|[_]\\)+;" 1 1 nil)
  (exchange-point-and-mark)
  (align-regexp start end "\\(\\s-*\\)\\(\\(\\/\\/.+\\.$\\)\\|\\(\\/\\/.+\\.v\\)\\|\\(\\/\\/.+\\.sv\\)\\)" 1 1 nil)
  )

;;Do - inputs
(defun my-do-inputs   ()
  (interactive)
  (my-select-inputs)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - outputs
(defun my-do-outputs   ()
  (interactive)
  (my-select-outputs)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - logic
(defun my-do-logic   ()
  (interactive)
  (my-select-logic)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - entity
(defun my-do-entity   ()
  (interactive)
  (my-do-parameters)
  (my-do-inputs)
  (my-do-outputs)
  (my-do-logic)
  )

;; ========== AUTOS ==========

;;Select autoinput
(defun my-select-autoinput ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOINPUT*/")
  (next-line nil 1)
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "End of automatics")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Select autooutput
(defun my-select-autooutput ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOOUTPUT*/")
  (next-line nil 1)
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "End of automatics")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Select autowire
(defun my-select-autowire ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOWIRE*/")
  (next-line nil 1)
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "End of automatics")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Select autologic
(defun my-select-autologic ()
  (interactive)
  (beginning-of-buffer)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOLOGIC*/")
  (next-line nil 1)
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "End of automatics")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Do - autoinput
(defun my-do-autoinput   ()
  (interactive)
  (my-select-autoinput)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - autooutput
(defun my-do-autooutput   ()
  (interactive)
  (my-select-autooutput)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - autowire
(defun my-do-autowire   ()
  (interactive)
  (my-select-autowire)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - autologic
(defun my-do-autologic   ()
  (interactive)
  (my-select-autologic)
  (my-align-ports-wires (region-beginning) (region-end))
  )

;;Do - entity
(defun my-do-autos   ()
  (interactive)
  (my-do-autoinput)
  (my-do-autooutput)
  (my-do-autowire)
  (my-do-autologic)
  )

;; ========== INSTANTIATION ==========

;;Select autotemplate
(defun my-select-autotemplate ()
  (interactive)
  (isearch-forward nil 1 )
  (isearch-yank-string "AUTO_TEMPLATE")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "*/")
  (move-end-of-line nil)
  )

;;Align user autotemplate
(defun my-align-autotemplate (start end)
  "Align within marked region."
  (interactive "*r")
  (align-regexp start end "\\(\\s-*\\)(.[a-z]" 1 1 nil)
  (exchange-point-and-mark)
  (align-regexp start end "\\(\\s-*\\)//" 1 1 nil)
  (exchange-point-and-mark)
  (electric-verilog-tab)
  )

;;Do - autotemplate
(defun my-do-autotemplate    ()
  (interactive)
  (my-select-autotemplate)
  (my-align-autotemplate (region-beginning) (region-end))
  )

;;Select instantiation parameters
(defun my-select-instantiation-parameters()
  (interactive)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOINSTPARAM*/")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOINST*/")
  (previous-line nil 1)
  (move-end-of-line nil)
  )

;;Align user instantiation parameters
(defun my-align-instantiation-parameters (start end)
  "Align comments within marked region."
  (interactive "*r")
  (align-regexp start end "\\(\\s-*\\)(" 1 1 nil)
  (exchange-point-and-mark)
  (align-regexp start end "\\(\\s-*\\)//" 1 1 nil)
  (exchange-point-and-mark)
  (electric-verilog-tab)
  )

;;Do - instantiation parameters
(defun my-do-instantiation-parameters    ()
  (interactive)
  (my-select-instantiation-parameters)
  (my-align-instantiation-parameters (region-beginning) (region-end))
  )

;;Select instantiation ports
(defun my-select-instantiation-ports ()
  (interactive)
  (isearch-forward nil 1 )
  (isearch-yank-string "/*AUTOINST*/")
  (next-line nil 1)
  (move-beginning-of-line nil)
  (set-mark-command nil)
  (isearch-forward nil 1 )
  (isearch-yank-string ";")
  (move-end-of-line nil)
  )

;;Align user instantiation ports
(defun my-align-instantiation-ports (start end)
  "Align comments within marked region."
  (interactive "*r")
  (align-regexp start end "\\(\\s-*\\)(" 1 1 nil)
  (exchange-point-and-mark)
  (align-regexp start end "\\(\\s-*\\)//" 1 1 nil)
  (exchange-point-and-mark)
  (electric-verilog-tab)
  )

;;Do - instantiation ports
(defun my-do-instantiation-ports    ()
  (interactive)
  (my-select-instantiation-ports)
  (my-align-instantiation-ports (region-beginning) (region-end))
  )

;;Align instantiation parameters and instantiation ports TOP
(defun my-do-instantiation ()
  (interactive)
  (my-select-autotemplate)
  (my-align-autotemplate (region-beginning) (region-end))
  (my-select-instantiation-parameters)
  (my-align-instantiation-parameters (region-beginning) (region-end))
  (my-select-instantiation-ports)
  (my-align-instantiation-ports (region-beginning) (region-end))
  )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


