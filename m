Content-Type: multipart/mixed; boundary="===============6514778223979003586=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 3/3] dbus: Add D-Bus mapping for OFONO_ERROR_TYPE_ERRNO
Date: Thu, 28 Jun 2018 19:31:00 +0300
Message-ID: <1530203460-20552-3-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1530203460-20552-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6514778223979003586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index cadf5c6..a175178 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <glib.h>
+#include <errno.h>
 #include <gdbus.h>
 =

 #include "ofono.h"
@@ -45,6 +46,16 @@ static const struct error_mapping_entry cme_errors_mappi=
ng[] =3D {
 	{ 31,	__ofono_error_timed_out },
 	{ 32,	__ofono_error_access_denied },
 	{ 50,	__ofono_error_invalid_args },
+	{ }
+};
+
+static const struct error_mapping_entry errno_errors_mapping[] =3D {
+	{ EACCES,      __ofono_error_access_denied },
+	{ EOPNOTSUPP,  __ofono_error_not_supported },
+	{ ENOSYS,      __ofono_error_not_implemented },
+	{ ETIMEDOUT,   __ofono_error_timed_out },
+	{ EINPROGRESS, __ofono_error_busy },
+	{ }
 };
 =

 static void append_variant(DBusMessageIter *iter,
@@ -419,26 +430,31 @@ DBusMessage *__ofono_error_network_terminated(DBusMes=
sage *msg)
 					" network");
 }
 =

-DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
-						DBusMessage *msg)
+static DBusMessage *__ofono_map_error(const struct error_mapping_entry *ma=
p,
+						int error, DBusMessage *msg)
 {
 	const struct error_mapping_entry *e;
-	int maxentries;
-	int i;
 =

+	for (e =3D map; e->ofono_error_func; e++)
+		if (e->error =3D=3D error)
+			return e->ofono_error_func(msg);
+
+	return __ofono_error_failed(msg);
+}
+
+DBusMessage *__ofono_error_from_error(const struct ofono_error *error,
+						DBusMessage *msg)
+{
 	switch (error->type) {
 	case OFONO_ERROR_TYPE_CME:
-		e =3D cme_errors_mapping;
-		maxentries =3D sizeof(cme_errors_mapping) /
-					sizeof(struct error_mapping_entry);
-		for (i =3D 0; i < maxentries; i++)
-			if (e[i].error =3D=3D error->error)
-				return e[i].ofono_error_func(msg);
-		break;
+		return __ofono_map_error(cme_errors_mapping, error->error, msg);
 	case OFONO_ERROR_TYPE_CMS:
 		return __ofono_error_failed(msg);
 	case OFONO_ERROR_TYPE_CEER:
 		return __ofono_error_failed(msg);
+	case OFONO_ERROR_TYPE_ERRNO:
+		return __ofono_map_error(errno_errors_mapping,
+						ABS(error->error), msg);
 	default:
 		return __ofono_error_failed(msg);
 	}
-- =

1.9.1


--===============6514778223979003586==--

