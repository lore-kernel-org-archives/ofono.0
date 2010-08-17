Content-Type: multipart/mixed; boundary="===============3151910978126349012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Add: n900modem driver
Date: Tue, 17 Aug 2010 14:19:47 -0500
Message-ID: <4C6AE0D3.5090903@gmail.com>
In-Reply-To: <1281724314-19465-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3151910978126349012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 08/13/2010 01:31 PM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> The N900 modem is based on isimodem. It works natively on N900 with Maemo=
 or
> Meego kernel.
> =

> The configuration option --disable-n900modem can be used to disable it (i=
f,
> for instance, using ofono with Maemo 5 userspace).

Just had a quick look and this caught my eye:

> +static int n900modem_init(void)
> +{
> +	isi_devinfo_init();
> +	isi_phonebook_init();
> +	isi_netreg_init();
> +	isi_voicecall_init();
> +	isi_sms_init();
> +	isi_cbs_init();
> +	isi_sim_init();
> +	isi_ssn_init();
> +	isi_ussd_init();
> +	isi_call_forwarding_init();
> +	isi_call_settings_init();
> +	isi_call_barring_init();
> +	isi_call_meter_init();
> +	isi_radio_settings_init();
> +
> +	ofono_modem_driver_register(&driver);
> +
> +	return 0;
> +}
> +
> +static void n900modem_exit(void)
> +{
> +	ofono_modem_driver_unregister(&driver);
> +
> +	isi_devinfo_exit();
> +	isi_phonebook_exit();
> +	isi_netreg_exit();
> +	isi_voicecall_exit();
> +	isi_sms_exit();
> +	isi_cbs_exit();
> +	isi_sim_exit();
> +	isi_ssn_exit();
> +	isi_ussd_exit();
> +	isi_call_forwarding_exit();
> +	isi_call_settings_exit();
> +	isi_call_barring_exit();
> +	isi_call_meter_exit();
> +	isi_radio_settings_exit();
> +}
> +

Why are we doing this inside n900modem?  Can't we simply:

1. Make isimodem/isimodem.c register these (just like atmodem, stemodem,
mbmmodem, etc does)
2. Rip out the actual modem driver out of isimodem/isimodem.c
3. Have plugins/n900.c contain the modem driver?

> +OFONO_PLUGIN_DEFINE(n900modem, "Nokia N900 modem driver", VERSION,
> +		OFONO_PLUGIN_PRIORITY_HIGH, n900modem_init, n900modem_exit)
> diff --git a/plugins/usbpnmodem.c b/plugins/usbpnmodem.c
> index 68beb6f..9fcf0c8 100644
> --- a/plugins/usbpnmodem.c
> +++ b/plugins/usbpnmodem.c
> @@ -39,9 +39,22 @@
>  =

>  static GPhonetNetlink *link =3D NULL;
>  =

> +static int match_ifname(char const *name, char const *ifname)
> +{
> +	size_t namelen =3D strlen(name);
> +
> +	if (strncmp(name, ifname, namelen) !=3D 0)
> +		return FALSE;
> +
> +	if (ifname[namelen + strspn(ifname + namelen, "0123456789")] !=3D '\0')
> +		return FALSE;
> +
> +	return TRUE;
> +}
> +
>  /*
>   * Add or remove isimodems
> - * when usbpn* phonet interfaces are added/removed
> + * when usbpn* or phonet* phonet interfaces are added/removed
>   */
>  static void usbpn_status_cb(GIsiModem *idx,
>  				GPhonetLinkState st,
> @@ -50,15 +63,25 @@ static void usbpn_status_cb(GIsiModem *idx,
>  {
>  	struct ofono_modem *modem;
>  	int error;
> +	char const *driver;
> +	uint8_t address =3D 0;
>  =

>  	DBG("Phonet link %s (%u) is %s",
>  		ifname, g_isi_modem_index(idx),
>  		st =3D=3D PN_LINK_REMOVED ? "removed" :
>  		st =3D=3D PN_LINK_DOWN ? "down" : "up");
>  =

> -	/* Expect phonet interface name usbpn<idx> */
> -	if (strncmp(ifname, "usbpn", 5) ||
> -		ifname[5 + strspn(ifname + 5, "0123456789")])
> +	if (match_ifname("usbpn", ifname)) {
> +		driver =3D "isimodem";
> +		address =3D PN_DEV_PC;
> +	} else if (strcmp("phonet0", ifname) =3D=3D 0) {
> +#if HAVE_N900MODEM
> +		driver =3D "n900modem";
> +#else
> +		driver =3D "isimodem";
> +#endif

And this really needs to go...

> +		address =3D PN_DEV_SOS;
> +	} else
>  		return;

Regards,
-Denis

--===============3151910978126349012==--

