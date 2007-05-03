;;; SBCL
#+sbcl
(progn
  (require 'asdf)
  (require 'stumpwm))
#+sbcl 
(progn
  (load "stumpwm.asd")
  (sb-ext:save-lisp-and-die "stumpwm" :toplevel #'stumpwm:stumpwm :executable t))

;;; CLISP

;; a custom loader for clisp. It beats trying to look for asdf, for now.
#+clisp
(let ((files '("package.lisp" "primitives.lisp" "keysyms.lisp" "keytrans.lisp" "kmap.lisp" "input.lisp" "core.lisp" "user.lisp" "mode-line.lisp" "stumpwm.lisp" "version.lisp")))
  (dolist (f files)
    (load (compile-file f))))

#+clisp
(progn
  (ext:saveinitmem "stumpwm" :init-function (lambda ()
                                              (stumpwm:stumpwm)
                                              (ext:quit))
                   :executable t :keep-global-handlers t :norc t :documentation "The StumpWM Executable"))


#-(or sbcl clisp) (error "This lisp implementation is not supported.")
