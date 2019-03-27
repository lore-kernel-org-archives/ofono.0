Content-Type: multipart/mixed; boundary="===============2715624025517702109=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/6] sim: Added new properties to simmanager for DSSA
Date: Wed, 27 Mar 2019 13:25:45 +0100
Message-ID: <20190327122545.GA2737@amd>
In-Reply-To: <1553688552-22144-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2715624025517702109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed 2019-03-27 17:39:12, Antara Borwankar wrote:
> Adding two new properties to sim manager interface to handle
> dual SIM single active use case.
> =

> CardSlotCount [readonly]
> Contains the count of number of SIM card slots available.
> =

> ActiveCardSlot [readwrite]
> Contains the index of the currently active SIM card slot
> for dual SIM single active mode.

Hmm. There are already modems which can have both SIMs active at the
same time. Would it make sense to have the APIs ready for that?

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2715624025517702109==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseWJhOGtBQ2drUU1PZndhcFhiK3ZLYit3Q2dsZDUya3VIc2laYVFuVHY2NXg4YUdoRzIK
dnhnQW5qMXlTMFI5Y0dDSXR5b0RhT2dSR0ZhOEE4eXYKPUxCcnoKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2715624025517702109==--

