Content-Type: multipart/mixed; boundary="===============7533447271196957545=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Thu, 02 Sep 2010 11:55:04 -0500
Message-ID: <4C7FD6E8.206@gmail.com>
In-Reply-To: <1283413960-31490-2-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7533447271196957545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 09/02/2010 02:52 AM, Aki Niemi wrote:
> Add a new function allowing preparing a message list using alphabets.
> ---
>  src/smsutil.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  src/smsutil.h |   14 +++++++
>  2 files changed, 113 insertions(+), 9 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 0de420b..7da7022 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -2987,9 +2987,10 @@ static inline GSList *sms_list_append(GSList *l, c=
onst struct sms *in)
>   * @use_delivery_reports: value for the Status-Report-Request field
>   *     (23.040 3.2.9, 9.2.2.2)
>   */
> -GSList *sms_text_prepare(const char *utf8, guint16 ref,
> -				gboolean use_16bit, int *ref_offset,
> -				gboolean use_delivery_reports)
> +GSList *sms_text_prepare_with_alphabet(const char *utf8, guint16 ref,
> +					gboolean use_16bit, int *ref_offset,
> +					gboolean use_delivery_reports,
> +					enum sms_alphabet alphabet)
>  {
>  	struct sms template;
>  	int offset =3D 0;
> @@ -3008,9 +3009,93 @@ GSList *sms_text_prepare(const char *utf8, guint16=
 ref,
>  	template.submit.srr =3D use_delivery_reports;
>  	template.submit.mr =3D 0;
>  	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
> +	template.submit.udhi =3D FALSE;
> +
> +	/* UDHI, UDL, UD and DCS actually depend on what we have in
> +	 * the text.  For the different GSM dialects, we use only
> +	 * matching locking and single shift tables.  For example,
> +	 * turkish locking shift with spanish single shift is not
> +	 * supported. */
> +	switch (alphabet) {
> +

An empty line is not really needed here
> +	case SMS_ALPHABET_REDUCED:
> +		gsm_encoded =3D convert_utf8_to_gsm_with_translit(utf8, -1, NULL,
> +								&written, 0);
> +		break;
> +
> +	case SMS_ALPHABET_TURKISH:
> +		gsm_encoded =3D convert_utf8_to_gsm_with_lang(utf8, -1, NULL,
> +							&written, 0,
> +							GSM_DIALECT_TURKISH,
> +							GSM_DIALECT_TURKISH);
> +
> +		if (!gsm_encoded)
> +			 break;
> +
> +		if (offset =3D=3D 0)
> +			offset =3D 1;
> +
> +		template.submit.udhi =3D TRUE;
> +		template.submit.ud[0] +=3D 6;
> +		template.submit.ud[offset] =3D SMS_IEI_NATIONAL_LANGUAGE_SINGLE_SHIFT;
> +		template.submit.ud[offset + 1] =3D 1;
> +		template.submit.ud[offset + 2] =3D GSM_DIALECT_TURKISH;
> +		template.submit.ud[offset + 3] =3D SMS_IEI_NATIONAL_LANGUAGE_LOCKING_S=
HIFT;
> +		template.submit.ud[offset + 4] =3D 1;
> +		template.submit.ud[offset + 5] =3D GSM_DIALECT_TURKISH;
> +
> +		offset +=3D 6;
> +		break;
> +
> +	case SMS_ALPHABET_SPANISH:
> +		gsm_encoded =3D convert_utf8_to_gsm_with_lang(utf8, -1, NULL,
> +							&written, 0,
> +							GSM_DIALECT_DEFAULT,
> +							GSM_DIALECT_SPANISH);
> +
> +		if (!gsm_encoded)
> +			 break;
> +
> +		if (offset =3D=3D 0)
> +			offset =3D 1;
> +
> +		template.submit.udhi =3D TRUE;
> +		template.submit.ud[0] +=3D 3;
> +		template.submit.ud[offset] =3D SMS_IEI_NATIONAL_LANGUAGE_SINGLE_SHIFT;
> +		template.submit.ud[offset + 1] =3D 1;
> +		template.submit.ud[offset + 2] =3D GSM_DIALECT_SPANISH;
> +
> +		offset +=3D 3;
> +		break;
>  =

> -	/* UDHI, UDL, UD and DCS actually depend on what we have in the text */
> -	gsm_encoded =3D convert_utf8_to_gsm(utf8, -1, NULL, &written, 0);
> +	case SMS_ALPHABET_PORTUGUESE:
> +		gsm_encoded =3D convert_utf8_to_gsm_with_lang(utf8, -1, NULL,
> +							&written, 0,
> +							GSM_DIALECT_PORTUGUESE,
> +							GSM_DIALECT_PORTUGUESE);
> +
> +		if (!gsm_encoded)
> +			 break;
> +
> +		if (offset =3D=3D 0)
> +			offset =3D 1;
> +
> +		template.submit.udhi =3D TRUE;
> +		template.submit.ud[0] +=3D 6;
> +		template.submit.ud[offset] =3D SMS_IEI_NATIONAL_LANGUAGE_SINGLE_SHIFT;
> +		template.submit.ud[offset + 1] =3D 1;
> +		template.submit.ud[offset + 2] =3D GSM_DIALECT_PORTUGUESE;
> +		template.submit.ud[offset + 3] =3D SMS_IEI_NATIONAL_LANGUAGE_LOCKING_S=
HIFT;
> +		template.submit.ud[offset + 4] =3D 1;
> +		template.submit.ud[offset + 5] =3D GSM_DIALECT_PORTUGUESE;
> +
> +		offset +=3D 6;
> +		break;
> +
> +	case SMS_ALPHABET_DEFAULT:
> +	default:

Marcel likes it when the compiler warns of missing enum handlers.  So
the default statement should be removed.

> +		gsm_encoded =3D convert_utf8_to_gsm(utf8, -1, NULL, &written, 0);
> +	}
>  =

>  	if (!gsm_encoded) {
>  		gsize converted;
> @@ -3028,9 +3113,6 @@ GSList *sms_text_prepare(const char *utf8, guint16 =
ref,
>  	else
>  		template.submit.dcs =3D 0x08; /* Class Unspecified, UCS2 */
>  =

> -	if (offset !=3D 0)
> -		template.submit.udhi =3D FALSE;
> -

This part doesn't look right.  The check should actually set udhi to
TRUE, since we can be issuing a return in the next if statement...

>  	if (gsm_encoded && (written <=3D sms_text_capacity_gsm(160, offset))) {
>  		if (ref_offset)
>  			*ref_offset =3D 0;
> @@ -3056,7 +3138,7 @@ GSList *sms_text_prepare(const char *utf8, guint16 =
ref,
>  =

>  	template.submit.udhi =3D TRUE;
>  =

> -	if (!offset)
> +	if (offset =3D=3D 0)
>  		offset =3D 1;
>  =

>  	if (ref_offset)
> @@ -3150,6 +3232,14 @@ GSList *sms_text_prepare(const char *utf8, guint16=
 ref,
>  	return r;
>  }
>  =

> +GSList *sms_text_prepare(const char *utf8, guint16 ref,
> +				gboolean use_16bit, int *ref_offset,
> +				gboolean use_delivery_reports)
> +{
> +	return sms_text_prepare_with_alphabet(utf8, ref, use_16bit, ref_offset,
> +				use_delivery_reports, SMS_ALPHABET_DEFAULT);
> +}
> +
>  gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
>  			enum sms_charset *charset, gboolean *compressed,
>  			enum cbs_language *language, gboolean *iso639)
> diff --git a/src/smsutil.h b/src/smsutil.h
> index 3c6b3ae..e58332c 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -153,6 +153,15 @@ enum sms_charset {
>  	SMS_CHARSET_UCS2 =3D 2,
>  };
>  =

> +enum sms_alphabet {
> +	SMS_ALPHABET_DEFAULT =3D 0,
> +	SMS_ALPHABET_TURKISH,
> +	SMS_ALPHABET_SPANISH,
> +	SMS_ALPHABET_PORTUGUESE,
> +	SMS_ALPHABET_REDUCED,
> +	SMS_ALHPABET_INVALID,

Why is the INVALID part needed at all?

> +};
> +
>  enum sms_mwi_type {
>  	SMS_MWI_TYPE_VOICE =3D 0,
>  	SMS_MWI_TYPE_FAX =3D 1,
> @@ -516,6 +525,11 @@ void status_report_assembly_expire(struct status_rep=
ort_assembly *assembly,
>  					time_t before, GFunc foreach_func,
>  					gpointer data);
>  =

> +GSList *sms_text_prepare_with_alphabet(const char *utf8, guint16 ref,
> +					gboolean use_16bit, int *ref_offset,
> +					gboolean use_delivery_reports,
> +					enum sms_alphabet alphabet);
> +
>  GSList *sms_text_prepare(const char *utf8, guint16 ref,
>  				gboolean use_16bit, int *ref_offset,
>  				gboolean use_delivery_reports);

Do you have time to write unit tests for this as well?

Regards,
-Denis

--===============7533447271196957545==--

