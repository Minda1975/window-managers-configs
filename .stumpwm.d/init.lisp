;; -*-lisp-*-
;;
;; Here is a sample stumpwm config

(in-package :stumpwm)

;; Set message
(setq *startup-message* "^5Lisp ^2^bsystem operational.")

(ql:quickload :slynk)

(stumpwm:defcommand sly-start-server () ()
  "Start a slynk server for sly."
  (sb-thread:make-thread (lambda () (slynk:create-server :dont-close t))))

(stumpwm:defcommand sly-stop-server () ()
  "Stop current slynk server for sly."
  (sb-thread:make-thread (lambda () (slynk:stop-server 4005))))

;; Startup
(stumpwm:run-shell-command
 "xsetroot -cursor_name left_ptr")

(define-key *root-map* (kbd "Print")
  "exec import -window root png:$HOME/screenshot_$(date +%F_%H-%M-%S).png")

;; Termit
(define-key *root-map* (kbd "C") "exec termit")

; Module
(load-module "kbd-layouts")
(kbd-layouts:keyboard-layout-list "us" "lt" "ru")


;; window name format (truncate name after 20 letters)
(setf *window-format* "%m%n%s%20t")

;; Set up workspaces
(run-commands
  "gnewbg term"
  "gnew dev"
  "gnewbg web"
  "gnewbg media")
  

;; Set mode line colors
(setf *mode-line-background-color* "#232635")
(setf *mode-line-foreground-color* "#A6Accd")

;; Set modeline
(setf *window-format* "%m%n%s%c")
(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
(setf *time-modeline-string* "%a %b %e %k:%M")
(setf *mode-line-timeout* 2)
(enable-mode-line (current-screen) (current-head) t)

;;; -- Window Placement Rules --

(define-frame-preference "web"
    (0 T T :class "Firefox-esr"))

(define-frame-preference "dev"
      (0 T T :class "Emacs"))

(define-frame-preference "term"
    (0 T T :class "Termit"))

(define-frame-preference "media"
    (0 T T :class "XTerm"))
