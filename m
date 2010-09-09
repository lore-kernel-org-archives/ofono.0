Content-Type: multipart/mixed; boundary="===============7810757970187664440=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/12] Internal and Driver api changes for Send USSD
 proactive command
Date: Thu, 09 Sep 2010 10:59:40 -0500
Message-ID: <4C89046C.5040106@gmail.com>
In-Reply-To: <1284035516-21359-12-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7810757970187664440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/09/2010 07:31 AM, Jeevaka Badrappan wrote:
> ---
>  drivers/atmodem/ussd.c  |   81 ++++++++++-----------
>  drivers/isimodem/ussd.c |   44 ++++--------
>  include/types.h         |    1 +
>  include/ussd.h          |    8 ++-
>  src/ofono.h             |   17 +++++
>  src/ussd.c              |  179 +++++++++++++++++++++++++++++++++++++++++=
+-----
>  6 files changed, 236 insertions(+), 94 deletions(-)

Please break this patch up into two.  One with the core driver changes
and one for implementing __ofono_ussd_initiate

> =

> diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
> index cb1515f..573417a 100644
> --- a/drivers/atmodem/ussd.c
> +++ b/drivers/atmodem/ussd.c
> @@ -67,15 +67,14 @@ static void read_charset_cb(gboolean ok, GAtResult *r=
esult,
>  =

>  static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
>  {
> +	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
>  	GAtResultIter iter;
>  	int status;
>  	int dcs;
>  	const char *content;
> -	char *converted =3D NULL;
> -	gboolean udhi;
>  	enum sms_charset charset;
> -	gboolean compressed;
> -	gboolean iso639;
> +	unsigned char msg[182];

The buffer should be 160 bytes no?

> +	long msg_len =3D 0;
>  =

>  	g_at_result_iter_init(&iter, result);
>  =

> @@ -89,33 +88,27 @@ static void cusd_parse(GAtResult *result, struct ofon=
o_ussd *ussd)
>  		goto out;
>  =

>  	if (g_at_result_iter_next_number(&iter, &dcs)) {
> -		if (!cbs_dcs_decode(dcs, &udhi, NULL, &charset,
> -					&compressed, NULL, &iso639))
> -			goto out;
> -
> -		if (udhi || compressed || iso639)
> +		if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
> +					NULL, NULL, NULL))
>  			goto out;
>  	} else
>  		charset =3D SMS_CHARSET_7BIT;
>  =

> -	if (charset =3D=3D SMS_CHARSET_7BIT)
> -		converted =3D convert_gsm_to_utf8((const guint8 *) content,
> -						strlen(content), NULL, NULL, 0);
> -
> -	else if (charset =3D=3D SMS_CHARSET_8BIT) {
> -		/* TODO: Figure out what to do with 8 bit data */
> -		ofono_error("8-bit coded USSD response received");
> -		status =3D 4; /* Not supported */
> -	} else {
> +	if (charset =3D=3D SMS_CHARSET_7BIT) {
> +		if (data->charset =3D=3D AT_UTIL_CHARSET_GSM)
> +			pack_7bit_own_buf((const guint8 *) content, =

> +					strlen(content), 0, TRUE,
> +					&msg_len, 0, msg);
> +	} else if (charset =3D=3D SMS_CHARSET_8BIT)
> +		decode_hex_own_buf(content, -1, &msg_len, 0, msg);
> +	else {
>  		/* No other encoding is mentioned in TS27007 7.15 */
>  		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
>  		status =3D 4; /* Not supported */
>  	}
>  =

>  out:
> -	ofono_ussd_notify(ussd, status, converted);
> -
> -	g_free(converted);
> +	ofono_ussd_notify(ussd, status, dcs, msg, (int) msg_len);

I don't think you need the cast here

>  }
>  =

>  static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> @@ -132,45 +125,50 @@ static void cusd_request_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
>  	cusd_parse(result, ussd);
>  }
>  =

> -static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
> +static void at_ussd_request(struct ofono_ussd *ussd, int dcs,
> +				const unsigned char *binary_data,
> +				int binary_data_len,
>  				ofono_ussd_cb_t cb, void *user_data)
>  {
>  	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
>  	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> -	unsigned char *converted =3D NULL;
> -	int dcs;
> -	int max_len;
> -	long written;
>  	char buf[256];
> +	long max_chars =3D 182;
> +	unsigned char *unpacked_buf =3D NULL;
> +	long written;
> +	enum sms_charset charset;
>  =

>  	if (!cbd)
>  		goto error;
>  =

>  	cbd->user =3D ussd;
> +        =

> +	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
> +					NULL, NULL, NULL))
> +		charset =3D SMS_CHARSET_7BIT;

Failing is fine here.  As a general rule, it is better to fail early.

>  =

