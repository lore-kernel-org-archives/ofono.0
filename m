Content-Type: multipart/mixed; boundary="===============6773423743959573400=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 10/12] gdbus: add Deprecated annotation in introspection
Date: Sun, 20 May 2012 02:07:34 -0300
Message-ID: <1337490456-10941-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6773423743959573400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/object.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index fcdd6ec..95947f3 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -82,7 +82,11 @@ static void generate_interface_xml(GString *gstr, struct=
 interface_data *iface)
 	const GDBusSignalTable *signal;
 =

 	for (method =3D iface->methods; method && method->name; method++) {
-		if (!(method->in_args && method->in_args->name) &&
+		gboolean deprecated =3D method->flags &
+						G_DBUS_METHOD_FLAG_DEPRECATED;
+
+		if (!deprecated &&
+				!(method->in_args && method->in_args->name) &&
 				!(method->out_args && method->out_args->name))
 			g_string_append_printf(gstr, "\t\t<method name=3D\"%s\"/>\n",
 								method->name);
@@ -91,18 +95,29 @@ static void generate_interface_xml(GString *gstr, struc=
t interface_data *iface)
 								method->name);
 			print_arguments(gstr, method->in_args, "in");
 			print_arguments(gstr, method->out_args, "out");
+
+			if (deprecated)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=3D\"org.freedeskt=
op.DBus.Deprecated\" value=3D\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
 =

 	for (signal =3D iface->signals; signal && signal->name; signal++) {
-		if (!(signal->args && signal->args->name))
+		gboolean deprecated =3D signal->flags &
+						G_DBUS_SIGNAL_FLAG_DEPRECATED;
+
+		if (!deprecated && !(signal->args && signal->args->name))
 			g_string_append_printf(gstr, "\t\t<signal name=3D\"%s\"/>\n",
 								signal->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=3D\"%s\">\n",
 								signal->name);
 			print_arguments(gstr, signal->args, NULL);
+
+			if (deprecated)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=3D\"org.freedeskt=
op.DBus.Deprecated\" value=3D\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
-- =

1.7.10.2


--===============6773423743959573400==--

