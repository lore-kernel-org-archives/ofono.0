Content-Type: multipart/mixed; boundary="===============3381311100971954183=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Thu, 03 Feb 2011 17:25:53 -0200
Message-ID: <20110203192553.GC2168@joana>
In-Reply-To: <1295563737-11115-1-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3381311100971954183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

* Dara Spieker-Doyle <dara.spieker-doyle@nokia.com> [2011-01-20 14:48:57 =
-0800]:

> Add support for providing the type of the attached modem device
> including GSM (3GPP), CDMA (3GPP2) and Bluetooth HFP.
> ---
>  doc/modem-api.txt |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index 45043b0..fe806c8 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -82,6 +82,19 @@ Properties	boolean Powered [readwrite]
>  =

>  			This is usually obtained by using the +CGSN AT command.
>  =

> +		string Type [readonly, optional, experimental]
> +
> +			String representing the type of the modem device.
> +
> +			The possible values are:
> +				"gsm" 	Modem supports one or more of the 3GPP
> +					family of technologies including GSM,
> +					EDGE, UMTS, HSPA, LTE.
> +				"cdma"  Modem supports one or more of the 3GPP2
> +					family of technologies including CDMA 1x,
> +					EVDO.
> +				"hfp"	Bluetooth hands-free profile (HFP) modem

I think that this can also help with ConnMan, currently it enables all mode=
ms,
even the hfp one, which is wrong.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============3381311100971954183==--

