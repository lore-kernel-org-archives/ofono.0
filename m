Content-Type: multipart/mixed; boundary="===============8938580148853600296=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/6] error-mapping: Add function to map telephony errors into
 ofono error types
Date: Tue, 29 May 2012 18:38:34 +0200
Message-ID: <1338309517-14808-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8938580148853600296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/error-mapping.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/error-mapping.h |   25 +++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 src/error-mapping.c
 create mode 100644 src/error-mapping.h

diff --git a/src/error-mapping.c b/src/error-mapping.c
new file mode 100644
index 0000000..2012881
--- /dev/null
+++ b/src/error-mapping.c
@@ -0,0 +1,77 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/types.h>
+#include <gdbus.h>
+#include "ofono.h"
+#include "error-mapping.h"
+
+struct error_mapping_entry {
+	int error;
+	DBusMessage *(*ofono_error_func)(DBusMessage *);
+};
+
+struct error_mapping_entry cme_errors_mapping[] =3D {
+	{ 3,	__ofono_error_not_allowed },
+	{ 4,	__ofono_error_not_supported },
+	{ 16,	__ofono_error_incorrect_password },
+	{ 30,	__ofono_error_not_registered },
+	{ 31,	__ofono_error_timed_out },
+	{ 32,	__ofono_error_access_denied },
+	{ 50,	__ofono_error_invalid_args },
+};
+
+DBusMessage *telephony_error_to_ofono_err(const struct ofono_error *error,
+						DBusMessage *msg)
+{
+	struct error_mapping_entry *e;
+	int maxentries;
+	int i;
+
+	switch (error->type) {
+	case OFONO_ERROR_TYPE_CME:
+		e =3D cme_errors_mapping;
+		maxentries =3D sizeof(cme_errors_mapping) /
+					sizeof(struct error_mapping_entry);
+		for (i =3D 0; i < maxentries; i++)
+			if (e[i].error =3D=3D error->error)
+				return e[i].ofono_error_func(msg);
+		break;
+	case OFONO_ERROR_TYPE_CMS:
+		return __ofono_error_failed(msg);
+	case OFONO_ERROR_TYPE_CEER:
+		return __ofono_error_failed(msg);
+	default:
+		return __ofono_error_failed(msg);
+	}
+
+	return __ofono_error_failed(msg);
+}
diff --git a/src/error-mapping.h b/src/error-mapping.h
new file mode 100644
index 0000000..9909f9b
--- /dev/null
+++ b/src/error-mapping.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
+#include <gdbus.h>
+
+DBusMessage *telephony_error_to_ofono_err(const struct ofono_error *error,
+						DBusMessage *msg);
\ No newline at end of file
-- =

1.7.9.5


--===============8938580148853600296==--

