Content-Type: multipart/mixed; boundary="===============4975863886280822256=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 06/10] Define packet switched bearers
Date: Mon, 10 Jan 2011 15:15:21 +0200
Message-ID: <1294665325-11937-6-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4975863886280822256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |   15 +++++++++++++++
 src/common.h |   13 +++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index d4e567b..595bc53 100644
--- a/src/common.c
+++ b/src/common.c
@@ -714,6 +714,21 @@ const char *registration_tech_to_string(int tech)
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
+
+	return "unknown";
+}
+
 gboolean is_valid_apn(const char *apn)
 {
 	int i;
diff --git a/src/common.h b/src/common.h
index 64f297e..d11cd8e 100644
--- a/src/common.h
+++ b/src/common.h
@@ -87,6 +87,18 @@ enum bearer_class {
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
@@ -158,5 +170,6 @@ gboolean is_valid_pin(const char *pin, enum pin_type ty=
pe);
 =

 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
+const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
-- =

1.7.1


--===============4975863886280822256==--

