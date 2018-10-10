Content-Type: multipart/mixed; boundary="===============2198781195693182832=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/6] lte.h: added proto and authentication handling
Date: Wed, 10 Oct 2018 08:54:50 +0200
Message-ID: <20181010065454.15232-2-gciofono@gmail.com>
In-Reply-To: <20181010065454.15232-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2198781195693182832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ofono_lte_default_attach_info is extended with protocol,
authentication method, username and password.
The transmission of this info from the src to the atom happens
through the existing set_default_attach_info.
A signal is emitted when one of these properties changes

There is a new function in the atom, set_reg_info, that the atom can
choose to use as a hint to transmit the information to the modem.

The newly added global function ofono_lte_set_reg_info locates the lte
atom if present, otherwise returns, and triggers the atom function
set_reg_info.
This function is to be called in src/modem just before setting it
online.
---
 include/lte.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/lte.h b/include/lte.h
index 0f2501c0..3f04984a 100644
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
@@ -32,6 +33,10 @@ struct ofono_lte;
 =

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
@@ -43,6 +48,8 @@ struct ofono_lte_driver {
 	void (*set_default_attach_info)(const struct ofono_lte *lte,
 			const struct ofono_lte_default_attach_info *info,
 			ofono_lte_cb_t cb, void *data);
+	void (*set_reg_info)(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info);
 };
 =

 int ofono_lte_driver_register(const struct ofono_lte_driver *d);
@@ -61,6 +68,8 @@ void ofono_lte_set_data(struct ofono_lte *lte, void *data=
);
 =

 void *ofono_lte_get_data(const struct ofono_lte *lte);
 =

+void ofono_lte_set_reg_info(struct ofono_modem *modem);
+
 struct ofono_modem *ofono_lte_get_modem(const struct ofono_lte *lte);
 =

 #ifdef __cplusplus
-- =

2.17.1


--===============2198781195693182832==--

