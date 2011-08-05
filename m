Content-Type: multipart/mixed; boundary="===============6556987832177732991=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v6 13/14] cdmamodem: add data strength to CDMA netreg atom.
Date: Fri, 05 Aug 2011 10:56:32 -0500
Message-ID: <4E3C12B0.4090203@gmail.com>
In-Reply-To: <1312550475-8537-14-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6556987832177732991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/05/2011 08:21 AM, Bertrand Aygon wrote:
> ---
>  src/cdma-netreg.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> =

> diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
> index 12ddd23..e57856e 100644
> --- a/src/cdma-netreg.c
> +++ b/src/cdma-netreg.c
> @@ -34,6 +34,7 @@ static GSList *g_drivers;
>  struct ofono_cdma_netreg {
>  	enum cdma_netreg_status status;
>  	int strength;
> +	int data_strength;
>  	const struct ofono_cdma_netreg_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> @@ -82,6 +83,13 @@ static DBusMessage *network_get_properties(DBusConnect=
ion *conn,
>  					&strength);
>  	}
>  =

> +	if (cdma_netreg->data_strength !=3D -1) {
> +		unsigned char data_strength =3D cdma_netreg->data_strength;
> +
> +		ofono_dbus_dict_append(&dict, "DataStrength", DBUS_TYPE_BYTE,
> +					&data_strength);
> +	}
> +
>  	dbus_message_iter_close_container(&iter, &dict);
>  =

>  	return reply;
> @@ -151,6 +159,36 @@ void ofono_cdma_netreg_strength_notify(struct ofono_=
cdma_netreg *netreg,
>  	}
>  }
>  =

> +void ofono_cdma_netreg_data_strength_notify(struct ofono_cdma_netreg *ne=
treg,
> +					int data_strength)
> +{
> +	if (netreg =3D=3D NULL)
> +		return;
> +
> +	if (netreg->data_strength =3D=3D data_strength)
> +		return;
> +
> +	/*
> +	 * Theoretically we can get signal strength even when not registered
> +	 * to any network.  However, what do we do with it in that case?
> +	 */
> +	if (netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTER=
ED)
> +		return;
> +
> +	netreg->data_strength =3D data_strength;
> +
> +	if (data_strength !=3D -1) {
> +		DBusConnection *conn =3D ofono_dbus_get_connection();
> +		const char *path =3D __ofono_atom_get_path(netreg->atom);
> +		unsigned char data_strength =3D netreg->data_strength;
> +
> +		ofono_dbus_signal_property_changed(conn, path,
> +				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
> +				"DataStrength", DBUS_TYPE_BYTE,
> +				&data_strength);
> +	}
> +}
> +

I don't like this, this function is nearly a 100% copy of the
strength_notify function, down to the comment in fact.  Are you sure you
can't refactor the common code into a helper?

>  int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_dri=
ver *d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);
> @@ -216,6 +254,7 @@ struct ofono_cdma_netreg *ofono_cdma_netreg_create(st=
ruct ofono_modem *modem,
>  =

>  	cdma_netreg->status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
>  	cdma_netreg->strength =3D -1;
> +	cdma_netreg->data_strength =3D -1;
>  =

>  	cdma_netreg->atom =3D __ofono_modem_add_atom(modem,
>  					OFONO_ATOM_TYPE_CDMA_NETREG,

Regards,
-Denis

--===============6556987832177732991==--

