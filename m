Content-Type: multipart/mixed; boundary="===============2823628903021375528=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH] Fix: simplify isimodem call-barring driver.
Date: Wed, 24 Mar 2010 10:05:08 +0200
Message-ID: <1269417908.2505.2.camel@phoenix.elisa-laajakaista.fi>
In-Reply-To: <201003231653.14125.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2823628903021375528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ti, 2010-03-23 kello 22:53 +0100, ext Denis Kenzior kirjoitti:
> Secondly, please keep your patches whitespace clean, there are several ca=
ses =

> of spaces being used instead of tabs for indentation.

Pekka is an emacs guy, and emacs likes syntactic indentation a lot. I'm
using this custom mode with fairly good results:

(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-syntactic-indentation nil)
  (setq c-basic-offset 8))

Cheers,
Aki


--===============2823628903021375528==--

