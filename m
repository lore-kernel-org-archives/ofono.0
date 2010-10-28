Content-Type: multipart/mixed; boundary="===============6840829297080636316=="
MIME-Version: 1.0
From: Rajesh Kadhiravan Nagaiah <Rajesh.Nagaiah@elektrobit.com>
Subject: [PATCH 3/4] common: Add modem access tech to string function
Date: Thu, 28 Oct 2010 01:14:53 -0700
Message-ID: <1288253694-25800-4-git-send-email-Rajesh.Nagaiah@elektrobit.com>
In-Reply-To: <1288253694-25800-1-git-send-email-Rajesh.Nagaiah@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6840829297080636316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/common.c |   12 ++++++++++++
 src/common.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/src/common.c b/src/common.c
index b5b9a6f..9b57b98 100644
--- a/src/common.c
+++ b/src/common.c
@@ -673,6 +673,18 @@ const char *registration_tech_to_string(int tech)
 	}
 }
 =

+const char *modem_access_tech_to_string(int access_tech)
+{
+	switch (access_tech) {
+	case OFONO_MODEM_ACCESS_TECHNOLOGY_GSM:
+		return "gsm";
+	case OFONO_MODEM_ACCESS_TECHNOLOGY_CDMA:
+		return "cdma";
+	default:
+		return "";
+	}
+}
+
 gboolean is_valid_apn(const char *apn)
 {
 	int i;
diff --git a/src/common.h b/src/common.h
index 8b5798a..f58ed68 100644
--- a/src/common.h
+++ b/src/common.h
@@ -146,4 +146,6 @@ gboolean is_valid_pin(const char *pin, enum pin_type ty=
pe);
 const char *registration_status_to_string(int status);
 const char *registration_tech_to_string(int tech);
 =

+const char *modem_access_tech_to_string(int access_tech);
+
 gboolean is_valid_apn(const char *apn);
-- =

1.7.0.4


--===============6840829297080636316==--

