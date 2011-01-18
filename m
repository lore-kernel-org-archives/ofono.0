Content-Type: multipart/mixed; boundary="===============9189678593622766970=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ste: Use UTF-8 as a default character set
Date: Tue, 18 Jan 2011 15:32:14 +0100
Message-ID: <1295361134.3873.183.camel@aeonflux>
In-Reply-To: <1295357904-16620-1-git-send-email-lasse.kunnasluoto@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9189678593622766970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

>  plugins/ste.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/ste.c b/plugins/ste.c
> index 7bb7232..cc01f7b 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -247,7 +247,7 @@ static int ste_enable(struct ofono_modem *modem)
>  		return -EIO;
>  =

>  	data->chat =3D g_at_chat_new_blocking(channel, syntax);
> -	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1",
> +	g_at_chat_send(data->chat, "AT&F E0 V1 X4 &C1 +CMEE=3D1;+CSCS=3D\"UTF-8=
\"",
>  			NULL, NULL, NULL, NULL);

is it guaranteed that every single STE modem supports UTF-8 character
set?

I would rather see a new command checking for supported character sets
and then picking the default. And intermixing with ATE is not really
clean from my perspective.

Regards

Marcel



--===============9189678593622766970==--

