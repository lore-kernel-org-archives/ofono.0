Content-Type: multipart/mixed; boundary="===============8813065522582504437=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] udev: changed linktop device strings
Date: Sat, 11 Jun 2011 09:05:27 -0500
Message-ID: <4DF37627.2080404@gmail.com>
In-Reply-To: <1307526380-6285-2-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8813065522582504437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On 06/08/2011 04:46 AM, Amit Mendapara wrote:
> Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>
> ---
>  plugins/udev.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =


Please remove the Signed-off-by line as we don't use it.

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 0234fc0..4f4e6d8 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -577,10 +577,10 @@ static void add_linktop(struct ofono_modem *modem,
>  =

>  	if (g_strcmp0(intfnum, "01") =3D=3D 0) {
>  		devnode =3D udev_device_get_devnode(udev_device);
> -		ofono_modem_set_string(modem, "Modem", devnode);
> +		ofono_modem_set_string(modem, "ModemDevice", devnode);
>  	} else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
>  		devnode =3D udev_device_get_devnode(udev_device);
> -		ofono_modem_set_string(modem, "Control", devnode);
> +		ofono_modem_set_string(modem, "DataDevice", devnode);
>  =

>  		ofono_modem_set_integer(modem, "Registered", 1);
>  		ofono_modem_register(modem);

Rest looks fine to me.

Regards,
-Denis

--===============8813065522582504437==--

