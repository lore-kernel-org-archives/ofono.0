Content-Type: multipart/mixed; boundary="===============3853384061760853437=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] stemodem: Add SIM/PIN polling and SIM events.
Date: Fri, 13 Aug 2010 13:40:36 -0500
Message-ID: <4C6591A4.3060508@gmail.com>
In-Reply-To: <1281696794-10891-4-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3853384061760853437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/13/2010 05:53 AM, Sjur Br=C3=A6ndeland wrote:
> Copied SIM/PIN handling from MBM.
> o Poll SIM status when initializing
> o STE modem uses PIN entry quirk for mbm as well
> ---
>  drivers/atmodem/sim.c |    9 +++++--
>  plugins/ste.c         |   56 +++++++++++++++++++++++++++++++++++++++++++=
+++--

Please break this up into two patches.

>  2 files changed, 59 insertions(+), 6 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index eb40ad7..8e7c403 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -567,10 +567,12 @@ static void at_pin_send_cb(gboolean ok, GAtResult *=
result,
>  	decode_at_error(&error, g_at_result_final_response(result));
>  =

>  	/*
> -	 * On the MBM modem, AT+CPIN? keeps returning SIM PIN for a moment
> -	 * after successful AT+CPIN=3D"..", but sends *EPEV when that changes.
> +	 * On the MBM and STE modem, AT+CPIN? keeps returning SIM PIN for a
> +	 * moment after successful AT+CPIN=3D"..", but sends *EPEV when that
> +	 * changes.
>  	 */
> -	if (ok && sd->vendor =3D=3D OFONO_VENDOR_MBM) {
> +	if (ok && (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
> +			sd->vendor =3D=3D OFONO_VENDOR_STE)) {
>  		sd->epev_id =3D g_at_chat_register(sd->chat, "*EPEV",
>  							at_epev_notify,
>  							FALSE, cbd, g_free);
> @@ -817,6 +819,7 @@ static int at_sim_probe(struct ofono_sim *sim, unsign=
ed int vendor,
>  	case OFONO_VENDOR_WAVECOM:
>  		g_at_chat_add_terminator(sd->chat, "+CPIN:", 6, TRUE);
>  		break;
> +	case OFONO_VENDOR_STE:
>  	case OFONO_VENDOR_MBM:
>  		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
>  		break;

I'm fine accepting this patch in the interim, but ideally we want to
solve it more generically since every vendor has their own notification
for this.  Please see the "Add support for SIM 'ready' notifications..."
task in the TODO list.

> diff --git a/plugins/ste.c b/plugins/ste.c
> index ab48e18..d82f48e 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -60,8 +60,13 @@
>  #include <drivers/stemodem/caif_socket.h>
>  #include <drivers/stemodem/if_caif.h>
>  =

> +static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> +
>  struct ste_data {
>  	GAtChat *chat;
> +	guint cpin_poll_source;
> +	guint cpin_poll_count;
> +	gboolean have_sim;
>  };
>  =

>  static int ste_probe(struct ofono_modem *modem)
> @@ -88,6 +93,10 @@ static void ste_remove(struct ofono_modem *modem)
>  	ofono_modem_set_data(modem, NULL);
>  =

>  	g_at_chat_unref(data->chat);
> +
> +	if (data->cpin_poll_source > 0)
> +		g_source_remove(data->cpin_poll_source);
> +
>  	g_free(data);
>  }
>  =

> @@ -96,18 +105,58 @@ static void ste_debug(const char *str, void *user_da=
ta)
>  	ofono_info("%s", str);
>  }
>  =

> +static gboolean init_simpin_check(gpointer user_data);
> +
> +static void simpin_check(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ste_data *data =3D ofono_modem_get_data(modem);
> +
> +	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
> +	if (!ok && result->final_or_pdu &&
> +			!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
> +			data->cpin_poll_count++ < 5) {
> +		data->cpin_poll_source =3D
> +			g_timeout_add_seconds(1, init_simpin_check, modem);
> +		return;
> +	}
> +
> +	data->cpin_poll_count =3D 0;
> +
> +	/* Modem returns ERROR if there is no SIM in slot. */
> +	data->have_sim =3D ok;
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static gboolean init_simpin_check(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ste_data *data =3D ofono_modem_get_data(modem);
> +
> +	data->cpin_poll_source =3D 0;
> +
> +	g_at_chat_send(data->chat, "AT+CPIN?", cpin_prefix,
> +			simpin_check, modem, NULL);
> +
> +	return FALSE;
> +}
> +
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
>  	struct ofono_modem *modem =3D user_data;
>  =

>  	DBG("");
>  =

> -	if (!ok)
> +	if (!ok) {
>  		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
>  =

> -	ofono_modem_set_powered(modem, TRUE);
> +	init_simpin_check(modem);
>  }
>  =

> +

Why the extra line?

>  static int ste_enable(struct ofono_modem *modem)
>  {
>  	struct ste_data *data =3D ofono_modem_get_data(modem);
> @@ -168,7 +217,8 @@ static int ste_enable(struct ofono_modem *modem)
>  	if (getenv("OFONO_AT_DEBUG"))
>  		g_at_chat_set_debug(data->chat, ste_debug, NULL);
>  =

> -	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
> +		NULL, NULL, NULL, NULL);

Please indent this one more.

>  	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_enable, modem, NUL=
L);
>  =

>  	return -EINPROGRESS;

Regards,
-Denis

--===============3853384061760853437==--

