Content-Type: multipart/mixed; boundary="===============5271310051253680753=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] Add parser for location information objects
Date: Wed, 24 Mar 2010 15:00:32 -0500
Message-ID: <201003241500.33124.denkenz@gmail.com>
In-Reply-To: <1269423347-15508-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5271310051253680753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/simutil.c |    2 +-
>  src/simutil.h |    1 +
>  src/stkutil.c |   32 ++++++++++++++++++++++++++++++++
>  src/stkutil.h |    9 +++++++++
>  4 files changed, 43 insertions(+), 1 deletions(-)
> =

> diff --git a/src/simutil.c b/src/simutil.c
> index d9383b7..65ffa36 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -538,7 +538,7 @@ static char *sim_network_name_parse(const unsigned ch=
ar
>  *buffer, int length, return ret;
>  }
> =

> -static void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
> +void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)

If this is becoming public api, then it should have a sim_ prefix like the =
rest =

of the functions in simutil.h.

>  {
>  	static const char digit_lut[] =3D "0123456789*#abd\0";
>  	guint8 digit;
> diff --git a/src/simutil.h b/src/simutil.h
> index 043c21f..09964a8 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -181,6 +181,7 @@ const struct sim_eons_operator_info
>  *sim_eons_lookup(struct sim_eons *eons, const char *mnc);
>  void sim_eons_free(struct sim_eons *eons);
> =

> +void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
>  struct sim_spdi *sim_spdi_new(const guint8 *tlv, int length);
>  gboolean sim_spdi_lookup(struct sim_spdi *spdi,
>  				const char *mcc, const char *mnc);
> diff --git a/src/stkutil.c b/src/stkutil.c
> index 9c83f49..a6b0284 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -519,6 +519,36 @@ error:
>  	return FALSE;
>  }
> =

> +/* Defined in TS 102.223 Section 8.19 */
> +static gboolean parse_dataobj_location_info(
> +		struct comprehension_tlv_iter *iter, void *user)
> +{
> +	struct stk_location_info *li =3D user;
> +	const unsigned char *data;
> +	unsigned int len;
> +
> +	if (comprehension_tlv_iter_get_tag(iter) !=3D
> +			STK_DATA_OBJECT_TYPE_LOCATION_INFO)
> +		return FALSE;
> +
> +	len =3D comprehension_tlv_iter_get_length(iter);
> +	if ((len !=3D 5) && (len !=3D 7) && (len !=3D 9))
> +		return FALSE;
> +
> +	data =3D comprehension_tlv_iter_get_data(iter);
> +
> +	parse_mcc_mnc(data, li->mcc, li->mnc);
> +	memcpy(li->lac_tac, data + 3, 2);
> +
> +	if (len >=3D 7)
> +		memcpy(li->cell_id, data+5, 2);
> +
> +	if (len =3D=3D 9)
> +		memcpy(li->ext_cell_id, data+7, 2);

See my comments below, these should be proper integers.  Make sure the byte-
ordering is correct.

> +
> +	return TRUE;
> +}
> +
>  /* Defined in TS 102.223 Section 8.31 */
>  static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *ite=
r,
>  					void *user)
> @@ -638,6 +668,8 @@ static dataobj_handler handler_for_type(enum
>  stk_data_object_type type) return parse_dataobj_tone;
>  	case STK_DATA_OBJECT_TYPE_FILE_LIST:
>  		return parse_dataobj_file_list;
> +	case STK_DATA_OBJECT_TYPE_LOCATION_INFO:
> +		return parse_dataobj_location_info;
>  	case STK_DATA_OBJECT_TYPE_ICON_ID:
>  		return parse_dataobj_icon_id;
>  	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
> diff --git a/src/stkutil.h b/src/stkutil.h
> index 93ac854..00c985a 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -345,6 +345,15 @@ struct stk_result {
>  	unsigned char *additional;
>  };
> =

> +/* Defined in TS 102.223 Section 8.19 */
> +struct stk_location_info {
> +	char mnc[OFONO_MAX_MNC_LENGTH + 1];
> +	char mcc[OFONO_MAX_MCC_LENGTH + 1];
> +	unsigned char lac_tac[2];

This should be just unsigned short

> +	unsigned char cell_id[2];

And this one

> +	unsigned char ext_cell_id[2];

And this one too

You also need a ofono_bool_t to signify the presence of lac/ci/ext_ci

> +};
> +
>  /* Define the struct of single file in TS102.223 Section 8.18.
>   * According to TS 11.11 Section 6.2, each file id has two bytes, and the
>   * maximum Dedicated File level is 2. So the maximum size of file is 8,
>  which
> =


Regards,
-Denis

--===============5271310051253680753==--

