Content-Type: multipart/mixed; boundary="===============1393157997424126310=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH] atmodem/sms: added Gemalto vendor for CNMI command
Date: Tue, 23 Oct 2018 10:29:31 +0200
Message-ID: <7aaec38a-6b31-1e65-ce09-b78aa6807e7b@norrbonn.se>
In-Reply-To: <20181023082147.31703-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1393157997424126310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/10/18 10:21, Giacinto Cifelli wrote:
> ---
>   drivers/atmodem/sms.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index 7638885e..380cd763 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -858,8 +858,18 @@ static gboolean build_cnmi_string(char *buf, int *cn=
mi_opts,
>   					data->cnma_enabled ? "21" : "1", FALSE))
>   		return FALSE;
>   =

> +	switch (data->vendor) {
> +	case OFONO_VENDOR_GEMALTO:
> +		mode =3D "0";
> +		break;
> +	default:
> +		/* Sounds like 2 is the sanest mode */

This particular comment doesn't add anything useful so just drop it.

/Jonas


> +		mode =3D "20";
> +		break;
> +	}
> +
>   	/* Always deliver CB via +CBM, otherwise don't deliver at all */
> -	if (!append_cnmi_element(buf, &len, cnmi_opts[2], "20", FALSE))
> +	if (!append_cnmi_element(buf, &len, cnmi_opts[2], mode, FALSE))
>   		return FALSE;
>   =

>   	/*
>=20

--===============1393157997424126310==--

