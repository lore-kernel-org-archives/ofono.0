Content-Type: multipart/mixed; boundary="===============7432495336981652932=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 2/4] gprs: add automatic context settings provisioning
Date: Tue, 11 Jan 2011 22:51:17 -0800
Message-ID: <1294815077.3873.75.camel@aeonflux>
In-Reply-To: <1294665072-13630-3-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7432495336981652932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> diff --git a/src/gprs.c b/src/gprs.c
> index 58166f8..7d188a3 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -43,6 +43,7 @@
>  #include "common.h"
>  #include "storage.h"
>  #include "idmap.h"
> +#include "gprs-provision.h"
>  =

>  #define GPRS_FLAG_ATTACHING 0x1
>  #define GPRS_FLAG_RECHECK 0x2
> @@ -2454,13 +2455,15 @@ remove:
>  		storage_sync(imsi, SETTINGS_STORE, gprs->settings);
>  }
>  =

> -void ofono_gprs_register(struct ofono_gprs *gprs)
> +static void ofono_gprs_finish_register(struct ofono_gprs *gprs)
>  {
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
>  	struct ofono_modem *modem =3D __ofono_atom_get_modem(gprs->atom);
>  	const char *path =3D __ofono_atom_get_path(gprs->atom);
>  	struct ofono_atom *netreg_atom;
> -	struct ofono_atom *sim_atom;
> +
> +	if (gprs->contexts =3D=3D NULL) /* Automatic provisioning failed */
> +		add_context(gprs, NULL, OFONO_GPRS_CONTEXT_TYPE_INTERNET);

so I see a potential race here between the UI trying to provision and us
trying to provision.

We don't wanna end up with duplicated contexts here. Any ideas on how we
could prevent that nicely? Or should we just fail any attempts to create
new contexts if provisioning is still ongoing?

Regards

Marcel



--===============7432495336981652932==--

