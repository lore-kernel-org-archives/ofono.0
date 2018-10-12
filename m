Content-Type: multipart/mixed; boundary="===============5332115344151858188=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 2/5] lte.h: added proto and authentication handling
Date: Fri, 12 Oct 2018 09:27:46 +0200
Message-ID: <20181012072749.7788-2-gciofono@gmail.com>
In-Reply-To: <20181012072749.7788-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5332115344151858188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>

The ofono_lte_default_attach_info is extended with protocol,
authentication method, username and password.
The transmission of this info from the src to the atom happens
through the existing set_default_attach_info.
A signal is emitted when one of these properties changes

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
---
 include/lte.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/lte.h b/include/lte.h
index 0f2501c0..2f12ac29 100644
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
-- =

2.17.1


--===============5332115344151858188==--

