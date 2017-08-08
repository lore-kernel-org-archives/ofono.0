Content-Type: multipart/mixed; boundary="===============0225113299145143561=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] common.c: move strlen(apn) check into is_valid_apn()
Date: Tue, 08 Aug 2017 15:20:48 -0500
Message-ID: <ac056f5c-db05-b3be-c52b-a58098304470@gmail.com>
In-Reply-To: <20170808135345.10755-2-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0225113299145143561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 08/08/2017 08:53 AM, Alexander Couzens wrote:
> ---
>   src/common.c | 5 +++++
>   src/gprs.c   | 9 ---------
>   src/lte.c    | 3 ---
>   3 files changed, 5 insertions(+), 12 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index 17d1d58a..013e2452 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -31,8 +31,10 @@
>   =

>   #include <ofono/types.h>
>   #include "common.h"
> +#include "gprs-context.h"
>   #include "util.h"
>   =

> +

Stray whitespace here...

>   struct error_entry {
>   	int error;
>   	const char *str;
> @@ -705,6 +707,9 @@ gboolean is_valid_apn(const char *apn)
>   	if (apn[0] =3D=3D '.' || apn[0] =3D=3D '\0')
>   		return FALSE;
>   =

> +	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
> +		return FALSE;
> +
>   	for (i =3D 0; apn[i] !=3D '\0'; i++) {
>   		if (g_ascii_isalnum(apn[i]))
>   			continue;
> diff --git a/src/gprs.c b/src/gprs.c
> index 098ba3d4..a4132cc0 100644
> --- a/src/gprs.c
> +++ b/src/gprs.c
> @@ -1027,9 +1027,6 @@ static DBusMessage *pri_set_apn(struct pri_context =
*ctx, DBusConnection *conn,
>   {
>   	GKeyFile *settings =3D ctx->gprs->settings;
>   =

> -	if (strlen(apn) > OFONO_GPRS_MAX_APN_LENGTH)
> -		return __ofono_error_invalid_format(msg);
> -
>   	if (g_str_equal(apn, ctx->context.apn))
>   		return dbus_message_new_method_return(msg);
>   =

> @@ -2376,9 +2373,6 @@ static void provision_context(const struct ofono_gp=
rs_provision_data *ap,
>   	if (ap->name && strlen(ap->name) > MAX_CONTEXT_NAME_LENGTH)
>   		return;
>   =

> -	if (ap->apn =3D=3D NULL || strlen(ap->apn) > OFONO_GPRS_MAX_APN_LENGTH)
> -		return;
> -

Don't we still need to check for ap->apn being NULL?

>   	if (is_valid_apn(ap->apn) =3D=3D FALSE)
>   		return;
>   =


Regards,
-Denis

--===============0225113299145143561==--

