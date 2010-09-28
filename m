Content-Type: multipart/mixed; boundary="===============8238902210075196959=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hso : swap username and password for PAP
Date: Mon, 27 Sep 2010 19:29:28 -0500
Message-ID: <4CA136E8.8050102@gmail.com>
In-Reply-To: <25022413.26143.1285591107292.JavaMail.www@wwinf8219>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8238902210075196959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Benoit,

On 09/27/2010 07:38 AM, Benoit Monin wrote:
> =

> The parameters for the AT command AT$QCPDPP must be swapped for PAP in or=
der
> to make to work with an Option modem. Tested with a GTM382 development ki=
t.
> No idea about CHAP parameters.
> ---
> drivers/hsomodem/gprs-context.c | 2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-cont=
ext.c
> index e1c94ad..dc6f1b6 100644
> --- a/drivers/hsomodem/gprs-context.c
> +++ b/drivers/hsomodem/gprs-context.c
> @@ -165,7 +165,7 @@ static void hso_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
> =

> if (ctx->username[0] && ctx->password[0])
> snprintf(buf, sizeof(buf), "AT$QCPDPP=3D%u,1,\"%s\",\"%s\"",
> - ctx->cid, ctx->username, ctx->password);
> + ctx->cid, ctx->password, ctx->username)
> else if (ctx->password[0])
> snprintf(buf, sizeof(buf), "AT$QCPDPP=3D%u,2,,\"%s\"",
> ctx->cid, ctx->password);

Your patch submission seems mangled:

Applying: hso : swap username and password for PAP
fatal: corrupt patch at line 11
Patch failed at 0001 hso : swap username and password for PAP
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

I went ahead and fixed this for you.

Regards,
-Denis

--===============8238902210075196959==--

