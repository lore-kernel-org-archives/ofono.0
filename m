Content-Type: multipart/mixed; boundary="===============7901881215043667782=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Thu, 18 Nov 2010 13:35:08 +0200
Message-ID: <1290080108-19576-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1290080108-19576-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7901881215043667782==
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


--===============7901881215043667782==--

