Content-Type: multipart/mixed; boundary="===============6290317420517736481=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 8/8] doc: update sim-api
Date: Tue, 12 Oct 2010 18:18:14 +0300
Message-ID: <1286896694-3054-9-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1286896694-3054-8-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6290317420517736481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index d5bf279..c502772 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -125,3 +125,7 @@ Properties	boolean Present [readonly]
 =

 			Contains the Intergrated Circuit Card Identifer (ICCID)
 			which is read directly from the SIM.
+
+		boolean FixedDialing [readonly]
+
+			True if a Fixed Dialing is enabled in SIM card.
-- =

1.6.3.3



--===============6290317420517736481==--

