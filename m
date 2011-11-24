Content-Type: multipart/mixed; boundary="===============6413834188222758018=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] cdma-netreg: Add provider name support
Date: Thu, 24 Nov 2011 17:55:08 -0600
Message-ID: <4ECED95C.3000900@gmail.com>
In-Reply-To: <1322156784-10402-8-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6413834188222758018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 11/24/2011 11:46 AM, Philippe Nunes wrote:
> ---
>  Makefile.am       |    3 ++-
>  src/cdma-netreg.c |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 6002eb0..978ac9f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -275,7 +275,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/cdmamodem/voicecall.c \
>  			drivers/cdmamodem/devinfo.c \
>  			drivers/cdmamodem/connman.c \
> -			drivers/cdmamodem/network-registration.c
> +			drivers/cdmamodem/network-registration.c \
> +			plugins/mbpi.c plugins/mbpi.h
>  endif
>  =

>  builtin_modules +=3D g1
> diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
> index 222c3b7..19947ab 100644
> --- a/src/cdma-netreg.c
> +++ b/src/cdma-netreg.c
> @@ -28,6 +28,7 @@
>  #include <gdbus.h>
>  =

>  #include "ofono.h"
> +#include "plugins/mbpi.h"

Don't do this, see below

>  =

>  static GSList *g_drivers;
>  =

> @@ -38,6 +39,7 @@ struct ofono_cdma_netreg {
>  	const struct ofono_cdma_netreg_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
> +	char *provider_name;
>  };
>  =

>  static const char *cdma_netreg_status_to_string(enum cdma_netreg_status =
status)
> @@ -90,6 +92,10 @@ static DBusMessage *network_get_properties(DBusConnect=
ion *conn,
>  					&strength);
>  	}
>  =

> +	if (cdma_netreg->provider_name)
> +		ofono_dbus_dict_append(&dict, "Name", DBUS_TYPE_STRING,
> +						&cdma_netreg->provider_name);
> +

You might also want to export the SystemIdentifier property here

>  	dbus_message_iter_close_container(&iter, &dict);
>  =

>  	return reply;
> @@ -108,6 +114,9 @@ static void serving_system_callback(const struct ofon=
o_error *error,
>  					const char *sid, void *data)
>  {
>  	struct ofono_cdma_netreg *cdma_netreg =3D data;
> +	const char *path =3D __ofono_atom_get_path(cdma_netreg->atom);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	GError *err =3D NULL;
>  =

>  	if (cdma_netreg->status !=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
>  			&& cdma_netreg->status !=3D
> @@ -120,6 +129,20 @@ static void serving_system_callback(const struct ofo=
no_error *error,
>  	}
>  =

>  	DBG("Serving system Identifier: %s", sid);
> +
> +	g_free(cdma_netreg->provider_name);
> +	cdma_netreg->provider_name =3D NULL;
> +	cdma_netreg->provider_name =3D mbpi_lookup_cdma_provider_name(sid, &err=
);

Please don't do it this way, this part should be abstracted behind a
provider name lookup plugin, similar to how context provisioning for GSM
is done.  Mobile Broadband Provider Info database might not be the only
source of this information, in fact manufacturers might have their own
(better) databases.

> +
> +	if (cdma_netreg->provider_name)
> +		ofono_dbus_signal_property_changed(conn, path,
> +				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
> +				"Name", DBUS_TYPE_STRING,
> +				&cdma_netreg->provider_name);
> +	else if (err !=3D NULL) {
> +		ofono_error("%s", err->message);
> +		g_error_free(err);
> +	}

Are you sure you want to perform the lookup every time? Why don't you
cache the last result and not perform the query if the SID is the same
as the last one obtained.  We're highly unlikely to get a different SID
under normal circumstances (e.g. signal loss, etc) so re-querying seems
wasteful.

>  }
>  =

>  static void set_registration_status(struct ofono_cdma_netreg *cdma_netre=
g,
> @@ -136,6 +159,12 @@ static void set_registration_status(struct ofono_cdm=
a_netreg *cdma_netreg,
>  				"Status", DBUS_TYPE_STRING,
>  				&str_status);
>  =

> +	if (cdma_netreg->status =3D=3D
> +			CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED) {
> +		g_free(cdma_netreg->provider_name);
> +		cdma_netreg->provider_name =3D NULL;

See comment above

> +	}
> +
>  	if (cdma_netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTE=
RED
>  			|| cdma_netreg->status =3D=3D
>  				CDMA_NETWORK_REGISTRATION_STATUS_ROAMING)
> @@ -251,6 +280,7 @@ static void cdma_netreg_remove(struct ofono_atom *ato=
m)
>  	if (cdma_netreg->driver && cdma_netreg->driver->remove)
>  		cdma_netreg->driver->remove(cdma_netreg);
>  =

> +	g_free(cdma_netreg->provider_name);
>  	g_free(cdma_netreg);
>  }
>  =


Regards,
-Denis

--===============6413834188222758018==--

