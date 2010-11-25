Content-Type: multipart/mixed; boundary="===============0376500534982773823=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 4/6] Define packet switched bearers
Date: Thu, 25 Nov 2010 17:14:36 +0200
Message-ID: <1290698078-18803-4-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201011251714.19241.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0376500534982773823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |   14 ++++++++++++++
 src/common.h |   13 +++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index 1088b5d..e403756 100644
--- a/src/common.c
+++ b/src/common.c
@@ -673,6 +673,20 @@ const char *registration_tech_to_string(int tech)
 	}
 }
 =

+const char *packet_bearer_to_string(int bearer)
+{
+	static const char list[][6] =3D {
+		"none",
+		"gsm", "edge",
+		"umts", "hsupa", "hsdpa", "hspa",
+		"lte",
+	};
+
+	if (((unsigned)bearer) < sizeof (list) / sizeof (list[0]))
+		return list[bearer];
+	return "unknown";
+}
+
 gboolean is_valid_apn(const char *apn)
 {
 	int i;
diff --git a/src/common.h b/src/common.h
index 8b5798a..31438d7 100644
--- a/src/common.h
+++ b/src/common.h
@@ -80,6 +80,18 @@ enum bearer_class {
 	BEARER_CLASS_PAD =3D 128
 };
 =

+/* 27.007 Section 7.29 */
+enum packet_bearer {
+	PACKET_BEARER_NONE =3D 0,
+	PACKET_BEARER_GPRS =3D 1,
+	PACKET_BEARER_EDGE =3D 2,
+	PACKET_BEARER_UMTS =3D 3,
+	PACKET_BEARER_HSUPA =3D 4,
+	PACKET_BEARER_HSDPA =3D 5,
+	PACKET_BEARER_HSUPA_HSDPA =3D 6,
+	PACKET_BEARER_LTE =3D 7,
+};
+
 /* 22.030 Section 6.5.2 */
 enum ss_control_type {
 	SS_CONTROL_TYPE_ACTIVATION,
@@ -145,5 +157,6 @@ gboolean is_valid_pin(const char *pin, enum pin_type ty=
pe);
 =

 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
+const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
-- =

1.7.1


--===============0376500534982773823==--

