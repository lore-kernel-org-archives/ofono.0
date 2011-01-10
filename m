Content-Type: multipart/mixed; boundary="===============7492117513113433220=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 5/6] doc: detail Retries property
Date: Mon, 10 Jan 2011 19:02:30 -0200
Message-ID: <1294693351-25475-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294693351-25475-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7492117513113433220==
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

1.7.3.5


--===============7492117513113433220==--

