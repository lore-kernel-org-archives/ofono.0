Content-Type: multipart/mixed; boundary="===============3207876788149862722=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/3] include: Add initial attach APN type
Date: Wed, 11 Nov 2015 15:38:37 +0100
Message-ID: <1447252719-9284-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3207876788149862722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The initial attach APN is used in LTE for signalling and to be able to
register to the network (default EPS bearer). Some operators request
users to configure this APN, so we need to add this APN type to ofono.
---
 include/gprs-context.h | 1 +
 include/gprs.h         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index ed27e66..9dae5f4 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -46,6 +46,7 @@ enum ofono_gprs_context_type {
 	OFONO_GPRS_CONTEXT_TYPE_MMS,
 	OFONO_GPRS_CONTEXT_TYPE_WAP,
 	OFONO_GPRS_CONTEXT_TYPE_IMS,
+	OFONO_GPRS_CONTEXT_TYPE_IA,
 };
 =

 enum ofono_gprs_auth_method {
diff --git a/include/gprs.h b/include/gprs.h
index 6c46d18..03849aa 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -27,6 +27,7 @@ extern "C" {
 #endif
 =

 #include <ofono/types.h>
+#include <ofono/gprs-context.h>
 =

 struct ofono_gprs;
 struct ofono_gprs_context;
@@ -45,6 +46,10 @@ struct ofono_gprs_driver {
 				ofono_gprs_cb_t cb, void *data);
 	void (*attached_status)(struct ofono_gprs *gprs,
 					ofono_gprs_status_cb_t cb, void *data);
+	void (*set_ia_apn)(struct ofono_gprs *gprs, const char *apn,
+				enum ofono_gprs_proto proto, const char *user,
+				const char *passwd, const char *mccmnc,
+				ofono_gprs_cb_t cb, void *data);
 };
 =

 enum gprs_suspend_cause {
-- =

2.5.0


--===============3207876788149862722==--

