Content-Type: multipart/mixed; boundary="===============1729664837597932162=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 2/4] stk: Handle Launch Browser proactive command
Date: Wed, 12 Jan 2011 16:31:48 -0600
Message-ID: <4D2E2BD4.9050303@gmail.com>
In-Reply-To: <1294652623-17287-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1729664837597932162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> +static gboolean handle_command_launch_browser(const struct stk_command *=
cmd,
> +						struct stk_response *rsp,
> +						struct ofono_stk *stk)
> +{
> +	const struct stk_command_launch_browser *lb =3D &cmd->launch_browser;
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
> +	static unsigned char no_cause[] =3D { 0x00 };
> +	static unsigned char no_service[] =3D { 0x04 };
> +	struct ofono_atom *netreg_atom;
> +	struct ofono_netreg *netreg;
> +	int qualifier =3D cmd->qualifier;
> +	char *alpha_id;
> +	int err;
> +	int status;
> +
> +	if (qualifier > 3 || qualifier =3D=3D 1) {
> +		rsp->result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
> +		return TRUE;
> +	}
> +
> +	if ( lb->browser_id > 4) {
> +		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
> +		return TRUE;
> +	}
> +
> +	if (ofono_modem_get_online(modem) =3D=3D FALSE) {
> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
> +					no_service);
> +		return TRUE;
> +	}
> +
> +	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
> +	if (netreg_atom =3D=3D NULL) {
> +		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
> +		return TRUE;
> +	}
> +
> +	netreg =3D __ofono_atom_get_data(netreg_atom);
> +	status =3D __ofono_netreg_registration_status(netreg);
> +
> +	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> +			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
> +		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
> +					no_service);
> +		return TRUE;
> +	}
> +

So a question about this.  Why are we checking the netreg atom?
Shouldn't we be checking the gprs atom's attached property?  But this
brings up an even more interesting question, do we even need to assume
that we have to be attached to the cellular network to perform these
operations?  We could in theory go over wifi.

Thoughts?

> +	alpha_id =3D dbus_apply_text_attributes(lb->alpha_id ? lb->alpha_id : "=
",
> +							&lb->text_attr);
> +	if (alpha_id =3D=3D NULL) {
> +		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
> +		return TRUE;
> +	}
> +
> +	err =3D stk_agent_launch_browser(stk->current_agent, alpha_id,
> +					lb->icon_id.id, lb->url,
> +					confirm_launch_browser_cb,
> +					stk, NULL, stk->timeout * 1000);
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

Rest seems reasonable to me.

Regards,
-Denis

--===============1729664837597932162==--

