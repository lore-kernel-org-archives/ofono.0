Content-Type: multipart/mixed; boundary="===============1215513331152015336=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [online PATCH 4/9] huawei: implement Online property
Date: Tue, 24 Aug 2010 18:20:33 +0200
Message-ID: <1282666833.6841.20.camel@localhost.localdomain>
In-Reply-To: <1282649524-31353-5-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1215513331152015336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  plugins/huawei.c |   44 +++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 37 insertions(+), 7 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index fc331ff..4869294 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -351,7 +351,7 @@ static int huawei_enable(struct ofono_modem *modem)
>  =

>  	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
>  =

> -	g_at_chat_send(data->pcui, "AT+CFUN=3D1", none_prefix,
> +	g_at_chat_send(data->pcui, "AT+CFUN=3D4", none_prefix,
>  					cfun_enable, modem, NULL);

this is exactly the one that doesn't work this way. You can't get from
CFUN=3D4 back into CFUN=3D1, but from CFUN=3D5 into CFUN=3D1. It seems that
Huawei has a few different online/offline modes and you can't switch as
you like. Only a few certain combination will work.

Regards

Marcel



--===============1215513331152015336==--

