Content-Type: multipart/mixed; boundary="===============7945039975507390337=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] util: Add best dialect picker API
Date: Thu, 03 Feb 2011 14:39:00 -0600
Message-ID: <4D4B1264.3050102@gmail.com>
In-Reply-To: <1296739236-24391-4-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7945039975507390337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 02/03/2011 07:20 AM, Aki Niemi wrote:
> ---
>  src/util.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/util.h |    7 ++++++
>  2 files changed, 71 insertions(+), 0 deletions(-)

<snip>

> +unsigned char *convert_utf8_to_gsm_best_lang(const char *utf8, long len,
> +					long *items_read, long *items_written,
> +					unsigned char terminator,
> +					enum gsm_dialect hint,
> +					enum gsm_dialect *used_locking,
> +					enum gsm_dialect *used_single)
> +{
> +	enum gsm_dialect locking =3D GSM_DIALECT_DEFAULT;
> +	enum gsm_dialect single =3D GSM_DIALECT_DEFAULT;
> +	unsigned char *encoded;
> +
> +	encoded =3D convert_utf8_to_gsm_with_lang(utf8, len, items_read,
> +						items_written, terminator,
> +						locking, single);
> +	if (encoded !=3D NULL)
> +		return encoded;

So this was actually wrong since you were not setting used_locking or
used_single.

> +
> +	if (hint =3D=3D GSM_DIALECT_DEFAULT)
> +		return NULL;
> +
> +	single =3D hint;
> +	encoded =3D convert_utf8_to_gsm_with_lang(utf8, len, items_read,
> +						items_written, terminator,
> +						locking, single);
> +	if (encoded !=3D NULL)
> +		return encoded;

Same here

> +
> +	/* Spanish dialect uses the default locking shift table */
> +	if (hint =3D=3D GSM_DIALECT_SPANISH)
> +		return NULL;
> +
> +	locking =3D hint;
> +	encoded =3D convert_utf8_to_gsm_with_lang(utf8, len, items_read,
> +						items_written, terminator,
> +						locking, single);
> +
> +	if (encoded =3D=3D NULL)
> +		return NULL;
> +
> +	if (used_locking !=3D NULL)
> +		*used_locking =3D locking;
> +
> +	if (used_single !=3D NULL)
> +		*used_single =3D single;
> +
> +	return encoded;
> +}
> +

Applied and fixed in a follow on patch.

Regards,
-Denis

--===============7945039975507390337==--

