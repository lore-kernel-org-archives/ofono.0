Content-Type: multipart/mixed; boundary="===============5089123505864478059=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/2] Update the network documentation
Date: Tue, 16 Nov 2010 12:59:12 +0200
Message-ID: <1289905152-20137-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <ec27632d1746f72703cc59e1f2cadf2a@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5089123505864478059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 083e918..9fb9974 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -125,8 +125,9 @@ Properties	string Mode [readonly]
 =

 			Contains the technology of the current network.
 =

-			The possible values are: "gsm", "edge", "umts", "hspa",
-							"lte"
+			The possible values are: "gsm", "edge", "umts",
+			"hsdpa", "hsupa", "hspa" (meaning both hsdpa and hsupa)
+			and "lte"
 =

 			TODO: Values for CDMA and EVDO based networks.
 =

-- =

1.7.1


--===============5089123505864478059==--

