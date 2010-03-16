Content-Type: multipart/mixed; boundary="===============2378527868892944302=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] Add parser for file list objects
Date: Tue, 16 Mar 2010 11:44:24 -0700
Message-ID: <1268765064.2700.25.camel@localhost.localdomain>
In-Reply-To: <1268733700-30154-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2378527868892944302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  src/stkutil.h |    6 ++++++
>  2 files changed, 48 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index ceba2d5..9f3bc0b 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -406,6 +406,46 @@ static gboolean parse_dataobj_tone(struct comprehens=
ion_tlv_iter *iter,
>  	return TRUE;
>  }
>  =

> +/* Defined in TS 102.223 Section 8.18 */
> +static gboolean parse_dataobj_file_list(struct comprehension_tlv_iter *i=
ter,
> +						void *user)
> +{
> +	GSList **fl =3D user;
> +	const unsigned char *data;
> +	unsigned int len;
> +	unsigned int i;
> +	unsigned int start =3D 1;
> +	struct stk_file *sf;
> +
> +	if (comprehension_tlv_iter_get_tag(iter) !=3D
> +			STK_DATA_OBJECT_TYPE_FILE_LIST)
> +		return FALSE;
> +
> +	len =3D comprehension_tlv_iter_get_length(iter);
> +	if (len < 5)
> +		return FALSE;
> +
> +	data =3D comprehension_tlv_iter_get_data(iter);
> +
> +	if (data[start] !=3D 0x3f)
> +		return FALSE;
> +
> +	for (i =3D start + 4; i <=3D len; i +=3D 2) {
> +		if ((data[i] =3D=3D 0x3f) || (i =3D=3D len)) {
> +			sf =3D g_new0(struct stk_file, 1);
> +			sf->file =3D g_malloc(i-start);
> +			memcpy(sf->file, data+start, i-start);
> +			sf->len =3D i - start;
> +			*fl =3D g_slist_prepend(*fl, sf);
> +			start =3D i;
> +		}

doing a simple continue statement is way better.

	if (data[i] !=3D 0x3f && i !=3D len)
		continue;

Also there are not extra braces needed around expression in an if
statement. And i-start would have to be i - start.

When using g_new0 and g_malloc you result in exit on OOM. We try to
avoid that whenever possible. So I prefer using g_try_new0 and
g_try_malloc except there is a reason to just accept exit on OOM.

Personally the whole counting looks pretty complicated. I think it needs
either some documentation or made simpler.

Regards

Marcel



--===============2378527868892944302==--

