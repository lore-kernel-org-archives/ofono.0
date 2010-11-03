Content-Type: multipart/mixed; boundary="===============6481668272003681566=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: Remove at_pin_send_puk_cb,
 and use at_pin_send_cb instead.
Date: Wed, 03 Nov 2010 15:40:54 +0100
Message-ID: <1288795254.9615.55.camel@aeonflux>
In-Reply-To: <1288794927-11647-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6481668272003681566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> When adding the use of pin event *EPEV also to at_pin_send_puk_cb,
> it becomes identical to at_pin_send_cb, and can be removed.
> ---
> New patch, this one should apply:)

please also do [PATCH v2] so we know which version it is. git am will
strip these nicely away from us.

>  drivers/atmodem/sim.c |   44 +-------------------------------------------
>  1 files changed, 1 insertions(+), 43 deletions(-)

Applying: atmodem: Remove at_pin_send_puk_cb, and use at_pin_send_cb instea=
d.
error: patch failed: drivers/atmodem/sim.c:647
error: drivers/atmodem/sim.c: patch does not apply
Patch failed at 0001 atmodem: Remove at_pin_send_puk_cb, and use at_pin_sen=
d_cb instead.

It does not apply.

Regards

Marcel



--===============6481668272003681566==--

