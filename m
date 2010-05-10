Content-Type: multipart/mixed; boundary="===============5193354490562210059=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/6] Add calypsomodem STK driver.
Date: Mon, 10 May 2010 15:18:29 -0500
Message-ID: <201005101518.29790.denkenz@gmail.com>
In-Reply-To: <1273192055-11276-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5193354490562210059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> There is an issue with the atom drivers not running at the time we issue
> AT+CFUN=3D1 so if that triggers an important notification, it'll be lost.
> It could be fixed properly but with major change to initialisation order,
> instead I added an extra ugly hack to store the initial %SATI
> notification, please comment if that it too ugly :)

What is the proper way? :)  Given that SATI needs to be preserved and the =

contents stored for future reference I agree your proposal is the best way =
to =

do it.

> +void calypsomodem_stk_sati_notify(struct ofono_stk *stk,
> +		const guint8 *pdu, gint len)
> +{
> +	struct stk_data *sd =3D ofono_stk_get_data(stk);
> +	int length_bytes;
> +
> +	ofono_stk_proactive_command_notify(stk, len, pdu);
> +
> +	/* Check if this is a Set Up Menu command, if so, cache the PDU
> +	 * because Calypso sends it only once.  */
> +
> +	while (len > 0 && (*pdu =3D=3D 0x00 || *pdu =3D=3D 0xff))
> +		pdu++, len--;
> +	if (len < 7)
> +		return;
> +	if (pdu[0] !=3D 0xd0) /* Command BER-TLV tag */
> +		return;
> +	if (pdu[1] < 0x80)
> +		length_bytes =3D 1;
> +	else
> +		length_bytes =3D pdu[1] - 0x7f;
> +	if (len < length_bytes + 6)
> +		return;
> +	if (pdu[1 + length_bytes] !=3D 0x01) /* Command Details CTLV tag */
> +		return;
> +	if (pdu[2 + length_bytes] !=3D 0x03) /* Command Details CTLV length */
> +		return;
> +	if (pdu[4 + length_bytes] !=3D 0x25) /* Set Up Menu command type */
> +		return;
> +
> +	if (sd->set_up_menu_pdu)
> +		g_free(sd->set_up_menu_pdu);
> +
> +	sd->set_up_menu_pdu =3D g_memdup(pdu, len);
> +	sd->set_up_menu_pdu_len =3D len;
> +}

Can we implement SetUp menu command parser or at least use tlv iterators? T=
his =

is just too ugly.

>  struct phonesim_data {
>  	GAtMux *mux;
>  	GAtChat *chat;
>  	gboolean calypso;
>  	gboolean use_mux;
> +	gboolean have_sim;
> +
> +	guint sati_cb_id;
> +	unsigned int stk_watch;
> +	guint8 *stk_early_pdu;
> +	guint stk_early_pdu_len;
>  };
> =

> +static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> +static const char *none_prefix[] =3D { NULL };
> +
>  static int phonesim_probe(struct ofono_modem *modem)
>  {
>  	struct phonesim_data *data;
> @@ -98,13 +109,32 @@ static void phonesim_debug(const char *str, void
>  *user_data) ofono_info("%s", str);
>  }
> =

> +static void cpin_check_cb(gboolean ok, GAtResult *result, gpointer
>  user_data) +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct phonesim_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	data->have_sim =3D ok;
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +

Again, looks like this belongs in a separate patch...

> +static void cfun_enable(struct phonesim_data *data, struct ofono_modem
>  *modem) +{
> +	/* It looks like the PROFILE DOWNLOAD is done by the modem
> +	 * as part of +CFUN=3D1.  By default the profile indicates that
> +	 * TE supports no Proactive UICC.  We need to enable the
> +	 * %SATA and other notifications here for STK support and
> +	 * give the modem our profile bits (first N bytes) according
> +	 * to ETSI TS 102 223 section 5.2.  The modem seems to AND
> +	 * the given value with its own capabilities and OR with some
> +	 * minimum value.  The bits are reset to the minimal values
> +	 * on +CFUN=3D0.
> +	 *
> +	 * Default value is 450F80021F0000A4020000000000000000000000.
> +	 * The mask is 4DFF973F7F0200FC0303FF00009FFFE700000000.
> +	 */
> +	g_at_chat_send(data->chat,
> +			"AT%SATC=3D1,\"19E1FFFF0000FF7FFF03FE\"",
> +			none_prefix, NULL, NULL);
> +
> +	/* The initial %SATI notification should arrive together with
> +	 * AT+CFUN=3D1 response, that may be before the STK driver registers
> +	 * the notification.  At the same time with Calypso we can't
> +	 * lose this first notification or STK will not be
> +	 * functional.  This is a hack to save the PDU and supply it
> +	 * to STK driver once it's brought up.
> +	 */
> +	data->sati_cb_id =3D g_at_chat_register(data->chat,
> +			"%SATI:", sati_notify, FALSE, modem, NULL);
> +	data->stk_watch =3D __ofono_modem_add_atom_watch(modem,
> +			OFONO_ATOM_TYPE_STK, stk_watch, modem, NULL);
> +
> +	g_at_chat_send(data->chat, "AT+CFUN=3D1",
> +			none_prefix, cfun_set_on_cb, modem);
> +}
> +

Send this part as a separate patch from calypso stk support and SIM inserte=
d =

changes.

>  static void mux_setup(GAtMux *mux, gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -163,7 +271,7 @@ static void mux_setup(GAtMux *mux, gpointer user_data)
>  	if (data->calypso)
>  		g_at_chat_set_wakeup_command(data->chat, "AT\r", 500, 5000);
> =

> -	g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem);
> +	cfun_enable(data, modem);
>  }
> =

>  static int phonesim_enable(struct ofono_modem *modem)
> @@ -246,8 +354,7 @@ static int phonesim_enable(struct ofono_modem *modem)
>  		g_at_chat_unref(data->chat);
>  		data->chat =3D NULL;
>  	} else {
> -		g_at_chat_send(data->chat, "AT+CFUN=3D1", NULL,
> -					cfun_set_on_cb, modem);
> +		cfun_enable(data, modem);
>  	}
> =

>  	return -EINPROGRESS;
> @@ -276,20 +383,16 @@ static void phonesim_pre_sim(struct ofono_modem
>  *modem) {
>  	struct phonesim_data *data =3D ofono_modem_get_data(modem);
>  	struct ofono_sim *sim;
> +	const char *drivername =3D data->calypso ? "calypsomodem" : "atmodem";
> =

>  	DBG("%p", modem);
> =

>  	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
>  	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
> +	ofono_voicecall_create(modem, 0, drivername, data->chat);
> +	ofono_stk_create(modem, 0, drivername, data->chat);
> =

> -	if (data->calypso)
> -		ofono_voicecall_create(modem, 0, "calypsomodem", data->chat);
> -	else
> -		ofono_voicecall_create(modem, 0, "atmodem", data->chat);
> -
> -	ofono_stk_create(modem, 0, "atmodem", data->chat);
> -
> -	if (sim)
> +	if (data->have_sim && sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
>  }
> =


Regards,
-Denis

--===============5193354490562210059==--

