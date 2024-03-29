;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(setq package-check-signature nil)
;;(package-initialize)

(if (string-match "XEmacs\\|Lucid" emacs-version)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; XEmacs
  ;;; ------
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (progn
     (if (file-readable-p "~/.xemacs/init.el")
        (load "~/.xemacs/init.el" nil t))
  )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; GNU-Emacs
  ;;; ---------
  ;;; load ~/.gnu-emacs or, if not exists /etc/skel/.gnu-emacs
  ;;; For a description and the settings see /etc/skel/.gnu-emacs
  ;;;   ... for your private ~/.gnu-emacs your are on your one.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if (file-readable-p "~/.gnu-emacs")
      (load "~/.gnu-emacs" nil t)
    (if (file-readable-p "/etc/skel/.gnu-emacs")
	(load "/etc/skel/.gnu-emacs" nil t)))

  ;; Custom Settings
  ;; ===============
  ;; To avoid any trouble with the customization system of GNU emacs
  ;; we set the default file ~/.gnu-emacs-custom
  (setq custom-file "~/.gnu-emacs-custom")
  (load "~/.gnu-emacs-custom" t t)

)
;;;关闭欢迎
(setq inhibit-splash-screen 1)

(put 'set-goal-column 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(setq cursor-type 'bar)
;;;(global-linum-mode 1)
;;;(setq inhibit-splash-screen 1)
(set-face-attribute 'default nil :height 120)
;;;主题
(load-theme 'monokai t)
(setq ;; foreground and background
      monokai-foreground     "#ABB2BF"
      monokai-background     "#282C34"
      ;; highlights and comments
      monokai-comments       "#F8F8F0"
      monokai-emphasis       "#282C34"
      monokai-highlight      "#FFB269"
      monokai-highlight-alt  "#66D9EF"
      monokai-highlight-line "#1B1D1E"
      monokai-line-number    "#F8F8F0"
      ;; colours
      monokai-blue           "#61AFEF"
      monokai-cyan           "#56B6C2"
      monokai-green          "#98C379"
      monokai-gray           "#3E4451"
      monokai-violet         "#C678DD"
      monokai-red            "#E06C75"
      monokai-orange         "#D19A66"
      monokai-yellow         "#E5C07B")

(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)
;;;最近打开文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key "\C-cs" 'swiper)

;;选中区域
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;多区域编辑                                                                                                                                                            
(global-set-key (kbd "C-c o") 'iedit-mode)                                                                                                                              
                                                                                                                                                                        
;;C-n C-p替换M-n M-p                                                                                                                                                    
(with-eval-after-load 'company                                                                                                                                          
  (define-key company-active-map (kbd "M-n") nil)                                                                                                                       
  (define-key company-active-map (kbd "M-p") nil)                                                                                                                       
  (define-key company-active-map (kbd "C-n") #'company-select-next)                                                                                                     
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;;for python配置
;; Fixing a key binding bug in elpy
;;(yas-reload-all)
;;(add-hook 'prog-mode-hook #'yas-minor-mode)
;;(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)

;; 设置 org-agenda 打开快捷键
;;(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

(delete-selection-mode 1)
(global-hungry-delete-mode t)
(fset 'yes-or-no-p 'y-or-n-p)

(global-company-mode 1)
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'org-mode-hook 'smartparens-mode)
;;括号高亮
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(add-hook 'prog-mode-hook 'show-paren-mode)
(add-hook 'org-mode-hook 'show-paren-mode)

(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))

(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
;;python
(setq tab-width 4)
(set-variable 'python-indent-offset 4)
(setq  python-indent-guess-indent-offset-verbose nil)

(put 'dired-find-alternate-file 'disabled nil)
;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
(require 'dired-x)
;;;
(setq-default make-backup-files nil)

;;
;;(global-auto-revert-mode 1)

(require 'org)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(setq org-directory "~/.emacs.d/org-file")

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/.emacs.d/org-file"))
(setq org-default-notes-file "~/.emacs.d/org-file/refile.org")

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

;; The tags are used to filter tasks in the agenda views conveniently
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/.emacs.d/org-file/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/.emacs.d/org-file/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file+datetree "~/.emacs.d/org-file/note.org")
               "* %T - %^{heading}\n %?\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/.emacs.d/org-file/diary.org")
;;             "* %?\n%U\n" :clock-in t :clock-resume t)
	       "* %T - %^{heading}\n  %?" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/.emacs.d/org-file/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/.emacs.d/org-file/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/.emacs.d/org-file/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/.emacs.d/org-file/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))
;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;; refile configurations
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
; (setq org-refile-targets (quote ((nil :maxlevel . 9)
;                                  (org-agenda-files :maxlevel . 9))))
; 
; ; Use full outline paths for refile targets - we file directly with IDO
; (setq org-refile-use-outline-path t)
; 
; ; Targets complete directly with IDO
; (setq org-outline-path-complete-in-steps nil)
; 
; ; Allow refile to create parent tasks with confirmation
; (setq org-refile-allow-creating-parent-nodes (quote confirm))
; 
; ; Use IDO for both buffer and file completion and ido-everywhere to t
; (setq org-completion-use-ido t)
; (setq ido-everywhere t)
; (setq ido-max-directory-size 100000)
; (ido-mode (quote both))
; ; Use the current window when visiting files and buffers with ido
; (setq ido-default-file-method 'selected-window)
; (setq ido-default-buffer-method 'selected-window)
; ; Use the current window for indirect buffer display
; (setq org-indirect-buffer-display 'current-window)
; 
; ;;;; Refile settings
; ; Exclude DONE state tasks from refile targets
; (defun bh/verify-refile-target ()
;   "Exclude todo keywords with a done state from refile targets"
;   (not (member (nth 2 (org-heading-components)) org-done-keywords)))
; 
; (setq org-refile-target-verify-function 'bh/verify-refile-target)
; 
; 

;;;custom agenda views

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              ("h" "Habits" tags-todo "STYLE=\"habit\""
               ((org-agenda-overriding-header "Habits")
                (org-agenda-sorting-strategy
                 '(todo-state-down effort-up category-keep))))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to Refile")
                       (org-tags-match-list-sublevels nil)))
                (tags-todo "-CANCELLED/!"
                           ((org-agenda-overriding-header "Stuck Projects")
                            (org-agenda-skip-function 'bh/skip-non-stuck-projects)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-HOLD-CANCELLED/!"
                           ((org-agenda-overriding-header "Projects")
                            (org-agenda-skip-function 'bh/skip-non-projects)
                            (org-tags-match-list-sublevels 'indented)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED/!NEXT"
                           ((org-agenda-overriding-header (concat "Project Next Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                            (org-tags-match-list-sublevels t)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Project Subtasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-REFILE-CANCELLED-WAITING-HOLD/!"
                           ((org-agenda-overriding-header (concat "Standalone Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-project-tasks)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-sorting-strategy
                             '(category-keep))))
                (tags-todo "-CANCELLED+WAITING|HOLD/!"
                           ((org-agenda-overriding-header (concat "Waiting and Postponed Tasks"
                                                                  (if bh/hide-scheduled-and-waiting-next-tasks
                                                                      ""
                                                                    " (including WAITING and SCHEDULED tasks)")))
                            (org-agenda-skip-function 'bh/skip-non-tasks)
                            (org-tags-match-list-sublevels nil)
                            (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
                            (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)))
                (tags "-REFILE/"
                      ((org-agenda-overriding-header "Tasks to Archive")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                       (org-tags-match-list-sublevels nil))))
               nil))))

(elpy-enable)

(require 'auto-virtualenvwrapper)
(add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate)
(add-hook 'projectile-after-switch-project-hook #'auto-virtualenvwrapper-activate) 
;; grammal check: flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);global enable
                    ; close flymake,  start flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; virutal environment:  virtualenvwrapper
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells)
(venv-initialize-eshell)
(setq venv-location "~/.emacs.d/py-file"); setup virtual environment folder
;; if there multiple folder:
;; (setq venv-location '("~/myvenv-1/"
;;                       "~/myvenv-2/"))
;; M-x venv-workon open virtual environment

;; enable elpy jedi backend
(setq elpy-rpc-backend "jedi")
;; 在python模式中自动启用
;;(add-hook 'python-mode-hook 'anaconda-mode)

;;
(defun kill-all-buffer ()
  "Kill all buffer."
  (interactive)
  (dolist (buffer (buffer-list)) (kill-buffer buffer)))

(defun kill-other-buffer ()
  "Close all of other buffer."
  (interactive)
  (dolist (buffer (delq (current-buffer) (buffer-list))) (kill-buffer buffer)))

(require 'gnuplot-mode)                                               
                                                                      
;; specify the gnuplot executable (if other than "gnuplot")           
(setq gnuplot-program "/usr/local/bin/gnuplot")                              
                                                                      
;; set gnuplot arguments (if other than "-persist")                   
(setq gnuplot-flags "-persist -pointsize 2")                          
                                                                      
;; if you want, add a mode hook.  e.g., the following turns on        
;; spell-checking for strings and comments and automatically cleans   
;; up whitespace on save.                                             
(add-hook 'gnuplot-mode-hook                                          
          (lambda ()                                                  
            (flyspell-prog-mode)                                      
            (add-hook 'before-save-hook                               
                      'whitespace-cleanup nil t)))
