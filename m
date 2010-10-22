Content-Type: multipart/mixed; boundary="===============5396937758908569862=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hso: Set modem name based on udev network interface name
Date: Fri, 22 Oct 2010 10:39:57 -0500
Message-ID: <4CC1B04D.5010304@gmail.com>
In-Reply-To: <20101021082620.178830@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5396937758908569862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Beno=C3=AEt,

On 10/21/2010 03:26 AM, "Beno=C3=AEt Monin" wrote:
> Useful if you have multiple identical modems and you need a way
> to know which modem you're talking to.
> ---
>  plugins/udev.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 737a637..e687c01 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -191,6 +191,7 @@ static void add_hso(struct ofono_modem *modem,
>         } else if (g_str_equal(subsystem, "net") =3D=3D TRUE) {
>                 devnode =3D get_property(udev_device, "INTERFACE");
>                 ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
> +               ofono_modem_set_name(modem, devnode);

I prefer you do this in plugins/hso and not in udev.

Regards,
-Denis

--===============5396937758908569862==--

