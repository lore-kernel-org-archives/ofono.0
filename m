Content-Type: multipart/mixed; boundary="===============0342081431088325917=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/4] doc: detail PinRetries property
Date: Mon, 20 Dec 2010 19:56:37 -0200
Message-ID: <1292882198-13736-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1292882198-13736-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0342081431088325917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index d4d2b1b..c7d1faa 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -145,3 +145,13 @@ Properties	boolean Present [readonly]
 =

 			If BDN is enabled, oFono halts the SIM initialization
 			procedure and only emergency calls are allowed.
+
+		byte PinRetries [readonly]
+
+			Contains the retry counter for the current required
+			pin. This counter is tipically decremented whenever a
+			call to EnterPin() fails.
+
+			E.g.: if PinRequired is equal "puk", this property
+			contains the number of times EnterPin can be called
+			with a wrong puk.
-- =

1.7.3.4


--===============0342081431088325917==--