> -	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
> -
> -	if (!converted)
> -		goto error;
> -	else {
> -		dcs =3D 15;
> -		max_len =3D 182;
> -	}
> +	if (charset =3D=3D SMS_CHARSET_7BIT) {
> +		unpacked_buf =3D unpack_7bit(binary_data, binary_data_len, 0,
> +						TRUE, max_chars, &written, 0);
>  =

> -	if (written > max_len)
> -		goto error;
> +		if ( !unpacked_buf || written <=3D 0)
> +			goto error;
>  =

> -	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> -			(int) written, converted, dcs);
> +		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> +				(int) written, unpacked_buf, dcs);
>  =

> -	g_free(converted);
> -	converted =3D NULL;
> +		g_free(unpacked_buf);
> +		unpacked_buf =3D NULL;
> +	} else =

> +		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
> +				binary_data_len, binary_data, dcs);

This should be hex encoded

>  =

>  	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
>  		/* Ensure that the modem is using GSM character set. It
>  		 * seems it defaults to IRA and then umlauts are not
>  		 * properly encoded. The modem returns some weird from
> -		 * of Latin-1, but it is not really Latin-1 either. */
> +		 * of Latin-1, but it is not really Latin-1 either.
> +		 */

Please send this as a separate cleanup patch

>  		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
>  							NULL, NULL, NULL);
>  	}
> @@ -181,7 +179,6 @@ static void at_ussd_request(struct ofono_ussd *ussd, =
const char *str,
>  =

>  error:
>  	g_free(cbd);
> -	g_free(converted);
>  =

>  	CALLBACK_WITH_FAILURE(cb, user_data);
>  }
> diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
> index 330a141..6ac945b 100644
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
> @@ -152,33 +151,18 @@ static GIsiRequest *ussd_send(GIsiClient *client,
>  				ussd_send_resp_cb, data, notify);
>  }
>  =

> -static void isi_request(struct ofono_ussd *ussd, const char *str,
> -				ofono_ussd_cb_t cb, void *data)
> +static void isi_request(struct ofono_ussd *ussd, int dcs,
> +			const unsigned char *binary_data, int binary_data_len,
> +			ofono_ussd_cb_t cb, void *data)
>  {
>  	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
>  	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
> -	unsigned char buf[256];
> -	unsigned char *packed =3D NULL;
> -	unsigned char *converted =3D NULL;
> -	long num_packed;
> -	long written;
>  =

>  	if (!cbd)
>  		goto error;
>  =

> -	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
> -	if (!converted)
> -		goto error;
> -
> -	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
> -					&num_packed, 0, buf);
> -
> -	g_free(converted);
> -
> -	if (written > SS_MAX_USSD_LENGTH)
> -		goto error;
> -
> -	if (ussd_send(ud->client, packed, num_packed, cbd, g_free))
> +	if (ussd_send(ud->client, dcs, (guint8 *) binary_data,
> +			binary_data_len, cbd, g_free))
>  		return;
>  =


This looks fine to me

>  error:
> diff --git a/include/types.h b/include/types.h
> index 6098cba..fbd3c6a 100644
> --- a/include/types.h
> +++ b/include/types.h
> @@ -77,6 +77,7 @@ struct ofono_error {
>  };
>  =

>  #define OFONO_MAX_PHONE_NUMBER_LENGTH 20
> +#define OFONO_MAX_USSD_LENGTH 160

This define is only being used by ussd.c.  If so, please move it out to
ussd.c and don't give it the OFONO_ prefix.

>  =

>  struct ofono_phone_number {
>  	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
> diff --git a/include/ussd.h b/include/ussd.h
> index 96e04cb..08dfc40 100644
> --- a/include/ussd.h
> +++ b/include/ussd.h
> @@ -45,13 +45,15 @@ struct ofono_ussd_driver {
>  	const char *name;
>  	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
>  	void (*remove)(struct ofono_ussd *ussd);
> -	void (*request)(struct ofono_ussd *ussd, const char *str,
> -				ofono_ussd_cb_t, void *data);
> +	void (*request)(struct ofono_ussd *ussd, int dcs,
> +			const unsigned char *binary_data, int binary_data_len,
> +			ofono_ussd_cb_t, void *data);
>  	void (*cancel)(struct ofono_ussd *ussd,
>  				ofono_ussd_cb_t cb, void *data);
>  };
>  =

> -void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *=
str);
> +void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
> +			const unsigned char *data, int data_len);
>  =

>  int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
>  void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);
> diff --git a/src/ofono.h b/src/ofono.h
> index 9b8d938..bc67c73 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -244,6 +244,13 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ss=
n *ssn, int id);
>  =

>  #include <ofono/ussd.h>
>  =

