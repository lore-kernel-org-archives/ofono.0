Content-Type: multipart/mixed; boundary="===============9219922525788039567=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V2 2/4] voicecall: add ATD support for HFP emulator
Date: Wed, 25 May 2011 06:16:22 -0500
Message-ID: <4DDCE506.1040406@gmail.com>
In-Reply-To: <1305884461-4476-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9219922525788039567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

<snip>

> +static void emulator_dial_callback(const struct ofono_error *error, void=
 *data)
> +{
> +	struct ofono_voicecall *vc =3D data;
> +	const char *number =3D NULL;
> +	gboolean need_to_emit;
> +	struct voicecall *v;
> +
> +	v =3D dial_handle_result(vc, error, number, &need_to_emit);
> +
> +	if (v =3D=3D NULL) {
> +		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> +
> +		if (is_emergency_number(vc, number) =3D=3D TRUE)
> +			__ofono_modem_dec_emergency_mode(modem);
> +	}
> +
> +	if (need_to_emit)
> +		voicecalls_emit_call_added(vc, v);
> +}
> +
> +static void emulator_dial(struct ofono_emulator *em, struct ofono_voicec=
all *vc,
> +				const char *number)
> +{
> +	struct ofono_error result;
> +	int err;
> +
> +	result.error =3D 0;
> +
> +	if (number =3D=3D NULL || number[0] =3D=3D '\0') {
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +		goto send;
> +	}
> +
> +	err =3D voicecall_dial(vc, number, OFONO_CLIR_OPTION_DEFAULT,
> +					emulator_dial_callback, vc);
> +	switch (err) {
> +	case 0:
> +		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +		break;
> +

Actually you can't do this.  There are bizarre circumstances where the
dial callback will be called synchronously, so even though all
conditions in voicecall_dial are satisfied and it returns 0, the modem
driver still fails to dispatch the ATD.  In which case you will
erroneously return OK.

e.g.:

voicecall_dial ->
	at_modem_dial ->
		emulator_dial_callback
voicecall_dial

you have to be also careful of the timing of the ofono_voicecall_notify
events and the ATD callback.  You should not report cind until you have
sent the final response to the ATD.

Regards,
-Denis

--===============9219922525788039567==--

