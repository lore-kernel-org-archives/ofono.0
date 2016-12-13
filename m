Content-Type: multipart/mixed; boundary="===============1112206217284481335=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] ublox:netmon: support +UCGED and get EARFCN,
 EBAND and CQI
Date: Tue, 13 Dec 2016 11:38:10 -0600
Message-ID: <cc295040-bff1-5951-b1c4-d9baa29f85b1@gmail.com>
In-Reply-To: <1481627128-20233-6-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1112206217284481335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 12/13/2016 05:05 AM, Djalal Harouni wrote:
> This adds support for +UCGED mode 2 and for now we collect only
> EARFCN, EBAND and CQI. Later we will follow up with +UCGED mode 3.
>
> Some ublox modems supports +UCGED mode 2 and others only +UCGED mode 3
> depending on the firmware.
> ---
>  drivers/ubloxmodem/netmon.c | 195 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 191 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
> index 0749078..9d414a8 100644
> --- a/drivers/ubloxmodem/netmon.c
> +++ b/drivers/ubloxmodem/netmon.c
> @@ -46,6 +46,13 @@
>
>  static const char *cops_prefix[] =3D { "+COPS:", NULL };
>  static const char *cesq_prefix[] =3D { "+CESQ:", NULL };
> +static const char *ucged_prefix[] =3D { "+UCGED:", NULL };
> +
> +/* Field from +UCGED response */
> +typedef struct ublox_ucged_value {
> +	int offset;	/* Offset at response */
> +	uint8_t base;	/* Base format how to parse */
> +} ublox_ucged_value;
>
>  struct netmon_driver_data {
>  	GAtChat *chat;
> @@ -67,6 +74,10 @@ struct req_cb_data {
>  	int rsrp;	/* CESQ: Reference Signal Received Power */
>  	int ecn0;	/* CESQ: Received Energy Ratio */
>  	int rsrq;	/* CESQ: Reference Signal Received Quality */
> +
> +	int earfcn;	/* UCGED: E-UTRA ARFCN */
> +	int eband;	/* UCGED: E-UTRA Band */
> +	int cqi;	/* UCGED: Channel Quality Indicator */
>  };
>
>  /*
> @@ -102,6 +113,7 @@ static inline struct req_cb_data *req_cb_data_new0(vo=
id *cb, void *data,
>  	ret->cb =3D cb;
>  	ret->data =3D data;
>  	ret->netmon =3D user;
> +
>  	ret->rxlev =3D -1;
>  	ret->ber =3D -1;
>  	ret->rscp =3D -1;
> @@ -109,6 +121,10 @@ static inline struct req_cb_data *req_cb_data_new0(v=
oid *cb, void *data,
>  	ret->ecn0 =3D -1;
>  	ret->rsrq =3D -1;
>
> +	ret->earfcn =3D -1;
> +	ret->eband =3D -1;
> +	ret->cqi =3D -1;
> +
>  	return ret;
>  }
>
> @@ -157,11 +173,158 @@ static void ublox_netmon_finish_success(struct req=
_cb_data *cbd)
>  					OFONO_NETMON_INFO_ECN0, cbd->ecn0,
>  					OFONO_NETMON_INFO_RSRQ, cbd->rsrq,
>  					OFONO_NETMON_INFO_RSRP, cbd->rsrp,
> +					OFONO_NETMON_INFO_EARFCN, cbd->earfcn,
> +					OFONO_NETMON_INFO_EBAND, cbd->eband,
> +					OFONO_NETMON_INFO_CQI, cbd->cqi,
>  					OFONO_NETMON_INFO_INVALID);
>
>  	CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
>  }
>
> +static void ucged_parse_4g(struct req_cb_data *cbd, GAtResultIter *iter)
> +{
> +	/* Offset of values in returned response */
> +	enum ucged_mode2_rat4_offsets {
> +		UCGED_EARFCN		=3D 0,
> +		UCGED_EBAND		=3D 1,
> +		UCGED_CQI		=3D 15,
> +		UCGED_VOLTE_MODE	=3D 21,
> +		_MAX		/* End */
> +	};
> +
> +	ublox_ucged_value ucged_values[] =3D {
> +		{ UCGED_EARFCN,	10 },
> +		{ UCGED_EBAND,	10 },
> +		{ UCGED_CQI,	10 },
> +		{ -1,		0  }, /* End of Array */
> +	};
> +
> +	gboolean ok;
> +	unsigned i;
> +	ublox_ucged_value *ptr;
> +
> +	/* Skip first fields */
> +	g_at_result_iter_next(iter, NULL);
> +
> +	for (i =3D 0, ptr =3D &ucged_values[0]; i < _MAX; i++) {
> +		const char *str =3D NULL;
> +		int number;
> +
> +		/* First read the data */
> +		ok =3D g_at_result_iter_next_unquoted_string(iter, &str);
> +		if (!ok) {
> +			DBG(" UCGED: error parsing at idx: %d ", i);
> +			return;
> +		}
> +
> +		DBG(" UCGED: RAT =3D 4G idx: %d  -  reading field: %s ", i, str);
> +
> +		/* End, nothing to do we got all our values */
> +		if (ptr->offset < 0)
> +			break;
> +
> +		/* Skip to next if we are not interested in this value */
> +		if (i !=3D (unsigned) ptr->offset)
> +			continue;
> +
> +		errno =3D 0;
> +		number =3D strtol(str, NULL, ptr->base);
> +		if (errno !=3D 0 && number =3D=3D 0) {
> +			DBG(" UCGED: RAT =3D 4G  idx: %u  failed parsing '%s' ",
> +				i, str);
> +			continue;
> +		}
> +
> +		switch (i) {
> +		case UCGED_EARFCN:
> +			cbd->earfcn =3D number !=3D 65535 ? number : cbd->earfcn;
> +			break;
> +		case UCGED_EBAND:
> +			cbd->eband =3D number !=3D 255 ? number : cbd->eband;
> +			break;
> +		case UCGED_CQI:
> +			cbd->cqi =3D number !=3D 255 ? number : cbd->cqi;
> +			break;
> +		}
> +
> +		ptr++;
> +	}

Okay, but this looks complicated.  Can't the loop be re-structured so =

that you just use g_at_result_iter_skip_next until the next value is one =

you're interested in, then use g_at_result_iter_next_number?

something like:

i =3D 0;
cur =3D 0;

while (ucged_values[cur].offset !=3D -1) {
	while (i < ucged_values[cur].offset) {
		if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
			// some parsing error
		i++;
	}

	switch (ucged_values[cur].offset) {
		/* parse into the right variable using .._next_number */
	}

	cur +=3D 1;
	i +=3D 1;
}

> +
> +	DBG(" UCGED: MODE 2 RAT =3D 4G	EARFCN =3D %d ", cbd->earfcn);
> +	DBG(" UCGED: MODE 2 RAT =3D 4G	EBAND =3D %d ", cbd->eband);
> +	DBG(" UCGED: MODE 2 RAT =3D 4G	CQI =3D %d ", cbd->cqi);
> +}
> +

