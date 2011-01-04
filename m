Content-Type: multipart/mixed; boundary="===============3344065893101952172=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v3 2/7] cdma-sms: Add CDMA SMS Support
Date: Tue, 04 Jan 2011 15:00:50 -0800
Message-ID: <1294182050-5526-1-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3344065893101952172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    3 +-
 include/cdma-sms.h |   67 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 69 insertions(+), 1 deletions(-)
 create mode 100644 include/cdma-sms.h

diff --git a/Makefile.am b/Makefile.am
index 8a8555d..5028f4f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
-			include/ctm.h include/cdma-voicecall.h
+			include/ctm.h include/cdma-voicecall.h \
+			include/cdma-sms.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

diff --git a/include/cdma-sms.h b/include/cdma-sms.h
new file mode 100644
index 0000000..90d8803
--- /dev/null
+++ b/include/cdma-sms.h
@@ -0,0 +1,67 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifndef __OFONO_CDMA_SMS_H
+#define __OFONO_CDMA_SMS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_sms;
+
+typedef void (*ofono_cdma_sms_submit_cb_t)(const struct ofono_error *error,
+						void *data);
+
+struct ofono_cdma_sms_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_sms *cdma_sms, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_cdma_sms *cdma_sms);
+	void (*submit)(struct ofono_cdma_sms *cdma_sms, unsigned char *tpdu,
+			int tpdu_len, ofono_cdma_sms_submit_cb_t cb,
+			void *data);
+};
+
+void ofono_cdma_sms_deliver_notify(struct ofono_cdma_sms *cdma_sms,
+					unsigned char *pdu, int tpdu_len);
+
+int ofono_cdma_sms_driver_register(const struct ofono_cdma_sms_driver *d);
+void ofono_cdma_sms_driver_unregister(const struct ofono_cdma_sms_driver *=
d);
+
+struct ofono_cdma_sms *ofono_cdma_sms_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_cdma_sms_register(struct ofono_cdma_sms *cdma_sms);
+void ofono_cdma_sms_remove(struct ofono_cdma_sms *cdma_sms);
+
+void ofono_cdma_sms_set_data(struct ofono_cdma_sms *cdma_sms, void *data);
+void *ofono_cdma_sms_get_data(struct ofono_cdma_sms *cdma_sms);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_SMS_H */
-- =

1.7.0.4


--===============3344065893101952172==--

