Content-Type: multipart/mixed; boundary="===============0300742919878288717=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/8] stk: Allow registering proactive command handlers.
Date: Wed, 23 Jun 2010 14:44:30 -0500
Message-ID: <201006231444.30791.denkenz@gmail.com>
In-Reply-To: <1277205651-29369-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0300742919878288717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Synchronous handlers can fill in the struct stk_respone *rsp
> parameter and return TRUE. Async handlers can ignore that parameter
> and return FALSE.  They have to call stk_respond() at some point.
> ---
>  src/stk.c |  151
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++------- 1 files
>  changed, 135 insertions(+), 16 deletions(-)
> =

> diff --git a/src/stk.c b/src/stk.c
> index b5c6919..0d7fc33 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -39,14 +39,80 @@
> =

>  static GSList *g_drivers =3D NULL;
> =

> +typedef void (*generic_cb_t)(const struct ofono_error *error,
> +				struct ofono_stk *stk);
> +
> +typedef void (*envelope_cb_t)(const struct ofono_error *error,
> +				const unsigned char *data,
> +				int length, struct ofono_stk *stk);
> +

I prefer to keep typedefs to a minimum.  Since these are copies from =

include/stk.h with a different type, I think I'd prefer to simply use those =

callbacks instead.

> +typedef gboolean (*command_handler_t)(const struct stk_command *cmd,
> +					struct stk_response *rsp,
> +					struct ofono_stk *stk);
> +

Since we're not using a true public-api registration framework (yet?) lets =
not =

typedef this one.

>  struct ofono_stk {
>  	const struct ofono_stk_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	command_handler_t handlers[STK_COMMAND_TYPE_END_SESSION + 1];

As discussed on IRC, lets just do switch/case for now.

> +	struct stk_command *pending_cmd;
>  };
> =

> +static void stk_respond(struct ofono_stk *stk,
> +			struct stk_response *rsp, generic_cb_t cb)
> +{
> +	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
> +	const guint8 *tlv;
> +	unsigned int tlv_len;
> +
> +	rsp->src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL;
> +	rsp->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
> +	rsp->number =3D stk->pending_cmd->number;
> +	rsp->type =3D stk->pending_cmd->type;
> +	rsp->qualifier =3D stk->pending_cmd->qualifier;
> +
> +	if (stk->driver->terminal_response =3D=3D NULL) {
> +		cb(&error, stk);
> +		return;
> +	}

What do you think of returning an int here (e.g. -ENOTSUPPORTED) instead of =

calling a callback?  I think that would make things a bit cleaner.

> +
> +	tlv =3D stk_pdu_from_response(rsp, &tlv_len);
> +	if (!tlv) {
> +		cb(&error, stk);
> +		return;

Perhaps -EINVAL here?
> +	}
> +
> +	stk->driver->terminal_response(stk, tlv_len, tlv,
> +					(ofono_stk_generic_cb_t) cb, stk);
> +}
> +
> +static void stk_send_envelope(struct ofono_stk *stk, struct stk_envelope
>  *e, +				envelope_cb_t cb)
> +{
> +	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
> +	const guint8 *tlv;
> +	unsigned int tlv_len;
> +
> +	e->dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
> +
> +	if (stk->driver->envelope =3D=3D NULL) {
> +		cb(&error, NULL, -1, stk);
> +		return;

Same comments as above for returning -errno.

> +	}
> +
> +	tlv =3D stk_pdu_from_envelope(e, &tlv_len);
> +	if (!tlv) {
> +		cb(&error, NULL, -1, stk);
> +		return;
> +	}
> +
> +	stk->driver->envelope(stk, tlv_len, tlv,
> +				(ofono_stk_envelope_cb_t) cb, stk);
> +}
> +
>  static void stk_cbs_download_cb(const struct ofono_error *error,
> -				const unsigned char *data, int len, void *user)
> +				const unsigned char *data, int len,
> +				struct ofono_stk *stk)
>  {
>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>  		ofono_error("CellBroadcast download to UICC failed");
> @@ -55,34 +121,46 @@ static void stk_cbs_download_cb(const struct
>  ofono_error *error, return;
>  	}
> =

> +	if (len)
> +		ofono_error("CellBroadcast download returned %i bytes of data",
> +				len);
> +
>  	DBG("CellBroadcast download to UICC reported no error");
>  }
> =

