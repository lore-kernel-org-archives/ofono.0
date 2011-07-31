Content-Type: multipart/mixed; boundary="===============8512913643310954236=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 5/6] cdmamodem: add status info to cdma network atom.
Date: Sun, 31 Jul 2011 05:26:03 -0500
Message-ID: <4E352DBB.5010809@gmail.com>
In-Reply-To: <1312289122-22845-6-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8512913643310954236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/02/2011 07:45 AM, Bertrand Aygon wrote:
> ---
>  include/cdma-netreg.h |   11 +++++++++
>  src/cdma-netreg.c     |   56 +++++++++++++++++++++++++++++++++++++++++++=
++++++

Two separate patches please, and the API changes should probably be
merged into the earlier include/cdma-netreg patch.

>  2 files changed, 67 insertions(+), 0 deletions(-)
> =

> diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
> index 0da7cbb..b18d500 100644
> --- a/include/cdma-netreg.h
> +++ b/include/cdma-netreg.h
> @@ -28,6 +28,12 @@ extern "C" {
>  =

>  #include <ofono/types.h>
>  =

> +enum cdma_network_registration_status {
> +	CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D	0,
> +	CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED =3D		1,
> +	CDMA_NETWORK_REGISTRATION_STATUS_UNKNOWN =3D		2,

Is the unknown status even used by the hardware? In general oFono tries
not to introduce such 'unknown' states whenever possible.

Regardless, please keep the API definition and API implementation
consistent.  Right now doc/cdma-network-api.txt does not have a value
for 'unknown'.  So you must either send an RFC to update the
cdma-network-api.txt first, or remove the reference to unknown.  Using
not registered as the default seems just fine to me right now...

> +};
> +
>  struct ofono_cdma_netreg;
>  =

>  struct ofono_cdma_netreg_driver {
> @@ -37,6 +43,9 @@ struct ofono_cdma_netreg_driver {
>  	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
>  };
>  =

> +void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
> +					int status);

Since you went to the trouble of defining an enum for status
information, please use that here instead of 'int'.

> +
>  int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_dri=
ver *d);
>  void ofono_cdma_netreg_driver_unregister(const struct ofono_cdma_netreg_=
driver *d);
>  =

> @@ -51,6 +60,8 @@ void ofono_cdma_netreg_remove(struct ofono_cdma_netreg =
*cdma_netreg);
>  void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *cdma_netreg, v=
oid *data);
>  void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *cdma_netreg);
>  =

> +int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *cdma_netreg);
> +

Do you actually have immediate need for this function?  If not, then
please remove it.  It is better to not to define an API than dealing
with the repercussions of changing it later on.

>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
> index b1cbd53..0d7dc03 100644
> --- a/src/cdma-netreg.c
> +++ b/src/cdma-netreg.c
> @@ -32,18 +32,36 @@
>  static GSList *g_drivers;
>  =

>  struct ofono_cdma_netreg {
> +	int status;

Again, please use an enum here

>  	const struct ofono_cdma_netreg_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
>  };
>  =

> +static const char *cdma_registration_status_to_string(int status)
> +{
> +	switch (status) {
> +	case CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED:
> +		return "unregistered";
> +	case CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED:
> +		return "registered";
> +	case CDMA_NETWORK_REGISTRATION_STATUS_UNKNOWN:
> +		return "unknown";
> +	}
> +
> +	return "";
> +}
> +
>  static DBusMessage *network_get_properties(DBusConnection *conn,
>  						DBusMessage *msg, void *data)
>  {
> +	struct ofono_cdma_netreg *cdma_netreg =3D data;
>  	DBusMessage *reply;
>  	DBusMessageIter iter;
>  	DBusMessageIter dict;
>  =

> +	const char *status =3D cdma_registration_status_to_string(cdma_netreg->=
status);
> +
>  	reply =3D dbus_message_new_method_return(msg);
>  	if (reply =3D=3D NULL)
>  		return NULL;
> @@ -54,6 +72,8 @@ static DBusMessage *network_get_properties(DBusConnecti=
on *conn,
>  					OFONO_PROPERTIES_ARRAY_SIGNATURE,
>  					&dict);
>  =

> +	ofono_dbus_dict_append(&dict, "Status", DBUS_TYPE_STRING, &status);
> +
>  	dbus_message_iter_close_container(&iter, &dict);
>  =

>  	return reply;
> @@ -68,6 +88,40 @@ static GDBusSignalTable cdma_netreg_manager_signals[] =
=3D {
>  	{ }
>  };
>  =

> +
> +static void set_registration_status(struct ofono_cdma_netreg *cdma_netre=
g,
> +						int status)
> +{
> +	const char *str_status =3D cdma_registration_status_to_string(status);
> +	const char *path =3D __ofono_atom_get_path(cdma_netreg->atom);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	cdma_netreg->status =3D status;
> +
> +	ofono_dbus_signal_property_changed(conn, path,
> +				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
> +				"Status", DBUS_TYPE_STRING,
> +				&str_status);
> +}
> +
> +void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *cdma_netr=
eg,
> +					int status)
> +{
> +	if (cdma_netreg =3D=3D NULL)
> +		return;
> +
> +	if (cdma_netreg->status !=3D status)
> +		set_registration_status(cdma_netreg, status);
> +}
> +
> +int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *cdma_netreg)
> +{
> +	if (cdma_netreg =3D=3D NULL)
> +		return -1;
> +
> +	return cdma_netreg->status;
> +}
> +
>  int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_dri=
ver *d)
>  {
>  	DBG("driver: %p, name: %s", d, d->name);
> @@ -130,6 +184,8 @@ struct ofono_cdma_netreg *ofono_cdma_netreg_create(st=
ruct ofono_modem *modem,
>  	if (cdma_netreg =3D=3D NULL)
>  		return NULL;
>  =

> +	cdma_netreg->status =3D CDMA_NETWORK_REGISTRATION_STATUS_UNKNOWN;
> +
>  	cdma_netreg->atom =3D __ofono_modem_add_atom(modem,
>  					OFONO_ATOM_TYPE_CDMA_NETREG,
>  					cdma_netreg_remove, cdma_netreg);

Regards,
-Denis

--===============8512913643310954236==--

