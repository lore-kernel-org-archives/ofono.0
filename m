Content-Type: multipart/mixed; boundary="===============0479127529183774124=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4] atmodem: Remove at_pin_send_puk_cb,
 and use at_pin_send_cb instead.
Date: Thu, 04 Nov 2010 10:41:08 +0100
Message-ID: <1288863668.9615.83.camel@aeonflux>
In-Reply-To: <1288862161-15704-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0479127529183774124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> When adding the use of pin event *EPEV also to at_pin_send_puk_cb,
> it becomes identical to at_pin_send_cb, and can be removed.
> ---
> Again, thank you for your patience, I really hope it's OK this time:)
> =

>  drivers/atmodem/sim.c |   34 +---------------------------------
>  1 files changed, 1 insertions(+), 33 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============0479127529183774124==--

