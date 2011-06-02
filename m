Content-Type: multipart/mixed; boundary="===============6487199254417715239=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH V3 2/4] voicecall: add ATD support for HFP emulator
Date: Wed, 01 Jun 2011 21:08:52 -0500
Message-ID: <4DE6F0B4.10208@gmail.com>
In-Reply-To: <1306927463-10642-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6487199254417715239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 06/01/2011 06:24 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/voicecall.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 109 insertions(+), 0 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 26fe3e4..a6ccddd 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -71,6 +71,7 @@ struct ofono_voicecall {
>  	GQueue *toneq;
>  	guint tone_source;
>  	unsigned int hfp_watch;
> +	struct ofono_emulator *pending_em;

I think you're on the right track, but...

>  };
>  =

>  struct voicecall {
> @@ -745,10 +746,14 @@ static void notify_emulator_call_status(struct ofon=
o_voicecall *vc)
>  			break;
>  =

>  		case CALL_STATUS_DIALING:
> +			if (v->vc->pending_em)
> +				return;
>  			dialing =3D TRUE;
>  			break;
>  =

>  		case CALL_STATUS_ALERTING:
> +			if (v->vc->pending_em)
> +				return;
>  			alerting =3D TRUE;
>  			break;
>  =


You can't really do it this way since you might have several emulators
active at once, and you want to make sure that only the one with the
pending ATD doesn't receive updates until ATD returns.

One thing you might try is to skip sending updates to the emulator if it
is equal to pending_em inside emulator_call_status_cb /
emulator_callheld_status_cb / emulator_callsetup_status_cb

> @@ -2453,6 +2458,10 @@ static void emulator_hfp_unregister(struct ofono_a=
tom *atom)
>  						OFONO_ATOM_TYPE_EMULATOR_HFP,
>  						emulator_remove_handler,
>  						"+VTS");
> +	__ofono_modem_foreach_registered_atom(modem,
> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
> +						emulator_remove_handler,
> +						"D");
>  =

>  	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
>  }
> @@ -2941,6 +2950,105 @@ static void emulator_vts_cb(struct ofono_emulator=
 *em,
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

Setting number to NULL is actually wrong.  dial_handle_result needs a
proper number, so you must track it somehow.  The only reason we set it
to NULL in e.g. manager_dial_callback is to get around the compiler
nagging us of uninitialized variables (which will never happen unless
something truly bizarre is happening.)

> +	if (v =3D=3D NULL) {
> +		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> +
> +		if (is_emergency_number(vc, number) =3D=3D TRUE)
> +			__ofono_modem_dec_emergency_mode(modem);
> +	}
> +
> +	ofono_emulator_send_final(vc->pending_em, error);
> +
> +	vc->pending_em =3D NULL;
> +
> +	notify_emulator_call_status(vc);
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
> +	if (vc->pending_em) {
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +		goto send;
> +	}

You might also want to check that the Dial is not happening via D-Bus or
STK, and vice-versa.

> +
> +	vc->pending_em =3D em;
> +
> +	err =3D voicecall_dial(vc, number, OFONO_CLIR_OPTION_DEFAULT,
> +					emulator_dial_callback, vc);
> +
> +	if (err >=3D 0)
> +		return;
> +
> +	vc->pending_em =3D NULL;
> +
> +	switch (err) {
> +	case -ENETDOWN:
> +		result.error =3D 30;
> +		result.type =3D OFONO_ERROR_TYPE_CME;
> +		break;
> +
> +	default:
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
> +	size_t len;
> +	char number[OFONO_MAX_PHONE_NUMBER_LENGTH + 1];
> +	struct ofono_error result;
> +
> +	switch (ofono_emulator_request_get_type(req)) {
> +	case OFONO_EMULATOR_REQUEST_TYPE_SET:
> +		str =3D ofono_emulator_request_get_raw(req);
> +
> +		if (str =3D=3D NULL || str[0] =3D=3D '\0')
> +			goto fail;
> +
> +		len =3D strlen(str);
> +
> +		if (len > OFONO_MAX_PHONE_NUMBER_LENGTH + 1 ||
> +				str[len - 1] !=3D ';')
> +			goto fail;
> +
> +		strncpy(number, str, len - 1);
> +		number[len - 1] =3D '\0';
> +
> +		emulator_dial(em, vc, number);
> +		break;
> +
> +	default:
> +fail:
> +		result.error =3D 0;
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +		ofono_emulator_send_final(em, &result);
> +	};
> +}
> +
>  static void emulator_hfp_watch(struct ofono_atom *atom,
>  				enum ofono_atom_watch_condition cond,
>  				void *data)
> @@ -2957,6 +3065,7 @@ static void emulator_hfp_watch(struct ofono_atom *a=
tom,
>  	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
>  	ofono_emulator_add_handler(em, "+CHLD", emulator_chld_cb, data, NULL);
>  	ofono_emulator_add_handler(em, "+VTS", emulator_vts_cb, data, NULL);
> +	ofono_emulator_add_handler(em, "D", emulator_atd_cb, data, NULL);
>  }
>  =

>  void ofono_voicecall_register(struct ofono_voicecall *vc)

Regards,
-Denis

--===============6487199254417715239==--

