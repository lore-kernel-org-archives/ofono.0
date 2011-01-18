Content-Type: multipart/mixed; boundary="===============1933237342048371755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] simutil: SIM applications directory decoding utils.
Date: Tue, 18 Jan 2011 13:22:29 -0600
Message-ID: <4D35E875.6080500@gmail.com>
In-Reply-To: <1295285934-9306-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1933237342048371755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/17/2011 11:38 AM, Andrzej Zaborowski wrote:
> ---
>  src/simutil.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/simutil.h |    2 ++
>  2 files changed, 59 insertions(+), 0 deletions(-)
> =

> diff --git a/src/simutil.c b/src/simutil.c
> index 8abf3d5..b3e2f52 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -1465,3 +1465,60 @@ gboolean sim_sst_is_active(unsigned char *efsst, u=
nsigned char len,
>  =

>  	return (efsst[index / 4] >> (((index % 4) * 2) + 1)) & 1;
>  }
> +
> +GSList *sim_parse_app_template_entries(const unsigned char *buffer, int =
len)
> +{
> +	GSList *ret =3D NULL;
> +	const unsigned char *dataobj;
> +	int dataobj_len;
> +
> +	/* Find all the application entries */
> +	while ((dataobj =3D ber_tlv_find_by_tag(buffer, 0x61, len,
> +						&dataobj_len)) !=3D NULL) {
> +		struct ofono_sim_app_record app;
> +		const unsigned char *aid, *label;
> +		int label_len;
> +
> +		/* Find the aid (mandatory) */
> +		aid =3D ber_tlv_find_by_tag(dataobj, 0x4f, dataobj_len,
> +						&app.aid_len);
> +		if (!aid || app.aid_len < 0x01 || app.aid_len > 0x10)
> +			goto error;
> +
> +		memcpy(app.aid, aid, app.aid_len);
> +
> +		/* Find the label (optional) */
> +		label =3D ber_tlv_find_by_tag(dataobj, 0x50, dataobj_len,
> +						&label_len);
> +		if (label) {
> +			/*
> +			 * Label field uses the extra complicated
> +			 * encoding in 102.221 Annex A
> +			 */
> +			app.label =3D sim_string_to_utf8(label, label_len);
> +
> +			if (app.label =3D=3D NULL)
> +				goto error;
> +		} else
> +			app.label =3D NULL;
> +
> +		ret =3D g_slist_prepend(ret, g_memdup(&app, sizeof(app)));
> +
> +		len -=3D (dataobj - buffer) + dataobj_len;
> +		buffer =3D dataobj + dataobj_len;
> +	}
> +
> +	return ret;
> +
> +error:
> +	while (ret) {
> +		GSList *t =3D ret;
> +
> +		g_free(((struct ofono_sim_app_record *) ret->data)->label);

Is there a memory leak here?  I don't believe you are freeing the
ofono_sim_app_record structure itself.  This might be the opportunity to
get rid of that nasty cast as well ;)

> +
> +		ret =3D ret->next;
> +		g_slist_free_1(t);
> +	}
> +
> +	return NULL;
> +}

Regards,
-Denis

--===============1933237342048371755==--

