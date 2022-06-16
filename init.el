;;; Configuração básica do Emacs

(setq inhibit-startup-message t)                      ; Tirando o buffer

(setq-default indent-tabs-mode t)
(setq-default tab-width 3)

(tool-bar-mode -1)                                    ; Oculta a barra de ferramentas
(menu-bar-mode -1)                                    ; Oculta a barra de menu
(scroll-bar-mode -1)                                  ; Oculta a barra de rolagem
(tooltip-mode -1)                                     ; Oculta dicas

(global-display-line-numbers-mode t)                  ; Ativa a numeração de linhas
(column-number-mode t)                                ; Ativa a numeração de colunas

;; Alertas visuais
(setq visible-bell t)                                 ; Ativa alertas visuais

;; Bordas
(set-fringe-mode 10)                                  ; Bordas laterais


;; Ajuste
(global-unset-key (kbd "C-z"))                        ; Desabilita Ctrzl-Z
(delete-selection-mode t)                             ; O texto digitado substitui a seleção

;; Rolaem mais suave
(setq mouse-whell-scroll-amount '(2 ((shift) . 1))    ; 2 linhas por vez
      mouse-whell-progressive-speed nil               ; Não acelera a rolagem
      mouse-whell-follow-mouse t                      ; Rola a janela sob o mouse
      scroll-step 1)                                  ; Rola uma linha com o teclado

;; Quebra de linha
(global-visual-line-mode t)

;; Fonte padrão
(set-face-attribute 'default nil :font "Roboto Mono" :height 120)

;; Função para criar um novo buffer
(defun yaba-new-buffer ()
  "Cria um novo buffer 'bem-vindo'."
  (interactive)
  (let ((yaba/buf (generate-new-buffer "bem-vindo")))
    (switch-to-buffer yaba/buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    yaba/buf))

;; Modo inicial
(setq initial-major-mode 'prog-mode)                  ; Emacs inicia no modo prog
(setq initial-buffer-choice 'yaba-new-buffer)

;; Verifica e inicia o package.el
(require 'package)

;; Definição de repositórios
(setq package-archives '(
			 ("melpa" . "https://melpa.org/packages/")
			 ("org"   . "https://orgmode.org/elpa/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))

;; Inicialização do sistema de pacotes
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; Instalação do use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package try
  :ensure t)

;; Instalação do auto-update
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (setq auto-package-update-show-preview t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "19:00")
  (add-hook 'auto-package-update-before-hook
				(lambda () (message "Vou dar uma atualizada agora parcero"))))

;; Customizando o buffer inicial
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome to Emacs my angel!")
  (setq dashboard-startup-banner "~/.emacs.d/banners/MidnightBSDLogo128x128.png")
  (setq dashboard-center-content t))

;; Checagem da syntaxe e autocomplete
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))

(use-package auto-complete
  :ensure t
  :init
  (progn
	 (ac-config-default)
	 (global-auto-complete-mode t)))

;;; Customização
(use-package all-the-icons
  :if (display-graphic-p))

(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'ascii))
  :bind
  (("C-~" . 'neotree-toggle)))

;; Color Theme
(use-package twilight-theme
  :ensure t
  :config
  (load-theme'twilight t))

;; Tipo de cursor
(setq-default cursor-type 'bar)
(set-cursor-color "#e76f51")

(use-package rainbow-delimiters
  :defer t)

(use-package highlight-parentheses
  :defer t
  :hook
  (prog-mode . highlight-parentheses-mode))

(use-package smartparens
    :ensure t
    :init
    (require 'smartparens-config)
    (smartparens-global-mode t)
    :config
    (show-smartparens-mode t))

;; Language
(use-package tree-sitter
  :ensure t)
(use-package tree-sitter-langs
  :ensure t)
(use-package tree-sitter-indent
  :ensure t)

(use-package ggtags
:ensure t
:config
(add-hook 'c-mode-common-hook
(lambda ()
(when (derived-mode-p 'c-mode 'c++-mode 'csharp-mode 'go-mode)
(ggtags-mode 1)))))





(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	'(ggtags c-mode c++-mode go-mode highlight-parentheses moody mood-line smartparens rainbow-delimiters doom-themes doom-modeline flycheck twilight-theme all-the-icons neotree auto-complete use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
