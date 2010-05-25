Content-Type: multipart/mixed; boundary="===============2755777657828861480=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] huawei: follow sim state change notifications
Date: Tue, 25 May 2010 10:01:58 +0200
Message-ID: <1274774518.27220.121.camel@localhost.localdomain>
In-Reply-To: <20100525075637.32623.43301.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2755777657828861480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> With Huawei E1552 I got sim busy errors when I plugged in the modem
> and ofono was already running:
> =

> May 24 17:02:04 tukki ofonod[7619]: > AT+CRC=3D1\r
> May 24 17:02:04 tukki ofonod[7619]: < \r\n+CME ERROR: SIM busy\r\n
> May 24 17:02:04 tukki ofonod[7619]: > AT+CLIP=3D1\r
> May 24 17:02:04 tukki ofonod[7619]: < \r\n+CME ERROR: SIM busy\r\n
> =

> Fix this by following sim state changes with ^SIMST notification and
> only enable modem after SIM is ready. In case SIM is already ready
> and we miss the notification for some reason, also use AT^SYSINFO
> to check the state during enable phase.
> =

> Also change huawei_enable() to return -EINPROGRESS to make sure that
> ofono modem is not powered too early. I believe this was a bug.
> ---
> =

>  plugins/huawei.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  1 files changed, 93 insertions(+), 6 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index e1408bd..7d59a26 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -47,9 +47,18 @@
>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
>  =

> +enum huawei_state {
> +	HUAWEI_DISABLED,
> +	HUAWEI_DISABLE,
> +	HUAWEI_ENABLE,
> +	HUAWEI_ENABLED,
> +};
> +

is this really needed? I don't see why you want it. Where is the race
condition that you are trying to fix with it.

>  struct huawei_data {
>  	GAtChat *chat;
>  	GAtChat *event;
> +	gint sim_state;
> +	enum huawei_state state;
>  };

I think the sim_state should be just enough.

Regards

Marcel



--===============2755777657828861480==--