> +enum ofono_ussd_failure {
> +	OFONO_USSD_FAILURE_NONE,
> +	OFONO_USSD_FAILURE_USER_TERMINATED,
> +	OFONO_USSD_FAILURE_RETURN_ERROR,
> +	OFONO_USSD_FAILURE_TIMED_OUT,
> +};
> +
>  typedef gboolean (*ofono_ussd_ssc_cb_t)(int type,
>  					const char *sc,
>  					const char *sia, const char *sib,
> @@ -254,6 +261,10 @@ typedef gboolean (*ofono_ussd_passwd_cb_t)(const cha=
r *sc,
>  					const char *old, const char *new,
>  					DBusMessage *msg, void *data);
>  =

> +typedef void (*ofono_ussd_request_cb_t)(int error, int dcs,
> +					const unsigned char *str,
> +					int str_len, void *data);
> +
>  gboolean __ofono_ussd_ssc_register(struct ofono_ussd *ussd, const char *=
sc,
>  					ofono_ussd_ssc_cb_t cb, void *data,
>  					ofono_destroy_func destroy);
> @@ -264,6 +275,12 @@ gboolean __ofono_ussd_passwd_register(struct ofono_u=
ssd *ussd, const char *sc,
>  					ofono_destroy_func destroy);
>  void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char =
*sc);
>  =

> +gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
> +
> +int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
> +			const unsigned char *binary_data, int binary_data_len,

naming these data or pdu and len is good enough

> +			ofono_ussd_request_cb_t cb, void *user_data);
> +
>  #include <ofono/netreg.h>
>  =

>  typedef void (*ofono_netreg_status_notify_cb_t)(int status, int lac, int=
 ci,
> diff --git a/src/ussd.c b/src/ussd.c
> index 825d560..c58bd7c 100644
> --- a/src/ussd.c
> +++ b/src/ussd.c
> @@ -34,6 +34,8 @@
>  #include "ofono.h"
>  =

>  #include "common.h"
> +#include "smsutil.h"
> +#include "util.h"
>  =

>  #define SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementaryService=
s"
>  =

> @@ -46,6 +48,15 @@ enum ussd_state {
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
> @@ -56,6 +67,7 @@ struct ofono_ussd {
>  	const struct ofono_ussd_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	struct ussd_request *req;
>  };
>  =

>  struct ssc_entry {
> @@ -306,15 +318,56 @@ static void ussd_change_state(struct ofono_ussd *us=
sd, int state)
>  			"State", DBUS_TYPE_STRING, &value);
>  }
>  =

> -void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *=
str)
> +static void ussd_request_finish(struct ofono_ussd *ussd, int error, int =
dcs,
> +				const unsigned char *str, int str_len)
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
> +			const unsigned char *data, int data_len)
>  {
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
>  	const char *ussdstr =3D "USSD";
> +	char *utf8_str =3D NULL;
> +	gboolean utf8_str_valid =3D FALSE;
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
> +					dcs, data, data_len);
> +
> +		ussd_change_state(ussd, USSD_STATE_IDLE);
> +		return;
> +	}
> +
>  	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
>  		ussd_change_state(ussd, USSD_STATE_IDLE);
>  =

> @@ -334,15 +387,21 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int=
 status, const char *str)
>  		reply =3D __ofono_error_timed_out(ussd->pending);
>  		goto out;
>  	}
> +	=

> +	if (data && data_len > 0)
> +		utf8_str =3D ussd_decode(dcs, data_len, data);
> +
> +	if (!utf8_str) {
> +		utf8_str =3D "";
> +		status =3D OFONO_USSD_STATUS_NOTIFY;
> +	} else
> +		utf8_str_valid =3D TRUE;
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
> @@ -352,7 +411,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
>  							&variant);
>  =

>  		dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING,
> -						&str);
> +						&utf8_str);
>  =

>  		dbus_message_iter_close_container(&iter, &variant);
>  =

> @@ -364,10 +423,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int =
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
> @@ -387,20 +443,17 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int=
 status, const char *str)
>  			signal_name =3D "NotificationReceived";
>  		}
>  =

> -		if (!str)
> -			str =3D "";
> -
>  		g_dbus_emit_signal(conn, path,
>  				SUPPLEMENTARY_SERVICES_INTERFACE, signal_name,
> -				DBUS_TYPE_STRING, &str, DBUS_TYPE_INVALID);
> +				DBUS_TYPE_STRING, &utf8_str, DBUS_TYPE_INVALID);
>  =

>  		ussd_change_state(ussd, new_state);
> -		return;
> +		goto free;
>  	} else {
>  		ofono_error("Received an unsolicited USSD but can't handle.");
> -		DBG("USSD is: status: %d, %s", status, str);
> +		DBG("USSD is: status: %d, %s", status, utf8_str);
>  =

> -		return;
> +		goto free;
>  	}
>  =

