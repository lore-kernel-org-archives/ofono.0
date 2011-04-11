Content-Type: multipart/mixed; boundary="===============2324679710898725628=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 5/8] emulator: add +CLIP support for HFP AG
Date: Mon, 11 Apr 2011 10:56:19 -0500
Message-ID: <4DA324A3.7060907@gmail.com>
In-Reply-To: <1302194040-18811-6-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2324679710898725628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/07/2011 11:33 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/emulator.c  |   74 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  src/voicecall.c |   17 +++++++++++-
>  2 files changed, 88 insertions(+), 3 deletions(-)
> =

> diff --git a/src/emulator.c b/src/emulator.c
> index f1ccfb3..7559d07 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -29,6 +29,7 @@
>  #include <glib.h>
>  =

>  #include "ofono.h"
> +#include "common.h"
>  #include "gatserver.h"
>  #include "gatppp.h"
>  =

> @@ -52,6 +53,13 @@ struct ofono_emulator {
>  	gboolean events_ind;
>  	GSList *indicators;
>  	guint ring;
> +	struct ofono_call *incoming;
> +	gboolean clip;
> +	/*
> +	 * '+CLIP: "+",' or '+CCWA: "+",' + phone number
> +	 * + phone type on 3 digits max + terminating null
> +	 */
> +	char incoming_str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];

You can probably get rid of incoming_str and incoming if you use
__ofono_voicecall_find_call_with_type...

>  };
>  =

>  struct indicator {
> @@ -200,6 +208,24 @@ static struct indicator *find_indicator(struct ofono=
_emulator *em,
>  	return NULL;
>  }
>  =

> +static void notify_ring(struct ofono_emulator *em)
> +{
> +	const char *phone;
> +
> +	g_at_server_send_unsolicited(em->server, "RING");
> +
> +	if (em->incoming &&
> +			em->incoming->clip_validity =3D=3D CLIP_VALIDITY_VALID &&
> +			em->incoming_str[0] =3D=3D '\0') {
> +		phone =3D phone_number_to_string(&em->incoming->phone_number);
> +		sprintf(em->incoming_str, "+CLIP: \"%s\",%d", phone,
> +				em->incoming->phone_number.type);
> +	}
> +
> +	if (em->clip && em->incoming_str[0] !=3D '\0')
> +		g_at_server_send_unsolicited(em->server, em->incoming_str);

Keep this simple, I really wouldn't try to optimize a strcpy operation.

> +}
> +
>  static gboolean ring_cb(gpointer user_data)
>  {
>  	struct ofono_emulator *em =3D user_data;
> @@ -211,7 +237,7 @@ static gboolean ring_cb(gpointer user_data)
>  	call_ind =3D find_indicator(em, OFONO_EMULATOR_IND_CALL, NULL);
>  =

>  	if (call_ind->value =3D=3D OFONO_EMULATOR_CALL_INACTIVE)
> -		g_at_server_send_unsolicited(em->server, "RING");
> +		notify_ring(em);
>  =

>  	return TRUE;
>  }
> @@ -426,6 +452,42 @@ fail:
>  	}
>  }
>  =

> +static void clip_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	GAtResultIter iter;
> +	int val;
> +
> +	if (em->slc =3D=3D FALSE)
> +		goto fail;
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (!g_at_result_iter_next_number(&iter, &val))
> +			goto fail;
> +
> +		if (val !=3D 0 && val !=3D 1)
> +			goto fail;
> +
> +		/* check this is last parameter */
> +		if (g_at_result_iter_skip_next(&iter))
> +			goto fail;
> +
> +		em->clip =3D val;
> +
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	default:
> +fail:
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +	};
> +}
> +
>  static void emulator_add_indicator(struct ofono_emulator *em, const char=
* name,
>  					int min, int max, int dflt)
>  {
> @@ -511,6 +573,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
>  		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
>  		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
>  		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
> +		g_at_server_register(em->server, "+CLIP", clip_cb, em, NULL);
>  	}
>  =

>  	__ofono_atom_register(em->atom, emulator_unregister);
> @@ -554,6 +617,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
>  	/* TODO: Check real local features */
>  	em->l_features =3D 32;
>  	em->events_mode =3D 3;	/* default mode is forwarding events */
> +	em->incoming_str[0] =3D '\0';
>  =

>  	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
>  							emulator_remove, em);
> @@ -763,5 +827,13 @@ void ofono_emulator_set_indicator(struct ofono_emula=
tor *em,
>  	} else if (value !=3D OFONO_EMULATOR_CALLSETUP_INCOMING && em->ring) {
>  		g_source_remove(em->ring);
>  		em->ring =3D 0;
> +		em->incoming =3D NULL;
> +		em->incoming_str[0] =3D '\0';
>  	}
>  }
> +
> +void ofono_emulator_incoming_call(struct ofono_emulator *em,
> +					struct ofono_call *call)
> +{
> +	em->incoming =3D call;
> +}
> diff --git a/src/voicecall.c b/src/voicecall.c
> index a3ea6de..8e68243 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -714,6 +714,13 @@ static void emulator_callheld_status_cb(struct ofono=
_atom *atom, void *data)
>  						GPOINTER_TO_INT(data));
>  }
>  =

> +static void emulator_incoming_cb(struct ofono_atom *atom, void *data)
> +{
> +	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
> +
> +	ofono_emulator_incoming_call(em, data);
> +}
> +
>  static void notify_emulator_call_status(struct ofono_voicecall *vc)
>  {
>  	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> @@ -726,6 +733,7 @@ static void notify_emulator_call_status(struct ofono_=
voicecall *vc)
>  	gboolean waiting =3D FALSE;
>  	GSList *l;
>  	struct voicecall *v;
> +	struct ofono_call *caller =3D NULL;
>  =

>  	for (l =3D vc->call_list; l; l =3D l->next) {
>  		v =3D l->data;
> @@ -749,10 +757,12 @@ static void notify_emulator_call_status(struct ofon=
o_voicecall *vc)
>  =

>  		case CALL_STATUS_INCOMING:
>  			incoming =3D TRUE;
> +			caller =3D v->call;
>  			break;
>  =

>  		case CALL_STATUS_WAITING:
>  			waiting =3D TRUE;
> +			caller =3D v->call;
>  			break;
>  		}
>  	}
> @@ -765,9 +775,12 @@ static void notify_emulator_call_status(struct ofono=
_voicecall *vc)
>  						emulator_call_status_cb,
>  						GINT_TO_POINTER(status));
>  =

> -	if (incoming || waiting)
> +	if (incoming || waiting) {
>  		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
> -	else if (dialing)
> +		__ofono_modem_foreach_registered_atom(modem,
> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
> +						emulator_incoming_cb, caller);
> +	} else if (dialing)
>  		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
>  	else if (alerting)
>  		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;

Regards,
-Denis

--===============2324679710898725628==--

