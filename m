Content-Type: multipart/mixed; boundary="===============1242053577872081178=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH 1/2] stemodem: Create network interfaces statically
Date: Thu, 18 Nov 2010 09:03:08 +0100
Message-ID: <AANLkTinFtqvnFFts9uBqSrHbJzrrkToifuqYXbz+pK6Z@mail.gmail.com>
In-Reply-To: <1289760663-10334-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1242053577872081178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis & Marcel.

> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
>
> Changes:
> o Restructure code so interfaces are created statically when probe is cal=
led.
> o Removed some of the unnecessary initializations at declaration.
> o No longer reporting "default gateway" on PtP IP Interface.
> o Bugfix: Handle network initiated deactivation.
> ---
> =C2=A0drivers/stemodem/gprs-context.c | =C2=A0153 ++++++++++++++++++++++-=
----------------
> =C2=A01 files changed, 85 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-cont=
ext.c
> index 05fec3f..d8db23b 100644
> --- a/drivers/stemodem/gprs-context.c
> +++ b/drivers/stemodem/gprs-context.c

Have you received this patch in readable format?
I'm sending patches using git send-email over gmail,
and when I check sent items in gmail, it comes up as base64 encoded.
Is this garbled for you as well?

BTW are you using patchwork or similar so I could check the patch
status somewhere?

Regards,
Sjur

--===============1242053577872081178==--

