Content-Type: multipart/mixed; boundary="===============8074060968282273898=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 4/4] doc: document power-event signals for quectel
 Hardware API
Date: Fri, 19 Jul 2019 13:04:16 +0200
Message-ID: <20190719110416.GA11224@amd>
In-Reply-To: <20190719101914.122689-4-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8074060968282273898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri 2019-07-19 12:19:14, Martin Hundeb=C3=B8ll wrote:
> ---
> =

> Changes since v1:
>  * new patch split out from PATCHv1 7/7
> =

>  doc/quectel-hardware-api.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> =

> diff --git a/doc/quectel-hardware-api.txt b/doc/quectel-hardware-api.txt
> index 6aafbfd8..411afcd1 100644
> --- a/doc/quectel-hardware-api.txt
> +++ b/doc/quectel-hardware-api.txt
> @@ -10,6 +10,25 @@ Methods		array{string,variant} GetProperties
>  			Returns hardware properties for the modem object. See
>  			the properties section for available properties.
>  =

> +Signals		PowerDown(string reason)
> +
> +			This signal is emitted on gracefull shutdowns initiated
> +			by the modem.
> +
> +			Possible reasons:
> +				"LowPower"	The supply voltage is too low
> +				"Normal"	The PWRKEY pin was asserted
> +				"HighPower"	The supply voltage is too high
> +
> +		PowerWarning(string reason)
> +
> +			This signal is emitted when the modem detects its supply
> +			voltage is close to its supported limits.
> +
> +			Possible reasons:
> +				"LowPower"	The supply voltage is low
> +				"HighPower"	The supply voltage is high
> +

It is "high voltage" not "high power", so maybe it should be
"HighVoltage" (etc?).

("Low power" sounds like device entered powersaving mode).
								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8074060968282273898==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMHhvNjhBQ2drUU1PZndhcFhiK3ZMNm1RQ2dxdENVWVRXeWpqTTBoVVN2dEsvWlhhaDQK
TGtvQW5SUFdYQUdRcWZvRmVYVzc5ell5YzNsaTNHS1MKPXpzR3kKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8074060968282273898==--

