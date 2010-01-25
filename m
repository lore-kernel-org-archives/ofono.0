Content-Type: multipart/mixed; boundary="===============8447942487484563814=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 3/6] STE-plugin: STE modem driver definition
Date: Mon, 25 Jan 2010 20:25:30 +0100
Message-ID: <1264447534-2386-4-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1264447534-2386-3-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8447942487484563814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/stemodem.c |   50 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/stemodem/stemodem.h |   29 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 drivers/stemodem/stemodem.c
 create mode 100644 drivers/stemodem/stemodem.h

diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
new file mode 100644
index 0000000..530956c
--- /dev/null
+++ b/drivers/stemodem/stemodem.c
@@ -0,0 +1,50 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "stemodem.h"
+
+static int stemodem_init(void)
+{
+
+	return 0;
+}
+
+static void stemodem_exit(void)
+{
+
+}
+
+OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			stemodem_init, stemodem_exit)
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
new file mode 100644
index 0000000..c34067d
--- /dev/null
+++ b/drivers/stemodem/stemodem.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
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
+#include <drivers/atmodem/atutil.h>
+
+extern void ste_voicecall_init();
+extern void ste_voicecall_exit();
+
+extern void ste_gprs_context_init();
+extern void ste_gprs_context_exit();
-- =

1.6.0.4


--===============8447942487484563814==--

