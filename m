Content-Type: multipart/mixed; boundary="===============4777490501069899407=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH RESEND] add zoned debug support
Date: Tue, 11 Aug 2009 21:32:13 -0700
Message-ID: <1250051533.30166.56.camel@localhost.localdomain>
In-Reply-To: <20090808201150.3e959284@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4777490501069899407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> This adds debug flags so that when users are debugging, they can pass
> arguments to --debug to specify what they want shown.  --debug without
> any args defaults to prior behavior.
> ---
>  include/log.h |   11 +++++++++--
>  src/log.c     |   11 +++++++----
>  src/main.c    |   25 +++++++++++++++++++++++--
>  src/ofono.h   |    2 +-
>  4 files changed, 40 insertions(+), 9 deletions(-)
> =

> diff --git a/include/log.h b/include/log.h
> index 47e5ec8..8a82f13 100644
> --- a/include/log.h
> +++ b/include/log.h
> @@ -26,6 +26,10 @@
>  extern "C" {
>  #endif
>  =

> +typedef enum {
> +	OFONO_DEBUG_CORE =3D 1 << 0,
> +} ofono_debug_flags;
> +
>  /**
>   * SECTION:log
>   * @title: Logging premitives
> @@ -36,8 +40,11 @@ extern void ofono_info(const char *format, ...)
>  				__attribute__((format(printf, 1, 2)));
>  extern void ofono_error(const char *format, ...)
>  				__attribute__((format(printf, 1, 2)));
> -extern void ofono_debug(const char *format, ...)
> -				__attribute__((format(printf, 1, 2)));
> +extern void __ofono_debug(ofono_debug_flags flag, const char *format, ..=
.)
> +				__attribute__((format(printf, 2, 3)));
> +#define ofono_debug(format, ...) \
> +			__ofono_debug(OFONO_DEBUG_CORE, (format), ##__VA_ARGS__)
> +

I don't like this. __ofono functions should not be part of public header
files.

Instead of trying to workaround previous users, just fix the users and
provide the default zone for DBG().

>  /**
>   * DBG:
> diff --git a/src/log.c b/src/log.c
> index 273e3ba..167fe21 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -29,6 +29,7 @@
>  #include "ofono.h"
>  =

>  static volatile gboolean debug_enabled =3D FALSE;
> +static guint debug_flags;
>  =

>  /**
>   * ofono_info:
> @@ -67,7 +68,8 @@ void ofono_error(const char *format, ...)
>  }
>  =

>  /**
> - * ofono_debug:
> + * __ofono_debug:
> + * @flag: zone flag (ie, OFONO_DEBUG_CORE)
>   * @format: format string
>   * @varargs: list of arguments
>   *
> @@ -76,11 +78,11 @@ void ofono_error(const char *format, ...)
>   * The actual output of the debug message is controlled via a command li=
ne
>   * switch. If not enabled, these messages will be ignored.
>   */
> -void ofono_debug(const char *format, ...)
> +void __ofono_debug(ofono_debug_flags flag, const char *format, ...)
>  {

Why not just using unsigned long here. I don't like the idea of
overloading enum with bitmask here.

Actually the more I think about it, do we wanna have multiple zones per
debug message. That sounds way to complicated anyway. So why not just
make ofono_debug_flags a simple enum and then use the bitmask only
internally.

>  	va_list ap;
>  =

> -	if (debug_enabled =3D=3D FALSE)
> +	if (!debug_enabled || !(debug_flags & flag))
>  		return;
>  =

>  	va_start(ap, format);
> @@ -98,7 +100,7 @@ void __ofono_toggle_debug(void)
>  		debug_enabled =3D TRUE;
>  }
>  =

> -int __ofono_log_init(gboolean detach, gboolean debug)
> +int __ofono_log_init(gboolean detach, gboolean debug, guint dflags)
>  {
>  	int option =3D LOG_NDELAY | LOG_PID;
>  =

> @@ -110,6 +112,7 @@ int __ofono_log_init(gboolean detach, gboolean debug)
>  	syslog(LOG_INFO, "oFono version %s", VERSION);
>  =

>  	debug_enabled =3D debug;
> +	debug_flags =3D dflags;

This is double. If dflags are not set, then don't enable debug. No need
to provide two parameters that do the same.

Also dflags is a pretty weird variable name.
 =

>  	return 0;
>  }
> diff --git a/src/main.c b/src/main.c
> index 7542e13..7227bde 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -54,12 +54,33 @@ static void system_bus_disconnected(DBusConnection *c=
onn, void *user_data)
>  =

>  static gboolean option_detach =3D TRUE;
>  static gboolean option_debug =3D FALSE;
> +static guint debug_flags =3D 0;
> +
> +static GDebugKey keys[] =3D {
> +	{ "core", OFONO_DEBUG_CORE },
> +};
> +
> +static gboolean parse_debug_flags(const gchar *option_name, const gchar =
*value,
> +		gpointer data, GError **err)
> +{
> +	option_debug =3D TRUE;
> +
> +	/* NULL means no string was supplied to --debug.  We default to "core"
> +	 * in that scenario; perhaps we should be defaulting to "all" instead? =
*/
> +	if (!value)
> +		value =3D "core";
> +
> +	debug_flags =3D g_parse_debug_string(value, keys,
> +			sizeof(keys) / sizeof(keys[0]));
> +	return TRUE;
> +}
>  =

>  static GOptionEntry options[] =3D {
>  	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
>  				G_OPTION_ARG_NONE, &option_detach,
>  				"Don't run as daemon in background" },
> -	{ "debug", 'd', 0, G_OPTION_ARG_NONE, &option_debug,
> +	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
> +				G_OPTION_ARG_CALLBACK, &parse_debug_flags,
>  				"Enable debug information output" },
>  	{ NULL },
>  };
> @@ -109,7 +130,7 @@ int main(int argc, char **argv)
>  	}
>  #endif
>  =

> -	__ofono_log_init(option_detach, option_debug);
> +	__ofono_log_init(option_detach, option_debug, debug_flags);

Same as from above. If debug_flags =3D 0, then debug is disabled.

Regards

Marcel



--===============4777490501069899407==--

