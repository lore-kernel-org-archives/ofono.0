Content-Type: multipart/mixed; boundary="===============6778921696677583310=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Add MBM/STE quirk for SIM record update
Date: Tue, 01 Mar 2011 15:30:59 -0600
Message-ID: <4D6D6593.2020309@gmail.com>
In-Reply-To: <1298448563-5033-1-git-send-email-miia.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6778921696677583310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Miia,

On 02/23/2011 02:09 AM, Miia Leinonen wrote:
> Fixed the <data> string to be set inside quotes for STE/MBM.
> =

> ---
> =

> Hi,
> =

> This fix has been tested with STE modem only due the lack of MBM HW.
> =

> Would it be possible that someone checks this with MBM modem? The problem=
 is =

> likely to appear also there - therefore OFONO_VENDOR_MBM used. Could fix =
this =

> also to cover all modems, but that might cause some backward compatibilit=
y =

> issues.

This does seem to be required on MBM

> =

> BR,
> Miia
> =

> =

>  drivers/atmodem/sim.c |   59 ++++++++++++++++++++++++++++++++++++++-----=
-----
>  1 files changed, 46 insertions(+), 13 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index d9c0d8d..7a0100a 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -332,17 +332,34 @@ static void at_sim_update_record(struct ofono_sim *=
sim, int fileid,
>  {
>  	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  	struct cb_data *cbd =3D cb_data_new(cb, data);
> -	char *buf =3D g_try_new(char, 36 + length * 2);
> +	char *buf;
>  	int len, ret;
>  =

> -	if (buf =3D=3D NULL)
> -		goto error;
> +	if (sd->vendor =3D=3D OFONO_VENDOR_MBM) {
> +		buf =3D g_try_new(char, 36 + 2 + length * 2);
>  =

> -	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
> -			record, length);
> +		if (buf =3D=3D NULL)
> +			goto error;
>  =

> -	for (; length; length--)
> -		len +=3D sprintf(buf + len, "%02hhX", *value++);
> +		len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,\"", fileid,
> +					record, length);
> +
> +		for (; length; length--)
> +			len +=3D sprintf(buf + len, "%02hhX", *value++);
> +
> +		sprintf(buf + len, "\"");
> +	} else {
> +		buf =3D g_try_new(char, 36 + length * 2);
> +
> +		if (buf =3D=3D NULL)
> +			goto error;
> +
> +		len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
> +				record, length);
> +
> +		for (; length; length--)
> +			len +=3D sprintf(buf + len, "%02hhX", *value++);
> +	}
>  =


Please don't duplicate code like this.  It is much better written
something like this:

int size =3D 36 + 2 + length * 2;

if (vendor =3D=3D VENDOR_MBM)
	size +=3D 2; /* Add quotes */

buf =3D g_try_new(char, size);

len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid, record, length);

if (vendor =3D=3D VENDOR_MBM)
	len +=3D sprint(buf + len, "\"");

for (; length; length--)
	...

if (vendor =3D=3D VENDOR_MBM)
	...

etc.

>  	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
>  				at_crsm_update_cb, cbd, g_free);
> @@ -364,16 +381,32 @@ static void at_sim_update_cyclic(struct ofono_sim *=
sim, int fileid,
>  {
>  	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  	struct cb_data *cbd =3D cb_data_new(cb, data);
> -	char *buf =3D g_try_new(char, 36 + length * 2);
> +	char *buf;
>  	int len, ret;
>  =

> -	if (buf =3D=3D NULL)
> -		goto error;
> +	if (sd->vendor =3D=3D OFONO_VENDOR_MBM) {
> +		buf =3D g_try_new(char, 36 + 2 + length * 2);
>  =

> -	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
> +		if (buf =3D=3D NULL)
> +			goto error;
>  =

> -	for (; length; length--)
> -		len +=3D sprintf(buf + len, "%02hhX", *value++);
> +		len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,\"", fileid, length);
> +
> +		for (; length; length--)
> +			len +=3D sprintf(buf + len, "%02hhX", *value++);
> +
> +		sprintf(buf + len, "\"");
> +	} else {
> +		buf =3D g_try_new(char, 36 + length * 2);
> +
> +		if (buf =3D=3D NULL)
> +			goto error;
> +
> +		len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
> +
> +		for (; length; length--)
> +			len +=3D sprintf(buf + len, "%02hhX", *value++);
> +	}
>  =

>  	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
>  				at_crsm_update_cb, cbd, g_free);

Regards,
-Denis

--===============6778921696677583310==--

