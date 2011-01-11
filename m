Content-Type: multipart/mixed; boundary="===============3288683611165682600=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 02/10] Distinguish HSDPA,
 HSUPA or both as access technologies
Date: Mon, 10 Jan 2011 16:39:26 -0800
Message-ID: <1294706366.3873.8.camel@aeonflux>
In-Reply-To: <1294665325-11937-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3288683611165682600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  src/common.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index 4d93488..d4e567b 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -702,9 +702,9 @@ const char *registration_tech_to_string(int tech)
>  	case ACCESS_TECHNOLOGY_GSM_EGPRS:
>  		return "edge";
>  	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> -		return "hspa";
> +		return "hsdpa";
>  	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> -		return "hspa";
> +		return "hsupa";
>  	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
>  		return "hspa";
>  	case ACCESS_TECHNOLOGY_EUTRAN:

what happens here on the CS interface. Will we ever see anything else
than UMTS indication on CS and the extra ones are purely for PS or how
is this expected?

The second question is why do we bother with the difference between
uplink and downlink speed. The user just cares about HSxPA in general
and that is why these three have been combined.

Regards

Marcel



--===============3288683611165682600==--

