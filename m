Content-Type: multipart/mixed; boundary="===============6222613492626655126=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/3] huawei: add gprs context
Date: Fri, 23 Apr 2010 16:26:05 +0200
Message-ID: <1272032765.22838.73.camel@localhost.localdomain>
In-Reply-To: <20100423134026.2107.49200.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6222613492626655126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Tested with Huawei E1552 HSDPA USB stick using a finnish Saunalahti prepa=
id
> SIM.
> ---
> =

>  plugins/huawei.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 90fdcf0..fd1528f 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -41,6 +41,8 @@
>  #include <ofono/gprs.h>
>  #include <ofono/voicecall.h>
>  #include <ofono/log.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
>  =

>  #include <drivers/atmodem/vendor.h>
>  =

> @@ -178,11 +180,19 @@ static void huawei_pre_sim(struct ofono_modem *mode=
m)
>  static void huawei_post_sim(struct ofono_modem *modem)
>  {
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs_context *gc;
> +	struct ofono_gprs *gprs;
>  =

>  	DBG("%p", modem);
>  =

>  	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->chat);
>  	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem", data->cha=
t);
> +
> +	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
> +
> +	if (gprs && gc)
> +		ofono_gprs_add_context(gprs, gc);
>  }

this patch is obviously correct if the PPP part and generic GPRS context
support is working correct. I haven't had time to verify that yet. So
far we only used gsmdial for testing.

Regards

Marcel



--===============6222613492626655126==--

