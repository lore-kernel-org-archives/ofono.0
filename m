Content-Type: multipart/mixed; boundary="===============5020978433214371624=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] fix compilation on gcc-6.3
Date: Sat, 29 Dec 2018 23:24:30 +0100
Message-ID: <20181229222430.GB28688@amd>
In-Reply-To: <20181229203046.GA1949@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5020978433214371624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gcc-6 fails to compile ofono due to #pragma directives. Limit them to
gcc versions where they are needed.

diff --git a/drivers/rilmodem/call-forwarding.c b/drivers/rilmodem/call-for=
warding.c
index eb65c23..231a06c 100644
--- a/drivers/rilmodem/call-forwarding.c
+++ b/drivers/rilmodem/call-forwarding.c
@@ -37,7 +37,9 @@
 #include <ofono/call-forwarding.h>
 #include "common.h"
 =

+#if __GNUC__ > 7
 #pragma GCC diagnostic ignored "-Wrestrict"
+#endif
 =

 #include "gril.h"
 =

diff --git a/drivers/rilmodem/network-registration.c b/drivers/rilmodem/net=
work-registration.c
index 99c80bc..241ec5f 100644
--- a/drivers/rilmodem/network-registration.c
+++ b/drivers/rilmodem/network-registration.c
@@ -36,7 +36,9 @@
 #include <ofono/modem.h>
 #include <ofono/netreg.h>
 =

+#if __GNUC__ > 7
 #pragma GCC diagnostic ignored "-Wrestrict"
+#endif
 =

 #include <gril/gril.h>
 =



-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5020978433214371624==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd245QjRBQ2drUU1PZndhcFhiK3ZLMzN3Q2ZiZ0dBVHNnTjNMVWpycjJMNGF1MXlZN0UK
WWxRQW5BbTZmOEZBTHdkWEdaSmw2VStjQlRxUTJPSHAKPU05NmUKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5020978433214371624==--

