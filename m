Content-Type: multipart/mixed; boundary="===============8404546603384484148=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/4] doc: Add BarredDialing property
Date: Mon, 25 Oct 2010 04:34:16 -0700
Message-ID: <1288006457-5415-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1288006457-5415-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8404546603384484148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/sim-api.txt b/doc/sim-api.txt
index 6dc5e0b..d4d2b1b 100644
--- a/doc/sim-api.txt
+++ b/doc/sim-api.txt
@@ -138,3 +138,10 @@ Properties	boolean Present [readonly]
 =

 			If FDN is enabled, oFono halts the SIM initialization
 			procedure and only emergency calls are allowed.
+
+		boolean BarredDialing [readonly]
+
+			True if Barred Dialing service is enabled in SIM card.
+
+			If BDN is enabled, oFono halts the SIM initialization
+			procedure and only emergency calls are allowed.
-- =

1.7.0.4


--===============8404546603384484148==--

