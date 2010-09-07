Content-Type: multipart/mixed; boundary="===============8294820001529265331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] stk and stkutil changes for Send USSD proactive
 command
Date: Tue, 07 Sep 2010 09:58:44 -0500
Message-ID: <4C865324.3010702@gmail.com>
In-Reply-To: <1283764886-17588-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8294820001529265331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/06/2010 04:21 AM, Jeevaka Badrappan wrote:
> ---
>  src/stk.c     |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>  src/stkutil.c |   22 +++++++++
>  src/stkutil.h |   13 +++++
>  3 files changed, 169 insertions(+), 3 deletions(-)

Changes to stkutil should come in a separate patch.

> =

> diff --git a/src/stk.c b/src/stk.c
> index 3fda2af..5d84141 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -56,10 +56,8 @@ struct ofono_stk {
>  	void (*cancel_cmd)(struct ofono_stk *stk);
>  	GQueue *envelope_q;
>  	DBusMessage *pending;
> -
>  	struct stk_timer timers[8];
>  	guint timers_source;
> -
>  	int timeout;
>  	int short_timeout;
>  	struct stk_agent *session_agent;

Please don't ever do this.  The empty lines are there for a reason.  If
you disagree, then send a separate RFC patch.

> @@ -1590,6 +1588,136 @@ static gboolean handle_command_set_up_call(const =
struct stk_command *cmd,
>  	return FALSE;
>  }
>  =

> +static void send_ussd_callback( int error, int dcs, const unsigned char =
*msg,
> +                                int msg_len, void *userdata)
> +{
> +	struct ofono_stk *stk =3D userdata;
> +	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
> +	struct stk_response rsp;
> +	enum sms_charset charset;
> +	=

> +	if (stk->pending_cmd->send_ussd.alpha_id &&
> +		stk->pending_cmd->send_ussd.alpha_id[0])
> +		stk_alpha_id_unset(stk);
> +
> +	switch (error) {
> +	case OFONO_USSD_FAILURE_NONE:
> +		memset(&rsp, 0, sizeof(rsp));
> +
> +		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
> +
> +		if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
> +			            	NULL, NULL, NULL))
> +			rsp.send_ussd.text.dcs =3D -1;
> +		else
> +			rsp.send_ussd.text.dcs =3D charset;
> +
> +		rsp.send_ussd.text.text =3D msg;
> +		rsp.send_ussd.text.len =3D msg_len;
> +
> +		if (stk_respond(stk, &rsp, stk_command_cb))
> +			stk_command_cb(&failure, stk);
> +
> +		break;
> +	case OFONO_USSD_FAILURE_USER_TERMINATED:
> +		send_simple_response(stk, STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION);
> +		break;
> +	case OFONO_USSD_FAILURE_TIMED_OUT:
> +		send_simple_response(stk, STK_RESULT_TYPE_NETWORK_UNAVAILABLE);
> +		break;
> +	case OFONO_USSD_FAILURE_RETURN_ERROR:
> +		send_simple_response(stk, STK_RESULT_TYPE_USSD_RETURN_ERROR);
> +		break;
> +	}
> +}
> +
> +static gboolean handle_command_send_ussd(const struct stk_command *cmd,
> +                                        struct stk_response *rsp,
> +                                        struct ofono_stk *stk)
> +{
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
> +	static unsigned char busy_on_ss_result[] =3D { 0x03 };
> +	static unsigned char busy_on_ussd_result[] =3D { 0x08 };
> +	int err;
> +
> +	struct ofono_atom *cf_atom;
> +	struct ofono_atom *cb_atom;
> +	struct ofono_atom *cs_atom;
> +	struct ofono_atom *ussd_atom;
> +
> +	struct ofono_call_forwarding *cf;
> +	struct ofono_call_barring *cb;
> +	struct ofono_call_settings *cs;
> +	struct ofono_ussd *ussd;
> +
> +	cf_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_FORWARD=
ING);
> +	cb_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_BARRING=
);
> +	cs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_SETTING=
S);
> +	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
> +
> +	if (cf_atom && __ofono_atom_get_registered(cf_atom)) {
> +		cf =3D __ofono_atom_get_data(cf_atom);
> +		if (__ofono_call_forwarding_is_busy(cf)) {
> +		    rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
> +		    rsp->result.additional_len =3D sizeof(busy_on_ss_result);
> +		    rsp->result.additional =3D busy_on_ss_result;
> +		    return TRUE;
> +		}
> +	}
> +
> +	if (cb_atom && __ofono_atom_get_registered(cb_atom)) {
> +		cb =3D __ofono_atom_get_data(cb_atom);
> +		if (__ofono_call_barring_is_busy(cb)) {
> +		    rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
> +		    rsp->result.additional_len =3D sizeof(busy_on_ss_result);
> +		    rsp->result.additional =3D busy_on_ss_result;
> +		    return TRUE;
> +		}
> +	}
> +
> +	if (cs_atom && __ofono_atom_get_registered(cs_atom)) {
> +		cs =3D __ofono_atom_get_data(cs_atom);
> +		if (__ofono_call_settings_is_busy(cs)) {
> +		    rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
> +		    rsp->result.additional_len =3D sizeof(busy_on_ss_result);
> +		    rsp->result.additional =3D busy_on_ss_result;
> +		    return TRUE;
> +		}
> +	}
> +
> +	if (!ussd_atom || !__ofono_atom_get_registered(ussd_atom)) {
> +		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
> +		return TRUE;
> +	}
> +
> +	ussd =3D __ofono_atom_get_data(ussd_atom);
> +
> +	if (__ofono_ussd_is_busy(ussd)) {
> +		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
> +		rsp->result.additional_len =3D sizeof(busy_on_ussd_result);
> +		rsp->result.additional =3D busy_on_ussd_result;
> +		return TRUE;
> +	}
> +
> +	err =3D __ofono_ussd_initiate( ussd, cmd->send_ussd.ussd_string.dcs,
> +        	                 cmd->send_ussd.ussd_string.string,
> +        	                 cmd->send_ussd.ussd_string.len,
> +        	                 send_ussd_callback, stk);
> +
> +	if (err >=3D 0) =

