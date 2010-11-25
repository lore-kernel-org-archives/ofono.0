Content-Type: multipart/mixed; boundary="===============1811426949088793248=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/6] Distinguish HSDPA, HSUPA or both as access technologies
Date: Thu, 25 Nov 2010 17:14:33 +0200
Message-ID: <1290698078-18803-1-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201011251714.19241.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1811426949088793248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common.c b/src/common.c
index f32153c..1088b5d 100644
--- a/src/common.c
+++ b/src/common.c
@@ -661,9 +661,9 @@ const char *registration_tech_to_string(int tech)
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


--===============1811426949088793248==--

