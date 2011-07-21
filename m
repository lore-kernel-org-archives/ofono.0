Content-Type: multipart/mixed; boundary="===============1721933420377730589=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/2] speedup: add cpin polling mechanism
Date: Thu, 21 Jul 2011 05:32:00 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F062E5@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311180775-20983-2-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1721933420377730589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>  plugins/speedup.c |   64
> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 63 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/speedup.c b/plugins/speedup.c
> index 7e89b6f..23ba173 100644
> --- a/plugins/speedup.c
> +++ b/plugins/speedup.c
> @@ -49,10 +49,14 @@
>  #include <drivers/atmodem/vendor.h>
> =

>  static const char *none_prefix[] =3D { NULL };
> +static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> =

>  struct speedup_data {
>  	GAtChat *modem;
>  	GAtChat *aux;
> +	guint cpin_poll_source;
> +	guint cpin_poll_count;
> +	gboolean have_sim;
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
>  };
> @@ -83,6 +87,9 @@ static void speedup_remove(struct ofono_modem *modem)
>  	g_at_chat_unref(data->modem);
>  	g_at_chat_unref(data->aux);
> =

> +	if (data->cpin_poll_source > 0)
> +		g_source_remove(data->cpin_poll_source);
> +
>  	g_free(data);
>  }
> =

> @@ -152,13 +159,68 @@ static void speedup_disconnect(gpointer user_data)
>  		ofono_gprs_add_context(data->gprs, data->gc);
>  }
> =

> +static gboolean init_simpin_check(gpointer user_data);
> +
> +static void simpin_check(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_error error;
> +
> +	DBG("");
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	/* Modem returns an error if SIM is not ready. */
> +	switch (error.error) {
> +	case 10:
> +	case 13:
> +		data->have_sim =3D FALSE;
> +		break;
> +	case 14: /* SIM Busy, wait and check again the SIM pin status */
> +		if (data->cpin_poll_count++ < 5) {
> +			data->cpin_poll_source =3D
> +				g_timeout_add_seconds(1, init_simpin_check,
> +						modem);
> +			return;
> +		}
> +		/*SIM card is present but not accessible*/
> +		data->have_sim =3D FALSE;
> +		break;
> +	default:
> +		data->have_sim =3D TRUE;
> +	}
> +
> +	data->cpin_poll_count =3D 0;
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static gboolean init_simpin_check(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	data->cpin_poll_source =3D 0;
> +
> +	g_at_chat_send(data->modem, "AT+CPIN?", cpin_prefix,
> +			simpin_check, modem, NULL);

The command need to be sent to Aux at chat and not Modem. Modem should be u=
sed only for the data call.

> +
> +	return FALSE;
> +}
> +
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
>  	struct ofono_modem *modem =3D user_data;
> =

>  	DBG("");
> =

> -	ofono_modem_set_powered(modem, ok);
> +	if (!ok) {
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	init_simpin_check(modem);
>  }
> =

>  static int speedup_enable(struct ofono_modem *modem)

Thanks,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============1721933420377730589==--

