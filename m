Content-Type: multipart/mixed; boundary="===============0207238614319617001=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 10:34:30 +0200
Message-ID: <b1046725-7e10-8fb1-f654-6e4f4fff3bb2@norrbonn.se>
In-Reply-To: <20181023075039.13587-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0207238614319617001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Do the USB interfaces show up long before the modem is ready to accept =

AT commands?  Or do the AT commands take a long time to complete?

/Jonas

On 23/10/18 09:50, Giacinto Cifelli wrote:
> Changed the connection timeout to 60 seconds (from 20 seconds),
> to accomodate for chipset that take time to boot-up.
> ---
>   src/modem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/modem.c b/src/modem.c
> index 124a5192..e7978bb0 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -1060,7 +1060,7 @@ static DBusMessage *set_property_lockdown(struct of=
ono_modem *modem,
>   		}
>   =

>   		modem->pending =3D dbus_message_ref(msg);
> -		modem->timeout =3D g_timeout_add_seconds(20,
> +		modem->timeout =3D g_timeout_add_seconds(60,
>   						set_powered_timeout, modem);
>   		return NULL;
>   	}
> @@ -1138,7 +1138,7 @@ static DBusMessage *modem_set_property(DBusConnecti=
on *conn,
>   				return __ofono_error_failed(msg);
>   =

>   			modem->pending =3D dbus_message_ref(msg);
> -			modem->timeout =3D g_timeout_add_seconds(20,
> +			modem->timeout =3D g_timeout_add_seconds(60,
>   						set_powered_timeout, modem);
>   			return NULL;
>   		}
>=20

--===============0207238614319617001==--

