Content-Type: multipart/mixed; boundary="===============0228324236675747465=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/9] Add parser for cause objects
Date: Mon, 29 Mar 2010 17:14:36 -0500
Message-ID: <201003291714.36718.denkenz@gmail.com>
In-Reply-To: <1269879884-12741-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0228324236675747465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index ecd5639..8f4ff39 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -687,6 +687,39 @@ static gboolean parse_dataobj_event_list(
>  				STK_DATA_OBJECT_TYPE_EVENT_LIST);
>  }
> =

> +/* Defined in TS 102.223 Section 8.26 */
> +static gboolean parse_dataobj_cause(
> +		struct comprehension_tlv_iter *iter, void *user)
> +{
> +	struct stk_common_byte_array *array =3D user;
> +	const unsigned char *data;
> +	unsigned int len;
> +
> +	if (comprehension_tlv_iter_get_tag(iter) !=3D STK_DATA_OBJECT_TYPE_CAUS=
E)
> +		return FALSE;
> +
> +	len =3D comprehension_tlv_iter_get_length(iter);
> +	if ((len =3D=3D 1) || (len > 30))
> +		return FALSE;

So if we know the max length is 30 why do we bother g_mallocing here?

> +
> +	if (len =3D=3D 0) {
> +		array->len =3D 0;
> +		array->array =3D NULL;
> +		return TRUE;
> +	}

This won't work unfortunately.  Cause is an optional element and cause with =

length 0 has special meaning.  We will have to include a boolean variable f=
or =

presence information somehow.

Regards,
-Denis

--===============0228324236675747465==--

