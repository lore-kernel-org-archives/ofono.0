Content-Type: multipart/mixed; boundary="===============1723706628877325440=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] sim: Use quoted string with AT+CRSM data parameter
Date: Wed, 21 Mar 2012 10:18:14 -0700
Message-ID: <1332350294.1870.26.camel@aeonflux>
In-Reply-To: <1332334633-11737-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1723706628877325440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

> Fix issue with some modems preventing to update elementary files
> (speedup, ZTE, huawei, MBM)
> ---
>  drivers/atmodem/sim.c |   52 ++++++++++++++++++++++++++++++++++++++++++-=
-----
>  1 files changed, 45 insertions(+), 7 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index 8ee9822..f307708 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -305,18 +305,38 @@ static void at_sim_update_binary(struct ofono_sim *=
sim, int fileid,
>  {
>  	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  	struct cb_data *cbd =3D cb_data_new(cb, data);
> -	char *buf =3D g_try_new(char, 36 + length * 2);
> +	char *buf;
>  	int len, ret;
> +	int size =3D 36 + length * 2;
>  =

> +	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
> +			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
> +			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
> +			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
> +		size +=3D 2; /*Add quotes*/

this is better done with a switch statement. And please fix the comment
style to adhere to the coding style.

> +
> +	buf =3D g_try_new(char, size);
>  	if (buf =3D=3D NULL)
>  		goto error;
>  =

>  	len =3D sprintf(buf, "AT+CRSM=3D214,%i,%i,%i,%i,", fileid,
>  			start >> 8, start & 0xff, length);
>  =

> +	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
> +			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
> +			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
> +			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
> +		sprintf(buf + len, "\"");
> +

I am getting a little bit worried about spreading sd->vendor checks at
many places here. Maybe this can be done smarter and cleaner.

Regards

Marcel



--===============1723706628877325440==--

