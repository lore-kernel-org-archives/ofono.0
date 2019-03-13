Content-Type: multipart/mixed; boundary="===============3340212710242011053=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 6/8] gprs-context : Force use of atd99
Date: Wed, 13 Mar 2019 09:19:13 +0100
Message-ID: <80971d3f-7b46-4da4-b11a-9dd21c021dc7@norrbonn.se>
In-Reply-To: <20190215121142.28163-7-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3340212710242011053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Could I get a clarification on the behaviour you see here?

As I understand it, the SARA-R4 doesn't support the CGDATA command. =

That's fine as ofono will detect this and set use_atd99 in order to =

force the use of the ATD command as a fallback.

Why do you need to force this setting in the below patch?  Does the =

CGDATA command not return ERROR?  What does it return?

Thanks,
Jonas

On 15/02/2019 13:11, philippedeswert(a)gmail.com wrote:
> From: Philippe De Swert <philippe.deswert@digitalistgroup.com>
> =

> QUIRCK: For some reason I really need to force the use of the atd99 comma=
nd here.
> ---
>   drivers/atmodem/gprs-context.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-contex=
t.c
> index 93894efd..a0776f2a 100644
> --- a/drivers/atmodem/gprs-context.c
> +++ b/drivers/atmodem/gprs-context.c
> @@ -214,7 +214,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   		return;
>   	}
>   =

> -	if (gcd->use_atd99)
> +	if (gcd->use_atd99 || gcd->vendor =3D=3D OFONO_VENDOR_UBLOX)
>   		sprintf(buf, "ATD*99***%u#", gcd->active_context);
>   	else
>   		sprintf(buf, "AT+CGDATA=3D\"PPP\",%u", gcd->active_context);
> @@ -457,6 +457,9 @@ static int at_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
>   	case OFONO_VENDOR_SIMCOM_SIM900:
>   		gcd->use_atd99 =3D FALSE;
>   		break;
> +	case OFONO_VENDOR_UBLOX:
> +		gcd->use_atd99 =3D TRUE;
> +		break;
>   	default:
>   		g_at_chat_send(chat, "AT+CGDATA=3D?", cgdata_prefix,
>   						at_cgdata_test_cb, gc, NULL);
>=20

--===============3340212710242011053==--

