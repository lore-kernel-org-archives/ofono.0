Content-Type: multipart/mixed; boundary="===============9211203102602487502=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/4] doc: Add ModemAccessTechnology property
Date: Thu, 28 Oct 2010 12:26:57 +0200
Message-ID: <1288261617.3322.7.camel@aeonflux>
In-Reply-To: <1288253694-25800-2-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9211203102602487502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

>  doc/modem-api.txt |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/modem-api.txt b/doc/modem-api.txt
> index c48375e..f5a3026 100644
> --- a/doc/modem-api.txt
> +++ b/doc/modem-api.txt
> @@ -43,6 +43,15 @@ Properties	boolean Powered [readwrite]
>  			modem. The Emergency is true if an emergency call or
>  			related operation is currently active.
>  =

> +		string ModemAccessTechnology [readonly]
> +
> +			Contains current access techonology of the modem.
> +			Possible values are:
> +			"gsm" - the current modem access technology is GSM
> +			"cdma" - the current modem access technology is CDMA
> +
> +			By default oFono uses "gsm" setting.
> +

so you are in the org.ofono.Modem interface and its properties and you
wanna prefix the property with "Modem". That is rather pointless
duplication of information. So just strip that.

The obvious question we have to discuss, if we really wanna do it this
way. What are the pros and what are the cons?

Regards

Marcel



--===============9211203102602487502==--

