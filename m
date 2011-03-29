Content-Type: multipart/mixed; boundary="===============6525642224573021419=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: gnss aggregate xml
Date: Tue, 29 Mar 2011 15:14:03 +0200
Message-ID: <1301404443.2572.110.camel@aeonflux>
In-Reply-To: <1301394341-22961-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6525642224573021419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

> this patch provides logic to re-construct XML-formatted string prefixed w=
ith +CPOSR as defined in 27.007.
> =

> Br,
> Jarko
> =

>  drivers/atmodem/gnss.c |  134 ++++++++++++++++++++++++++++++++++++++++++=
------
>  1 files changed, 118 insertions(+), 16 deletions(-)
> =

> diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
> index 4954bb8..5d5a883 100644
> --- a/drivers/atmodem/gnss.c
> +++ b/drivers/atmodem/gnss.c
> @@ -47,6 +47,8 @@ struct gnss_data {
>  	unsigned int vendor;
>  };
>  =

> +char *xml_data;
> +

this is never ever going to work. Global and public variables are a big
no no.

First of all it would need to be static, but that is not going to help
you since the GNSS atom can be instantiated multiple times. oFono
supports multiple modems at the same time. And then you end up in a big
mess.

Regards

Marcel



--===============6525642224573021419==--

