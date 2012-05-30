Content-Type: multipart/mixed; boundary="===============3960191647119315295=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wavecom: add support for Wavecom Q2403/Q2686 modems
Date: Wed, 30 May 2012 00:15:53 -0500
Message-ID: <4FC5AD09.5090103@gmail.com>
In-Reply-To: <1338257667-24281-3-git-send-email-pablo@gnumonks.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3960191647119315295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pablo,

On 05/28/2012 09:14 PM, pablo(a)gnumonks.org wrote:
> From: Pablo Neira Ayuso<pablo@gnumonks.org>
>
> This patch extends the existing wavecom plugin to include the new
> wavecom 2xxx plugin.
> ---
>   plugins/udev.c    |   15 ++++++++++++
>   plugins/wavecom.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++-----
>   2 files changed, 86 insertions(+), 6 deletions(-)
>

Please break this patch into two, one for adding the udev logic and one =

for wavecom stuff...

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 8cb87a5..6e3205e 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -167,6 +167,19 @@ static void add_calypso(struct ofono_modem *modem,
>   	ofono_modem_register(modem);
>   }
>
> +static void add_wavecom_q2xxx(struct ofono_modem *modem,
> +					struct udev_device *udev_device)

please rename this into add_wavecom.

> +{
> +	const char *devnode;
> +
> +	DBG("modem %p", modem);
> +
> +	devnode =3D udev_device_get_devnode(udev_device);
> +	ofono_modem_set_string(modem, "Device", devnode);

Since this is a serial device, you can easily do something like this in =

your rules file:

ENV{OFONO_WAVECOM_MODEL}=3D"Q2XXX"

This setting can then be forwarded to the modem driver by using =

ofono_modem_set_string(modem, "Model" (or Quirk, or whatever), ...);

There is no need to create a separate driver for the wavecom.

See add_ifx() for an example of this.

> +
> +	ofono_modem_register(modem);
> +}
> +
>   static void add_tc65(struct ofono_modem *modem,
>   			struct udev_device *udev_device)
>   {
> @@ -286,6 +299,8 @@ done:
>   		add_nokiacdma(modem, udev_device);
>   	else if (g_strcmp0(driver, "sim900") =3D=3D 0)
>   		add_sim900(modem, udev_device);
> +	else if (g_strcmp0(driver, "wavecom_q2xxx") =3D=3D 0)
> +		add_wavecom_q2xxx(modem, udev_device);
>   }
>
>   static gboolean devpath_remove(gpointer key, gpointer value, gpointer u=
ser_data)
> diff --git a/plugins/wavecom.c b/plugins/wavecom.c
> index 5d30f39..c8bd55b 100644
> --- a/plugins/wavecom.c
> +++ b/plugins/wavecom.c
> @@ -66,7 +66,7 @@ static void wavecom_debug(const char *str, void *user_d=
ata)
>   	ofono_info("%s%s", prefix, str);
>   }
>
> -static int wavecom_enable(struct ofono_modem *modem)
> +static int wavecom_generic_enable(struct ofono_modem *modem, int vendor)
>   {
>   	GAtChat *chat;
>   	GIOChannel *channel;
> @@ -104,6 +104,8 @@ static int wavecom_enable(struct ofono_modem *modem)
>   	syntax =3D g_at_syntax_new_gsm_permissive();
>
>   	chat =3D g_at_chat_new(channel, syntax);
> +	if (vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX)
> +		g_at_chat_add_terminator(chat, "+CPIN: READY", -1, TRUE);

Please do this inside drivers/atmodem/sim.c?  In at_sim_probe() =

specifically.

>   	g_at_syntax_unref(syntax);
>   	g_io_channel_unref(channel);
>
> @@ -118,6 +120,16 @@ static int wavecom_enable(struct ofono_modem *modem)
>   	return 0;
>   }
>
> +static int wavecom_enable(struct ofono_modem *modem)
> +{
> +	return wavecom_generic_enable(modem, OFONO_VENDOR_WAVECOM);
> +}
> +
> +static int wavecom_q2xxx_enable(struct ofono_modem *modem)
> +{
> +	return wavecom_generic_enable(modem, OFONO_VENDOR_WAVECOM_Q2XXX);
> +}
> +
>   static int wavecom_disable(struct ofono_modem *modem)
>   {
>   	GAtChat *chat =3D ofono_modem_get_data(modem);
> @@ -131,18 +143,32 @@ static int wavecom_disable(struct ofono_modem *mode=
m)
>   	return 0;
>   }
>
> -static void wavecom_pre_sim(struct ofono_modem *modem)
> +static void wavecom_generic_pre_sim(struct ofono_modem *modem, int vendo=
r)
>   {
>   	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	struct ofono_sim *sim;
>
>   	DBG("%p", modem);
>
>   	ofono_devinfo_create(modem, 0, "atmodem", chat);
> -	ofono_sim_create(modem, OFONO_VENDOR_WAVECOM, "atmodem", chat);
> +	sim =3D ofono_sim_create(modem, vendor, "atmodem", chat);
> +	if (vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX)
> +		ofono_sim_inserted_notify(sim, TRUE);
> +

Do something like:
vendor =3D 0;

if ofono_modem_get_string(modem, "Model") equals "Q2XXX":
	vendor =3D OFONO_VENDOR_WAVECOM_Q2XXX;

ofono_sim_create(...);

>   	ofono_voicecall_create(modem, 0, "atmodem", chat);
>   }
>
> -static void wavecom_post_sim(struct ofono_modem *modem)
> +static void wavecom_pre_sim(struct ofono_modem *modem)
> +{
> +	wavecom_generic_pre_sim(modem, OFONO_VENDOR_WAVECOM);
> +}
> +
> +static void wavecom_q2xxx_pre_sim(struct ofono_modem *modem)
> +{
> +	wavecom_generic_pre_sim(modem, OFONO_VENDOR_WAVECOM_Q2XXX);
> +}
> +
> +static void wavecom_generic_post_sim(struct ofono_modem *modem, int vend=
or)
>   {
>   	GAtChat *chat =3D ofono_modem_get_data(modem);
>   	struct ofono_message_waiting *mw;
> @@ -155,7 +181,8 @@ static void wavecom_post_sim(struct ofono_modem *mode=
m)
>   	ofono_netreg_create(modem, 0, "atmodem", chat);
>   	ofono_call_meter_create(modem, 0, "atmodem", chat);
>   	ofono_call_barring_create(modem, 0, "atmodem", chat);
> -	ofono_sms_create(modem, 0, "atmodem", chat);
> +	/* We have to specify the vendor to support AT+CPMS=3D? reply in Q2xxx =
*/
> +	ofono_sms_create(modem, vendor, "atmodem", chat);
>   	ofono_phonebook_create(modem, 0, "atmodem", chat);
>
>   	mw =3D ofono_message_waiting_create(modem);
> @@ -163,6 +190,16 @@ static void wavecom_post_sim(struct ofono_modem *mod=
em)
>   		ofono_message_waiting_register(mw);
>   }
>
> +static void wavecom_post_sim(struct ofono_modem *modem)
> +{
> +	wavecom_generic_post_sim(modem, OFONO_VENDOR_WAVECOM);
> +}
> +
> +static void wavecom_q2xxx_post_sim(struct ofono_modem *modem)
> +{
> +	wavecom_generic_post_sim(modem, OFONO_VENDOR_WAVECOM_Q2XXX);
> +}
> +
>   static struct ofono_modem_driver wavecom_driver =3D {
>   	.name		=3D "wavecom",
>   	.probe		=3D wavecom_probe,
> @@ -173,15 +210,43 @@ static struct ofono_modem_driver wavecom_driver =3D=
 {
>   	.post_sim	=3D wavecom_post_sim,
>   };
>
> +static struct ofono_modem_driver wavecom_q2xxx_driver =3D {
> +	.name		=3D "wavecom_q2xxx",
> +	.probe		=3D wavecom_probe,
> +	.remove		=3D wavecom_remove,
> +	.enable		=3D wavecom_q2xxx_enable,
> +	.disable	=3D wavecom_disable,
> +	.pre_sim	=3D wavecom_q2xxx_pre_sim,
> +	.post_sim	=3D wavecom_q2xxx_post_sim,
> +};
> +
>   static int wavecom_init(void)
>   {
> -	return ofono_modem_driver_register(&wavecom_driver);
> +	int ret;
> +
> +	ret =3D ofono_modem_driver_register(&wavecom_driver);
> +	if (ret<  0)
> +		goto err;
> +
> +	ret =3D ofono_modem_driver_register(&wavecom_q2xxx_driver);
> +	if (ret<  0)
> +		goto err_wavecom;
> +
> +	return ret;
> +
> +err_wavecom:
> +	ofono_modem_driver_unregister(&wavecom_driver);
> +err:
> +	return ret;
>   }
>
>   static void wavecom_exit(void)
>   {
>   	ofono_modem_driver_unregister(&wavecom_driver);
> +	ofono_modem_driver_unregister(&wavecom_q2xxx_driver);
>   }
>
>   OFONO_PLUGIN_DEFINE(wavecom, "Wavecom driver", VERSION,
>   		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_init, wavecom_exit)
> +OFONO_PLUGIN_DEFINE(wavecom_q2xxx, "Wavecom Q2XXX driver", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_init, wavecom_exit)

The rest of this is really unnecessary, there is no need to register =

multiple modem drivers or any other fancy stuff ;)

Regards,
-Denis

--===============3960191647119315295==--

