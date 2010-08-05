Content-Type: multipart/mixed; boundary="===============2549073706478327490=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [PATCH v3 2/2] huawei: add gprs context
Date: Thu, 05 Aug 2010 10:29:51 -0700
Message-ID: <1281029391.19261.92.camel@localhost.localdomain>
In-Reply-To: <87fwytwqnt.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2549073706478327490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kale

On Thu, 2010-08-05 at 08:54 +0300, Kalle Valo wrote: =

> .... =

> >> Oh man, I have to fix my emacs settings :/
> >
> > Did you find a set of emacs offset settings to get to oFono's liking?
> > I've been fiddling with it for a while, but keep alking in circles
> > around it. It's been too long since I've done emacs config :(
> =

> This is my setup:
> =

> ; from linux/Documentation/CodingStyle
> (defun c-lineup-arglist-tabs-only (ignored)
>   "Line up argument lists by tabs, not spaces"
>   (let* ((anchor (c-langelem-pos c-syntactic-element))
> 	 (column (c-langelem-2nd-pos c-syntactic-element))
> 	 (offset (- (1+ column) anchor))
> 	 (steps (floor offset c-basic-offset)))
>     (* (max steps 1)
>        c-basic-offset)))

Thanks! Phew ... this is a handful of lisp! I don't understand anything
that is not basic anymore :) -- I gave it a whiz and one thing I saw was
that

struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
						GSList *list,
						unsigned int flags, unsigned msg_id,
						ofono_sms_msg_stch_cb_t stch_cb,
						void *data, ofono_destroy_func destroy)

is being formatted as:

struct tx_queue_entry *__ofono_sms_txq_submit(struct ofono_sms *sms,
					GSList *list,
					unsigned int flags, unsigned msg_id,
					ofono_sms_msg_stch_cb_t stch_cb,
					void *data, ofono_destroy_func destroy)

ie: one c-basic-offset less than it should -- I really can't figure out whe=
re to poke.

> (add-hook 'c-mode-common-hook
>           (lambda ()
>             ;; Add kernel style
>             (c-add-style
>              "linux-tabs-only"
>              '("linux" (c-offsets-alist
>                         (arglist-cont-nonempty
>                          c-lineup-gcc-asm-reg
>                          c-lineup-arglist-tabs-only))))))
> =

> And whenever I start editing ofono or connman, I run command "C-c .
> linux-tabs-only" choose the style. But it's not perfect yet, for example
> I need to manually add tabs when having multi-line function calls.
> =


I have a code snippet for automate the mode setting:

;; Initialization hook
(add-hook 'c-mode-common-hook 'c-select-style)

;; this looks at the path and based on the name, sets a style -- it =

;; is setup to my work habits -- I keep all my ofono work in
;; ~/something/ofono/ofono.git, kernel work in ~/something/linux/*..

(defun c-select-style ()
  (let
      ((style c-default-style))
    (if (string-match =

         "linux[^/]*"
         buffer-file-truename)
        (progn
          (c-set-style "linux")
          (setq indent-tabs-mode t)
          (setq c-basic-offset 8)
          (setq style "linux")
          )
      (if (string-match "ofono[^/]*/" buffer-file-truename)
          (progn
;; I renamed your c-style to 'ofono' so not to get confused :)
            (c-set-style "ofono")
            (setq indent-tabs-mode t)
            (setq c-basic-offset 8)
            (setq style "ofono")
            )
        ;; Default
        (progn
          (c-set-style "linux")
          (setq indent-tabs-mode t)
          (setq c-basic-offset 8)
          (setq style "ofono")
          )
        )
      )
    (setq c-indent-comments-syntactically-p t)
    (define-key c-mode-map "\C-m" 'c-context-line-break)
    (c-toggle-auto-hungry-state 1)
    (message (concat "C style set to " style))
    )
  )




--===============2549073706478327490==--

