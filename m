Content-Type: multipart/mixed; boundary="===============4796004081585487598=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 3/6] gatqcdm: Add helper functions for QCDM handling
Date: Wed, 18 Jan 2012 18:05:14 +0100
Message-ID: <1326906317-11601-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4796004081585487598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am       |    1 +
 gatchat/gatqcdm.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/gatqcdm.h |   57 ++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 gatchat/gatqcdm.c
 create mode 100644 gatchat/gatqcdm.h

diff --git a/Makefile.am b/Makefile.am
index 0472dfa..fc8bc42 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -72,6 +72,7 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/gatserver.h gatchat/gatserver.c \
 				gatchat/gatrawip.h gatchat/gatrawip.c \
 				gatchat/gathdlc.c gatchat/gathdlc.h \
+				gatchat/gatqcdm.c gatchat/gatqcdm.h \
 				gatchat/gatppp.c gatchat/gatppp.h \
 				gatchat/ppp.h gatchat/ppp_cp.h \
 				gatchat/ppp_cp.c gatchat/ppp_lcp.c \
diff --git a/gatchat/gatqcdm.c b/gatchat/gatqcdm.c
new file mode 100644
index 0000000..3941a8e
--- /dev/null
+++ b/gatchat/gatqcdm.c
@@ -0,0 +1,84 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include "gatqcdm.h"
+
+#define QCDM_RESULT_VERSION_LENGTH	55
+#define QCDM_RESULT_STATUS_LENGTH	48
+
+#define QCDM_RESULT_STATUS_CDMA_RX_STATE_OFFSET	23
+#define QCDM_RESULT_STATUS_SID_OFFSET	39
+
+gboolean g_at_qcdm_send(GAtHDLC *hdlc, guint8 cmd, GAtReceiveFunc func,
+							gpointer user_data)
+{
+	unsigned char cmdbuf[1];
+
+	cmdbuf[0] =3D cmd;
+
+	g_at_hdlc_set_receive(hdlc, func, user_data);
+	return g_at_hdlc_send(hdlc, cmdbuf, sizeof(cmdbuf));
+}
+
+
+gboolean g_at_qcdm_result_get_version_info(const unsigned char *buf, gsize=
 len,
+						struct version_info *verinfo)
+{
+	if (len < 1 || len > QCDM_RESULT_VERSION_LENGTH ||
+			buf[0] !=3D G_AT_QCDM_CMD_VERSION_INFO)
+		return FALSE;
+
+	memcpy(verinfo->comp_date, buf+1, 11);
+	verinfo->comp_date[11] =3D '\0';
+	memcpy(verinfo->comp_time, buf+12, 8);
+	verinfo->comp_time[8] =3D '\0';
+	memcpy(verinfo->rel_date, buf+20, 11);
+	verinfo->rel_date[11] =3D '\0';
+	memcpy(verinfo->rel_time, buf+31, 8);
+	verinfo->rel_time[8] =3D '\0';
+	memcpy(verinfo->model, buf+39, 8);
+	verinfo->model[8] =3D '\0';
+	verinfo->msm_ver =3D buf[53];
+
+	return TRUE;
+}
+
+gboolean g_at_qcdm_result_parse_status(const unsigned char *buf, gsize len,
+						guint16 *sid)
+{
+	if (len < 1 || len > QCDM_RESULT_STATUS_LENGTH ||
+			buf[0] !=3D G_AT_QCDM_CMD_STATUS)
+		return FALSE;
+
+	/* check if network is registered */
+	if (buf[QCDM_RESULT_STATUS_CDMA_RX_STATE_OFFSET] =3D=3D 0)
+		return FALSE;
+
+	*sid =3D buf[QCDM_RESULT_STATUS_SID_OFFSET+1] << 8 |
+			buf[QCDM_RESULT_STATUS_SID_OFFSET];
+
+	return TRUE;
+}
diff --git a/gatchat/gatqcdm.h b/gatchat/gatqcdm.h
new file mode 100644
index 0000000..2e6cf46
--- /dev/null
+++ b/gatchat/gatqcdm.h
@@ -0,0 +1,57 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __G_AT_QCDM_H
+#define __G_AT_QCDM_H
+
+#include <glib.h>
+#include "gathdlc.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define G_AT_QCDM_CMD_VERSION_INFO	0	/* Version info */
+#define G_AT_QCDM_CMD_STATUS		12	/* Station status */
+
+struct version_info {
+	char comp_date[12];
+	char comp_time[9];
+	char rel_date[12];
+	char rel_time[9];
+	char model[9];
+	guint8 msm_ver;
+};
+
+gboolean g_at_qcdm_send(GAtHDLC *hdlc, guint8 cmd, GAtReceiveFunc func,
+				gpointer user_data);
+
+gboolean g_at_qcdm_result_get_version_info(const unsigned char *buf, gsize=
 len,
+						struct version_info *verinfo);
+
+gboolean g_at_qcdm_result_parse_status(const unsigned char *buf, gsize len,
+						guint16 *sid);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __G_AT_QCDM_H */
-- =

1.7.1


--===============4796004081585487598==--

