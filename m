Content-Type: multipart/mixed; boundary="===============0857852428602881350=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] add some length verification to avoid reading not
 owned memory
Date: Fri, 23 Mar 2012 12:09:11 -0700
Message-ID: <1332529751.1870.57.camel@aeonflux>
In-Reply-To: <1330417045-26518-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0857852428602881350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

please prefix the subject line with the files that get changed. So
something like push: would be good.

>  src/push.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> =

> diff --git a/src/push.c b/src/push.c
> index 6a54907..6107352 100644
> --- a/src/push.c
> +++ b/src/push.c
> @@ -351,13 +351,16 @@ gboolean mms_push_notify(unsigned char *pdu, unsign=
ed int len,
>  	/* Consume TID and Type */
>  	nread =3D 2;
>  =

> -	if (wsp_decode_uintvar(pdu + nread, len,
> +	if (wsp_decode_uintvar(pdu + nread, len - nread,
>  					&headerslen, &consumed) =3D=3D FALSE)
>  		return FALSE;
>  =

>  	/* Consume uintvar bytes */
>  	nread +=3D consumed;
>  =

> +	/* Check if content type could be read */
> +	if (headerslen > (len - nread))
> +		return FALSE;

No need for (len - nread). Just do > len - nread.

>  	/* Try to decode content-type */
>  	if (wsp_decode_content_type(pdu + nread, headerslen, &ct,
>  			&consumed, &param_len) =3D=3D FALSE)
> @@ -370,6 +373,9 @@ gboolean mms_push_notify(unsigned char *pdu, unsigned=
 int len,
>  	consumed +=3D param_len;
>  	nread +=3D consumed;
>  =

> +	/* Check if application_id could be read */
> +	if ((headerslen - consumed) > (len - nread))
> +		return FALSE;

Same here (headerslen - consumed > len - nread) is good enough.

>  	/* Parse header to decode application_id */
>  	wsp_header_iter_init(&iter, pdu + nread, headerslen - consumed, 0);
>  =


Regards

Marcel



--===============0857852428602881350==--

