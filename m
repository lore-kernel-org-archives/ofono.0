Content-Type: multipart/mixed; boundary="===============7813410582091225993=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hso: Set modem name based on udev network interface name
Date: Mon, 25 Oct 2010 13:17:24 +0200
Message-ID: <1288005444.9729.7.camel@aeonflux>
In-Reply-To: <20101025091609.178830@gmx.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7813410582091225993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Benoit,

> Subject: [PATCH] hso: Set modem name based on udev network interface name
> =

> Useful if you have multiple identical modems and you need a way
> to know which modem you're talking to.
> ---
>  plugins/hso.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/hso.c b/plugins/hso.c
> index 055c63b..a9fb1ba 100644
> --- a/plugins/hso.c
> +++ b/plugins/hso.c
> @@ -59,6 +59,7 @@ struct hso_data {
>  static int hso_probe(struct ofono_modem *modem)
>  {
>         struct hso_data *data;
> +       const char *interface;
> =

>         DBG("%p", modem);
> =

> @@ -68,6 +69,11 @@ static int hso_probe(struct ofono_modem *modem)
> =

>         ofono_modem_set_data(modem, data);
> =

> +       /* Set name based on network interface name */
> +       interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +       if (interface)
> +               ofono_modem_set_name(modem, interface);
> +
>         return 0;
>  }

the friendly modem name is for devices that do have a friendly name,
like Bluetooth headsets. Why do you wanna misuse the interface name
here. I am a bit against this, because it leads to speculation and
assumptions in userspace programs.

Regards

Marcel



--===============7813410582091225993==--

