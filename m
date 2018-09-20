Content-Type: multipart/mixed; boundary="===============3876410457270878266=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: add AT+CREG handling for lte status
Date: Thu, 20 Sep 2018 10:17:39 -0500
Message-ID: <97be7b45-a23e-ee25-4f3a-5a2c4b2ee55a@gmail.com>
In-Reply-To: <1536654756-394-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3876410457270878266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 09/11/2018 03:32 AM, Anirudh Gargi wrote:
> added CREG 'status' 6 and 7 for sms only registered state on E-UTRAN
> for  CREG cmd reply callback and URC notfiy.
> ---
>   drivers/atmodem/network-registration.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 0854cd1..c0ec8c7 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -228,6 +228,10 @@ static void at_creg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
>   		tech =3D nd->tech;
>   =

> +	/* Handle EUTRAN cases */
> +	if ((status =3D=3D 6 || status =3D=3D 7) && (tech =3D=3D -1))
> +		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
> +

Perhaps:

if (status > 5 && tech =3D=3D -1)
	tech =3D ACCESS_TECHNOLOGY_EUTRAN;   ?

status =3D 8 (emergency bearer) also applies to EUTRAN correct?

>   	cb(&error, status, lac, ci, tech, cbd->data);
>   }
>   =

> @@ -1522,8 +1526,11 @@ static void creg_notify(GAtResult *result, gpointe=
r user_data)
>   				&lac, &ci, &tech, nd->vendor) =3D=3D FALSE)
>   		return;
>   =

> -	if (status !=3D 1 && status !=3D 5)
> -		goto notify;
> +	/* Not camped case */
> +	if (status !=3D 1 && status !=3D 5) {
> +		if (status !=3D 6 && status !=3D 7)
> +			goto notify;
> +	}

Perhaps:

if (status > 5 && tech =3D=3D -1)
	tech =3D ACCESS_TECHNOLOGY_EUTRAN;

if (status !=3D 1 && status !=3D 5)
	goto notify;

We need to only query technology for old modems that don't support LTE =

anyway...

>   =

>   	tq =3D g_try_new0(struct tech_query, 1);
>   	if (tq =3D=3D NULL)
> @@ -1569,6 +1576,9 @@ static void creg_notify(GAtResult *result, gpointer=
 user_data)
>   	if ((status =3D=3D 1 || status =3D=3D 5) && tech =3D=3D -1)
>   		tech =3D nd->tech;
>   =

> +	if ((status =3D=3D 6 || status =3D=3D 7) && tech =3D=3D -1)
> +		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
> +

And then this part might not be needed.

>   notify:
>   	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
>   }
> =


Regards,
-Denis

--===============3876410457270878266==--

