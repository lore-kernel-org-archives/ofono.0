Content-Type: multipart/mixed; boundary="===============1342782539380325606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] Use ofono_bool_t with D-Bus API.
Date: Thu, 27 May 2010 13:02:53 -0500
Message-ID: <201005271302.53682.denkenz@gmail.com>
In-Reply-To: <1274976768-1555-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1342782539380325606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>  	if (modem->powered_pending =3D=3D FALSE) {
>  		DBusConnection *conn =3D ofono_dbus_get_connection();
> -		dbus_bool_t powered =3D FALSE;
> -
>  		modem->powered =3D FALSE;
>  		ofono_dbus_signal_property_changed(conn, modem->path,
>  						OFONO_MODEM_INTERFACE,
>  						"Powered", DBUS_TYPE_BOOLEAN,
> -						&powered);
> +						&modem->powered);

Actually this is the preferred approach and is more type safe.  If you noti=
ce =

cases where we don't do this, then please send a patch.

Regards,
-Denis

--===============1342782539380325606==--

