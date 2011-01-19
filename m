Content-Type: multipart/mixed; boundary="===============2968154544678004154=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] stk: Handle Launch Browser proactive command
Date: Tue, 18 Jan 2011 21:54:13 -0600
Message-ID: <4D366065.60406@gmail.com>
In-Reply-To: <1294997935-21814-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2968154544678004154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/14/2011 03:38 AM, Jeevaka Badrappan wrote:
> ---
>  src/stk.c      |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/stkagent.c |   68 ++++++++++++++++++++++++++++++++++++++++++
>  src/stkagent.h |    7 ++++
>  3 files changed, 165 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stk.c b/src/stk.c
> index f151fc1..e6df58b 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -2358,6 +2358,91 @@ static gboolean handle_command_play_tone(const str=
uct stk_command *cmd,
>  	return FALSE;
>  }
>  =

> +static void confirm_launch_browser_cb(enum stk_agent_result result,
> +					gboolean confirm,
> +					void *user_data)
> +{
> +	struct ofono_stk *stk =3D user_data;
> +	unsigned char no_cause[] =3D { 0x00 };
> +	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
> +	struct stk_response rsp;
> +
> +	stk->respond_on_exit =3D FALSE;
> +
> +	switch (result) {
> +	case STK_AGENT_RESULT_TIMEOUT:
> +		confirm =3D FALSE;
> +		/* Fall through */
> +
> +	case STK_AGENT_RESULT_OK:
> +		if (confirm)
> +			break;
> +
> +		send_simple_response(stk, STK_RESULT_TYPE_USER_REJECT);

So funnily enough TS 102.223 Table 6.1 says that USER_REJECT is not a
valid response to Launch Browser, even though it certainly describes a
user confirmation phase.

> +		return;
> +	default:
> +		memset(&rsp, 0, sizeof(rsp));
> +		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
> +					no_cause);
> +
> +		if (stk_respond(stk, &rsp, stk_command_cb))
> +			stk_command_cb(&failure, stk);
> +
> +		return;
> +	}
> +
> +	send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
> +}
> +
> +static gboolean handle_command_launch_browser(const struct stk_command *=
cmd,
> +						struct stk_response *rsp,
> +						struct ofono_stk *stk)
> +{
> +	const struct stk_command_launch_browser *lb =3D &cmd->launch_browser;
> +	static unsigned char no_cause[] =3D { 0x00 };
> +	int qualifier =3D cmd->qualifier;
> +	char *alpha_id;
> +	int err;
> +
> +	if (qualifier > 3 || qualifier =3D=3D 1) {
> +		rsp->result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
> +		return TRUE;
> +	}

So my view is that this should be done inside stkutil.c

> +
> +	if ( lb->browser_id > 4) {
> +		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
> +		return TRUE;
> +	}

Same for this one, the id should be validated inside browser_id parser

> +
> +	alpha_id =3D dbus_apply_text_attributes(lb->alpha_id ? lb->alpha_id : "=
",
> +							&lb->text_attr);
> +	if (alpha_id =3D=3D NULL) {
> +		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
> +		return TRUE;
> +	}
> +
> +	err =3D stk_agent_confirm_launch_browser(stk->current_agent, alpha_id,
> +						lb->icon_id.id, lb->url,
> +						confirm_launch_browser_cb,
> +						stk, NULL, stk->timeout * 1000);
> +	g_free(alpha_id);
> +
> +	if (err < 0) {
> +		/*
> +		 * We most likely got an out of memory error, tell SIM
> +		 * to retry
> +		 */
> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
> +					no_cause);
> +		return TRUE;
> +	}
> +
> +	stk->respond_on_exit =3D TRUE;
> +	stk->cancel_cmd =3D stk_request_cancel;
> +
> +	return FALSE;
> +}
> +
>  static void stk_proactive_command_cancel(struct ofono_stk *stk)
>  {
>  	if (stk->immediate_response)
> @@ -2545,6 +2630,11 @@ void ofono_stk_proactive_command_notify(struct ofo=
no_stk *stk,
>  							&rsp, stk);
>  		break;
>  =

> +	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
> +		respond =3D handle_command_launch_browser(stk->pending_cmd,
> +							&rsp, stk);
> +		break;
> +
>  	default:
>  		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
>  		break;
> diff --git a/src/stkagent.c b/src/stkagent.c
> index 2cdc6e1..2395182 100644
> --- a/src/stkagent.c
> +++ b/src/stkagent.c
> @@ -1013,3 +1013,71 @@ int stk_agent_display_action_info(struct stk_agent=
 *agent, const char *text,
>  =

>  	return 0;
>  }
> +
> +static void confirm_launch_browser_cb(DBusPendingCall *call, void *data)
> +{
> +	struct stk_agent *agent =3D data;
> +	stk_agent_confirmation_cb cb =3D agent->user_cb;
> +	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
> +	enum stk_agent_result result;
> +	gboolean remove_agent;
> +	dbus_bool_t confirm;
> +
> +	if (check_error(agent, reply, 0, &result) =3D=3D -EINVAL) {
> +		remove_agent =3D TRUE;
> +		cb(STK_AGENT_RESULT_TERMINATE, FALSE, agent->user_data);
> +		goto error;
> +	}
> +
> +	if (result !=3D STK_AGENT_RESULT_OK) {
> +		cb(result, FALSE, agent->user_data);
> +		goto done;
> +	}
> +
> +	if (dbus_message_get_args(reply, NULL,
> +					DBUS_TYPE_BOOLEAN, &confirm,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE) {
> +		ofono_error("Can't parse the reply to ConfirmLaunchBrowser()");
> +		remove_agent =3D TRUE;
> +		goto error;
> +	}
> +
> +	cb(result, confirm, agent->user_data);
> +
> +	CALLBACK_END();
> +}
> +
> +int stk_agent_confirm_launch_browser(struct stk_agent *agent, const char=
 *text,
> +					unsigned char icon_id, const char *url,
> +					stk_agent_confirmation_cb cb,
> +					void *user_data,
> +					ofono_destroy_func destroy, int timeout)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
> +							OFONO_SIM_APP_INTERFACE,
> +							"ConfirmLaunchBrowser");
> +	if (agent->msg =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	dbus_message_append_args(agent->msg,
> +					DBUS_TYPE_STRING, &text,
> +					DBUS_TYPE_BYTE, &icon_id,
> +					DBUS_TYPE_STRING, &url,
> +					DBUS_TYPE_INVALID);
> +
> +	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
> +						timeout) =3D=3D FALSE ||
> +						agent->call =3D=3D NULL)
> +		return -EIO;
> +
> +	agent->user_cb =3D cb;
> +	agent->user_data =3D user_data;
> +	agent->user_destroy =3D destroy;
> +
> +	dbus_pending_call_set_notify(agent->call, confirm_launch_browser_cb,
> +					agent, NULL);
> +
> +	return 0;
> +}
> diff --git a/src/stkagent.h b/src/stkagent.h
> index 6477dbf..1f0c4fa 100644
> --- a/src/stkagent.h
> +++ b/src/stkagent.h
> @@ -140,3 +140,10 @@ void append_menu_items_variant(DBusMessageIter *iter,
>  =

>  int stk_agent_display_action_info(struct stk_agent *agent, const char *t=
ext,
>  					const struct stk_icon_id *icon);
> +
> +int stk_agent_confirm_launch_browser(struct stk_agent *agent, const char=
 *text,
> +					unsigned char icon_id, const char *url,
> +					stk_agent_confirmation_cb cb,
> +					void *user_data,
> +					ofono_destroy_func destroy,
> +					int timeout);

The rest looks fine to me.

Regards,
-Denis

--===============2968154544678004154==--

