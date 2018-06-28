Content-Type: multipart/mixed; boundary="===============0048863739889117840=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] dbus: Add D-Bus mapping for generic errors
Date: Thu, 28 Jun 2018 10:43:17 -0500
Message-ID: <fa89578f-edd0-5f7d-4718-8a732394fbc7@gmail.com>
In-Reply-To: <1530197420-6290-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0048863739889117840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 06/28/2018 09:50 AM, Slava Monich wrote:
> This allows plugins/drivers to be a bit more specific about
> what went wrong.
> ---
>   src/dbus.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> =

> diff --git a/src/dbus.c b/src/dbus.c
> index 3e1e162..7ea86ed 100644
> --- a/src/dbus.c
> +++ b/src/dbus.c
> @@ -24,6 +24,7 @@
>   #endif
>   =

>   #include <glib.h>
> +#include <errno.h>
>   #include <gdbus.h>
>   =

>   #include "ofono.h"
> @@ -37,7 +38,7 @@ struct error_mapping_entry {
>   	DBusMessage *(*ofono_error_func)(DBusMessage *);
>   };
>   =

> -struct error_mapping_entry cme_errors_mapping[] =3D {
> +static const struct error_mapping_entry cme_errors_mapping[] =3D {

This should probably be a separate patch...

>   	{ 3,	__ofono_error_not_allowed },
>   	{ 4,	__ofono_error_not_supported },
>   	{ 16,	__ofono_error_incorrect_password },
> @@ -47,6 +48,14 @@ struct error_mapping_entry cme_errors_mapping[] =3D {
>   	{ 50,	__ofono_error_invalid_args },
>   };
>   =

> +static const struct error_mapping_entry generic_errors_mapping[] =3D {
> +	{ EACCES,      __ofono_error_access_denied },
> +	{ EOPNOTSUPP,  __ofono_error_not_supported },
> +	{ ENOSYS,      __ofono_error_not_implemented },
> +	{ ETIMEDOUT,   __ofono_error_timed_out },
> +	{ EINPROGRESS, __ofono_error_busy }
> +};
> +
>   static void append_variant(DBusMessageIter *iter,
>   				int type, const void *value)
>   {
> @@ -422,15 +431,14 @@ DBusMessage *__ofono_error_network_terminated(DBusM=
essage *msg)
>   DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
>   						DBusMessage *msg)
>   {
> -	struct error_mapping_entry *e;
> +	const struct error_mapping_entry *e;
>   	int maxentries;
>   	int i;
>   =

>   	switch (error->type) {
>   	case OFONO_ERROR_TYPE_CME:
>   		e =3D cme_errors_mapping;
> -		maxentries =3D sizeof(cme_errors_mapping) /
> -					sizeof(struct error_mapping_entry);
> +		maxentries =3D G_N_ELEMENTS(cme_errors_mapping);
>   		for (i =3D 0; i < maxentries; i++)
>   			if (e[i].error =3D=3D error->error)
>   				return e[i].ofono_error_func(msg);
> @@ -439,6 +447,18 @@ DBusMessage *__ofono_error_from_error(const struct o=
fono_error *error,
>   		return __ofono_error_failed(msg);
>   	case OFONO_ERROR_TYPE_CEER:
>   		return __ofono_error_failed(msg);
> +	case OFONO_ERROR_TYPE_FAILURE:

So I'm okay with the concept, but I'm not okay with trying to hi-jack an =

existing error type for this.  TYPE_FAILURE is used mostly for the =

internal emulator framework in the core or where we are returning an =

generic unknown error.

If you want to introduce an error type for ERRNO errors (which I still =

wonder how you plan to use this), okay, but at least add this as a =

specific type to ofono/types.h

> +		if (error->error) {
> +			int err =3D error->error;
> +
> +			if (err < 0) err =3D -err;
> +			e =3D generic_errors_mapping;
> +			maxentries =3D G_N_ELEMENTS(generic_errors_mapping);
> +			for (i =3D 0; i < maxentries; i++)
> +				if (e[i].error =3D=3D err)
> +					return e[i].ofono_error_func(msg);
> +		}

Should this part be a separate utility function instead of a copy-paste job?

> +		break;
>   	default:
>   		return __ofono_error_failed(msg);
>   	}
> =


Regards,
-Denis

--===============0048863739889117840==--

