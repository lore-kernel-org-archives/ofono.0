Content-Type: multipart/mixed; boundary="===============9159277326846926388=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 4/4] udev: add Telit UC864-G and update udev rules
Date: Mon, 13 Jun 2011 04:04:31 -0500
Message-ID: <4DF5D29F.9020703@gmail.com>
In-Reply-To: <1307546317-31831-4-git-send-email-Bernhard.Guillon@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9159277326846926388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bernhard,

On 06/08/2011 10:18 AM, Bernhard.Guillon(a)hale.at wrote:
> From: Bernhard Guillon <Bernhard.Guillon@hale.at>
> =

> *add Modem and GPS check for telit
> *make GPS yes/no configurable with udev rules settings
> **this is necessary because telit has different interface
>   numbers on different modems e.g. GPS and UART
> ---
>  plugins/ofono.rules |    8 +++++
>  plugins/udev.c      |   72 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 80 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/ofono.rules b/plugins/ofono.rules
> index 268b327..64fa4b2 100644
> --- a/plugins/ofono.rules
> +++ b/plugins/ofono.rules
> @@ -344,6 +344,11 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"=
1485", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
>  ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1486", ENV{OFONO_IFA=
CE_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
>  =

> +#Telit UC864-G
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_TEL=
IT_GPS}=3D"1"
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFA=
CE_NUM}=3D=3D"00", ENV{OFONO_TELIT_TYPE}=3D"Modem"
> +ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004", ENV{OFONO_IFA=
CE_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"GPS"
> +

What I would do here is something like:
ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004",
ENV{OFONO_IFACE_NUM}=3D=3D"00", ENV{OFONO_TELIT_TYPE}=3D"Modem"

ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004",
ENV{OFONO_IFACE_NUM}=3D=3D"02", ENV{OFONO_TELIT_TYPE}=3D"GPS"

ATTRS{idVendor}=3D=3D"1bc7", ATTRS{idProduct}=3D=3D"1004",
ENV{OFONO_IFACE_NUM}=3D=3D"03", ENV{OFONO_TELIT_TYPE}=3D"Data"

>  LABEL=3D"ofono_tty_end"
>  =

>  # ISI/Phonet drivers
> @@ -459,4 +464,7 @@ ATTRS{idVendor}=3D=3D"0421", ATTRS{idProduct}=3D=3D"0=
0b6", ENV{OFONO_DRIVER}=3D"nokiacdma"
>  # Teracom (Linktop/LW27x) 3G Data Card
>  ATTRS{idVendor}=3D=3D"230d", ATTRS{idProduct}=3D=3D"0001", ENV{OFONO_DRI=
VER}=3D"linktop"
>  =

> +# Telit
> +ATTRS{idVendor}=3D=3D"1bc7", ENV{OFONO_DRIVER}=3D"telit"
> +
>  LABEL=3D"ofono_end"
> diff --git a/plugins/udev.c b/plugins/udev.c
> index 0234fc0..e56d3db 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -587,6 +587,76 @@ static void add_linktop(struct ofono_modem *modem,
>  	}
>  }
>  =

> +static void add_telit(struct ofono_modem *modem,
> +					struct udev_device *udev_device)
> +{
> +	struct udev_list_entry *entry;
> +	const char *devnode, *type;
> +	int device, gps_device, has_gps;
> +
> +	DBG("modem %p", modem);
> +
> +	/*
> +	 * Some Telit modems have a built in GPS device. According to the
> +	 * manual the the interface numbers can differ between different
> +	 * devices hence we need to use udev rules to set the environment
> +	 * accordingly.
> +	 */
> +	device =3D ofono_modem_get_integer(modem, "ModemRegistered");
> +	gps_device =3D ofono_modem_get_integer(modem, "GPSRegistered");
> +	has_gps =3D ofono_modem_get_integer(modem, "HasGPS");
> +
> +	if ((!has_gps && device) || (device && gps_device))
> +		return;

You can then skip the HasGPS variable.  I would then model the detection
logic after add mbm. e.g. something like:

registered =3D ofono_modem_get_integer(modem, "Registered");

> +
> +	entry =3D udev_device_get_properties_list_entry(udev_device);
> +	while (entry) {
> +		const char *name =3D udev_list_entry_get_name(entry);
> +		type =3D udev_list_entry_get_value(entry);
> +
> +		if (g_str_equal(name, "OFONO_TELIT_GPS") =3D=3D TRUE) {
> +			int value =3D g_str_equal(type, "1");
> +
> +			ofono_modem_set_integer(modem, "HasGPS", value);
> +			entry =3D udev_list_entry_get_next(entry);
> +			continue;
> +		}

drop this if statement

> +
> +		if (g_str_equal(name, "OFONO_TELIT_TYPE") !=3D TRUE) {
> +			entry =3D udev_list_entry_get_next(entry);
> +			continue;
> +		}
> +
> +		if (g_str_equal(type, "Modem") =3D=3D TRUE) {

if (registered =3D=3D 0 && g_str_equal(type, "Modem") =3D=3D TRUE) {
	...

> +

We prefer nested if statements like this to be written like:

if (expression) {
	if ()
		...
}

e.g. no spaces before the nested if.

> +			if (device !=3D 0)
> +				return;
> +
> +			devnode =3D udev_device_get_devnode(udev_device);
> +			ofono_modem_set_string(modem, "Modem", devnode);
> +			device =3D 1;
> +			ofono_modem_set_integer(modem, "ModemRegistered",
> +							device);

Drop the device=3D1 and ofono_modem_set_integer calls..

> +		} else if (g_str_equal(type, "GPS") =3D=3D TRUE) {
> +
> +			if (gps_device !=3D 0)
> +				return;
> +
> +			devnode =3D udev_device_get_devnode(udev_device);
> +			ofono_modem_set_string(modem, "GPS", devnode);
> +
> +			gps_device =3D 1;
> +			ofono_modem_set_integer(modem, "GPSRegistered",
> +							gps_device);
> +		}

Same comments as above for this statement

Then add another if statement detecting the Data port.

> +
> +		break;
> +	}
> +
> +	if ((!has_gps && device) || (device && gps_device))
> +		ofono_modem_register(modem);

Then here do something like:

if (registered =3D=3D 1)
	return;

if (ofono_modem_get_string(modem, "Modem") !=3D NULL &&
		ofono_modem_get_string(modem, "Data") !=3D NULL) {
	ofono_modem_set_integer(modem, "Registered", 1");
	ofono_modem_register(modem);
}

> +}
> +
>  static void add_modem(struct udev_device *udev_device)
>  {
>  	struct ofono_modem *modem;
> @@ -681,6 +751,8 @@ done:
>  		add_calypso(modem, udev_device);
>  	else if (g_strcmp0(driver, "tc65") =3D=3D 0)
>  		add_tc65(modem, udev_device);
> +	else if (g_strcmp0(driver, "telit") =3D=3D 0)
> +		add_telit(modem, udev_device);
>  	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
>  		add_nokiacdma(modem, udev_device);
>          else if (g_strcmp0(driver, "linktop") =3D=3D 0)

Regards,
-Denis

--===============9159277326846926388==--