Might be nice to add a comment with 'mode2' sample data so it is easier =

to see what is going on.

> +static void ucged_collect_mode2_data(struct req_cb_data *cbd, GAtResult =
*result)
> +{
> +	int rat;
> +	GAtResultIter iter;
> +	gboolean ok;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	g_at_result_iter_next(&iter, NULL);
> +	g_at_result_iter_next(&iter, NULL);
> +

Okay, so you re-init the iterator and re-run the parser to skip the =

first two lines of output.  But there's no error checking that the =

second line exits...

Also, why not simply send in the GAtResultIter pointer into this =

function from ucged_query_mode2_cb?

> +	ok =3D g_at_result_iter_next_number(&iter, &rat);
> +	if (!ok) {
> +		DBG(" UCGED: error parsing 'RAT' ");
> +		return;
> +	}
> +
> +	/* For now we support only RAT 4 */
> +	if (rat !=3D 4) {
> +		DBG(" UCGED: 'RAT' is %d, nothing to do. ", rat);
> +		return;
> +	}
> +
> +	ucged_parse_4g(cbd, &iter);
> +}
> +
> +static void ucged_query_mode2_cb(gboolean ok, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct req_cb_data *cbd =3D user_data;
> +	struct ofono_error error;
> +	GAtResultIter iter;
> +	int mode;
> +
> +	DBG("ok %d", ok);
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		DBG(" UCGED: failed ");
> +		goto out;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+UCGED:")) {
> +		DBG(" UCGED: no result ");
> +		goto out;
> +	}
> +
> +	ok =3D g_at_result_iter_next_number(&iter, &mode);
> +	if (!ok) {
> +		DBG(" UCGED: error parsing 'mode' ");
> +		goto out;
> +	}
> +
> +	DBG(" UCGED:  report mode is %d ", mode);
> +
> +	/* mode 2 collect +UCGED data */
> +	if (mode =3D=3D 2)
> +		ucged_collect_mode2_data(cbd, result);
> +
> +	/*
> +	 * We never fail at this point we always send what we collected so
> +	 * far
> +	 */
> +out:
> +	ublox_netmon_finish_success(cbd);
> +}
> +
>  static void cesq_cb(gboolean ok, GAtResult *result, gpointer user_data)
>  {
>  	enum cesq_ofono_netmon_info {
> @@ -175,6 +338,8 @@ static void cesq_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
>  	};
>
>  	struct req_cb_data *cbd =3D user_data;
> +	struct ofono_netmon *nm =3D cbd->netmon;
> +	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(nm);
>  	struct ofono_error error;
>  	GAtResultIter iter;
>  	int idx, number;
> @@ -233,10 +398,16 @@ static void cesq_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
>  	DBG(" RSRQ	%d ", cbd->rsrq);
>  	DBG(" RSRP	%d ", cbd->rsrp);
>
> -	/*
> -	 * We never fail at this point we always send what we collected so
> -	 * far
> -	 */
> +	cbd =3D req_cb_data_ref(cbd);
> +	if (g_at_chat_send(nmd->chat, "AT+UCGED?", NULL,
> +			ucged_query_mode2_cb, cbd, req_cb_data_unref) =3D=3D 0) {
> +		CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
> +		req_cb_data_unref(cbd);
> +	}
> +
> +	return;
> +
> +	/* We never fail, we always send what we collected so far */

If this is the intent, then are you sure you want a return statement =

just above this comment?  Or should it be done something like:

if (g_at_chat_send(..., "AT+UCGED?", ...) > 0)
	return;

CALLBACK_WITH_FAILURE(...);
req_cb_data_unref(...);

out:
	...

>  out:
>  	ublox_netmon_finish_success(cbd);
>  }
> @@ -320,6 +491,22 @@ static int ublox_netmon_probe(struct ofono_netmon *n=
etmon,
>
>  	g_idle_add(ublox_delayed_register, netmon);
>
> +	/*
> +	 * We set +UCGED=3D2 mode as early as possible so we are able to handle
> +	 * the following:
> +	 * 1) In case the modem supports only +UCGED mode 2 then we have
> +	 *    already set the appropriate mode and we can query the information
> +	 *    later.
> +	 * 2) In case the modem supports only +UCGED mode 3, then to set mode 3
> +	 *    the modem has to be first in +UCGED mode 2. Setting the mode here
> +	 *    allows later to query the information and on errors we fallback
> +	 *    to mode 3.
> +	 *
> +	 * This should handle current firmware versions of ublox modems.
> +	 */
> +	g_at_chat_send(nmd->chat, "AT+UCGED=3D2", ucged_prefix,
> +			NULL, NULL, NULL);
> +

Do you want to call ofono_netmon_register from inside UCGED=3D2 callback? =

Might make things a bit cleaner..

>  	return 0;
>  }
>
>

Regards,
-Denis

--===============1112206217284481335==--

