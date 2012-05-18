Content-Type: multipart/mixed; boundary="===============2543564702438181367=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 11/12] gdbus: add Method.NoReply annotation in
 introspection
Date: Fri, 18 May 2012 16:59:58 -0300
Message-ID: <1337371199-29496-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337371199-29496-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2543564702438181367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/object.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 95947f3..dacbe58 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -84,8 +84,10 @@ static void generate_interface_xml(GString *gstr, struct=
 interface_data *iface)
 	for (method =3D iface->methods; method && method->name; method++) {
 		gboolean deprecated =3D method->flags &
 						G_DBUS_METHOD_FLAG_DEPRECATED;
+		gboolean noreply =3D method->flags &
+						G_DBUS_METHOD_FLAG_NOREPLY;
 =

-		if (!deprecated &&
+		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
 				!(method->out_args && method->out_args->name))
 			g_string_append_printf(gstr, "\t\t<method name=3D\"%s\"/>\n",
@@ -99,6 +101,9 @@ static void generate_interface_xml(GString *gstr, struct=
 interface_data *iface)
 			if (deprecated)
 				g_string_append_printf(gstr, "\t\t\t<annotation name=3D\"org.freedeskt=
op.DBus.Deprecated\" value=3D\"true\"/>\n");
 =

+			if (noreply)
+				g_string_append_printf(gstr, "\t\t\t<annotation name=3D\"org.freedeskt=
op.DBus.Method.NoReply\" value=3D\"true\"/>\n");
+
 			g_string_append_printf(gstr, "\t\t</method>\n");
 		}
 	}
-- =

1.7.10.2


--===============2543564702438181367==--

