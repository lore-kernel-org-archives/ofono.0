Content-Type: multipart/mixed; boundary="===============1953158164604779126=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/1] Distinguish HSDPA, HSUPA or both as access technologies
Date: Tue, 04 Jan 2011 18:18:41 +0200
Message-ID: <1294157921-23657-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1953158164604779126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |    5 +++--
 src/common.c        |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 4616542..28304e3 100644
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

diff --git a/src/common.c b/src/common.c
index 4d93488..d4e567b 100644
--- a/src/common.c
+++ b/src/common.c
@@ -702,9 +702,9 @@ const char *registration_tech_to_string(int tech)
 	case ACCESS_TECHNOLOGY_GSM_EGPRS:
 		return "edge";
 	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
-		return "hspa";
+		return "hsdpa";
 	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
-		return "hspa";
+		return "hsupa";
 	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
 		return "hspa";
 	case ACCESS_TECHNOLOGY_EUTRAN:
-- =

1.7.1


--===============1953158164604779126==--

