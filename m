Content-Type: multipart/mixed; boundary="===============1858320843641555368=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Tue, 23 Nov 2010 15:46:14 +0100
Message-ID: <1290523574.13641.11.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <1290080108-19576-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1858320843641555368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

>  doc/network-api.txt |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/doc/network-api.txt b/doc/network-api.txt
> index 083e918..9fb9974 100644
> --- a/doc/network-api.txt
> +++ b/doc/network-api.txt
> @@ -125,8 +125,9 @@ Properties	string Mode [readonly]
>  =

>  			Contains the technology of the current network.
>  =

> -			The possible values are: "gsm", "edge", "umts", "hspa",
> -							"lte"
> +			The possible values are: "gsm", "edge", "umts",
> +			"hsdpa", "hsupa", "hspa" (meaning both hsdpa and hsupa)
> +			and "lte"

so what is the intended usage for showing this difference? When we
discussed this the last time, it was clear that we need to show a
difference between 3G (umts) and 3.5G (hspa) and where HSPA would be
either HSDPA or HSUPA or both.

Regards

Marcel



--===============1858320843641555368==--

