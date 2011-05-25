Content-Type: multipart/mixed; boundary="===============0930549380623708385=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 3/3] udev: add Telit UC864-G and update udev rules
Date: Wed, 25 May 2011 12:10:30 -0700
Message-ID: <1306350630.2681.41.camel@aeonflux>
In-Reply-To: <1306329265-12066-3-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0930549380623708385==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernard,

> *for now only check for Modem, add GPS later
> =

> Co-authored-by: Christopher Vogl <Christopher.Vogl@hale.at>
> ---
>  plugins/ofono.rules |    8 ++++++++
>  plugins/udev.c      |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 5a36380..87ef065 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -344,6 +344,14 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"=
1485", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFA=
CE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
>  =

> +#Telit UC864-G
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_TELIT_TYPE}=3D"Modem"
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFA=
CE_NUM}=3D=3D"01", ENV{OFONO_TELIT_TYPE}=3D"Aux"
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFA=
CE_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"GPS"
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFA=
CE_NUM}=3D=3D"03", ENV{OFONO_TELIT_TYPE}=3D"UART"
> +

I can actually look this up, but which ones are you planning to use. I
can see the Modem, Aux and GPS, but what is the UART for?

> +ATTRS{idVendor}=3D=3D"1bc7", ENV{OFONO_DRIVER}=3D"telit"
> +
>  LABEL=3D"ofono_tty_end"
>  =

>  # ISI/Phonet drivers
> diff --git a/plugins/udev.c b/plugins/udev.c
> index cbb596d..28fff72 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -588,6 +588,35 @@ static void add_linktop(struct ofono_modem *modem,
>  	}
>  }
>  =

> +static void add_telit(struct ofono_modem *modem,
> +					struct udev_device *udev_device)
> +{
> +	struct udev_list_entry *entry;
> +	const char *devnode;
> +	gboolean found =3D FALSE;
> +
> +	DBG("modem %p", modem);
> +
> +	entry =3D udev_device_get_properties_list_entry(udev_device);
> +	while (entry) {
> +		const char *name =3D udev_list_entry_get_name(entry);
> +		const char *value =3D udev_list_entry_get_value(entry);
> +
> +		if (g_str_equal(name, "OFONO_TELIT_TYPE") =3D=3D TRUE &&
> +					g_str_equal(value, "Modem") =3D=3D TRUE) {
> +			found =3D TRUE;
> +		}
> +		entry =3D udev_list_entry_get_next(entry);
> +	}
> +
> +	if (found =3D=3D FALSE)
> +		return;
> +
> +	devnode =3D udev_device_get_devnode(udev_device);
> +	ofono_modem_set_string(modem, "Modem", devnode);
> +	ofono_modem_register(modem);
> +}
> +

You can not really do it like this. You have to wait to register the
modem until all mandatory TTYs are present. Especially in case you
require two or more TTYs, which it seems you will.

Check the other ones like Novatel for examples.

>  static void add_modem(struct udev_device *udev_device)
>  {
>  	struct ofono_modem *modem;
> @@ -682,6 +711,8 @@ done:
>  		add_calypso(modem, udev_device);
>  	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
>  		add_tc65(modem, udev_device);
> +	else if (g_strcmp0(driver, "telit") =3D=3D 0)
> +		add_telit(modem, udev_device);
>  	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
>  		add_nokiacdma(modem, udev_device);
>          else if (g_strcmp0(driver, "linktop") =3D=3D 0)

Regards

Marcel



--===============0930549380623708385==--

