Content-Type: multipart/mixed; boundary="===============7160075442567015451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: add LTE state for AT+CREG
Date: Mon, 10 Sep 2018 11:23:13 -0500
Message-ID: <23e0fa81-a354-ce26-b2ed-0b8a36aac630@gmail.com>
In-Reply-To: <1536556520-24462-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7160075442567015451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 09/10/2018 12:15 AM, "Anirudh Gargi anirudh.gargi"@intel.com wrote:

Something is funny with your email address here..

> From: Anirudh Gargi <anirudh.gargi@intel.com>
> =

> CREG reports 6 and 7 for SMS only registration on E-UTRAN. Fix
> sms atom to consider the new states while sending SMS.
> ---
>   drivers/atmodem/network-registration.c | 11 +++++++++--
>   src/common.c                           |  4 ++++
>   src/common.h                           |  2 ++
>   src/sms.c                              |  2 ++
>   4 files changed, 17 insertions(+), 2 deletions(-)

This needs to be broken up into two patches per 'HACKING', 'Submitting =

patches' section.

> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 0854cd1..5945e1c 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -228,6 +228,10 @@ static void at_creg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
>   		tech =3D nd->tech;
>   =

> +	/* Handle EUTRAN cases */
> +	if ((status =3D=3D 6 || status =3D=3D 7) && (tech =3D=3D -1))
> +		tech =3D nd->tech;
> +

Should tech be hardcoded to EUTRAN here?

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
> +	if (status !=3D 1 && status !=3D 5) {
> +		/* Check EUTRAN cases */
> +		if (status !=3D 6 && status !=3D 7)
> +			goto notify;
> +	}

So I would do something like:

if (status =3D=3D 6 || status =3D=3D 7) {
	tech =3D EUTRAN;
	goto notify;
}

if (status !=3D 1 && status !=3D 5)
	goto notify;

>   =

>   	tq =3D g_try_new0(struct tech_query, 1);
>   	if (tq =3D=3D NULL)
> diff --git a/src/common.c b/src/common.c
> index 3ccaf7c..79eed3e 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -669,6 +669,10 @@ const char *registration_status_to_string(int status)
>   		return "unknown";
>   	case NETWORK_REGISTRATION_STATUS_ROAMING:
>   		return "roaming";
> +	case NETWORK_REGISTRATION_STATUS_REGISTERED_EUTRAN:
> +		return "registered lte";
> +	case NETWORK_REGISTRATION_STATUS_ROAMING_EUTRAN:
> +		return "roaming lte";

No spaces in our property values.  Also you're changing the D-Bus API, =

so you might want to add a separate commit to doc/network-api.txt.

And another thing, this is an SMS-only registration according to 27.007. =

  So 'registered lte' makes no sense.   Perhaps we need a separate =

property for this and the CSFB cases.  E.g.
	boolean SmsOnly [readonly] - Current registration is only valid for SMS.

>   	}
>   =

>   	return "";
> diff --git a/src/common.h b/src/common.h
> index 1b6b01d..44d7c6f 100644
> --- a/src/common.h
> +++ b/src/common.h
> @@ -43,6 +43,8 @@ enum network_registration_status {
>   	NETWORK_REGISTRATION_STATUS_DENIED =3D		3,
>   	NETWORK_REGISTRATION_STATUS_UNKNOWN =3D		4,
>   	NETWORK_REGISTRATION_STATUS_ROAMING =3D		5,
> +	NETWORK_REGISTRATION_STATUS_REGISTERED_EUTRAN =3D	6,
> +	NETWORK_REGISTRATION_STATUS_ROAMING_EUTRAN =3D 	7,
REGISTERED_SMS_EUTRAN?
>   };
>   =

>   /* 27.007 Section 7.3 <stat> */
> diff --git a/src/sms.c b/src/sms.c
> index b86158e..e229425 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -782,6 +782,8 @@ static void netreg_status_watch(int status, int lac, =
int ci, int tech,
>   	switch (status) {
>   	case NETWORK_REGISTRATION_STATUS_REGISTERED:
>   	case NETWORK_REGISTRATION_STATUS_ROAMING:
> +	case NETWORK_REGISTRATION_STATUS_REGISTERED_EUTRAN:
> +	case NETWORK_REGISTRATION_STATUS_ROAMING_EUTRAN:
>   		sms->registered =3D TRUE;
>   		break;
>   	default:
> =


Regards,
-Denis

--===============7160075442567015451==--

