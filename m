Content-Type: multipart/mixed; boundary="===============8962174419842139393=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Fri, 15 Jul 2011 11:34:58 -0500
Message-ID: <4E206C32.3060000@gmail.com>
In-Reply-To: <1310733734-4206-4-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8962174419842139393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew, Jeevaka,

<snip>

> +static void proactive_command_handled_end(struct ofono_stk *stk)
> +{
> +	stk->modem_handled_cmd =3D FALSE;
> +
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
> +
> +	default:
> +		break;
> +	}
> +}
> +

So I'm still not sure this part is actually needed.  Once the user has
acknowledged the call, there is no way for us to cancel it until the
call is notified to the voicecall driver.  So unless the modem is drunk,
I don't really see the need to cover this case.

Once the call is notified to voicecall driver, then the need for
clearing alpha/icon id disappears.  The voicecall driver will do this
automatically based on the ofono_voicecall_disconnected notification.

What do you guys think?

Regards,
-Denis

--===============8962174419842139393==--

