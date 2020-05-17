;;; Usage: /path/to/emacs -nw -Q -l /path/to/minimal-test.el

(toggle-debug-on-error)

(setq package-user-dir (format "%s/elpa--test-lsp-docker/%s" user-emacs-directory emacs-version))

(setq package-selected-packages
      '(
        use-package
        python
        lsp-mode
        lsp-docker
        ))

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(package-install-selected-packages)

(require 'package)
(defun list-installed-package ()
  (mapcar
   #'car
   (mapcar
    (lambda (p) (cons (package-desc-full-name p) p))
    (delq nil
          (mapcar (lambda (p) (unless (package-built-in-p p) p))
                  (apply #'append (mapcar #'cdr package-alist)))))))

;; ------------------------------------------------------------------

(require 'use-package)

(use-package lsp-mode)

(use-package python
  :init
  (add-hook 'python-mode-hook #'lsp))

(use-package lsp-docker
  ;; :defer t
  :config
  (defvar lsp-docker-client-packages
    '(lsp-css lsp-clients lsp-bash lsp-go lsp-pyls lsp-html lsp-typescript
              lsp-terraform lsp-cpp))

  (defvar lsp-docker-client-configs
    (list
     (list :server-id 'pyls :docker-server-id 'pyls-docker :server-command "pyls"
           )))
  (lsp-docker-init-clients
   :path-mappings `((,(file-truename "~/Developer/lsp-docker-test") . "/projects"))
   ;; :client-packages lsp-docker-client-packages
   ;; :docker-image-id "emacslsp/lsp-docker-full"
   :docker-image-id "my-lsp-docker-container:1.0"
   ;; :docker-container-name  "my-lsp-docker-container"
   :client-packages '(lsp-pyls)
   :client-configs lsp-docker-client-configs)
  )
