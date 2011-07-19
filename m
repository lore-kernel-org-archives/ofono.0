Content-Type: multipart/mixed; boundary="===============9042236282530061222=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] stk: Handle set up call in handled_notify
Date: Tue, 19 Jul 2011 16:01:47 -0500
Message-ID: <4E25F0BB.3000001@gmail.com>
In-Reply-To: <1311059607-10695-3-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9042236282530061222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/19/2011 02:13 AM, Jeevaka Badrappan wrote:
> ---
>  src/stk.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 110 insertions(+), 3 deletions(-)
> =

> diff --git a/src/stk.c b/src/stk.c
> index e8ffb42..a204e45 100644
> --- a/src/stk.c
> +++ b/src/stk.c
> @@ -1790,6 +1790,45 @@ static void confirm_call_cb(enum stk_agent_result =
result, gboolean confirm,
>  		stk_command_cb(&error, stk);
>  }
>  =

> +static void confirm_handled_call_cb(enum stk_agent_result result,
> +					gboolean confirm, void *user_data)
> +{
> +	struct ofono_stk *stk =3D user_data;
> +	const struct stk_command_setup_call *sc =3D
> +					&stk->pending_cmd->setup_call;
> +	struct ofono_voicecall *vc =3D NULL;
> +	struct ofono_atom *vc_atom;
> +
> +	if (stk->driver->user_confirmation =3D=3D NULL)
> +		goto out;
> +
> +	if (result !=3D STK_AGENT_RESULT_OK) {
> +		stk->driver->user_confirmation(stk, FALSE);
> +		goto out;
> +	}
> +
> +	stk->driver->user_confirmation(stk, confirm);
> +
> +	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
> +						OFONO_ATOM_TYPE_VOICECALL);
> +	if (vc_atom)
> +		vc =3D __ofono_atom_get_data(vc_atom);
> +
> +	if (vc =3D=3D NULL)
> +		goto out;
> +
> +	__ofono_voicecall_set_alpha_and_icon_id(vc, sc->addr.number,
> +						sc->addr.ton_npi,
> +						sc->alpha_id_call_setup,
> +						sc->icon_id_call_setup.id);
> +
> +	return;
> +
> +out:
> +	stk_command_free(stk->pending_cmd);
> +	stk->pending_cmd =3D NULL;
> +}
> +
>  static gboolean handle_command_set_up_call(const struct stk_command *cmd,
>  						struct stk_response *rsp,
>  						struct ofono_stk *stk)
> @@ -2606,6 +2645,74 @@ static gboolean handle_command_launch_browser(cons=
t struct stk_command *cmd,
>  	return FALSE;
>  }
>  =

> +static void proactive_command_handled_end(struct ofono_stk *stk)
> +{
> +	if (stk->pending_cmd =3D=3D NULL)
> +		return;
> +
> +	switch(stk->pending_cmd->type) {
> +	case STK_COMMAND_TYPE_SETUP_CALL:
> +	{
> +		struct ofono_voicecall *vc =3D NULL;
> +		struct ofono_atom *vc_atom;
> +
> +		vc_atom =3D __ofono_modem_find_atom(
> +					__ofono_atom_get_modem(stk->atom),
> +					OFONO_ATOM_TYPE_VOICECALL);
> +		if (vc_atom)
> +			vc =3D __ofono_atom_get_data(vc_atom);
> +
> +		if (vc !=3D NULL)
> +			__ofono_voicecall_clear_alpha_and_icon_id(vc);
> +
> +		break;
> +	}
> +	case STK_COMMAND_TYPE_SEND_SMS:
> +	case STK_COMMAND_TYPE_SEND_USSD:
> +	case STK_COMMAND_TYPE_SEND_SS:
> +	case STK_COMMAND_TYPE_SEND_DTMF:
> +		stk_alpha_id_unset(stk);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +}
> +
> +static void handle_setup_call_confirmation_req(struct stk_command *cmd,
> +						struct ofono_stk *stk)
> +{
> +	const struct stk_command_setup_call *sc =3D &cmd->setup_call;
> +	int err;
> +	char *alpha_id =3D dbus_apply_text_attributes(
> +					sc->alpha_id_usr_cfm ?
> +					sc->alpha_id_usr_cfm : "",
> +					&sc->text_attr_usr_cfm);
> +	if (alpha_id =3D=3D NULL)
> +		goto out;
> +
> +	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id,
> +					&sc->icon_id_usr_cfm,
> +					confirm_handled_call_cb,
> +					stk, NULL,
> +					stk->timeout * 1000);
> +	g_free(alpha_id);
> +
> +	if (err < 0)
> +		goto out;
> +
> +	stk->pending_cmd =3D cmd;
> +	stk->cancel_cmd =3D proactive_command_handled_end;
> +
> +	return;
> +
> +out:
> +	if (stk->driver->user_confirmation)
> +		stk->driver->user_confirmation(stk, FALSE);
> +
> +	stk_command_free(cmd);
> +}
> +
>  static void stk_proactive_command_cancel(struct ofono_stk *stk)
>  {
>  	if (stk->immediate_response)
> @@ -2826,7 +2933,7 @@ void ofono_stk_proactive_command_handled_notify(str=
uct ofono_stk *stk,
>  	 * responses here
>  	 */
>  	if (length > 0 && pdu[0] =3D=3D 0x81) {
> -		stk_alpha_id_unset(stk);
> +		proactive_command_handled_end(stk);

You have to be careful here, you're not setting stk->pending_cmd for
anything except SETUP_CALL.

>  		return;
>  	}
>  =

> @@ -2863,8 +2970,8 @@ void ofono_stk_proactive_command_handled_notify(str=
uct ofono_stk *stk,
>  		break;
>  =

>  	case STK_COMMAND_TYPE_SETUP_CALL:
> -		/* TODO */
> -		break;
> +		handle_setup_call_confirmation_req(cmd, stk);
> +		return;
>  =

>  	case STK_COMMAND_TYPE_SEND_USSD:
>  		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id,

Regards,
-Denis

--===============9042236282530061222==--

