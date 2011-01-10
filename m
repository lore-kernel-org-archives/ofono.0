Content-Type: multipart/mixed; boundary="===============7374369212137990975=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 02/10] Distinguish HSDPA, HSUPA or both as access technologies
Date: Mon, 10 Jan 2011 15:15:17 +0200
Message-ID: <1294665325-11937-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7374369212137990975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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


--===============7374369212137990975==--

