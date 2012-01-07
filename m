Content-Type: multipart/mixed; boundary="===============1797915031299231583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 05/10] cdma-netreg: Add provider name and SID support
Date: Sat, 07 Jan 2012 12:51:06 -0600
Message-ID: <4F08941A.7020103@gmail.com>
In-Reply-To: <1323885372-3574-6-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1797915031299231583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> @@ -120,6 +134,30 @@ static void serving_system_callback(const struct ofo=
no_error *error,
>  	}
>  =

>  	DBG("Serving system Identifier: %s", sid);
> +
> +	if (cdma_netreg->sid !=3D NULL && !strcmp(cdma_netreg->sid, sid))
> +		return;
> +
> +	g_free(cdma_netreg->provider_name);
> +	g_free(cdma_netreg->sid);
> +	cdma_netreg->provider_name =3D NULL;
> +	cdma_netreg->sid =3D g_strdup(sid);
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
> +				"SystemIdentifier", DBUS_TYPE_STRING,
> +				&cdma_netreg->sid);
> +
> +	if (__ofono_cdma_provision_get_name(sid,
> +				&cdma_netreg->provider_name) =3D=3D FALSE) {
> +		ofono_warn("Provider name not found");
> +		return;
> +	}
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
> +				"Name", DBUS_TYPE_STRING,
> +				&cdma_netreg->provider_name);

So in theory the Name might not have changed since there can be multiple
SIDs associated with a name.  Something that should probably be fixed in
a follow-on patch.

>  }
>  =

>  static void set_registration_status(struct ofono_cdma_netreg *cdma_netre=
g,

the first 5 patches in this series have been applied, thanks.

Regards,
-Denis

--===============1797915031299231583==--

