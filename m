Content-Type: multipart/mixed; boundary="===============1255063027407826187=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] modem: do not allow more than one client to lock down
Date: Wed, 26 Jan 2011 09:54:36 +0100
Message-ID: <1296032076.1520.76.camel@aeonflux>
In-Reply-To: <1296027237-2532-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1255063027407826187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  src/modem.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)

patch has been applied.

However I added some paranoia protection for lock_owner reset to NULL. I
know that in theory it is protected via lockdown =3D=3D TRUE, but that is an
issue bound to break something eventually.

> @@ -847,12 +850,8 @@ static DBusMessage *set_property_lockdown(struct ofo=
no_modem *modem,
>  					OFONO_MODEM_INTERFACE,
>  					"Powered", DBUS_TYPE_BOOLEAN,
>  					&powered);
> -	} else {
> -		if (g_strcmp0(caller, modem->lock_owner))
> -			return __ofono_error_access_denied(msg);
> -
> +	} else
>  		lockdown_remove(modem);
> -	}
>  =

>  done:
>  	g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);

And since this becomes a one line statement now and we already have a
goto label there, I changed this a bit around and removed the
unnecessary indentation.

Regards

Marcel



--===============1255063027407826187==--

