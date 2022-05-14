;; -*-lisp-*-
;;
;; Here is a sample .stumpwmrc file

(in-package :stumpwm)

;; set prefix key
(set-prefix-key (kbd "C-z"))

;; startup message
(setf *startup-message* "^5    Stump Window Manager ^0has initialized!
Press ^2Ctrl+z ? ^0for Help. ^5Never Stop Hacking!^n
          Powered with ^02 Common Lisp ")
;; Startup
(stumpwm:run-shell-command
 "xsetroot -cursor_name left_ptr")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Swank settings                                                          ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require :swank)
(swank-loader:init)

(defparameter *port-number* 4004
  "My default port number for Swank")

(defvar *swank-server-p* nil
  "Keep track of swank server, turned off by default on startup")

(defcommand start-swank () ()
  "Start Swank if it is not already running"
  (if *swank-server-p*
      (message "Swank server is already active on Port^5 ~a^n" *port-number*)
      (progn
	(swank:create-server :port *port-number*
			     :style swank:*communication-style*
			     :dont-close t)
	(setf *swank-server-p* t)
	(message "Swank server is now active on Port^5 ~a^n.
Use^4 M-x slime-connect^n in Emacs. 
Type^2 (in-package :stumpwm)^n in Slime REPL." *port-number*))))

(defcommand stop-swank () ()
  "Stop Swank"
  (swank:stop-server *port-number*)
  (setf *swank-server-p* nil)
  (message "Stopping Swank Server! Closing Port^5 ~a^n." *port-number*))

(defcommand toggle-swank () ()
  (if *swank-server-p*
      (run-commands "stop-swank")
      (run-commands "start-swank")))

(define-key *top-map* (kbd "s-s") "toggle-swank")

;; Screenshot

(define-key *root-map* (kbd "Print")
"exec import -window root png:$HOME/screenshot_$(date +%F_%H-%M-%S).png")
;; Xterm
(define-key *root-map* (kbd "C") "exec xterm")

;; messages display time
(setf *timeout-wait* 7)

;; ignore window hints
(setf *ignore-wm-inc-hints* t)

;; window name format (truncate name after 20 letters)
(setf *window-format* "%m%n%s%20t")

;; input focus is transferred to the window you click on
(setf *mouse-focus-policy* :click)

;; message and input window location
(setf *message-window-gravity* :center)
(setf *input-window-gravity* :center)

;; message/input bar settings
(set-msg-border-width 3)
(setf *message-window-padding* 6)

;; Module
(load-module "kbd-layouts")
(kbd-layouts:keyboard-layout-list "us" "lt" "ru")
