Content-Type: multipart/mixed; boundary="===============6177485821968929260=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/6] Define packet switched bearers
Date: Wed, 19 Jan 2011 06:18:09 +0100
Message-ID: <1295414289.3873.237.camel@aeonflux>
In-Reply-To: <1294915781-8330-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6177485821968929260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  src/common.c |   24 ++++++++++++++++++++++++
>  src/common.h |   13 +++++++++++++
>  2 files changed, 37 insertions(+), 0 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index d4e567b..c58ed5c 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -714,6 +714,30 @@ const char *registration_tech_to_string(int tech)
>  	}
>  }
>  =

> +const char *packet_bearer_to_string(int bearer)
> +{
> +	switch (bearer) {
> +	case PACKET_BEARER_NONE:
> +		return "none";
> +	case PACKET_BEARER_GPRS:
> +		return "gprs";
> +	case PACKET_BEARER_EGPRS:
> +		return "egprs";
> +	case PACKET_BEARER_UMTS:
> +		return "umts";
> +	case PACKET_BEARER_HSUPA:
> +		return "hsupa";
> +	case PACKET_BEARER_HSDPA:
> +		return "hsdpa";
> +	case PACKET_BEARER_HSUPA_HSDPA:
> +		return "hspa";
> +	case PACKET_BEARER_EPS:
> +		return "eps";
> +	default:
> +		return "";
> +	}
> +}

these don't match the documentation. Use "edge" and "lte" for them.

And please don't use a default switch label. Just return "" at the end
of the function.

Regards

Marcel



--===============6177485821968929260==--

