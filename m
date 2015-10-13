Content-Type: multipart/mixed; boundary="===============2572847844256545244=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 8/9] rildev: plugin that creates ril-type modems
Date: Tue, 13 Oct 2015 18:07:57 +0200
Message-ID: <1444752478-18198-9-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2572847844256545244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This plugin creates modems that use the rilmodem driver by looking at
environment variables: when OFONO_RIL_DEVICE exists it creates a ril
modem of the sub-type specified by the variable. OFONO_RIL_NUM_SIM_SLOTS
specifies the number of SIM slots for multi-SIM modems.
---
 plugins/rildev.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 133 insertions(+)
 create mode 100644 plugins/rildev.c

diff --git a/plugins/rildev.c b/plugins/rildev.c
new file mode 100644
index 0000000..461324d
--- /dev/null
+++ b/plugins/rildev.c
@@ -0,0 +1,133 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2014 Canonical Ltd.
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
+#include <errno.h>
+#include <ctype.h>
+#include <stdlib.h>
+
+#include <glib.h>
+#include <string.h>
+#include <stdio.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/log.h>
+
+static GSList *modem_list;
+
+static int create_rilmodem(const char *ril_type, int slot)
+{
+	struct ofono_modem *modem;
+	char dev_name[64];
+	int retval;
+
+	snprintf(dev_name, sizeof(dev_name), "ril_%d", slot);
+
+	modem =3D ofono_modem_create(dev_name, ril_type);
+	if (modem =3D=3D NULL) {
+		DBG("ofono_modem_create failed for type %s", ril_type);
+		return -ENODEV;
+	}
+
+	modem_list =3D g_slist_prepend(modem_list, modem);
+
+	ofono_modem_set_integer(modem, "Slot", slot);
+
+	/* This causes driver->probe() to be called... */
+	retval =3D ofono_modem_register(modem);
+	if (retval !=3D 0) {
+		ofono_error("%s: ofono_modem_register returned: %d",
+				__func__, retval);
+		return retval;
+	}
+
+	/*
+	 * kickstart the modem:
+	 * causes core modem code to call
+	 * - set_powered(TRUE) - which in turn
+	 *   calls driver->enable()
+	 *
+	 * - driver->pre_sim()
+	 *
+	 * Could also be done via:
+	 *
+	 * - a DBus call to SetProperties w/"Powered=3DTRUE" *1
+	 * - sim_state_watch ( handles SIM removal? LOCKED states? **2
+	 * - ofono_modem_set_powered()
+	 */
+	ofono_modem_reset(modem);
+
+	return 0;
+}
+
+static int detect_init(void)
+{
+	const char *ril_type;
+	const char *multi_sim;
+	int num_slots =3D 1;
+	int i;
+
+	ril_type =3D getenv("OFONO_RIL_DEVICE");
+	if (ril_type =3D=3D NULL)
+		ril_type =3D "ril";
+
+	/* Check for multi-SIM support */
+	multi_sim =3D getenv("OFONO_RIL_NUM_SIM_SLOTS");
+	if (multi_sim !=3D NULL && *multi_sim !=3D '\0') {
+		int env_slots;
+		char *endp;
+
+		env_slots =3D (int) strtoul(multi_sim, &endp, 10);
+		if (*endp =3D=3D '\0')
+			num_slots =3D env_slots;
+	}
+
+	ofono_info("RILDEV detected modem type %s, %d SIM slot(s)",
+			ril_type, num_slots);
+
+	for (i =3D 0; i < num_slots; ++i)
+		create_rilmodem(ril_type, i);
+
+	return 0;
+}
+
+static void detect_exit(void)
+{
+	GSList *list;
+
+	for (list =3D modem_list; list; list =3D list->next) {
+		struct ofono_modem *modem =3D list->data;
+
+		ofono_modem_remove(modem);
+	}
+
+	g_slist_free(modem_list);
+	modem_list =3D NULL;
+}
+
+OFONO_PLUGIN_DEFINE(rildev, "ril type detection", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, detect_init, detect_exit)
-- =

2.1.4


--===============2572847844256545244==--

