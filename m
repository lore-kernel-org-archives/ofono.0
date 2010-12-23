Content-Type: multipart/mixed; boundary="===============7577024497781305106=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3, Part2, 3/3] udev: Add nokiacdma device
Date: Wed, 22 Dec 2010 20:23:39 -0600
Message-ID: <4D12B2AB.2000000@gmail.com>
In-Reply-To: <1292959410-6566-4-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7577024497781305106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 12/21/2010 01:23 PM, Dara Spieker-Doyle wrote:
> ---
>  plugins/udev.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 255755e..9447e5c 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -449,6 +449,25 @@ static void add_isi(struct ofono_modem *modem,
>  	ofono_modem_register(modem);
>  }
>  =

> +static void add_nokiacdma(struct ofono_modem *modem,
> +					struct udev_device *udev_device)
> +{
> +	const char *devnode;
> +	int registered;
> +
> +	DBG("modem %p", modem);
> +
> +	devnode =3D udev_device_get_devnode(udev_device);
> +
> +	registered =3D ofono_modem_get_integer(modem, "Registered");
> +	if (registered !=3D 0)
> +		return;
> +
> +	ofono_modem_set_string(modem, "Device", devnode);
> +	ofono_modem_set_integer(modem, "Registered", 1);
> +	ofono_modem_register(modem);

This looks a little fishy to me.  How many ttys are created when this
device is plugged in?  Is it really just one or are you relying on luck
to select the right tty?

> +}
> +
>  static void add_modem(struct udev_device *udev_device)
>  {
>  	struct ofono_modem *modem;
> @@ -533,6 +552,8 @@ done:
>  		add_isi(modem, udev_device);
>  	else if (g_strcmp0(driver, "n900") =3D=3D 0)
>  		add_isi(modem, udev_device);
> +	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
> +		add_nokiacdma(modem, udev_device);
>  }
>  =

>  static gboolean devpath_remove(gpointer key, gpointer value, gpointer us=
er_data)

Regards,
-Denis

--===============7577024497781305106==--

