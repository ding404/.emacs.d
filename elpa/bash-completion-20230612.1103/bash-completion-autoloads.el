;;; bash-completion-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "bash-completion" "bash-completion.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from bash-completion.el

(defun bash-completion-setup nil "\
Register bash completion for the shell buffer and shell command line.

This function adds `bash-completion-dynamic-complete' to the completion
function list of shell mode, `shell-dynamic-complete-functions'." (add-hook 'shell-dynamic-complete-functions #'bash-completion-dynamic-complete))

(autoload 'bash-completion-dynamic-complete "bash-completion" "\
Return the completion table for bash command at point.

This function is meant to be added into
`shell-dynamic-complete-functions'.  It uses `comint' to figure
out what the current command is and returns a completion table or
nil if no completions available.

When doing completion outside of a comint buffer, call
`bash-completion-dynamic-complete-nocomint' instead." nil nil)

(autoload 'bash-completion-capf-nonexclusive "bash-completion" "\
Bash completion function for `completion-at-point-functions'.

Returns the same list as the one returned by
`bash-completion-dynamic-complete-nocomint' appended with
\(:exclusive no) so that other completion functions are tried
when bash-completion fails to match the text at point." nil nil)

(autoload 'bash-completion-dynamic-complete-nocomint "bash-completion" "\
Return completion information for bash command at an arbitrary position.

The bash command to be completed begins at COMP-START in the
current buffer.  This must specify where the current command
starts, usually right after the prompt.

COMP-POS is the point where completion should happen, usually
just (point).  Note that a bash command can span across multiple
line, so COMP-START is not necessarily on the same line as
COMP-POS.

This function does not assume that the current buffer is a shell
or even comint buffer.  It can safely be called from any buffer
where a bash command appears, including `completion-at-point'.

If DYNAMIC-TABLE is passed a non-nil value, the resulting
collection will be a function that fetches the result lazily,
when it's called.

When calling from `completion-at-point', make sure to pass a
non-nil value to DYNAMIC-TABLE.  This isn't just an optimization:
returning a function instead of a list tells Emacs it should
avoids post-filtering the results and possibly discarding useful
completion from bash.

When calling from another completion engine, make sure to treat
the returned completion as reliable and not post-process them
further.

Returns (list stub-start stub-end completions) with
 - stub-start, the position at which the completed region starts
 - stub-end, the position at which the completed region ends
 - completions, a possibly empty list of completion candidates
   or a function, if DYNAMIC-TABLE is non-nil, a lambda such as the one
   returned by `completion-table-dynamic'

\(fn COMP-START &optional COMP-POS DYNAMIC-TABLE)" nil nil)

(autoload 'bash-completion-refresh "bash-completion" "\
Does nothing.

This command is obsolete and doesn't do anything useful anymore.
It used to refresh the copy of the completion table kept in
memory, but bash-completion.el now uses the completion table of
the Bash process directly." t nil)

(autoload 'bash-completion-reset "bash-completion" "\
Force the next completion command to start with a fresh BASH process.

This function kills any existing BASH completion process.  This
way, the next time BASH completion is requested, a new process
will be created with the latest configuration.  The BASH
completion process that will be killed depends on the
`default-directory' of the buffer where the command is executed.

Call this method if you have updated your .bashrc or any bash init scripts
and would like bash completion in Emacs to take these changes into account." t nil)

(register-definition-prefixes "bash-completion" '("bash-completion-"))

;;;***

;;;### (autoloads nil nil ("bash-completion-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; bash-completion-autoloads.el ends here
