Content-Type: multipart/mixed; boundary="===============1875587122892124027=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v3 2/2] huawei: add gprs context
Date: Thu, 05 Aug 2010 08:54:14 +0300
Message-ID: <87fwytwqnt.fsf@potku.valot.fi>
In-Reply-To: <1280951948.19261.63.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1875587122892124027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Inaky Perez-Gonzalez <inaky@linux.intel.com> writes:

> Hi Kale

Hi Inaky,

> On Thu, 2010-05-20 at 10:35 +0300, Kalle Valo wrote: =

>> Denis Kenzior <denkenz@gmail.com> writes:
>> =

>> > No mixing of tabs & spaces for indentation
>> =

>> Fixed.
>> =

>> Oh man, I have to fix my emacs settings :/
>
> Did you find a set of emacs offset settings to get to oFono's liking?
> I've been fiddling with it for a while, but keep alking in circles
> around it. It's been too long since I've done emacs config :(

This is my setup:

; from linux/Documentation/CodingStyle
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
	 (column (c-langelem-2nd-pos c-syntactic-element))
	 (offset (- (1+ column) anchor))
	 (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

And whenever I start editing ofono or connman, I run command "C-c .
linux-tabs-only" choose the style. But it's not perfect yet, for example
I need to manually add tabs when having multi-line function calls.

-- =

Kalle Valo

--===============1875587122892124027==--

