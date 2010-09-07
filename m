Content-Type: multipart/mixed; boundary="===============7561212482834095527=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Internal and Driver API changes for Send USSD
 proactive command
Date: Tue, 07 Sep 2010 09:54:51 -0500
Message-ID: <4C86523B.7060804@gmail.com>
In-Reply-To: <1283764886-17588-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7561212482834095527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/06/2010 04:21 AM, Jeevaka Badrappan wrote:
> ---
>  drivers/atmodem/atutil.c |  111 +++++++++++++++++++++++++++++++++++++
>  drivers/atmodem/atutil.h |   25 +++++++++
>  drivers/atmodem/ussd.c   |  136 +++++++++++++++++++++++++++++++---------=
------
>  drivers/isimodem/ussd.c  |   55 +++++++++++--------
>  include/types.h          |    2 +
>  include/ussd.h           |    8 ++-
>  plugins/atgen.c          |   59 ++++++++++++++++++++
>  plugins/phonesim.c       |   53 ++++++++++++++++++
>  src/call-barring.c       |    5 ++
>  src/call-forwarding.c    |    5 ++
>  src/call-settings.c      |    5 ++
>  src/ofono.h              |   26 +++++++++
>  src/smsutil.h            |    6 +-
>  src/ussd.c               |  131 +++++++++++++++++++++++++++++++++++++++-=
----
>  14 files changed, 541 insertions(+), 86 deletions(-)
> =

> diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
> index f566237..a3c3297 100644
> --- a/drivers/atmodem/atutil.c
> +++ b/drivers/atmodem/atutil.c
> @@ -341,3 +341,114 @@ gboolean at_util_parse_sms_index_delivery(GAtResult=
 *result, const char *prefix,
>  =

>  	return TRUE;
>  }
> +
> +int at_util_charset_string_to_charset(const char *charsetstr)
> +{

The preference is gboolean func(const char *charsetstr, enum
at_util_charset *ret)

> +	int charset =3D -1;
> +
> +	if (!g_strcmp0(charsetstr, "GSM"))
> +		charset =3D AT_UTIL_CHARSET_GSM;
> +	else if (!g_strcmp0(charsetstr, "HEX"))
> +		charset =3D AT_UTIL_CHARSET_HEX;
> +	else if (!g_strcmp0(charsetstr, "IRA"))
> +		charset =3D AT_UTIL_CHARSET_IRA;
> +	else if (!g_strcmp0(charsetstr, "PCCP437"))
> +		charset =3D AT_UTIL_CHARSET_PCCP437;
> +	else if (!g_strcmp0(charsetstr, "PCDN"))
> +		charset =3D AT_UTIL_CHARSET_PCDN;
> +	else if (!g_strcmp0(charsetstr, "UCS2"))
> +		charset =3D AT_UTIL_CHARSET_UCS2;
> +	else if (!g_strcmp0(charsetstr, "UTF-8"))
> +		charset =3D AT_UTIL_CHARSET_UTF8;
> +	else if (!g_strcmp0(charsetstr, "8859-1"))
> +		charset =3D AT_UTIL_CHARSET_8859_1;
> +	else if (!g_strcmp0(charsetstr, "8859-2"))
> +		charset =3D AT_UTIL_CHARSET_8859_2;
> +	else if (!g_strcmp0(charsetstr, "8859-3"))
> +		charset =3D AT_UTIL_CHARSET_8859_3;
> +	else if (!g_strcmp0(charsetstr, "8859-4"))
> +		charset =3D AT_UTIL_CHARSET_8859_4;
> +	else if (!g_strcmp0(charsetstr, "8859-5"))
> +		charset =3D AT_UTIL_CHARSET_8859_5;
> +	else if (!g_strcmp0(charsetstr, "8859-6"))
> +		charset =3D AT_UTIL_CHARSET_8859_6;
> +	else if (!g_strcmp0(charsetstr, "8859-C"))
> +		charset =3D AT_UTIL_CHARSET_8859_C;
> +	else if (!g_strcmp0(charsetstr, "8859-A"))
> +		charset =3D AT_UTIL_CHARSET_8859_A;
> +	else if (!g_strcmp0(charsetstr, "8859-G"))
> +		charset =3D AT_UTIL_CHARSET_8859_G;
> +	else if (!g_strcmp0(charsetstr, "8859-H"))
> +		charset =3D AT_UTIL_CHARSET_8859_H;
> +
> +	return charset;
> +}
> +
> +gboolean at_util_parse_charsets(GAtResult *result, int *supported)
> +{

Maybe name this into at_util_parse_cscs_supported?

> +	GAtResultIter iter;
> +	const char *charset;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSCS:"))
> +		return FALSE;
> +
> +	/* Some modems don't report CSCS in a proper list */
> +	g_at_result_iter_open_list(&iter);
> +
> +	while (g_at_result_iter_next_string(&iter, &charset)) {
> +		if (!g_strcmp0(charset, "GSM"))
> +			*supported |=3D AT_UTIL_CHARSET_GSM;
> +		else if (!g_strcmp0(charset, "HEX"))
> +			*supported |=3D AT_UTIL_CHARSET_HEX;
> +		else if (!g_strcmp0(charset, "IRA"))
> +			*supported |=3D AT_UTIL_CHARSET_IRA;
> +		else if (!g_strcmp0(charset, "PCCP437"))
> +			*supported |=3D AT_UTIL_CHARSET_PCCP437;
> +		else if (!g_strcmp0(charset, "PCDN"))
> +			*supported |=3D AT_UTIL_CHARSET_PCDN;
> +		else if (!g_strcmp0(charset, "UCS2"))
> +			*supported |=3D AT_UTIL_CHARSET_UCS2;
> +		else if (!g_strcmp0(charset, "UTF-8"))
> +			*supported |=3D AT_UTIL_CHARSET_UTF8;
> +		else if (!g_strcmp0(charset, "8859-1"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_1;
> +		else if (!g_strcmp0(charset, "8859-2"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_2;
> +		else if (!g_strcmp0(charset, "8859-3"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_3;
> +		else if (!g_strcmp0(charset, "8859-4"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_4;
> +		else if (!g_strcmp0(charset, "8859-5"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_5;
> +		else if (!g_strcmp0(charset, "8859-6"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_6;
> +		else if (!g_strcmp0(charset, "8859-C"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_C;
> +		else if (!g_strcmp0(charset, "8859-A"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_A;
> +		else if (!g_strcmp0(charset, "8859-G"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_G;
> +		else if (!g_strcmp0(charset, "8859-H"))
> +			*supported |=3D AT_UTIL_CHARSET_8859_H;

Can't you simply call at_util_charset_string_to_charset here?

> +	}
> +
> +	g_at_result_iter_close_list(&iter);
> +
> +	return TRUE;
> +}
> +
> +const char *at_util_parse_read_charset(GAtResult *result)
> +{

You might want to redo this function with the following signature:

gboolean at_util_parse_cscs_query(GAtResult *result, enum
at_util_charset *out)

> +	GAtResultIter iter;
> +	const char *str;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSCS:"))
> +        	return NULL;
> +
> +	g_at_result_iter_next_string(&iter, &str);
> +	return str;
> +}
> diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
> index 9e0a84b..4bc30fa 100644
> --- a/drivers/atmodem/atutil.h
> +++ b/drivers/atmodem/atutil.h
> @@ -27,6 +27,27 @@ enum at_util_sms_store {
>  	AT_UTIL_SMS_STORE_BM =3D	4,
>  };
>  =

> +/* 3GPP TS 27.007 Release 8 Section 5.5 */
> +enum at_util_charset {
> +	AT_UTIL_CHARSET_GSM     =3D 0,
> +	AT_UTIL_CHARSET_HEX     =3D 1,
> +	AT_UTIL_CHARSET_IRA     =3D 2,
> +	AT_UTIL_CHARSET_PCCP437 =3D 3,
> +	AT_UTIL_CHARSET_PCDN    =3D 4,
> +	AT_UTIL_CHARSET_UCS2    =3D 5,
> +	AT_UTIL_CHARSET_UTF8    =3D 6,
> +	AT_UTIL_CHARSET_8859_1  =3D 7,
> +	AT_UTIL_CHARSET_8859_2  =3D 8,
> +	AT_UTIL_CHARSET_8859_3  =3D 9,
> +	AT_UTIL_CHARSET_8859_4  =3D 10,
> +	AT_UTIL_CHARSET_8859_5  =3D 11,
> +	AT_UTIL_CHARSET_8859_6  =3D 12,
> +	AT_UTIL_CHARSET_8859_C  =3D 13,
> +	AT_UTIL_CHARSET_8859_A  =3D 14,
> +	AT_UTIL_CHARSET_8859_G  =3D 15,
> +	AT_UTIL_CHARSET_8859_H  =3D 16,
> +};
> +
>  void decode_at_error(struct ofono_error *error, const char *final);
>  gint at_util_call_compare_by_status(gconstpointer a, gconstpointer b);
>  gint at_util_call_compare_by_phone_number(gconstpointer a, gconstpointer=
 b);
> @@ -46,6 +67,10 @@ gboolean at_util_parse_sms_index_delivery(GAtResult *r=
esult, const char *prefix,
>  						enum at_util_sms_store *store,
>  						int *index);
>  =

> +int at_util_charset_string_to_charset(const char *charset);
> +gboolean at_util_parse_charsets(GAtResult *result, int *supported);
> +const char *at_util_parse_read_charset(GAtResult *result);
> +
>  struct cb_data {
>  	void *cb;
>  	void *data;

atutil.[ch] needs to be a separate patch.

> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index 1e1fc25..d3531bb 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -44,23 +44,39 @@
>  =

>  static const char *cusd_prefix[] =3D { "+CUSD:", NULL };
>  static const char *none_prefix[] =3D { NULL };
> +static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
>  =

>  struct ussd_data {
>  	GAtChat *chat;
>  	unsigned int vendor;
> +	int charset;
>  };
>  =

> +static void read_charset_cb(gboolean ok, GAtResult *result,
> +                            gpointer user_data)
> +{
> +	struct ussd_data *data =3D user_data;
> +	const char *charset =3D NULL;
> +
> +	if (!ok)
> +        	return;
> +
> +	charset =3D at_util_parse_read_charset(result);
> +
> +	if (charset)
> +		data->charset =3D at_util_charset_string_to_charset(charset);
> +}
> +
>  static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
>  {
>  	GAtResultIter iter;
>  	int status;
> -	int dcs;
>  	const char *content;
> -	char *converted =3D NULL;
> -	gboolean udhi;
> +	char *msg =3D NULL;
> +	long msg_len =3D 0;
> +	int dcs;
> +	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
>  	enum sms_charset charset;
> -	gboolean compressed;
> -	gboolean iso639;
>  =

>  	g_at_result_iter_init(&iter, result);
>  =

> @@ -73,34 +89,46 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
>  	if (!g_at_result_iter_next_string(&iter, &content))
>  		goto out;
>  =

> -	if (g_at_result_iter_next_number(&iter, &dcs)) {
> -		if (!cbs_dcs_decode(dcs, &udhi, NULL, &charset,
> -					&compressed, NULL, &iso639))
> -			goto out;
> -
> -		if (udhi || compressed || iso639)
> -			goto out;
> -	} else
> -		charset =3D SMS_CHARSET_7BIT;
> +	if (!g_at_result_iter_next_number(&iter, &dcs))
> +		goto out;
>  =

> -	if (charset =3D=3D SMS_CHARSET_7BIT)
> -		converted =3D convert_gsm_to_utf8((const guint8 *) content,
> -						strlen(content), NULL, NULL, 0);
> +	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset, NULL, NULL, NULL))
> +		goto out;
>  =

> -	else if (charset =3D=3D SMS_CHARSET_8BIT) {
> -		/* TODO: Figure out what to do with 8 bit data */
> +	if (charset =3D=3D SMS_CHARSET_7BIT) {
> +		switch (data->charset) {
> +		case AT_UTIL_CHARSET_GSM:
> +			msg =3D convert_gsm_to_utf8((const guint8 *) content,
> +		                      strlen(content), NULL, &msg_len, 0);
> +			break;
> +		case AT_UTIL_CHARSET_PCCP437:
> +		case AT_UTIL_CHARSET_PCDN:
> +		case AT_UTIL_CHARSET_8859_1:
> +		case AT_UTIL_CHARSET_IRA:
> +		default:
> +			DBG("charset:%d not supported", data->charset);
> +			status =3D 4; /* Not supported */
> +		}
> +	} else if (charset =3D=3D SMS_CHARSET_8BIT) {
> +		/* MT/TA converts each 8 bit octet into two IRA character
> +		* long hexadecimal number (e.g. octet with integer value 42
> +		* is presented to TE as two characters 2A (IRA 50 and 65))
> +		*/
>  		ofono_error("8-bit coded USSD response received");
>  		status =3D 4; /* Not supported */

If we're not handling 8BIT USSDs, what exactly is the point of this
exercise?

> -	} else {
> -		/* No other encoding is mentioned in TS27007 7.15 */
> +	}  else {

Whats up with the double space after the }?

> +		/* No other encoding is mentioned in TS27.007 7.15 */
>  		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
>  		status =3D 4; /* Not supported */
>  	}
>  =

>  out:
> -	ofono_ussd_notify(ussd, status, converted);
> +	if (!msg || !msg_len)
> +		status =3D OFONO_USSD_STATUS_NOTIFY;
>  =

> -	g_free(converted);
> +	ofono_ussd_notify(ussd, status, -1, (const guint8 *) msg, (int) msg_len=
);

Err, why are we passing UTF8 text as binary data + len?  I'm lost.  You
either do UTF8 always, or full binary always.

> +
> +	g_free(msg);
>  }
>  =

>  static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> @@ -117,14 +145,17 @@ static void cusd_request_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
>  	cusd_parse(result, ussd);
>  }
>  =

> -static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
> -				ofono_ussd_cb_t cb, void *user_data)
> +static void at_ussd_request(struct ofono_ussd *ussd, int dcs,
> +                            const unsigned char *str, int str_len,
> +                            ofono_ussd_cb_t cb, void *user_data)
>  {
>  	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
>  	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	int dcs_value =3D 0x0f;  // GSM 7 bit default alphabet
>  	unsigned char *converted =3D NULL;
> -	int dcs;
> -	int max_len;
> +	unsigned char coded_str[256];
> +	long coded_str_len;
> +	long num_packed;
>  	long written;
>  	char buf[256];
>  =

> @@ -133,40 +164,53 @@ static void at_ussd_request(struct ofono_ussd *ussd=
, const char *str,
>  =

>  	cbd->user =3D ussd;
>  =

> -	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
> +	if (dcs =3D=3D -1) {
> +		converted =3D convert_utf8_to_gsm((const char *) str, str_len, NULL, &=
written, 0);

Get rid of this.  The core either passes a raw USSD data or UTF8.
There's no mix and match here.

>  =

> -	if (!converted)
> -		goto error;
> -	else {
> -		dcs =3D 15;
> -		max_len =3D 182;
> -	}
> +		if (!converted)
> +			goto error;
>  =

> -	if (written > max_len)
> -		goto error;
> +		/* As per 3GPP TS 23.038, When this character set is used,
> +		 * the characters of the message are packed in octets as shown in sect=
ion 6.1.2.1.1,
> +		 * and the message can consist of up to 160 characters.
> +		 */
> +		pack_7bit_own_buf(converted, written, 0, TRUE,
> +                		      &num_packed, 0, coded_str);

CUSD does not take packed GSM data, so I'm lost here

>  =

> -	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> -			(int) written, converted, dcs);
> +		g_free(converted);
> +		converted =3D NULL;
> +		coded_str_len =3D num_packed;
>  =

> -	g_free(converted);
> -	converted =3D NULL;
> +		if (coded_str_len > OFONO_MAX_USSD_LENGTH)
> +			goto error;
> +	} else {
> +		if (str_len > OFONO_MAX_USSD_LENGTH)
> +			goto error;
> +
> +		memcpy(coded_str, str, str_len);
> +		coded_str_len =3D str_len;
> +		dcs_value =3D dcs;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> +			 (int) coded_str_len, coded_str, dcs_value);
>  =

>  	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
>  		/* Ensure that the modem is using GSM character set. It
>  		 * seems it defaults to IRA and then umlauts are not
>  		 * properly encoded. The modem returns some weird from
> -		 * of Latin-1, but it is not really Latin-1 either. */
> +		 * of Latin-1, but it is not really Latin-1 either. =

> +		 */
>  		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
> -							NULL, NULL, NULL);
> +				NULL, NULL, NULL);
>  	}
>  =

>  	if (g_at_chat_send(data->chat, buf, cusd_prefix,
> -				cusd_request_cb, cbd, g_free) > 0)
> +		cusd_request_cb, cbd, g_free) > 0)
>  		return;
>  =

>  error:
>  	g_free(cbd);
> -	g_free(converted);
>  =

>  	CALLBACK_WITH_FAILURE(cb, user_data);
>  }
> @@ -244,9 +288,13 @@ static int at_ussd_probe(struct ofono_ussd *ussd, un=
signed int vendor,
>  	data =3D g_new0(struct ussd_data, 1);
>  	data->chat =3D g_at_chat_clone(chat);
>  	data->vendor =3D vendor;
> +	data->charset =3D -1;
>  =

>  	ofono_ussd_set_data(ussd, data);
>  =

> +	g_at_chat_send(chat, "AT+CSCS?", cscs_prefix, read_charset_cb, data,
> +			NULL);
> +
>  	g_at_chat_send(chat, "AT+CUSD=3D1", NULL, at_ussd_register, ussd, NULL);
>  =

>  	return 0;
> diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
> index 330a141..c02fc55 100644
> --- a/drivers/isimodem/ussd.c
> +++ b/drivers/isimodem/ussd.c
> @@ -74,7 +74,9 @@ static void ussd_parse(struct ofono_ussd *ussd, const v=
oid *restrict data,
>  {
>  	const unsigned char *msg =3D data;
>  	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
> -	char *converted =3D NULL;
> +	int msg_len =3D 0;
> +	int dcs =3D -1;
> +	unsigned char *coded_msg =3D NULL;
>  =

>  	if (!msg || len < 4)
>  		goto out;
> @@ -84,14 +86,11 @@ static void ussd_parse(struct ofono_ussd *ussd, const=
 void *restrict data,
>  	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
>  		goto out;
>  =

> -	converted =3D ussd_decode(msg[1], msg[3], msg + 4);
> -
> -	if (converted)
> -		status =3D OFONO_USSD_STATUS_NOTIFY;
> -
> +	dcs =3D msg[1];
> +	msg_len =3D msg[3];
> +	coded_msg =3D (guint8 *) msg+4;
>  out:
> -	ofono_ussd_notify(ussd, status, converted);
> -	g_free(converted);
> +	ofono_ussd_notify(ussd, status, dcs, coded_msg, msg_len);
>  }
>  =

>  =

> @@ -129,7 +128,7 @@ error:
>  }
>  =

>  static GIsiRequest *ussd_send(GIsiClient *client,
> -				uint8_t *str, size_t len,
> +				int dcs, uint8_t *str, size_t len,
>  				void *data, GDestroyNotify notify)
>  {
>  	const uint8_t msg[] =3D {
> @@ -138,7 +137,7 @@ static GIsiRequest *ussd_send(GIsiClient *client,
>  		0x01,		/* subblock count */
>  		SS_GSM_USSD_STRING,
>  		4 + len + 3,	/* subblock length */
> -		0x0f,		/* DCS */
> +		dcs,		/* DCS */
>  		len,		/* string length */
>  		/* USSD string goes here */
>  	};
> @@ -152,8 +151,9 @@ static GIsiRequest *ussd_send(GIsiClient *client,
>  				ussd_send_resp_cb, data, notify);
>  }
>  =

> -static void isi_request(struct ofono_ussd *ussd, const char *str,
> -				ofono_ussd_cb_t cb, void *data)
> +static void isi_request(struct ofono_ussd *ussd, int dcs,
> +                        const unsigned char *str, int str_len,
> +                        ofono_ussd_cb_t cb, void *data)
>  {
>  	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
>  	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
> @@ -162,24 +162,35 @@ static void isi_request(struct ofono_ussd *ussd, co=
nst char *str,
>  	unsigned char *converted =3D NULL;
>  	long num_packed;
>  	long written;
> +	int dcs_value =3D 0x0f; // GSM 7 bit default alphabet
>  =

>  	if (!cbd)
>  		goto error;
>  =

> -	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
> -	if (!converted)
> -		goto error;
> +	if (dcs =3D=3D -1) {
> +		converted =3D convert_utf8_to_gsm((const char *) str, str_len, NULL, &=
written, 0);
>  =

> -	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
> -					&num_packed, 0, buf);
> +		if (!converted)
> +			goto error;
>  =

> -	g_free(converted);
> +		packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
> +				&num_packed, 0, buf);
>  =

> -	if (written > SS_MAX_USSD_LENGTH)
> -		goto error;
> +		g_free(converted);
>  =

> -	if (ussd_send(ud->client, packed, num_packed, cbd, g_free))
> -		return;
> +		if (written > SS_MAX_USSD_LENGTH)
> +			goto error;
> +
> +		if (ussd_send(ud->client, dcs_value, packed, num_packed, cbd, g_free))
> +			return;
> +	} else {
> +		dcs_value =3D dcs;
> +		if (str_len > SS_MAX_USSD_LENGTH)
> +			goto error;
> +
> +		if (ussd_send(ud->client, dcs_value, (guint8 *) str, str_len, cbd, g_f=
ree))
> +			return;
> +    	}
>  =

>  error:
>  	CALLBACK_WITH_FAILURE(cb, data);
> diff --git a/include/types.h b/include/types.h
> index 6098cba..e25ff02 100644
> --- a/include/types.h
> +++ b/include/types.h
> @@ -77,6 +77,8 @@ struct ofono_error {
>  };
>  =

>  #define OFONO_MAX_PHONE_NUMBER_LENGTH 20
> +#define OFONO_MAX_USSD_LENGTH 160
> +
>  =

>  struct ofono_phone_number {
>  	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
> diff --git a/include/ussd.h b/include/ussd.h
> index 96e04cb..e3b43f7 100644
> --- a/include/ussd.h
> +++ b/include/ussd.h
> @@ -45,13 +45,15 @@ struct ofono_ussd_driver {
>  	const char *name;
>  	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
>  	void (*remove)(struct ofono_ussd *ussd);
> -	void (*request)(struct ofono_ussd *ussd, const char *str,
> -				ofono_ussd_cb_t, void *data);
> +	void (*request)(struct ofono_ussd *ussd, int dcs,
> +                    const unsigned char *str, int str_len,
> +                    ofono_ussd_cb_t, void *data);
>  	void (*cancel)(struct ofono_ussd *ussd,
>  				ofono_ussd_cb_t cb, void *data);
>  };
>  =

> -void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *=
str);
> +void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
> +                       const unsigned char *str, int str_len);
>  =

>  int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
>  void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);
> diff --git a/plugins/atgen.c b/plugins/atgen.c
> index a6eee60..8d54c0a 100644
> --- a/plugins/atgen.c
> +++ b/plugins/atgen.c
> @@ -25,6 +25,8 @@
>  =

>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
>  =

>  #include <glib.h>
>  #include <gatchat.h>
> @@ -50,10 +52,14 @@
>  #include <ofono/voicecall.h>
>  =

>  #include <drivers/atmodem/sim-poll.h>
> +#include <drivers/atmodem/atutil.h>
>  =

>  #include <ofono/gprs.h>
>  #include <ofono/gprs-context.h>
>  =

> +static const char *none_prefix[] =3D { NULL };
> +static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
> +
>  static const char *tty_opts[] =3D {
>  	"Baud",
>  	"Read",
> @@ -66,6 +72,57 @@ static const char *tty_opts[] =3D {
>  	NULL,
>  };
>  =

> +static const char *best_charset(int supported)
> +{
> +	const char *charset =3D "Invalid";
> +
> +	if (supported & AT_UTIL_CHARSET_GSM)
> +		charset =3D "GSM";
> +
> +	if (supported & AT_UTIL_CHARSET_UTF8)
> +		charset =3D "UTF-8";
> +
> +	return charset;
> +}
> +
> +static void set_charset_cb(gboolean ok, GAtResult *result,
> +                                gpointer user_data)
> +{
> +	if (!ok)
> +		ofono_error("Setting character set failed");
> +}
> +
> +static void list_charsets_cb(gboolean ok, GAtResult *result,
> +                                        gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	const char *charset;
> +	int supported =3D 0;
> +	char buf[32];
> +
> +	if (!ok)
> +        	return;
> +
> +	if (!at_util_parse_charsets(result, &supported))
> +		return;
> +
> +	charset =3D best_charset(supported);
> +	snprintf(buf, sizeof(buf), "AT+CSCS=3D\"%s\"", charset);
> +
> +	if( !g_at_chat_send(chat, buf, none_prefix, set_charset_cb, modem, NULL=
))
> +		ofono_error("AT+CSCS=3D%s request failed", charset);
> +}
> +
> +static void list_charsets(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	if (!g_at_chat_send(chat, "AT+CSCS=3D?", cscs_prefix,
> +			list_charsets_cb, modem, NULL) > 0)
> +		ofono_error("AT+CSCS=3D? request failed");
> +}
> +
>  static int atgen_probe(struct ofono_modem *modem)
>  {
>  	return 0;
> @@ -172,6 +229,8 @@ static void atgen_pre_sim(struct ofono_modem *modem)
>  =

>  	if (sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
> +
> +	list_charsets(modem);
>  }
>  =


All atgen changes should be in a separate patch

>  static void atgen_post_sim(struct ofono_modem *modem)
> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index d3caa20..7c20786 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -64,6 +64,7 @@
>  #include <drivers/atmodem/atutil.h>
>  =

>  static const char *none_prefix[] =3D { NULL };
> +static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
>  =

>  struct phonesim_data {
>  	GAtMux *mux;
> @@ -72,6 +73,56 @@ struct phonesim_data {
>  	gboolean use_mux;
>  };
>  =

> +static const char *best_charset(int supported)
> +{
> +	const char *charset =3D "Invalid";
> +
> +	if (supported & AT_UTIL_CHARSET_UCS2)
> +        	charset =3D "UCS2";
> +
> +	if (supported & AT_UTIL_CHARSET_GSM)
> +        	charset =3D "GSM";
> +
> +	return charset;
> +}
> +
> +static void set_charset_cb(gboolean ok, GAtResult *result,
> +						gpointer user_data)
> +{
> +	if (!ok)
> +		ofono_error("Setting character set failed");
> +}
> +
> +static void list_charsets_cb(gboolean ok, GAtResult *result,
> +                                gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct phonesim_data *data =3D ofono_modem_get_data(modem);
> +	const char *charset;
> +	int supported =3D 0;
> +	char buf[32];
> +
> +	if (!ok)
> +		return;
> +
> +	if (!at_util_parse_charsets(result, &supported))
> +		return;
> +
> +	charset =3D best_charset(supported);
> +	snprintf(buf, sizeof(buf), "AT+CSCS=3D\"%s\"", charset);
> +
> +	if (!g_at_chat_send(data->chat, buf, none_prefix, set_charset_cb, modem=
, NULL))
> +		ofono_error("Setting charset: %s failed", charset);
> +	}
> +
> +static void list_charsets(struct ofono_modem *modem)
> +{
> +	struct phonesim_data *data =3D ofono_modem_get_data(modem);
> +	if (!g_at_chat_send(data->chat, "AT+CSCS=3D?", cscs_prefix,
> +                            list_charsets_cb, modem, NULL))
> +		ofono_error("AT+CSCS=3D? request failed");
> +}
> +
>  static int phonesim_probe(struct ofono_modem *modem)
>  {
>  	struct phonesim_data *data;
> @@ -321,6 +372,8 @@ static void phonesim_pre_sim(struct ofono_modem *mode=
m)
>  =

>  	if (sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
> +
> +	list_charsets(modem);
>  }
>  =


phonesim changes should be in a separate patch.

>  static void phonesim_post_sim(struct ofono_modem *modem)
> diff --git a/src/call-barring.c b/src/call-barring.c
> index 7607f3f..a0ac689 100644
> --- a/src/call-barring.c
> +++ b/src/call-barring.c
> @@ -580,6 +580,11 @@ static void cb_unregister_ss_controls(struct ofono_c=
all_barring *cb)
>  	__ofono_ussd_passwd_unregister(cb->ussd, "353");
>  }
>  =

> +gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb)
> +{
> +	return cb->pending ? TRUE : FALSE;
> +}
> +
>  static inline void cb_append_property(struct ofono_call_barring *cb,
>  					DBusMessageIter *dict, int start,
>  					int end, int cls, const char *property)

This should be in a separate patch along with the declaration in ofono.h.

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 4e77144..3e9265b 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -1092,6 +1092,11 @@ static void cf_unregister_ss_controls(struct ofono=
_call_forwarding *cf)
>  	__ofono_ussd_ssc_unregister(cf->ussd, "004");
>  }
>  =

> +gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *c=
f)
> +{
> +	return cf->pending ? TRUE : FALSE;
> +}
> +

This should be in a separate patch along with the declaration in ofono.h.

>  int ofono_call_forwarding_driver_register(const struct ofono_call_forwar=
ding_driver *d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);
> diff --git a/src/call-settings.c b/src/call-settings.c
> index ab20062..9c536e9 100644
> --- a/src/call-settings.c
> +++ b/src/call-settings.c
> @@ -778,6 +778,11 @@ static void cs_unregister_ss_controls(struct ofono_c=
all_settings *cs)
>  		__ofono_ussd_ssc_unregister(cs->ussd, "77");
>  }
>  =

> +gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs)
> +{
> +	return cs->pending ? TRUE : FALSE;
> +}
> +

This should be in a separate patch along with the declaration in ofono.h.

>  static DBusMessage *generate_get_properties_reply(struct ofono_call_sett=
ings *cs,
>  							DBusMessage *msg)
>  {
> diff --git a/src/ofono.h b/src/ofono.h
> index d95f2f2..43368d5 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -163,9 +163,18 @@ gboolean __ofono_modem_remove_atom_watch(struct ofon=
o_modem *modem,
>  void __ofono_atom_free(struct ofono_atom *atom);
>  =

>  #include <ofono/call-barring.h>
> +
> +gboolean __ofono_call_barring_is_busy(struct ofono_call_barring *cb);
> +
>  #include <ofono/call-forwarding.h>
> +
> +gboolean __ofono_call_forwarding_is_busy(struct ofono_call_forwarding *c=
f);
> +
>  #include <ofono/call-meter.h>
>  #include <ofono/call-settings.h>
> +
> +gboolean __ofono_call_settings_is_busy(struct ofono_call_settings *cs);
> +
>  #include <ofono/cbs.h>
>  #include <ofono/devinfo.h>
>  #include <ofono/phonebook.h>
> @@ -235,6 +244,13 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ss=
n *ssn, int id);
>  =

>  #include <ofono/ussd.h>
>  =

> +enum ofono_ussd_failure{
> +	OFONO_USSD_FAILURE_NONE =3D 0x0,
> +	OFONO_USSD_FAILURE_USER_TERMINATED,
> +	OFONO_USSD_FAILURE_RETURN_ERROR,
> +	OFONO_USSD_FAILURE_TIMED_OUT,
> +};
> +

Please check the coding-style.txt document for enum declarations.

>  typedef gboolean (*ofono_ussd_ssc_cb_t)(int type,
>  					const char *sc,
>  					const char *sia, const char *sib,
> @@ -245,6 +261,10 @@ typedef gboolean (*ofono_ussd_passwd_cb_t)(const cha=
r *sc,
>  					const char *old, const char *new,
>  					DBusMessage *msg, void *data);
>  =

> +typedef void (*ofono_ussd_request_cb_t)(int error, int dcs,
> +                                        const unsigned char *str,
> +                                        int str_len, void *data);
> +
>  gboolean __ofono_ussd_ssc_register(struct ofono_ussd *ussd, const char *=
sc,
>  					ofono_ussd_ssc_cb_t cb, void *data,
>  					ofono_destroy_func destroy);
> @@ -255,6 +275,12 @@ gboolean __ofono_ussd_passwd_register(struct ofono_u=
ssd *ussd, const char *sc,
>  					ofono_destroy_func destroy);
>  void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char =
*sc);
>  =

> +gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
> +
> +int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
> +                          const unsigned char *str, int str_len,
> +                          ofono_ussd_request_cb_t cb, void *user_data);
> +
>  #include <ofono/netreg.h>
>  =

>  typedef void (*ofono_netreg_status_notify_cb_t)(int status, int lac, int=
 ci,
> diff --git a/src/smsutil.h b/src/smsutil.h
> index 3c6b3ae..a29dbb3 100644
> --- a/src/smsutil.h
> +++ b/src/smsutil.h
> @@ -148,9 +148,9 @@ enum sms_class {
>  };
>  =

>  enum sms_charset {
> -	SMS_CHARSET_7BIT =3D 0,
> -	SMS_CHARSET_8BIT =3D 1,
> -	SMS_CHARSET_UCS2 =3D 2,
> +	SMS_CHARSET_7BIT =3D 0x00,
> +	SMS_CHARSET_8BIT =3D 0x04,
> +	SMS_CHARSET_UCS2 =3D 0x08,

Please don't mess with this enum, the USSD DCS has nothing to do with SMS.

>  };
>  =

>  enum sms_mwi_type {
> diff --git a/src/ussd.c b/src/ussd.c
> index 825d560..465272c 100644
> --- a/src/ussd.c
> +++ b/src/ussd.c
> @@ -34,6 +34,7 @@
>  #include "ofono.h"
>  =

>  #include "common.h"
> +#include "smsutil.h"
>  =

>  #define SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementaryService=
s"
>  =

> @@ -46,6 +47,15 @@ enum ussd_state {
>  	USSD_STATE_RESPONSE_SENT,
>  };
>  =

> +struct ussd_request {
> +	struct ofono_ussd *ussd;
> +	int dcs;
> +	unsigned char *str;
> +	int str_len;
> +	ofono_ussd_request_cb_t cb;
> +	void *user_data;
> +};
> +
>  struct ofono_ussd {
>  	int state;
>  	DBusMessage *pending;
> @@ -56,6 +66,7 @@ struct ofono_ussd {
>  	const struct ofono_ussd_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	struct ussd_request *req;
>  };
>  =

>  struct ssc_entry {
> @@ -306,15 +317,55 @@ static void ussd_change_state(struct ofono_ussd *us=
sd, int state)
>  			"State", DBUS_TYPE_STRING, &value);
>  }
>  =

> -void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *=
str)
> +static void ussd_request_finish(struct ofono_ussd *ussd, int error, int =
dcs,
> +                                const unsigned char *str, int str_len)
> +{
> +	struct ussd_request *req =3D ussd->req;
> +
> +	if (req && req->cb) {
> +		req->cb(error, dcs, str, str_len, req->user_data);
> +		g_free(req->str);
> +		g_free(req);
> +		ussd->req =3D NULL;
> +	}
> +}
> +
> +static int ussd_status_to_failure_code(int status)
> +{
> +	switch (status) {
> +	case OFONO_USSD_STATUS_TIMED_OUT:
> +		return OFONO_USSD_FAILURE_TIMED_OUT;
> +	case OFONO_USSD_STATUS_NOT_SUPPORTED:
> +		return OFONO_USSD_FAILURE_RETURN_ERROR;
> +	}
> +
> +	return OFONO_USSD_FAILURE_NONE;
> +}
> +
> +void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
> +                       const unsigned char *str, int str_len)
>  {
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
>  	const char *ussdstr =3D "USSD";
> +	const char *utf8_str =3D NULL;
>  	const char sig[] =3D { DBUS_TYPE_STRING, 0 };
>  	DBusMessage *reply;
>  	DBusMessageIter iter;
>  	DBusMessageIter variant;
>  =

> +	if (ussd->req &&
> +		(status =3D=3D OFONO_USSD_STATUS_NOTIFY ||
> +		status =3D=3D OFONO_USSD_STATUS_TERMINATED ||
> +		status =3D=3D OFONO_USSD_STATUS_TIMED_OUT ||
> +		status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED)) {
> +
> +		ussd_request_finish(ussd, ussd_status_to_failure_code(status),
> +                		    dcs, str, str_len);
> +
> +		ussd_change_state(ussd, USSD_STATE_IDLE);
> +		return;
> +	}
> +
>  	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
>  		ussd_change_state(ussd, USSD_STATE_IDLE);
>  =

> @@ -334,15 +385,24 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int=
 status, const char *str)
>  		reply =3D __ofono_error_timed_out(ussd->pending);
>  		goto out;
>  	}
> +	=

> +	if (str) {
> +		if (dcs =3D=3D -1)
> +			utf8_str =3D (const char *) str;
> +		else
> +			utf8_str =3D ussd_decode(dcs, str_len, str);
> +	}
> +
> +	if (!utf8_str) {
> +		utf8_str =3D "";
> +		status =3D OFONO_USSD_STATUS_NOTIFY;
> +	}
>  =

>  	/* TODO: Rework this in the Agent framework */
>  	if (ussd->state =3D=3D USSD_STATE_ACTIVE) {
>  =

>  		reply =3D dbus_message_new_method_return(ussd->pending);
>  =

> -		if (!str)
> -			str =3D "";
> -
>  		dbus_message_iter_init_append(reply, &iter);
>  =

>  		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
> @@ -352,7 +412,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
>  							&variant);
>  =

>  		dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING,
> -						&str);
> +                                       &utf8_str);
>  =

>  		dbus_message_iter_close_container(&iter, &variant);
>  =

> @@ -364,10 +424,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int =
status, const char *str)
>  	} else if (ussd->state =3D=3D USSD_STATE_RESPONSE_SENT) {
>  		reply =3D dbus_message_new_method_return(ussd->pending);
>  =

> -		if (!str)
> -			str =3D "";
> -
> -		dbus_message_append_args(reply, DBUS_TYPE_STRING, &str,
> +		dbus_message_append_args(reply, DBUS_TYPE_STRING, &utf8_str,
>  						DBUS_TYPE_INVALID);
>  =

>  		if (status =3D=3D OFONO_USSD_STATUS_ACTION_REQUIRED)
> @@ -387,9 +444,6 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
>  			signal_name =3D "NotificationReceived";
>  		}
>  =

> -		if (!str)
> -			str =3D "";
> -
>  		g_dbus_emit_signal(conn, path,
>  				SUPPLEMENTARY_SERVICES_INTERFACE, signal_name,
>  				DBUS_TYPE_STRING, &str, DBUS_TYPE_INVALID);
> @@ -436,6 +490,7 @@ static DBusMessage *ussd_initiate(DBusConnection *con=
n, DBusMessage *msg,
>  {
>  	struct ofono_ussd *ussd =3D data;
>  	const char *str;
> +	int dcs =3D -1;
>  =

>  	if (ussd->pending)
>  		return __ofono_error_busy(msg);
> @@ -465,7 +520,8 @@ static DBusMessage *ussd_initiate(DBusConnection *con=
n, DBusMessage *msg,
>  =

>  	ussd->pending =3D dbus_message_ref(msg);
>  =

> -	ussd->driver->request(ussd, str, ussd_callback, ussd);
> +	ussd->driver->request(ussd, dcs, (const guint8 *) str, strlen(str), =

> +                          ussd_callback, ussd);
>  =

>  	return NULL;
>  }
> @@ -496,6 +552,7 @@ static DBusMessage *ussd_respond(DBusConnection *conn=
, DBusMessage *msg,
>  {
>  	struct ofono_ussd *ussd =3D data;
>  	const char *str;
> +	int dcs =3D -1;
>  =

>  	if (ussd->pending)
>  		return __ofono_error_busy(msg);
> @@ -515,7 +572,8 @@ static DBusMessage *ussd_respond(DBusConnection *conn=
, DBusMessage *msg,
>  =

>  	ussd->pending =3D dbus_message_ref(msg);
>  =

> -	ussd->driver->request(ussd, str, ussd_response_callback, ussd);
> +	ussd->driver->request(ussd, dcs, (const guint8 *) str, strlen(str),
> +                          ussd_response_callback, ussd);
>  =

>  	return NULL;
>  }
> @@ -543,6 +601,9 @@ static void ussd_cancel_callback(const struct ofono_e=
rror *error, void *data)
>  	reply =3D dbus_message_new_method_return(ussd->cancel);
>  	__ofono_dbus_pending_reply(&ussd->cancel, reply);
>  =

> +	if (ussd->req)
> +		ussd_request_finish(ussd, -1, USSD_STATE_USER_ACTION, NULL, -1);
> +
>  	ussd_change_state(ussd, USSD_STATE_IDLE);
>  }
>  =

> @@ -741,3 +802,45 @@ void *ofono_ussd_get_data(struct ofono_ussd *ussd)
>  {
>  	return ussd->driver_data;
>  }
> +
> +static void ussd_request_callback(const struct ofono_error *error, void =
*data)
> +{
> +	struct ofono_ussd *ussd =3D data;
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
> +		ussd_request_finish(ussd, OFONO_USSD_FAILURE_RETURN_ERROR, -1, NULL, -=
1);
> +	else
> +		ussd_change_state(ussd,USSD_STATE_ACTIVE);
> +}
> +
> +gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd)
> +{
> +	if (ussd->pending || ussd->state !=3D USSD_STATE_IDLE || ussd->req)
> +		return TRUE;
> +
> +	return FALSE;
> +}
> +
> +int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
> +                          const unsigned char *str, int str_len,
> +                          ofono_ussd_request_cb_t cb, void *user_data)
> +{
> +	struct ussd_request *req;
> +
> +	if (!ussd->driver->request)
> +		return -ENOSYS;
> +
> +	req =3D g_try_new0(struct ussd_request, 1);
> +	req->dcs =3D dcs;
> +	req->str =3D g_memdup(str, str_len);
> +	req->str_len =3D str_len;
> +	req->cb =3D cb;
> +	req->user_data =3D user_data;
> +
> +	ussd->req =3D req;
> +
> +	ussd->driver->request(ussd, dcs, str, str_len, ussd_request_callback,
> +        	          ussd);
> +
> +	return 0;
> +}

Regards,
-Denis

--===============7561212482834095527==--

