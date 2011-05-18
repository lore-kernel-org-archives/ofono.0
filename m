Content-Type: multipart/mixed; boundary="===============2123161717469541155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecall: add ATD support for HFP emulator
Date: Tue, 17 May 2011 23:53:02 -0500
Message-ID: <4DD350AE.6020809@gmail.com>
In-Reply-To: <1305211258-8189-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2123161717469541155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 05/12/2011 09:40 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/voicecall.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 92 insertions(+), 0 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 037caac..b98c858 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -2473,6 +2473,10 @@ static void emulator_hfp_unregister(struct ofono_a=
tom *atom)
>  						OFONO_ATOM_TYPE_EMULATOR_HFP,
>  						emulator_remove_handler,
>  						"+CHLD");
> +	__ofono_modem_foreach_registered_atom(modem,
> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
> +						emulator_remove_handler,
> +						"D");
>  =

>  	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
>  }
> @@ -2918,6 +2922,93 @@ fail:
>  	ofono_emulator_send_final(em, &result);
>  }
>  =

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
> +	enum ofono_clir_option clir;
> +	struct ofono_error result;
> +	enum dial_error err;
> +
> +	result.error =3D 0;
> +
> +	if (number =3D=3D NULL || number[0] =3D=3D '\0') {
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +		goto send;
> +	}
> +
> +	if (!strncmp(number, "*31#", 4)) {
> +		number +=3D 4;
> +		clir =3D OFONO_CLIR_OPTION_INVOCATION;
> +	} else if (!strncmp(number, "#31#", 4)) {
> +		number +=3D 4;
> +		clir =3D  OFONO_CLIR_OPTION_SUPPRESSION;
> +	} else
> +		clir =3D OFONO_CLIR_OPTION_DEFAULT;
> +

Actually this is not quite right.  The clir option is determined by the
presence of 'I'/'i' characters at the end of the dial string.  Refer to
27.007 for more details.

oFono does not actually recognize temporary forms of *31/#31 invocation yet.

> +	err =3D voicecall_dial(vc, number, clir, emulator_dial_callback, vc);
> +	switch (err) {
> +	case DIAL_NO_ERROR:
> +		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +		break;
> +
> +	case DIAL_NO_NETWORK:
> +		result.error =3D 30;
> +		result.type =3D OFONO_ERROR_TYPE_CME;
> +		break;

This might need to be NO CARRIER

> +
> +	case DIAL_INVALID_PHONE:
> +	case DIAL_NOT_SUPPORTED:
> +	case DIAL_TOO_MANY_CALLS:
> +	case DIAL_INCOMING:
> +	case DIAL_BUSY:
> +	case DIAL_ACTIVE:
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +	}
> +
> +send:
> +	ofono_emulator_send_final(em, &result);
> +}
> +
> +static void emulator_atd_cb(struct ofono_emulator *em,
> +			struct ofono_emulator_request *req, void *userdata)
> +{
> +	struct ofono_voicecall *vc =3D userdata;
> +	const char *str;
> +	struct ofono_error result;
> +
> +	switch (ofono_emulator_request_get_type(req)) {
> +	case OFONO_EMULATOR_REQUEST_TYPE_SET:
> +		str =3D ofono_emulator_request_get_raw(req);
> +		emulator_dial(em, vc, str);
> +		break;
> +
> +	default:
> +		result.error =3D 0;
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +		ofono_emulator_send_final(em, &result);
> +	};
> +}
> +
>  static void emulator_hfp_watch(struct ofono_atom *atom,
>  				enum ofono_atom_watch_condition cond,
>  				void *data)
> @@ -2933,6 +3024,7 @@ static void emulator_hfp_watch(struct ofono_atom *a=
tom,
>  	ofono_emulator_add_handler(em, "+CHUP", emulator_chup_cb, data, NULL);
>  	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
>  	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
> +	ofono_emulator_add_handler(em, "D", emulator_atd_cb, data, NULL);
>  }
>  =

>  void ofono_voicecall_register(struct ofono_voicecall *vc)

Regards,
-Denis

--===============2123161717469541155==--

