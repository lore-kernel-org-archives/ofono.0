Content-Type: multipart/mixed; boundary="===============5975232015978984905=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ifxmodem: Adding fast dormancy support to Infineon modem
Date: Thu, 18 Nov 2010 04:47:43 +0100
Message-ID: <1290052063.29148.15.camel@aeonflux>
In-Reply-To: <1290022164-24730-1-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5975232015978984905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

> Initial patch to add fast dormancy to Infineon modem. Timeout is not
> supported yet.
> =

> Thanks,
> -- r.
> =

> ---
>  drivers/ifxmodem/radio-settings.c |   40 +++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 39 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-s=
ettings.c
> index 89e97e7..68077db 100644
> --- a/drivers/ifxmodem/radio-settings.c
> +++ b/drivers/ifxmodem/radio-settings.c
> @@ -27,6 +27,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <stdint.h>
>  #include <errno.h>
>  =

>  #include <glib.h>
> @@ -45,6 +46,7 @@ static const char *xrat_prefix[] =3D { "+XRAT:", NULL };
>  =

>  struct radio_settings_data {
>  	GAtChat *chat;
> +	uint16_t fast_dormancy;
>  };
>  =

>  static void xrat_query_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> @@ -196,12 +198,48 @@ static void ifx_radio_settings_remove(struct ofono_=
radio_settings *rs)
>  	g_free(rsd);
>  }
>  =

> +static void update_fast_dormancy(struct radio_settings_data *rsd)
> +{
> +	char buf[20];
> +
> +	snprintf(buf, sizeof(buf), "AT+XFDOR=3D%u", rsd->fast_dormancy);

is this command for fast dormancy really doing exactly what is expected
according to doc/radio-settings.txt. In my last documentation from
Infineon, that is still not the case.

Regards

Marcel



--===============5975232015978984905==--

