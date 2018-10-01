Content-Type: multipart/mixed; boundary="===============2325862903824542618=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] coex: adding coex interface doc for  coex api
Date: Mon, 01 Oct 2018 21:20:43 +0200
Message-ID: <20181001192043.GA4218@amd>
In-Reply-To: <1538389988-6093-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2325862903824542618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!


> +*header for params
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +string
> +	uint16 MobileNetworkCode [readonly, optional]
> +		Contains the MNC of the cell.

> +string
> +	uint16 MobileCountryCode [readonly, optional]
> +		Contains the MCC of the cell.

Confused. What is *header? Is MobileNetworkCode uint16 or string?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2325862903824542618==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsdXljNHNBQ2drUU1PZndhcFhiK3ZKeGdBQ2doMjJuZjhQOUdhWlFINWs3ZTNJbFZLT0UK
RndZQW5BaVFHbVZFMk1wS3BUbW9ma3BiT2MrRDh1dmcKPXhQMUkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2325862903824542618==--

