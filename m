Content-Type: multipart/mixed; boundary="===============2013062896113605595=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/6] Define packet switched bearers
Date: Thu, 20 Jan 2011 10:37:48 +0200
Message-ID: <1295512672-4891-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101201037.31234.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2013062896113605595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |   23 +++++++++++++++++++++++
 src/common.h |   13 +++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index d4e567b..2dd0da0 100644
--- a/src/common.c
+++ b/src/common.c
@@ -714,6 +714,29 @@ const char *registration_tech_to_string(int tech)
 	}
 }
 =

+const char *packet_bearer_to_string(int bearer)
+{
+	switch (bearer) {
+	case PACKET_BEARER_NONE:
+		return "none";
+	case PACKET_BEARER_GPRS:
+		return "gprs";
+	case PACKET_BEARER_EGPRS:
+		return "edge";
+	case PACKET_BEARER_UMTS:
+		return "umts";
+	case PACKET_BEARER_HSUPA:
+		return "hsupa";
+	case PACKET_BEARER_HSDPA:
+		return "hsdpa";
+	case PACKET_BEARER_HSUPA_HSDPA:
+		return "hspa";
+	case PACKET_BEARER_EPS:
+		return "lte";
+	}
+	return "";
+}
+
 gboolean is_valid_apn(const char *apn)
 {
 	int i;
diff --git a/src/common.h b/src/common.h
index 50c418d..d4bcd36 100644
--- a/src/common.h
+++ b/src/common.h
@@ -87,6 +87,18 @@ enum bearer_class {
 	BEARER_CLASS_PAD =3D		128,
 };
 =

+/* 27.007 Section 7.29 */
+enum packet_bearer {
+	PACKET_BEARER_NONE =3D		0,
+	PACKET_BEARER_GPRS =3D		1,
+	PACKET_BEARER_EGPRS =3D		2,
+	PACKET_BEARER_UMTS =3D		3,
+	PACKET_BEARER_HSUPA =3D		4,
+	PACKET_BEARER_HSDPA =3D		5,
+	PACKET_BEARER_HSUPA_HSDPA =3D	6,
+	PACKET_BEARER_EPS =3D		7,
+};
+
 /* 22.030 Section 6.5.2 */
 enum ss_control_type {
 	SS_CONTROL_TYPE_ACTIVATION,
@@ -164,5 +176,6 @@ gboolean is_valid_pin(const char *pin, enum pin_type ty=
pe);
 =

 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
+const char *packet_bearer_to_string(int bearer);
 =

 gboolean is_valid_apn(const char *apn);
-- =

1.7.1


--===============2013062896113605595==--

