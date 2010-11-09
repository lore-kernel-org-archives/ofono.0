Content-Type: multipart/mixed; boundary="===============0953188349936736603=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 5/8] dun: add network registration atom
Date: Tue, 09 Nov 2010 02:42:58 -0200
Message-ID: <1289277781-6378-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1289277781-6378-5-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0953188349936736603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                             |    4 +-
 drivers/dunmodem/dunmodem.c             |    3 +
 drivers/dunmodem/dunmodem.h             |    3 +
 drivers/dunmodem/network-registration.c |   91 +++++++++++++++++++++++++++=
++++
 plugins/dun.c                           |   10 ++++
 5 files changed, 110 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dunmodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 7fcde7f..344fda6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -197,7 +197,9 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/call-volume.c
 =

 builtin_modules +=3D dunmodem
-builtin_sources +=3D drivers/dunmodem/dunmodem.h drivers/dunmodem/dunmodem=
.c
+builtin_sources +=3D drivers/dunmodem/dunmodem.h \
+			drivers/dunmodem/dunmodem.c \
+			drivers/dunmodem/network-registration.c
 =

 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
index 1020dd2..565b40e 100644
--- a/drivers/dunmodem/dunmodem.c
+++ b/drivers/dunmodem/dunmodem.c
@@ -40,11 +40,14 @@
 =

 static int dunmodem_init(void)
 {
+	dun_netreg_init();
+
 	return 0;
 }
 =

 static void dunmodem_exit(void)
 {
+	dun_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(dunmodem, "Dial-up Networking Driver", VERSION,
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index f7351b7..f4c54dc 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -24,3 +24,6 @@ struct dun_data {
 	char *rfcomm;
 	GAtChat *chat;
 };
+
+void dun_netreg_init();
+void dun_netreg_exit();
diff --git a/drivers/dunmodem/network-registration.c b/drivers/dunmodem/net=
work-registration.c
new file mode 100644
index 0000000..901aa41
--- /dev/null
+++ b/drivers/dunmodem/network-registration.c
@@ -0,0 +1,91 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009 ProFUSION embedded systems. All rights reserved.
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+
+#include "gatchat.h"
+#include "common.h"
+
+#include "dunmodem.h"
+
+
+static void dun_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data)
+{
+	struct ofono_error error;
+
+	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+
+	cb(&error, NETWORK_REGISTRATION_STATUS_REGISTERED,
+			-1, -1, -1, data);
+}
+
+static gboolean dun_netreg_register(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	ofono_netreg_register(netreg);
+
+	return FALSE;
+}
+
+static int dun_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *user_data)
+{
+	g_idle_add(dun_netreg_register, netreg);
+
+	return 0;
+}
+
+static void dun_netreg_remove(struct ofono_netreg *netreg)
+{
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name				=3D "dunmodem",
+	.probe				=3D dun_netreg_probe,
+	.remove				=3D dun_netreg_remove,
+	.registration_status		=3D dun_registration_status,
+};
+
+void dun_netreg_init()
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void dun_netreg_exit()
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/plugins/dun.c b/plugins/dun.c
index 488e7a3..7e0b768 100644
--- a/plugins/dun.c
+++ b/plugins/dun.c
@@ -303,12 +303,22 @@ static int dun_disable(struct ofono_modem *modem)
 	return -EINPROGRESS;
 }
 =

+static void dun_pre_sim(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_netreg_create(modem, 0, "dunmodem", data);
+}
+
 static struct ofono_modem_driver dun_driver =3D {
 	.name		=3D "dun",
 	.probe		=3D dun_probe,
 	.remove		=3D dun_remove,
 	.enable		=3D dun_enable,
 	.disable	=3D dun_disable,
+	.pre_sim	=3D dun_pre_sim,
 };
 =

 static struct bluetooth_profile dun_profile =3D {
-- =

1.7.3


--===============0953188349936736603==--

