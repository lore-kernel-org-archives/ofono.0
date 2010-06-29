Content-Type: multipart/mixed; boundary="===============4670441475274766014=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 2/2] PPP GPRS context is now done, update documentation
Date: Tue, 29 Jun 2010 10:59:37 +0300
Message-ID: <20100629075937.18717.75437.stgit@potku.valot.fi>
In-Reply-To: <20100629075931.18717.84414.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4670441475274766014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---
 TODO             |    7 -------
 doc/overview.txt |    6 ------
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/TODO b/TODO
index a25394a..470d4a6 100644
--- a/TODO
+++ b/TODO
@@ -200,13 +200,6 @@ Flight Mode
 GPRS
 =3D=3D=3D=3D
 =

-- PPP gprs-context driver support.  Add an implementation for 'atmodem' th=
at
-  will use the GAtPPP stack to drive a GPRS context interface.  Nicely sup=
port
-  existing PPP based modems like Huawei, Novatel and Sierra.
-
-  Priority: High
-  Complexity: C2
-
 - PPP Server support.  Extend GAtPPP to support PPP Server role, similarly=
 to
   how existing GSM modems support PPP GPRS contexts.
 =

diff --git a/doc/overview.txt b/doc/overview.txt
index cda9f68..a18e620 100644
--- a/doc/overview.txt
+++ b/doc/overview.txt
@@ -130,12 +130,6 @@ Work in progress features:
 		User initiated USSD support is available, but not
 		network-initiated USSD support.
 =

-	PPP
-
-		Modems that use PPP for data connections are currently not
-		supported.  This feature will be available once a functional
-		userspace ppp stack is available.
-
 Not implemented features:
 =

 	SIM card storage


--===============4670441475274766014==--

