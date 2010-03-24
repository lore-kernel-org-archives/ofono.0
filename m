Content-Type: multipart/mixed; boundary="===============0277188457614785789=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] Add parser for imei objects
Date: Wed, 24 Mar 2010 12:38:36 -0500
Message-ID: <201003241238.37128.denkenz@gmail.com>
In-Reply-To: <1269423347-15508-5-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0277188457614785789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index a6b0284..3e423b5 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -549,6 +549,28 @@ static gboolean parse_dataobj_location_info(
>  	return TRUE;
>  }
> =

> +/* Defined in TS 102.223 Section 8.20 */
> +static gboolean parse_dataobj_imei(struct comprehension_tlv_iter *iter,
> +						void *user)
> +{
> +	char **imei =3D user;

So this one implies character data (e.g. string), but...

> +	const unsigned char *data;
> +	unsigned int len;
> +
> +	if (comprehension_tlv_iter_get_tag(iter) !=3D
> +			STK_DATA_OBJECT_TYPE_IMEI)
> +		return FALSE;
> +
> +	len =3D comprehension_tlv_iter_get_length(iter);
> +	if (len !=3D 8)
> +		return FALSE;
> +
> +	data =3D comprehension_tlv_iter_get_data(iter);
> +	memcpy(*imei, data, len);

Here you copy binary data into a string array.  Since IMEI is essentially b=
cd =

encoded I suggest you parse it into string form here.

> +
> +	return TRUE;
> +}
> +

Regards,
-Denis

--===============0277188457614785789==--

