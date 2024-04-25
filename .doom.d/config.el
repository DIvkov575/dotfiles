(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/") (defun move-line-up () (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(setq dap-cpptools-extension-version "1.5.1")

(with-eval-after-load 'lsp-rust
(require 'dap-cpptools))

(with-eval-after-load 'dap-cpptools
(dap-register-debug-template "Rust::CppTools Run Configuration"
                                (list :type "cppdbg"
                                :request "launch"
                                :name "Rust::Run"
                                :MIMode "gdb"
                                :miDebuggerPath "rust-gdb"
                                :environment []
                                :program "${workspaceFolder}/target/debug/hello"
                                ;; :program "${workspaceFolder}/target/debug/hello / replace with binary"
                                :cwd "${workspaceFolder}"
                                :console "external"
                                :dap-compilation "cargo build"
                                :dap-compilation-dir "${workspaceFolder}")))

;; (with-eval-after-load 'dap-mode
;; (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
;; (dap-auto-configure-mode +1))

(evil-multiedit-default-keybinds)
(require 'evil-multiedit)
