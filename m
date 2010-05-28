Content-Type: multipart/mixed; boundary="===============3639570626828763536=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/11] Removed Siemens TC65 specific code.
Date: Fri, 28 May 2010 12:15:54 -0500
Message-ID: <201005281215.54788.denkenz@gmail.com>
In-Reply-To: <1274957690-4893-7-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3639570626828763536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> =

> ---
>  drivers/atmodem/sms.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index a1c885b..adaf4f2 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -561,9 +561,6 @@ static void at_cmgl_cpms_cb(gboolean ok, GAtResult
>  *result, gpointer user_data) struct ofono_sms *sms =3D req->sms;
>  	struct sms_data *data =3D ofono_sms_get_data(sms);
> =

> -	DBG("PASS AT+CMGL=3D4!!!");
> -	return;
> -
>  	if (!ok) {
>  		ofono_error("Initial CPMS request failed");
>  		at_cmgl_done(sms);
> =


In the future please don't send patches where one patch adds a piece of cod=
e =

and a later patch removes it.  It is very confusing :)

git rebase --interactive is very helpful tool for restructuring / re-orderi=
ng =

your patches for submission.

Regards,
-Denis

--===============3639570626828763536==--