>  void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs
>  *msg) {
> -	const guint8 *tlv;
> -	unsigned int tlv_len;
>  	struct stk_envelope e;
> =

> -	if (stk->driver->envelope =3D=3D NULL)
> -		return;
> +	memset(&e, 0, sizeof(e));
> =

>  	e.type =3D STK_ENVELOPE_TYPE_CBS_PP_DOWNLOAD;
>  	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
> -	e.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC;
>  	memcpy(&e.cbs_pp_download.page, msg, sizeof(msg));
> =

> -	tlv =3D stk_pdu_from_envelope(&e, &tlv_len);
> -	if (!tlv)
> +	stk_send_envelope(stk, &e, stk_cbs_download_cb);
> +}
> +
> +static void stk_command_cb(const struct ofono_error *error,
> +				struct ofono_stk *stk)
> +{
> +	stk_command_free(stk->pending_cmd);
> +	stk->pending_cmd =3D NULL;
> +
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		ofono_error("TERMINAL RESPONSE to a UICC command failed");
> +		/* "The ME may retry to deliver the same Cell Broadcast
> +		 * page." */
>  		return;
> +	}
> =

> -	stk->driver->envelope(stk, tlv_len, tlv, stk_cbs_download_cb, stk);
> +	DBG("TERMINAL RESPONSE to a command reported no errors");
>  }
> =

>  void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
>  					int length, const unsigned char *pdu)
>  {
> -	struct stk_command *cmd;
> +	struct stk_response rsp;
>  	char *buf;
>  	int i;
> =

> @@ -93,23 +171,64 @@ void ofono_stk_proactive_command_notify(struct
>  ofono_stk *stk, for (i =3D 0; i < length; i ++)
>  		sprintf(buf + i * 2, "%02hhx", pdu[i]);
> =

> -	cmd =3D stk_command_new_from_pdu(pdu, length);
> -	if (!cmd) {
> +	stk->pending_cmd =3D stk_command_new_from_pdu(pdu, length);
> +	if (!stk->pending_cmd) {
>  		ofono_error("Can't parse proactive command: %s", buf);
> =

> -		/* TODO: return TERMINAL RESPONSE with permanent error */
> +		/*
> +		 * Nothing we can do, we'd need at least Command Details
> +		 * to be able to respond with an error.
> +		 */
>  		goto done;
>  	}
> =

> -	/* TODO: execute */
> -	ofono_info("Proactive command PDU: %s", buf);
> +	ofono_debug("Proactive command PDU: %s", buf);
> +
> +	memset(&rsp, 0, sizeof(rsp));
> =

> -	stk_command_free(cmd);
> +	switch (stk->pending_cmd->status) {
> +	case STK_PARSE_RESULT_OK:
> +		if (stk->handlers[stk->pending_cmd->type]) {
> +			if (stk->handlers[stk->pending_cmd->type](
> +					stk->pending_cmd, &rsp, stk) =3D=3D TRUE)
> +				break;
> +
> +			return;
> +		}
> +		/* Fall through */
> +
> +	case STK_PARSE_RESULT_TYPE_NOT_UNDERSTOOD:
> +	default:
> +		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
> +		break;
> +
> +	case STK_PARSE_RESULT_MISSING_VALUE:
> +		rsp.result.type =3D STK_RESULT_TYPE_MINIMUM_NOT_MET;
> +		break;
> +
> +	case STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD:
> +		rsp.result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
> +		break;
> +	}
> +
> +	stk_respond(stk, &rsp, stk_command_cb);
> =

>  done:
>  	g_free(buf);
>  }
> =

> +static gboolean stk_command_handler_register(struct ofono_stk *stk,
> +						enum stk_command_type type,
> +						command_handler_t handler)
> +{
> +	if (stk->handlers[type])
> +		return FALSE;
> +
> +	stk->handlers[type] =3D handler;
> +
> +	return TRUE;
> +}
> +
>  int ofono_stk_driver_register(const struct ofono_stk_driver *d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);
> =


Thanks,
-Denis

--===============0300742919878288717==--

