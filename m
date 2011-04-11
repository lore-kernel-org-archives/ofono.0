Content-Type: multipart/mixed; boundary="===============2280650813347039312=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 10/20] doc: add PreferredMode property to modem
Date: Mon, 11 Apr 2011 14:27:45 -0500
Message-ID: <4DA35631.5090906@gmail.com>
In-Reply-To: <1302517218-2147-11-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2280650813347039312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

On 04/11/2011 05:20 AM, Vijay Nayani wrote:
> ---
>  doc/modem-api.txt |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index fa400a2..c79bffa 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -54,6 +54,24 @@ Properties	boolean Powered [readwrite]
>  			modem. The Emergency is true if an emergency call or
>  			related operation is currently active.
>  =

> +		string PreferredMode [readonly, optional]
> +
> +			Preferred UE mode setting. A UE attached for EPS services
> +			shall operate in one of the following operation modes:
> +
> +				"PS mode 2"	UE registers only to EPS
> +						services, and UE's usage setting
> +						is "data centric".
> +				"CS/PS mode 1"	UE registers to both EPS and
> +						non-EPS services, and UE's usage
> +						setting is "voice centric".
> +				"CS/PS mode 2"	UE registers to both EPS and
> +						non-EPS services, and UE's usage
> +						setting is "data centric".
> +				"PS mode 1"	UE registers only to EPS
> +						services, and UE's usage setting
> +						is "voice centric".
> +

I don't like that this is being exposed on the modem interface.  This
really belongs on a separate atom.  Not all modems are going to be LTE
enabled yet...

Have you looked at the IMS/LTE API proposal from Sjur a while back?

>  		string Name [readonly, optional]
>  =

>  			Friendly name of the modem device.

Regards,
-Denis

--===============2280650813347039312==--

