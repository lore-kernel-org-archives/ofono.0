Content-Type: multipart/mixed; boundary="===============7738802784197824132=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] speedup: during enable, we have to go offline first.
Date: Thu, 28 Jul 2011 13:18:55 +0200
Message-ID: <1311851936.8920.87.camel@aeonflux>
In-Reply-To: <1311841508-19358-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7738802784197824132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  plugins/speedup.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/speedup.c b/plugins/speedup.c
> index 90ca5e3..a7aa43c 100644
> --- a/plugins/speedup.c
> +++ b/plugins/speedup.c
> @@ -177,7 +177,7 @@ static int speedup_enable(struct ofono_modem *modem)
>  	g_at_chat_send(data->modem, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NUL=
L);
>  	g_at_chat_send(data->aux, "ATE0 &C0 +CMEE=3D1", NULL, NULL, NULL, NULL);
>  =

> -	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
> +	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL,
>  					cfun_enable, modem, NULL);

this is not a correct fix. You are messing up the logic here. You are
still in offline mode from an oFono point of view, but your modem is
actually online.

Try the same that we did for ZTE with sending +CFUN=3D1;+CFUN=3D4 if that
works out.

If not, then check if we can go CFUN=3D1 first and then after SIM query
succeeded, we go into CFUN=3D4. We do this for Huawei actually.

If none of these work, then you need to remove the set_online callback
like we do for Nokia. If you can not support online/offline mode, then
don't even try to.

And please show proper OFONO_AT_DEBUG traces. They can be part of the
commit message actually.

Regards

Marcel



--===============7738802784197824132==--