> +		return FALSE;
> +
> +	if (err =3D=3D -ENOSYS) {
> +		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
> +		return TRUE;
> +	}
> +
> +	if (cmd->send_ussd.alpha_id && cmd->send_ussd.alpha_id[0])
> +		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id);
> +
> +	return FALSE;
> +}
> +
>  static void stk_proactive_command_cancel(struct ofono_stk *stk)
>  {
>  	if (stk->immediate_response)
> @@ -1740,7 +1868,10 @@ void ofono_stk_proactive_command_notify(struct ofo=
no_stk *stk,
>  		respond =3D handle_command_set_up_call(stk->pending_cmd,
>  							&rsp, stk);
>  		break;
> -
> +	case STK_COMMAND_TYPE_SEND_USSD:
> +		respond =3D handle_command_send_ussd(stk->pending_cmd,
> +							&rsp, stk);
> +		break;
>  	default:
>  		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
>  		break;
> diff --git a/src/stkutil.c b/src/stkutil.c
> index ae4cc32..48d409b 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -4170,6 +4170,22 @@ static gboolean build_dataobj_text(struct stk_tlv_=
builder *tlv,
>  	return stk_tlv_builder_close_container(tlv);
>  }
>  =

> +/* Defined in TS 102.223 Section 8.15 - USSD specific case*/
> +static gboolean build_dataobj_ussd_text(struct stk_tlv_builder *tlv,
> +					const void *data, gboolean cr)
> +{
> +	const struct stk_ussd_text *text =3D data;
> +	unsigned char tag =3D STK_DATA_OBJECT_TYPE_TEXT;
> +
> +	if (!text->text || !text->len)
> +		return TRUE;
> +
> +	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
> +		stk_tlv_builder_append_byte(tlv, text->dcs) &&
> +		stk_tlv_builder_append_bytes(tlv, text->text, text->len) &&
> +		stk_tlv_builder_close_container(tlv);
> +}
> +
>  /* Described in TS 131.111 Section 8.17 */
>  static gboolean build_dataobj_ussd_string(struct stk_tlv_builder *tlv,
>  					const void *data, gboolean cr)
> @@ -5459,6 +5475,12 @@ const unsigned char *stk_pdu_from_response(const s=
truct stk_response *response,
>  	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
>  	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
>  		break;
> +	case STK_COMMAND_TYPE_SEND_USSD:
> +		ok =3D build_dataobj(&builder,
> +				build_dataobj_ussd_text, DATAOBJ_FLAG_CR,
> +				&response->send_ussd.text,
> +				NULL);
> +		break;
>  	default:
>  		return NULL;
>  	};
> diff --git a/src/stkutil.h b/src/stkutil.h
> index 44d167a..fac0553 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -237,6 +237,7 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_GO_BACK =3D			0x11,
>  	STK_RESULT_TYPE_NO_RESPONSE =3D			0x12,
>  	STK_RESULT_TYPE_HELP_REQUESTED =3D		0x13,
> +	STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION =3D   0x14,
>  =

>  	/* 0x20 to 0x2F are used to indicate that SIM should retry */
>  	STK_RESULT_TYPE_TERMINAL_BUSY =3D			0x20,
> @@ -254,6 +255,7 @@ enum stk_result_type {
>  	STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD =3D		0x32,
>  	STK_RESULT_TYPE_COMMAND_ID_UNKNOWN =3D		0x33,
>  	STK_RESULT_TYPE_MINIMUM_NOT_MET =3D		0x36,
> +	STK_RESULT_TYPE_USSD_RETURN_ERROR =3D             0x37,
>  	STK_RESULT_TYPE_CALL_CONTROL_PERMANENT =3D	0x39,
>  	STK_RESULT_TYPE_BIP_ERROR =3D			0x3A,
>  	STK_RESULT_TYPE_ACCESS_TECHNOLOGY_ERROR =3D	0x3B,
> @@ -1374,6 +1376,12 @@ struct stk_answer_text {
>  	 */

Modifications to the enum should also be in a separate patch.

>  };
>  =

> +struct stk_ussd_text {
> +	const unsigned char *text;
> +	int dcs;
> +	int len;
> +};
> +
>  struct stk_response_get_inkey {
>  	struct stk_answer_text text;
>  	struct stk_duration duration;
> @@ -1445,6 +1453,10 @@ struct stk_response_run_at_command {
>  	const char *at_response;
>  };
>  =

> +struct stk_response_send_ussd {
> +        struct stk_ussd_text text;
> +};
> +
>  struct stk_response {
>  	unsigned char number;
>  	unsigned char type;
> @@ -1474,6 +1486,7 @@ struct stk_response {
>  		struct stk_response_generic send_dtmf;
>  		struct stk_response_generic language_notification;
>  		struct stk_response_generic launch_browser;
> +		struct stk_response_send_ussd send_ussd;
>  	};
>  =

>  	void (*destructor)(struct stk_response *response);

Regards,
-Denis

--===============8294820001529265331==--

