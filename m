Content-Type: multipart/mixed; boundary="===============1893592569217900677=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/11] Enable status report.
Date: Fri, 28 May 2010 11:56:56 -0500
Message-ID: <201005281156.57071.denkenz@gmail.com>
In-Reply-To: <1274957690-4893-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1893592569217900677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> =

> ---
>  src/smsutil.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index e634764..2679cc2 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -2596,7 +2596,7 @@ GSList *sms_text_prepare(const char *utf8, guint16
>  ref, template.submit.rd =3D FALSE;
>  	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
>  	template.submit.rp =3D FALSE;
> -	template.submit.srr =3D FALSE;
> +	template.submit.srr =3D TRUE;
>  	template.submit.mr =3D 0;
>  	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
> =


I suggest that this be made a parameter passed to sms_text_prepare.

Regards,
-Denis

--===============1893592569217900677==--

