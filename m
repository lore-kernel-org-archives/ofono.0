Content-Type: multipart/mixed; boundary="===============7732409854889632116=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 05/11] Distinguish HSUPA and HSDPA
Date: Tue, 11 Jan 2011 16:08:33 +0200
Message-ID: <1294754919-9687-5-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7732409854889632116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common.c b/src/common.c
index 817af45..a5ea492 100644
--- a/src/common.c
+++ b/src/common.c
@@ -721,9 +721,9 @@ const char *data_tech_to_string(int tech)
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


--===============7732409854889632116==--

