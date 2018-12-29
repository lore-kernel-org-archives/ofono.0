Content-Type: multipart/mixed; boundary="===============1870582134140037860=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] document getting of ell, point people at useful docs
Date: Sat, 29 Dec 2018 23:47:04 +0100
Message-ID: <20181229224704.GA4451@amd>
In-Reply-To: <20181229222430.GB28688@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1870582134140037860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently there's README and HACKING... each describing part of what
needs to be done to build ofono.

Provide some cross-links and fix build example.

diff --git a/HACKING b/HACKING
index 15ea291..b1bd599 100644
--- a/HACKING
+++ b/HACKING
@@ -45,7 +45,8 @@ bootstrap-configure since it could export development spe=
cific settings.
 So the normal steps to checkout, build and install such a repository is
 like this:
 =

-  Checkout repository
+  Checkout repositories
+    # git clone git://git.kernel.org/pub/scm/libs/ell/ell.git
     # git clone git://git.kernel.org/pub/scm/network/ofono/ofono.git
     # cd ofono
 =

diff --git a/README b/README
index 45bb2e9..04a50a5 100644
--- a/README
+++ b/README
@@ -16,11 +16,14 @@ To configure run:
 	./configure --prefix=3D/usr --mandir=3D/usr/share/man \
 				--sysconfdir=3D/etc --localstatedir=3D/var
 =

-Configure automatically searches for all required components and packages.
+Configure automatically searches for all required components and
+packages, except ell, mentioned below.
 =

 To compile and install run:
 	make && make install
 =

+See "HACKING" file for details and step-by-step examples.
+
 =

 Embedded Linux library
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1870582134140037860==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd24rV2NBQ2drUU1PZndhcFhiK3ZJeVR3Q2ZZVG9WSHJ5MUYvMytEOUtHRHl6cGdYQWsK
SlMwQW4xS00wNXVJeEJXb0N5amR5RHErWlE0RmlXRTgKPXlwbTIKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1870582134140037860==--

