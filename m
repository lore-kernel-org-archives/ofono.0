Content-Type: multipart/mixed; boundary="===============5435861898870209233=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/12] atutil changes for parsing cscs query and cscs
 support
Date: Thu, 09 Sep 2010 09:45:17 -0500
Message-ID: <4C88F2FD.7080109@gmail.com>
In-Reply-To: <1284035516-21359-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5435861898870209233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/09/2010 07:31 AM, Jeevaka Badrappan wrote:
> ---
>  drivers/atmodem/atutil.c |   78 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/atmodem/atutil.h |   26 +++++++++++++++
>  2 files changed, 104 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index f566237..ffbcb6c 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -341,3 +341,81 @@ gboolean at_util_parse_sms_index_delivery(GAtResult =
*result, const char *prefix,
>  =

>  	return TRUE;
>  }
> +
> +gboolean at_util_charset_string_to_charset(const char *str,
> +					enum at_util_charset *charset)
> +{
> +	if (!g_strcmp0(str, "GSM"))
> +		*charset =3D AT_UTIL_CHARSET_GSM;
> +	else if (!g_strcmp0(str, "HEX"))
> +		*charset =3D AT_UTIL_CHARSET_HEX;
> +	else if (!g_strcmp0(str, "IRA"))
> +		*charset =3D AT_UTIL_CHARSET_IRA;
> +	else if (!g_strcmp0(str, "PCCP437"))
> +		*charset =3D AT_UTIL_CHARSET_PCCP437;
> +	else if (!g_strcmp0(str, "PCDN"))
> +		*charset =3D AT_UTIL_CHARSET_PCDN;
> +	else if (!g_strcmp0(str, "UCS2"))
> +		*charset =3D AT_UTIL_CHARSET_UCS2;
> +	else if (!g_strcmp0(str, "UTF-8"))
> +		*charset =3D AT_UTIL_CHARSET_UTF8;
> +	else if (!g_strcmp0(str, "8859-1"))
> +		*charset =3D AT_UTIL_CHARSET_8859_1;
> +	else if (!g_strcmp0(str, "8859-2"))
> +		*charset =3D AT_UTIL_CHARSET_8859_2;
> +	else if (!g_strcmp0(str, "8859-3"))
> +		*charset =3D AT_UTIL_CHARSET_8859_3;
> +	else if (!g_strcmp0(str, "8859-4"))
> +		*charset =3D AT_UTIL_CHARSET_8859_4;
> +	else if (!g_strcmp0(str, "8859-5"))
> +		*charset =3D AT_UTIL_CHARSET_8859_5;
> +	else if (!g_strcmp0(str, "8859-6"))
> +		*charset =3D AT_UTIL_CHARSET_8859_6;
> +	else if (!g_strcmp0(str, "8859-C"))
> +		*charset =3D AT_UTIL_CHARSET_8859_C;
> +	else if (!g_strcmp0(str, "8859-A"))
> +		*charset =3D AT_UTIL_CHARSET_8859_A;
> +	else if (!g_strcmp0(str, "8859-G"))
> +		*charset =3D AT_UTIL_CHARSET_8859_G;
> +	else if (!g_strcmp0(str, "8859-H"))
> +		*charset =3D AT_UTIL_CHARSET_8859_H;
> +	else
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
> +gboolean at_util_parse_cscs_supported(GAtResult *result, int *supported)
> +{
> +	GAtResultIter iter;
> +	const char *str;
> +	enum at_util_charset charset;
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSCS:"))
> +		return FALSE;
> +
> +	/* Some modems don't report CSCS in a proper list */
> +	g_at_result_iter_open_list(&iter);
> +
> +	while (g_at_result_iter_next_string(&iter, &str)) {
> +		if (at_util_charset_string_to_charset(str, &charset))
> +			*supported |=3D charset;

If you're going to do this, then you better make sure that the enum
values are setup for ORing.  Right now a modem supporting
AT_UTIL_CHARSET_8859_A will test positive to supporting UTF8, GSM, HEX,
PCCDN to name a few.

> +	}
> +
> +	g_at_result_iter_close_list(&iter);
> +
> +	return TRUE;
> +}
> +
> +gboolean at_util_parse_cscs_query(GAtResult *result, const char **charse=
t)

I suggest you do the conversion of string to the enum here and perhaps
make at_util_charset_string_to_charset static.

> +{
> +	GAtResultIter iter;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSCS:"))
> +		return FALSE;
> +
> +	return g_at_result_iter_next_string(&iter, charset);
> +}
> diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
> index 9e0a84b..845d8de 100644
> --- a/drivers/atmodem/atutil.h
> +++ b/drivers/atmodem/atutil.h
> @@ -27,6 +27,27 @@ enum at_util_sms_store {
>  	AT_UTIL_SMS_STORE_BM =3D	4,
>  };
>  =

> +/* 3GPP TS 27.007 Release 8 Section 5.5 */
> +enum at_util_charset {
> +	AT_UTIL_CHARSET_GSM     =3D 1,
> +	AT_UTIL_CHARSET_HEX     =3D 2,
> +	AT_UTIL_CHARSET_IRA     =3D 3,
> +	AT_UTIL_CHARSET_PCCP437 =3D 4,
> +	AT_UTIL_CHARSET_PCDN    =3D 5,
> +	AT_UTIL_CHARSET_UCS2    =3D 6,
> +	AT_UTIL_CHARSET_UTF8    =3D 7,
> +	AT_UTIL_CHARSET_8859_1  =3D 8,
> +	AT_UTIL_CHARSET_8859_2  =3D 9,
> +	AT_UTIL_CHARSET_8859_3  =3D 10,
> +	AT_UTIL_CHARSET_8859_4  =3D 11,
> +	AT_UTIL_CHARSET_8859_5  =3D 12,
> +	AT_UTIL_CHARSET_8859_6  =3D 13,
> +	AT_UTIL_CHARSET_8859_C  =3D 14,
> +	AT_UTIL_CHARSET_8859_A  =3D 15,
> +	AT_UTIL_CHARSET_8859_G  =3D 16,
> +	AT_UTIL_CHARSET_8859_H  =3D 17,
> +};

Please refer to doc/coding-style.txt Section M11 on the preferred coding
style.  Namely, use a single space after the enum name and before the
'=3D' and several tabs to align the enum value.  There should be plenty of
examples in stkutil.h...

> +
>  void decode_at_error(struct ofono_error *error, const char *final);
>  gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b);
>  gint at_util_call_compare_by_phone_number(gconstpointer a, gconstpointer=
 b);
> @@ -46,6 +67,11 @@ gboolean at_util_parse_sms_index_delivery(GAtResult *r=
esult, const char *prefix,
>  						enum at_util_sms_store *store,
>  						int *index);
>  =

> +gboolean at_util_charset_string_to_charset(const char *str,
> +						enum at_util_charset *charset);
> +gboolean at_util_parse_cscs_supported(GAtResult *result, int *supported);
> +gboolean at_util_parse_cscs_query(GAtResult *result, const char **charse=
t);
> +
>  struct cb_data {
>  	void *cb;
>  	void *data;

Regards,
-Denis

--===============5435861898870209233==--

