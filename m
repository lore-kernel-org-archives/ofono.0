Content-Type: multipart/mixed; boundary="===============6957056947190014522=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 12/12] hfp_hf: BT address exposed through Serial
 property
Date: Fri, 21 Oct 2011 14:33:27 -0500
Message-ID: <4EA1C907.7040800@gmail.com>
In-Reply-To: <1319215897-6310-13-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6957056947190014522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/21/2011 11:51 AM, Mikel Astiz wrote:
> ---
>  plugins/hfp_hf.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
> index ba06434..c9451d2 100644
> --- a/plugins/hfp_hf.c
> +++ b/plugins/hfp_hf.c
> @@ -38,6 +38,7 @@
>  #include <ofono/plugin.h>
>  #include <ofono/log.h>
>  #include <ofono/modem.h>
> +#include <ofono/devinfo.h>
>  #include <ofono/netreg.h>
>  #include <ofono/voicecall.h>
>  #include <ofono/call-volume.h>
> @@ -232,6 +233,9 @@ static int hfp_hf_probe(const char *device, const cha=
r *dev_addr,
>  =

>  	ofono_modem_set_data(modem, data);
>  	ofono_modem_set_name(modem, alias);
> +
> +	ofono_devinfo_create(modem, 0, "hfpmodem", (void *) dev_addr);
> +

Why is this being done in probe and not pre_sim?

>  	ofono_modem_register(modem);
>  =

>  	g_hash_table_insert(modem_hash, g_strdup(device), modem);

Regards,
-Denis

--===============6957056947190014522==--

