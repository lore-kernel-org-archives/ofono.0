Content-Type: multipart/mixed; boundary="===============3287914766038629337=="
MIME-Version: 1.0
From: Daniele Palmas <Daniele.Palmas@telit.com>
Subject: [PATCH]enable-modem.c
Date: Tue, 25 May 2010 16:12:14 +0200
Message-ID: <24A9345B397CD24AA76A4E82E237956531ECF3AD4F@XCHTS.tmt.telital.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3287914766038629337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

here is the first simple example in c for enabling modem. This is my first =
time using glib, dbus and git so I hope not to have done too many mistakes.=
.. If you find it useful I can continue submitting the others I have,

Regards,
Daniele

test/enable-modem.c |  116 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++
1 files changed, 116 insertions(+), 0 deletions(-)

diff --git a/test/enable-modem.c b/test/enable-modem.c
new file mode 100644
index 0000000..610b933
--- /dev/null
+++ b/test/enable-modem.c
@@ -0,0 +1,116 @@
+/*
+ * enable-modem.c
+ *
+ *  Created on: 25/mag/2010
+ *  Author: Daniele Palmas <daniele.palmas@telit.com>
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
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include "dbus/dbus-glib.h"
+
+#define OFONO_BUS_NAME 				"org.ofono"
+#define OFONO_MANAGER_INTERFACE		"org.ofono.Manager"
+#define OFONO_MODEM_INTERFACE		"org.ofono.Modem"
+
+#define MODEM_NAME_SIZE 32
+
+int main (int argc, char **argv)
+{
+	DBusGConnection *connection;
+	GError *error;
+	DBusGProxy *proxy;
+	int exitValue;
+
+	char modemName[MODEM_NAME_SIZE];
+	GHashTable *dict;
+	GValue varEnable =3D {0, };
+
+	g_type_init ();
+
+	connection =3D dbus_g_bus_get (DBUS_BUS_SESSION, &error);
+
+	if (connection =3D=3D NULL)
+	{
+		g_printerr("Failed to open connection to bus: %s\n", error->message);
+		g_error_free (error);
+		exit (EXIT_FAILURE);
+	}
+
+	proxy =3D dbus_g_proxy_new_for_name (connection,
+			OFONO_BUS_NAME,
+			"/",
+			OFONO_MANAGER_INTERFACE);
+
+	if (!dbus_g_proxy_call (proxy, "GetProperties", &error, G_TYPE_INVALID, d=
bus_g_type_get_map("GHashTable", G_TYPE_STRING, G_TYPE_VALUE), &dict, G_TYP=
E_INVALID))
+	{
+		if (error->domain =3D=3D DBUS_GERROR && error->code =3D=3D DBUS_GERROR_R=
EMOTE_EXCEPTION)
+			g_printerr ("Caught remote method exception %s: %s",
+					dbus_g_error_get_name (error),
+					error->message);
+		else
+			g_printerr ("Error: %s\n", error->message);
+
+		g_error_free (error);
+
+		exitValue =3D EXIT_FAILURE;
+		goto End;
+	} else {
+		GValue *value;
+		GPtrArray* modemArr;
+
+		value =3D (GValue *) g_hash_table_lookup(dict, "Modems");
+		modemArr =3D g_value_peek_pointer(value);
+
+		// I suppose that the desired device is the first in the list and name l=
ength is < MODEM_NAME_SIZE
+		strcpy(modemName, g_ptr_array_index(modemArr, 0));
+
+		g_ptr_array_free(modemArr, FALSE);
+		g_hash_table_destroy(dict);
+	}
+
+	g_object_unref (proxy);
+
+	proxy =3D dbus_g_proxy_new_for_name (connection,
+			OFONO_BUS_NAME,
+			modemName,
+			OFONO_MODEM_INTERFACE);
+
+	g_value_init (&varEnable, G_TYPE_BOOLEAN);
+	g_value_set_boolean (&varEnable, TRUE);
+
+	if (!dbus_g_proxy_call (proxy, "SetProperty", &error, G_TYPE_STRING, "Pow=
ered", G_TYPE_VALUE, &varEnable, G_TYPE_INVALID, G_TYPE_INVALID))
+	{
+		if (error->domain =3D=3D DBUS_GERROR && error->code =3D=3D DBUS_GERROR_R=
EMOTE_EXCEPTION)
+			g_printerr ("Caught remote method exception %s: %s",
+					dbus_g_error_get_name (error),
+					error->message);
+		else
+			g_printerr ("Error: %s\n", error->message);
+
+		g_error_free (error);
+
+		exitValue =3D EXIT_FAILURE;
+		goto End;
+	}
+
+	exitValue =3D EXIT_SUCCESS;
+
+End:
+	g_object_unref (proxy);
+	exit(exitValue);
+}
+



--===============3287914766038629337==--

