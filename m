Content-Type: multipart/mixed; boundary="===============2120438135428541968=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: Remove at_pin_send_puk_cb,
 and use at_pin_send_cb instead.
Date: Wed, 03 Nov 2010 14:37:46 +0100
Message-ID: <1288791466.9615.46.camel@aeonflux>
In-Reply-To: <1288785996-10991-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2120438135428541968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> When adding the use of pin event *EPEV also to at_pin_send_puk_cb,
> it becomes identical to at_pin_send_cb, and can be removed.
> ---
>  drivers/atmodem/sim.c |   44 +-------------------------------------------
>  1 files changed, 1 insertions(+), 43 deletions(-)

I am fine with this patch, but I have let Denis have a second look.
Since getting this right for IFX took me three attempts. Most likely
that was my own stupidity, but just in case ;)

Regards

Marcel



--===============2120438135428541968==--

