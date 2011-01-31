Content-Type: multipart/mixed; boundary="===============7614009425330048793=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 4/8] include: add public headed to emulator atom
Date: Mon, 31 Jan 2011 18:51:58 -0200
Message-ID: <1296507122-10936-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296507122-10936-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7614009425330048793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |   55 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100644 include/emulator.h

diff --git a/include/emulator.h b/include/emulator.h
new file mode 100644
index 0000000..1287b47
--- /dev/null
+++ b/include/emulator.h
@@ -0,0 +1,55 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_EMULATOR_H
+#define __OFONO_EMULATOR_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_emulator;
+
+struct ofono_emulator_driver {
+	const char *name;
+	enum ofono_atom_type type;
+	int (*probe)(struct ofono_emulator *emulator,
+			struct ofono_modem *modem);
+	void (*remove)();
+};
+
+int ofono_emulator_enable(struct ofono_emulator *emulator, int fd);
+void ofono_emulator_disable(struct ofono_emulator *emulator);
+void ofono_emulator_remove(struct ofono_emulator *emulator);
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+					struct ofono_emulator_driver *driver);
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *dri=
ver);
+void ofono_emulator_driver_unregister(
+				const struct ofono_emulator_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
-- =

1.7.4.rc3


--===============7614009425330048793==--

