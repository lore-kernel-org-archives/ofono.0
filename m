Content-Type: multipart/mixed; boundary="===============4818941075835349755=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/2] Distinguish HSDPA, HSUPA or both as access technologies
Date: Tue, 16 Nov 2010 12:59:11 +0200
Message-ID: <1289905152-20137-1-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <ec27632d1746f72703cc59e1f2cadf2a@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4818941075835349755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common.c b/src/common.c
index b5b9a6f..22bf1c2 100644
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


--===============4818941075835349755==--

