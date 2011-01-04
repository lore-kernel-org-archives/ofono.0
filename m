Content-Type: multipart/mixed; boundary="===============0329541207554496027=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 3/4] doc: detail Retries property
Date: Tue, 04 Jan 2011 20:22:58 -0200
Message-ID: <1294179779-4013-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294179779-4013-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0329541207554496027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 89c321e..65c920d 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -145,3 +145,15 @@ Properties	boolean Present [readonly]
 =

 			If BDN is enabled, oFono halts the SIM initialization
 			procedure and only emergency calls are allowed.
+
+		dict{string,byte} Retries [readonly]
+
+			Contains all the retry counters available. The possible
+			values for the first field are the same as in
+			PinRequired property. The second field contains is the
+			counter for that pin type.
+
+			This property is updated after each operation that
+			might have changed the retry counters, i.e. calls to
+			ChangePin(), EnterPin(), ResetPin() LockPin(),
+			UnlockPin().
-- =

1.7.3.4


--===============0329541207554496027==--

