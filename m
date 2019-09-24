Content-Type: multipart/mixed; boundary="===============0471904669264314306=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Tue, 24 Sep 2019 21:55:33 +0200
Message-ID: <20190924195533.GA10695@amd>
In-Reply-To: <20190924160126.26221-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0471904669264314306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue 2019-09-24 18:01:26, Jonas Bonn wrote:
> uBlox devices present their USB interfaces well before those interfaces
> are ready to respond to any commands.  The documentation says to monitor
> the 'greeting text' to detect readiness, but this 'greeting text' is not
> actually specified for any device other than the TOBY L4.

Collecting "greeting texts" from all the modems we want to support
should not be hard, right?

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============0471904669264314306==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMktkTFVBQ2drUU1PZndhcFhiK3ZKMm53Q2d0NDFvV2ZidjNNckorV0RGekdQeVdCVVkK
QTMwQW5qMnE5d3BuMi84akUrRUUxUzFDVDNIUG5lb3IKPTc1dEMKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============0471904669264314306==--

