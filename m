Content-Type: multipart/mixed; boundary="===============5635036331656347467=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC v0] ofono: Only register network when APN is set
Date: Tue, 28 Feb 2012 11:02:30 +0100
Message-ID: <4F4CA636.2000503@monom.org>
In-Reply-To: <1330420763-8244-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5635036331656347467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

O>  		dbus_message_iter_next(dict);
> @@ -1180,6 +1188,19 @@ static gboolean context_changed(DBusConnection *co=
nnection,
>  			set_connected(modem);
>  		else
>  			set_disconnected(modem);
> +	} else if (g_str_equal(key, "AccessPointName") =3D=3D TRUE) {
> +		g_free(modem->apn);
> +
> +		dbus_message_iter_get_basic(&value, &modem->apn);
> +
> +		DBG("%s AccessPointName %s", modem->path, modem->apn);
> +
> +		if (has_interface(modem->interfaces,
> +					OFONO_API_NETREG) =3D=3D TRUE &&
> +				modem->network !=3D NULL) {
> +			DBG("Register network at core");
> +			add_network(modem);
> +		}

that should be a "modem->network =3D=3D NULL" of course.

--===============5635036331656347467==--

