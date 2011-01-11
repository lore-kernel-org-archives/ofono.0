Content-Type: multipart/mixed; boundary="===============1941378136844652614=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 02/11] Network registration does not contain data technology
Date: Tue, 11 Jan 2011 16:08:30 +0200
Message-ID: <1294754919-9687-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1941378136844652614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Provide different rules to parse network registration and packet
service registration values. Data technologies do not make sense
for network registration, and will be added to ConnectionManager
in a later commit.
---
 src/common.c |   19 +++++++++++++++++++
 src/common.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index 4d93488..817af45 100644
--- a/src/common.c
+++ b/src/common.c
@@ -694,6 +694,25 @@ const char *registration_tech_to_string(int tech)
 {
 	switch (tech) {
 	case ACCESS_TECHNOLOGY_GSM:
+	case ACCESS_TECHNOLOGY_GSM_COMPACT:
+	case ACCESS_TECHNOLOGY_GSM_EGPRS:
+		return "gsm";
+	case ACCESS_TECHNOLOGY_UTRAN:
+	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
+	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
+	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
+		return "umts";
+	case ACCESS_TECHNOLOGY_EUTRAN:
+		return "lte";
+	default:
+		return "";
+	}
+}
+
+const char *data_tech_to_string(int tech)
+{
+	switch (tech) {
+	case ACCESS_TECHNOLOGY_GSM:
 		return "gsm";
 	case ACCESS_TECHNOLOGY_GSM_COMPACT:
 		return "gsm";
diff --git a/src/common.h b/src/common.h
index 64f297e..4509d48 100644
--- a/src/common.h
+++ b/src/common.h
@@ -158,5 +158,6 @@ gboolean is_valid_pin(const char *pin, enum pin_type ty=
pe);
 =

 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
+const char *data_tech_to_string(int tech);
 =

 gboolean is_valid_apn(const char *apn);
-- =

1.7.1


--===============1941378136844652614==--

