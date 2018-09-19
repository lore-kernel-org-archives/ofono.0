Content-Type: multipart/mixed; boundary="===============4219063649473778485=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/7] extended support for LTE and NR. Some minor fixes. part 1
 of 7
Date: Wed, 19 Sep 2018 07:37:27 +0200
Message-ID: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4219063649473778485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs-context.h |  1 +
 include/lte.h          | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index 20ca9ef..8869c12 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -57,6 +57,7 @@ enum ofono_gprs_context_type {
 enum ofono_gprs_auth_method {
 	OFONO_GPRS_AUTH_METHOD_CHAP =3D 0,
 	OFONO_GPRS_AUTH_METHOD_PAP,
+	OFONO_GPRS_AUTH_METHOD_NONE,
 };
 =

 struct ofono_gprs_primary_context {
diff --git a/include/lte.h b/include/lte.h
index ef84ab9..38587c3 100644
--- a/include/lte.h
+++ b/include/lte.h
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2016  Endocode AG. All rights reserved.
+ *  Copyright (C) 2018 Gemalto M2M
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -28,14 +29,18 @@ extern "C" {
 =

 #include <ofono/types.h>
 =

-struct ofono_lte;
-
 struct ofono_lte_default_attach_info {
 	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
+	enum ofono_gprs_proto proto;
+	enum ofono_gprs_auth_method auth_method;
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 };
 =

 typedef void (*ofono_lte_cb_t)(const struct ofono_error *error, void *data=
);
 =

+struct ofono_lte;
+
 struct ofono_lte_driver {
 	const char *name;
 	int (*probe)(struct ofono_lte *lte, unsigned int vendor, void *data);
@@ -61,6 +66,8 @@ void ofono_lte_set_data(struct ofono_lte *lte, void *data=
);
 =

 void *ofono_lte_get_data(const struct ofono_lte *lte);
 =

+struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.9.1


--===============4219063649473778485==--

