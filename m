Content-Type: multipart/mixed; boundary="===============3229046768965718571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: add +CLCC support for HFP emulator
Date: Thu, 21 Apr 2011 16:27:40 -0500
Message-ID: <4DB0A14C.7050806@gmail.com>
In-Reply-To: <1303379997-6238-2-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3229046768965718571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/21/2011 04:59 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> ---
>  src/voicecall.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 2e20c80..49f190a 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -2390,6 +2390,10 @@ static void emulator_hfp_unregister(struct ofono_a=
tom *atom)
>  						OFONO_ATOM_TYPE_EMULATOR_HFP,
>  						emulator_remove_handler,
>  						"A");
> +	__ofono_modem_foreach_registered_atom(modem,
> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
> +						emulator_remove_handler,
> +						"+CLCC");
>  =

>  	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
>  }
> @@ -2604,6 +2608,65 @@ fail:
>  	};
>  }
>  =

> +static void emulator_clcc_cb(struct ofono_emulator *em,
> +			struct ofono_emulator_request *req, void *userdata)
> +{
> +	struct ofono_voicecall *vc =3D userdata;
> +	struct ofono_error result;
> +	GSList *l;
> +	struct voicecall *v;
> +	const char *phone;
> +	gboolean mpty;
> +	/*
> +	 * '+CLCC: 123,1,1,0,1,"+",' + phone number + phone type on 3 digits
> +	 * + terminating null
> +	 */
> +	char buf[OFONO_MAX_PHONE_NUMBER_LENGTH + 26 + 1];
> +
> +	result.error =3D 0;
> +
> +	switch (ofono_emulator_request_get_type(req)) {
> +	case OFONO_EMULATOR_REQUEST_TYPE_COMMAND_ONLY:
> +

Can you remove this empty line here?

> +		for (l =3D vc->call_list; l; l =3D l->next) {
> +			v =3D l->data;
> +
> +			if (g_slist_find_custom(vc->multiparty_list,
> +						GINT_TO_POINTER(v->call->id),
> +						call_compare_by_id))
> +				mpty =3D TRUE;
> +			else
> +				mpty =3D FALSE;
> +
> +			if (v->call->clip_validity !=3D CLIP_VALIDITY_VALID) {
> +				sprintf(buf, "+CLCC: %d,%d,%d,0,%d",
> +					v->call->id, v->call->direction,
> +					v->call->status, mpty);

I suggest you do not omit phone number and type, but use "",128 instead.

> +				goto send;
> +			}
> +
> +			phone =3D phone_number_to_string(&v->call->phone_number);

This is not quite what you want to do.  The phone_number contents can be
passed directly to CLCC.  What phone_number_to_string does is
potentially adds '+' prefix, which is not what you want.

> +
> +			sprintf(buf, "+CLCC: %d,%d,%d,0,%d,\"%s\",%d",
> +					v->call->id, v->call->direction,
> +					v->call->status, mpty, phone,
> +					v->call->phone_number.type);
> +
> +send:
> +			ofono_emulator_send_info(em, buf, l->next =3D=3D NULL ?
> +							TRUE : FALSE);
> +		}
> +
> +		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +		break;
> +
> +	default:
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +	}
> +
> +	ofono_emulator_send_final(em, &result);
> +}
> +
>  static void emulator_hfp_watch(struct ofono_atom *atom,
>  				enum ofono_atom_watch_condition cond,
>  				void *data)
> @@ -2616,6 +2679,7 @@ static void emulator_hfp_watch(struct ofono_atom *a=
tom,
>  	notify_emulator_call_status(data);
>  =

>  	ofono_emulator_add_handler(em, "A", emulator_ata_cb, data, NULL);
> +	ofono_emulator_add_handler(em, "+CLCC", emulator_clcc_cb, data, NULL);
>  }
>  =

>  void ofono_voicecall_register(struct ofono_voicecall *vc)

Regards,
-Denis

--===============3229046768965718571==--

