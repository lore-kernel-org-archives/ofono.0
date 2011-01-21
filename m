Content-Type: multipart/mixed; boundary="===============7892824602174365310=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: Add modem Type property
Date: Fri, 21 Jan 2011 14:15:46 -0600
Message-ID: <4D39E972.5060305@gmail.com>
In-Reply-To: <1295563737-11115-1-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7892824602174365310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 01/20/2011 04:48 PM, Dara Spieker-Doyle wrote:
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
> +

So one pointed question:

How are we planning to support dual-mode devices with this property?  I
believe during the CDMA workshop we decided that the clients should
simply look at the set of interfaces, not a semi-static property...

Regards,
-Denis

--===============7892824602174365310==--

