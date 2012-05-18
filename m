Content-Type: multipart/mixed; boundary="===============3448656124429451862=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 06/12] gdbus: use GDBusArgInfo to generate introspection
Date: Fri, 18 May 2012 16:44:06 -0300
Message-ID: <1337370252-29346-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337370252-29346-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3448656124429451862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By using GDBusArgInfo in methods and signals, the introspection
generation is much simpler and we can add each argument name.
---
 gdbus/object.c |   75 +++++++++++-----------------------------------------=
----
 1 file changed, 14 insertions(+), 61 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2ddc574..3ac6a0b 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -59,68 +59,20 @@ struct security_data {
 	void *iface_user_data;
 };
 =

-static void print_arguments(GString *gstr, const char *sig,
+static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 						const char *direction)
 {
-	int i;
-
-	for (i =3D 0; sig[i]; i++) {
-		char type[32];
-		int struct_level, dict_level;
-		unsigned int len;
-		gboolean complete;
-
-		complete =3D FALSE;
-		struct_level =3D dict_level =3D 0;
-
-		/* Gather enough data to have a single complete type */
-		for (len =3D 0; len < (sizeof(type) - 1) && sig[i]; len++, i++) {
-			switch (sig[i]) {
-			case '(':
-				struct_level++;
-				break;
-			case ')':
-				struct_level--;
-				if (struct_level <=3D 0 && dict_level <=3D 0)
-					complete =3D TRUE;
-				break;
-			case '{':
-				dict_level++;
-				break;
-			case '}':
-				dict_level--;
-				if (struct_level <=3D 0 && dict_level <=3D 0)
-					complete =3D TRUE;
-				break;
-			case 'a':
-				break;
-			default:
-				if (struct_level <=3D 0 && dict_level <=3D 0)
-					complete =3D TRUE;
-				break;
-			}
-
-			type[len] =3D sig[i];
-
-			if (complete)
-				break;
-		}
-
-		type[len + 1] =3D '\0';
-
-		if (!complete) {
-			error("Unexpected signature: %s", sig);
-			return;
-		}
+	for (; args && args->name; args++) {
+		g_string_append_printf(gstr,
+					"\t\t\t<arg name=3D\"%s\" type=3D\"%s\"",
+					args->name, args->signature);
 =

 		if (direction)
 			g_string_append_printf(gstr,
-					"\t\t\t<arg type=3D\"%s\" direction=3D\"%s\"/>\n",
-					type, direction);
+					" direction=3D\"%s\"/>\n", direction);
 		else
-			g_string_append_printf(gstr,
-					"\t\t\t<arg type=3D\"%s\"/>\n",
-					type);
+			g_string_append_printf(gstr, "/>\n");
+
 	}
 }
 =

@@ -130,26 +82,27 @@ static void generate_interface_xml(GString *gstr, stru=
ct interface_data *iface)
 	const GDBusSignalTable *signal;
 =

 	for (method =3D iface->methods; method && method->name; method++) {
-		if (!strlen(method->signature) && !strlen(method->reply))
+		if (!(method->in_args && method->in_args->name) &&
+				!(method->out_args && method->out_args->name))
 			g_string_append_printf(gstr, "\t\t<method name=3D\"%s\"/>\n",
 								method->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<method name=3D\"%s\">\n",
 								method->name);
-			print_arguments(gstr, method->signature, "in");
-			print_arguments(gstr, method->reply, "out");
+			print_arguments(gstr, method->in_args, "in");
+			print_arguments(gstr, method->out_args, "out");
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
 =

 	for (signal =3D iface->signals; signal && signal->name; signal++) {
-		if (!strlen(signal->signature))
+		if (!(signal->args && signal->args->name))
 			g_string_append_printf(gstr, "\t\t<signal name=3D\"%s\"/>\n",
 								signal->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=3D\"%s\">\n",
 								signal->name);
-			print_arguments(gstr, signal->signature, NULL);
+			print_arguments(gstr, signal->args, NULL);
 			g_string_append_printf(gstr, "\t\t</signal>\n");
 		}
 	}
-- =

1.7.10.2


--===============3448656124429451862==--

