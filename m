Content-Type: multipart/mixed; boundary="===============7195373651295321924=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Fix: Check if interface exists before creating it.
Date: Mon, 01 Feb 2010 08:03:47 -0800
Message-ID: <1265040227.31341.40.camel@localhost.localdomain>
In-Reply-To: <1265039424-1961-2-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7195373651295321924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-cont=
ext.c
> index c178fb6..79e697b 100644
> --- a/drivers/stemodem/gprs-context.c
> +++ b/drivers/stemodem/gprs-context.c
> @@ -187,9 +187,11 @@ static gboolean caif_if_create(const char *interface=
, unsigned int connid)
>  		return FALSE;
>  	}
>  =

> -	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
> -		ofono_debug("Failed to create IP interface for CAIF");
> -		return FALSE;
> +	if (ioctl(s, SIOCGIFINDEX, &ifr) !=3D 0) {
> +		if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
> +			ofono_debug("Failed to create IP interface for CAIF");
> +			return FALSE;
> +		}
>  	}
>  =

>  	return TRUE;

just doing it like this would be better:

	/* Check if interface exists */
	if (ioctl(s, SIOCGIFINDEX, &ifr) =3D=3D 0)
		return TRUE;

	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
		...
		return FALSE;
	}

	return TRUE;

We are not a big fan complicated if clauses if they can be avoid with a
simple goto or just a return.

Also I think we need to check errno value here. Since potentially the
ioctl can fail for other reasons. And maybe extending CAIF with a proper
way of checking for an existing interface might be better.

Regards

Marcel



--===============7195373651295321924==--

