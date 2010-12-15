Content-Type: multipart/mixed; boundary="===============8676415492302679525=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/6] doc: detail PinRetries property
Date: Tue, 14 Dec 2010 23:36:31 -0200
Message-ID: <1292376992-1888-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1292376992-1888-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8676415492302679525==
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

1.7.3.3


--===============8676415492302679525==--

