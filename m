Content-Type: multipart/mixed; boundary="===============6088099892914568126=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] gatchat: add g_at_result_iter_next_number_or_void API
Date: Thu, 24 Feb 2011 07:56:49 -0800
Message-ID: <1298563009.2519.50.camel@aeonflux>
In-Reply-To: <1298562394-11475-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6088099892914568126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

>  gatchat/gatresult.c |   25 +++++++++++++++++++++++++
>  gatchat/gatresult.h |    2 ++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatresult.c b/gatchat/gatresult.c
> index 8a6dfae..0003f0b 100644
> --- a/gatchat/gatresult.c
> +++ b/gatchat/gatresult.c
> @@ -292,6 +292,31 @@ gboolean g_at_result_iter_next_number(GAtResultIter =
*iter, gint *number)
>  	return TRUE;
>  }
>  =

> +gboolean g_at_result_iter_next_number_or_void(GAtResultIter *iter, gint =
*number)
> +{
> +	unsigned int pos;
> +	int len;
> +	char *line;
> +
> +	if (iter =3D=3D NULL)
> +		return FALSE;
> +
> +	if (iter->l =3D=3D NULL)
> +		return FALSE;
> +
> +	line =3D iter->l->data;
> +	len =3D strlen(line);
> +
> +	pos =3D skip_to_next_field(line, iter->line_pos, len);
> +
> +	if (pos !=3D iter->line_pos) {
> +		iter->line_pos =3D pos;
> +		return TRUE;
> +	}

a general assumption is that if you return TRUE, you can assume that the
*number value is filled in properly. This is not the case anymore. So
you might need to give a default value in case it is void.

And that might mean we better do g_at_result_iter_next_number_default()
or something alike.

Or just having a peek function to check for an empty entry ahead before
calling g_at_result_iter_next_number() might be sufficient.

Regards

Marcel



--===============6088099892914568126==--

