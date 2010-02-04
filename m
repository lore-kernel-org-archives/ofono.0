Content-Type: multipart/mixed; boundary="===============5278081877852676203=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Add radio settings atom and driver API
Date: Thu, 04 Feb 2010 14:28:41 -0600
Message-ID: <201002041428.41922.denkenz@gmail.com>
In-Reply-To: <1265266709-3835-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5278081877852676203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> This interface exposes a rw property for radio access selection mode
> setting.
> ---
>  Makefile.am                |    6 +-
>  doc/radio-settings-api.txt |   42 +++++
>  include/radio-settings.h   |   74 +++++++++
>  src/ofono.h                |    2 +
>  src/radio-settings.c       |  372
>  ++++++++++++++++++++++++++++++++++++++++++++ 5 files changed, 494
>  insertions(+), 2 deletions(-)
>  create mode 100644 doc/radio-settings-api.txt
>  create mode 100644 include/radio-settings.h
>  create mode 100644 src/radio-settings.c

<snip>

> +Properties	string Mode [read-write]

Per mailing list thread with Marcel, "Technology" or "TechnologySelection" =
or =

"TechnologyPreference" will be better here.

> +
> +			The current radio access selection mode, also known
> +			as network preference.
> +
> +			The possible values are:
> +				"dual"     Radio access selection is done
> +					   automatically, using either 2G
> +					   or 3G, depending on reception.

As discussed in later threads, I do like "auto" or "any" here.

> +				"2g"       Only GSM used for radio access.
> +				"3g"       Only UTRAN used for radio access.
> +				"unknown"  Mode currently unknown.

Lets get rid of the "unknown" part, we always know the setting, even if it =

takes a little time to query it.

> diff --git a/include/radio-settings.h b/include/radio-settings.h
> new file mode 100644
> index 0000000..807d3da
> +typedef void (*ofono_radio_settings_mode_query_cb_t)(const struct
>  ofono_error *error, +						enum ofono_radio_access_mode mode,
> +						void *data);

I still say this part is not required.

> +
> +struct ofono_radio_settings_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor, void
>  *data); +	void (*remove)(struct ofono_radio_settings *rs);
> +	void (*query_mode)(struct ofono_radio_settings *rs,
> +				ofono_radio_settings_mode_query_cb_t cb, void *data);

Neither is query_mode.  This is a local modem setting, not a network settin=
g.  =

There's simply no reason to query it when oFono can store the settings.

Lets just add ability to read the mode setting from storage and set it at =

interface startup.

> +	void (*set_mode)(struct ofono_radio_settings *rs,
> +				enum ofono_radio_access_mode mode,
> +				ofono_radio_settings_mode_set_cb_t cb, void *data);

Should this be called something else? E.g. set_technology or set_rat_mode.

> +};
> +
> diff --git a/src/ofono.h b/src/ofono.h
> index 379f413..ff67728 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -113,6 +113,7 @@ enum ofono_atom_type {
>  	OFONO_ATOM_TYPES_CALL_VOLUME =3D 15,
>  	OFONO_ATOM_TYPE_GPRS =3D 16,
>  	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
> +	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
>  };
> =

>  enum ofono_atom_watch_condition {
> @@ -168,6 +169,7 @@ void __ofono_atom_free(struct ofono_atom *atom);
>  #include <ofono/voicecall.h>
>  #include <ofono/gprs.h>
>  #include <ofono/gprs-context.h>
> +#include <ofono/radio-settings.h>
> =

>  #include <ofono/sim.h>
> =

> diff --git a/src/radio-settings.c b/src/radio-settings.c
> new file mode 100644
> index 0000000..6e41194
> --- /dev/null
> +++ b/src/radio-settings.c

<snip>

> +#define RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
> +#define RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
> +

Double define?

Otherwise it looks good to me.

Regards,
-Denis

--===============5278081877852676203==--

