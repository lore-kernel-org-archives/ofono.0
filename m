Content-Type: multipart/mixed; boundary="===============2445824063810086208=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 14/15] hfp_hf: BT address exposed through Serial
 property
Date: Thu, 20 Oct 2011 20:42:31 -0500
Message-ID: <4EA0CE07.8080504@gmail.com>
In-Reply-To: <1319128700-15841-15-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2445824063810086208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/20/2011 11:38 AM, Mikel Astiz wrote:
> ---
>  plugins/hfp_hf.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
> index ba06434..bceae55 100644
> --- a/plugins/hfp_hf.c
> +++ b/plugins/hfp_hf.c
> @@ -38,12 +38,14 @@
>  #include <ofono/plugin.h>
>  #include <ofono/log.h>
>  #include <ofono/modem.h>
> +#include <ofono/devinfo.h>
>  #include <ofono/netreg.h>
>  #include <ofono/voicecall.h>
>  #include <ofono/call-volume.h>
>  #include <ofono/handsfree.h>
>  =

>  #include <drivers/hfpmodem/slc.h>
> +#include <drivers/hfpmodem/hfpmodem.h>
>  =

>  #include "bluetooth.h"
>  =

> @@ -207,6 +209,7 @@ static int hfp_hf_probe(const char *device, const cha=
r *dev_addr,
>  	struct ofono_modem *modem;
>  	struct hfp_data *data;
>  	char buf[256];
> +	struct hfp_devinfo_params devinfo_params;
>  =

>  	/* We already have this device in our hash, ignore */
>  	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
> @@ -232,6 +235,10 @@ static int hfp_hf_probe(const char *device, const ch=
ar *dev_addr,
>  =

>  	ofono_modem_set_data(modem, data);
>  	ofono_modem_set_name(modem, alias);
> +
> +	devinfo_params.device_address =3D dev_addr;
> +	ofono_devinfo_create(modem, 0, "hfpmodem", &devinfo_params);
> +

This looks way too complicated, why don't you just pass the const char
*dev_addr to ofono_devinfo_create?

>  	ofono_modem_register(modem);
>  =

>  	g_hash_table_insert(modem_hash, g_strdup(device), modem);

Regards,
-Denis

--===============2445824063810086208==--

