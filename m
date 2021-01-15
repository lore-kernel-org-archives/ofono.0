Content-Type: multipart/mixed; boundary="===============0883036141257426545=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 3/3] gemalto: netmon measurements scaling
Date: Fri, 15 Jan 2021 11:46:39 -0600
Message-ID: <9407799e-a301-9058-f787-ebd6dcf37d36@gmail.com>
In-Reply-To: <20210115162547.17156-4-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0883036141257426545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/15/21 10:25 AM, Sergey Matyukevich wrote:
> Gemalto modem reports raw measurements in dBm. Reported values may
> include negative numbers. Meanwhile oFono follows ETSI TS 27.007,
> so negative numbers do not really exist at the API level.
> =

> Modify gemalto netmon driver to report measurements according to
> 27.007. For this purpose re-scale from what Gemalto firmware
> reports into something that 27.007 recommends.
> ---
>   drivers/gemaltomodem/netmon.c | 52 ++++++++++++++++++++++++++++++++---
>   1 file changed, 48 insertions(+), 4 deletions(-)
> =


I went ahead and applied all three patches after making minor tweaks in thi=
s one:

> +static int gemalto_rscp_scale(int value)
> +{
> +	if (value < -120)
> +		return 0;
> +
> +	if (value > -24)
> +		return 96;
> +
> +	return (value + 120);

The ()s weren't needed here..

> +}
> +
> +static int gemalto_rsrp_scale(int value)
> +{
> +	if (value < -140)
> +		return 0;
> +
> +	if (value > -43)
> +		return 97;
> +
> +	return (value + 140);

here and ...

> +}
> +
> +static int gemalto_rsrq_scale(int value)
> +{
> +	if (2 * value < -39)
> +		return 0;
> +
> +	if (2 * value > -5)
> +		return 34;
> +
> +	return (2 * value + 39);

here

> +}
> +
>   static int gemalto_parse_smoni_gsm(GAtResultIter *iter,
>   					struct req_cb_data *cbd)
>   {
> @@ -273,13 +317,13 @@ static int gemalto_parse_smoni_umts(GAtResultIter *=
iter,
>   		case SMONI_UMTS_ECN0:
>   			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
>   				if (sscanf(str, "%f", &fnumber) =3D=3D 1)
> -					cbd->t.umts.ecno =3D (int)fnumber;
> +					cbd->t.umts.ecno =3D gemalto_ecno_scale((int)fnumber);

Also added a line break to better wrap to 80 char columns here...

>   			}
>   			break;
>   		case SMONI_UMTS_RSCP:
>   			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
>   				if (sscanf(str, "%d", &number) =3D=3D 1)
> -					cbd->t.umts.rscp =3D number;
> +					cbd->t.umts.rscp =3D gemalto_rscp_scale(number);

and here

>   			}
>   			break;
>   		case SMONI_UMTS_MCC:

Regards,
-Denis
--===============0883036141257426545==--