>  out:
> @@ -408,6 +461,10 @@ out:
>  =

>  	dbus_message_unref(ussd->pending);
>  	ussd->pending =3D NULL;
> +
> +free:
> +	if (utf8_str_valid)
> +		g_free(utf8_str);
>  }
>  =

>  static void ussd_callback(const struct ofono_error *error, void *data)
> @@ -436,6 +493,12 @@ static DBusMessage *ussd_initiate(DBusConnection *co=
nn, DBusMessage *msg,
>  {
>  	struct ofono_ussd *ussd =3D data;
>  	const char *str;
> +	int dcs =3D 0x0f;
> +	unsigned char buf[256];
> +	unsigned char *converted;
> +	unsigned char *packed =3D NULL;
> +	long num_packed;
> +	long written;
>  =

>  	if (ussd->pending)
>  		return __ofono_error_busy(msg);
> @@ -458,14 +521,27 @@ static DBusMessage *ussd_initiate(DBusConnection *c=
onn, DBusMessage *msg,
>  	if (!valid_ussd_string(str))
>  		return __ofono_error_invalid_format(msg);
>  =

> -	DBG("OK, running USSD request");
> +	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
> +	if (!converted)
> +		return __ofono_error_invalid_format(msg);
> +
> +	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
> +					&num_packed, 0, buf);
> +
> +	g_free(converted);
> +
> +	if (num_packed > OFONO_MAX_USSD_LENGTH)
> +		return __ofono_error_invalid_format(msg);
>  =

>  	if (!ussd->driver->request)
>  		return __ofono_error_not_implemented(msg);
>  =

> +	DBG("OK, running USSD request");
> +
>  	ussd->pending =3D dbus_message_ref(msg);
>  =

> -	ussd->driver->request(ussd, str, ussd_callback, ussd);
> +	ussd->driver->request(ussd, dcs, packed, (int) num_packed,
> +				ussd_callback, ussd);
>  =

>  	return NULL;
>  }
> @@ -496,6 +572,12 @@ static DBusMessage *ussd_respond(DBusConnection *con=
n, DBusMessage *msg,
>  {
>  	struct ofono_ussd *ussd =3D data;
>  	const char *str;
> +	int dcs =3D 0x0f;
> +	unsigned char buf[256];
> +	unsigned char *converted;
> +	unsigned char *packed =3D NULL;
> +	long num_packed;
> +	long written;
>  =

>  	if (ussd->pending)
>  		return __ofono_error_busy(msg);
> @@ -510,12 +592,25 @@ static DBusMessage *ussd_respond(DBusConnection *co=
nn, DBusMessage *msg,
>  	if (strlen(str) =3D=3D 0)
>  		return __ofono_error_invalid_format(msg);
>  =

> +	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
> +	if (!converted)
> +		return __ofono_error_invalid_format(msg);
> +
> +	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
> +					&num_packed, 0, buf);
> +
> +	g_free(converted);
> +
> +	if (num_packed > OFONO_MAX_USSD_LENGTH)
> +		return __ofono_error_invalid_args(msg);
> +
>  	if (!ussd->driver->request)
>  		return __ofono_error_not_implemented(msg);
>  =

>  	ussd->pending =3D dbus_message_ref(msg);
>  =

> -	ussd->driver->request(ussd, str, ussd_response_callback, ussd);
> +	ussd->driver->request(ussd, dcs, packed, (int) num_packed,
> +				ussd_response_callback, ussd);
>  =

>  	return NULL;
>  }
> @@ -543,6 +638,9 @@ static void ussd_cancel_callback(const struct ofono_e=
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

> @@ -741,3 +839,46 @@ void *ofono_ussd_get_data(struct ofono_ussd *ussd)
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
> +				const unsigned char *binary_data,
> +				int binary_data_len,
> +				ofono_ussd_request_cb_t cb, void *user_data)
> +{
> +	struct ussd_request *req;
> +
> +	if (!ussd->driver->request)
> +		return -ENOSYS;
> +
> +	req =3D g_try_new0(struct ussd_request, 1);
> +	req->dcs =3D dcs;
> +	req->str =3D g_memdup(binary_data, binary_data_len);
> +	req->str_len =3D binary_data_len;
> +	req->cb =3D cb;
> +	req->user_data =3D user_data;
> +
> +	ussd->req =3D req;
> +
> +	ussd->driver->request(ussd, dcs, binary_data, binary_data_len,
> +				ussd_request_callback, ussd);
> +
> +	return 0;
> +}

Otherwise it looks fine, but I'll have to perform another round of
reviews once you separate out the driver changes from
ofono_ussd_initiate changes.

Regards,
-Denis

--===============7810757970187664440==--

