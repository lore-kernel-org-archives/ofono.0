Content-Type: multipart/mixed; boundary="===============0135649275116126887=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] telit: notify sim inserted when sim ready
Date: Mon, 13 Aug 2012 08:23:18 -0500
Message-ID: <5028FFC6.2030807@gmail.com>
In-Reply-To: <1344863812-22857-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0135649275116126887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/13/2012 08:16 AM, Christopher Vogl wrote:
> Use AT#QSS=3D2 instead of AT#QSS=3D1 to get an URC when the SIM is not on=
ly
> inserted but ready to be used.
>
> Remove sim_inserted_source and sim_inserted_timeout_cb which are not
> needed anymore as a consequence.
> By the way the 1 second timeout was an ugly hack.
>
> Don't query current SIM status in cfun_enable_cb() as the SIM is
> disabled due to prior AT+CFUN=3D4.
>
> Remove telit_qss_cb() which was used as a callback for querying the
> current SIM status.
> ---
>   plugins/telit.c |   44 ++++++++++----------------------------------
>   1 files changed, 10 insertions(+), 34 deletions(-)
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index 6ae7249..853fd44 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -68,7 +68,6 @@ struct telit_data {
>   	GAtChat *chat;
>   	GAtChat *aux;
>   	struct ofono_sim *sim;
> -	guint sim_inserted_source;
>   	struct ofono_modem *sap_modem;
>   	GIOChannel *bt_io;
>   	GIOChannel *hw_io;
> @@ -211,20 +210,6 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>   	return chat;
>   }
>
> -static gboolean sim_inserted_timeout_cb(gpointer user_data)
> -{
> -	struct ofono_modem *modem =3D user_data;
> -	struct telit_data *data =3D ofono_modem_get_data(modem);
> -
> -	DBG("%p", modem);
> -
> -	data->sim_inserted_source =3D 0;
> -
> -	ofono_sim_inserted_notify(data->sim, TRUE);
> -
> -	return FALSE;
> -}
> -
>   static void switch_sim_state_status(struct ofono_modem *modem, int stat=
us)
>   {
>   	struct telit_data *data =3D ofono_modem_get_data(modem);
> @@ -238,16 +223,13 @@ static void switch_sim_state_status(struct ofono_mo=
dem *modem, int status)
>   		break;
>   	case 1:
>   		DBG("SIM inserted");
> -		/* We need to sleep a bit */
> -		data->sim_inserted_source =3D g_timeout_add_seconds(1,
> -							sim_inserted_timeout_cb,
> -							modem);
>   		break;
>   	case 2:
>   		DBG("SIM inserted and PIN unlocked");
>   		break;
>   	case 3:
>   		DBG("SIM inserted and ready");
> +		ofono_sim_inserted_notify(data->sim, TRUE);
>   		break;
>   	}

According to Telit documentation 1 is inserted, 2 is inserted and pin =

unlocked, 3 is unlocked and phonebook ready.  How do you plan on =

handling PIN-locked SIMs?  You can't run commands such as EnterPin until =

the sim is at least inserted.

You might need to do the same thing as we did for e.g. IFX and STE. =

notify sim insertion on #QSS: 1, and only return from CPIN once #QSS: 3 =

has been sent.  See drivers/atmodem/sim.c at_epev_notify() or =

at_xsim_notify() for an example.

>   }
> @@ -270,6 +252,13 @@ static void telit_qss_notify(GAtResult *result, gpoi=
nter user_data)
>   	switch_sim_state_status(modem, status);
>   }
>
> +/*
> + * This function was used as a callback for querying the current SIM sta=
tus
> + * with 'AT#QSS?'. As this was done in cfun_enable_cb(), in a state wher=
e the
> + * SIM is disabled because of 'AT+CFUN=3D4', the querying was removed.
> + * As soon as the modem is set online with 'AT+CFUN=3D1' (SIM is enabled=
 again),
> + * we will start receiving QSS notifications - which makes querying the =
SIM
> + * status redundant.
>   static void telit_qss_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
>   {
>   	struct ofono_modem *modem =3D user_data;
> @@ -288,6 +277,7 @@ static void telit_qss_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>
>   	switch_sim_state_status(modem, status);
>   }
> +*/

Please don't comment out functions.  We should not have dead code in the =

source. This comment can go into the patch description.  The git history =

will preserve it for posterity.

>
>   static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
>   {
> @@ -308,15 +298,11 @@ static void cfun_enable_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
>   	ofono_modem_set_powered(m, TRUE);
>
>   	/* Enable sim state notification */
> -	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
>
>   	/* Follow sim state */
>   	g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
>   				FALSE, modem, NULL);
> -
> -	/* Query current sim state */
> -	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
> -				telit_qss_cb, modem, NULL);
>   }
>
>   static int telit_enable(struct ofono_modem *modem)
> @@ -397,9 +383,6 @@ static void cfun_disable_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>   	g_at_chat_unref(data->chat);
>   	data->chat =3D NULL;
>
> -	if (data->sim_inserted_source>  0)
> -		g_source_remove(data->sim_inserted_source);
> -
>   	if (ok)
>   		ofono_modem_set_powered(modem, FALSE);
>
> @@ -650,18 +633,11 @@ static int telit_probe(struct ofono_modem *modem)
>
>   static void telit_remove(struct ofono_modem *modem)
>   {
> -	struct telit_data *data =3D ofono_modem_get_data(modem);
> -
>   	DBG("%p", modem);
>
>   	bluetooth_sap_client_unregister(modem);
>
>   	ofono_modem_set_data(modem, NULL);
> -
> -	if (data->sim_inserted_source>  0)
> -		g_source_remove(data->sim_inserted_source);
> -
> -	g_free(data);
>   }
>
>   static struct ofono_modem_driver telit_driver =3D {

Regards,
-Denis

--===============0135649275116126887==--

