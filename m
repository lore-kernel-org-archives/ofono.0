Content-Type: multipart/mixed; boundary="===============4422160229383451851=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] emulator: add AT+CMEE support for HFP
Date: Tue, 05 Apr 2011 00:40:47 -0500
Message-ID: <4D9AAB5F.4050909@gmail.com>
In-Reply-To: <1301667693-7781-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4422160229383451851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

On 04/01/2011 09:21 AM, Olivier Guiter wrote:
> ---
>  src/emulator.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 58 insertions(+), 1 deletions(-)
> =

> diff --git a/src/emulator.c b/src/emulator.c
> index c84f0a9..24897b4 100644
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

> @@ -48,6 +49,7 @@ struct ofono_emulator {
>  	int r_features;
>  	int events_mode;
>  	gboolean events_ind;
> +	char cme_error_ind;

You probably want unsigned char here, since the value is never negative.

>  	GSList *indicators;
>  };
>  =

> @@ -387,6 +389,52 @@ fail:
>  	}
>  }
>  =

> +static void cmee_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	GAtResultIter iter;
> +	int val;
> +	char buf[16];
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "");
> +
> +		if (g_at_result_iter_next_number(&iter, &val) =3D=3D FALSE)
> +			goto fail;
> +
> +		if ((val < 0) && (val > 1))

Please avoid unneeded parentheses whenever possible.

> +			goto fail;
> +
> +		em->cme_error_ind =3D (char)val;

Do you really need this cast?

> +
> +		sprintf(buf, "+CMEE: %d", em->cme_error_ind);
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		sprintf(buf, "+CMEE: %d", em->cme_error_ind);
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> +		/* HFP only support 0 and 1 */
> +		sprintf(buf, "+CMEE: (0,1)");
> +		g_at_server_send_info(em->server, buf, TRUE);
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
> +		break;
> +
> +	default:
> +fail:
> +		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
> +		break;
> +	}
> +}
> +
>  static void emulator_add_indicator(struct ofono_emulator *em, const char=
* name,
>  					int min, int max, int dflt)
>  {
> @@ -462,6 +510,7 @@ void ofono_emulator_register(struct ofono_emulator *e=
m, int fd)
>  		g_at_server_register(em->server, "+BRSF", brsf_cb, em, NULL);
>  		g_at_server_register(em->server, "+CIND", cind_cb, em, NULL);
>  		g_at_server_register(em->server, "+CMER", cmer_cb, em, NULL);
> +		g_at_server_register(em->server, "+CMEE", cmee_cb, em, NULL);
>  	}
>  =

>  	__ofono_atom_register(em->atom, emulator_unregister);
> @@ -505,6 +554,7 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
>  	/* TODO: Check real local features */
>  	em->l_features =3D 32;
>  	em->events_mode =3D 3;	/* default mode is forwarding events */
> +	em->cme_error_ind =3D 0;	/* numeric only */

The comment does not match the initializer?  Do you really mean numeric
only here (e.g. CMEE=3D1) or something like disable cme-error?  What
default does BT-HFP spec suggests?

>  =

>  	em->atom =3D __ofono_modem_add_atom_offline(modem, atom_t,
>  							emulator_remove, em);
> @@ -533,7 +583,14 @@ void ofono_emulator_send_final(struct ofono_emulator=
 *em,
>  		break;
>  =

>  	case OFONO_ERROR_TYPE_CME:
> -		sprintf(buf, "+CME ERROR: %d", final->error);
> +		/* default string */
> +		sprintf(buf, "ERROR");
> +
> +		if (em->cme_error_ind =3D=3D 1)
> +			sprintf(buf, "+CME ERROR: %d", final->error);
> +		else if (em->cme_error_ind =3D=3D 2)
> +			sprintf(buf, "+CME ERROR: %s", telephony_error_to_str(final));
> +

I suspect that a switch/case would be more readable and slightly more
efficient here.

>  		g_at_server_send_ext_final(em->server, buf);
>  		break;
>  =


Regards,
-Denis

--===============4422160229383451851==--

