Content-Type: multipart/mixed; boundary="===============4599680621859541536=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 12/12] gdbus: do not check signature twice
Date: Sun, 20 May 2012 02:07:36 -0300
Message-ID: <1337490456-10941-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4599680621859541536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Message signature is already checked in generic_message(), so there's no
need to check again in the callback.
---
 gdbus/object.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index dacbe58..2dd7c0e 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -174,11 +174,6 @@ static DBusMessage *introspect(DBusConnection *connect=
ion,
 	struct generic_data *data =3D user_data;
 	DBusMessage *reply;
 =

-	if (!dbus_message_has_signature(message, DBUS_TYPE_INVALID_AS_STRING)) {
-		error("Unexpected signature to introspect call");
-		return NULL;
-	}
-
 	if (data->introspect =3D=3D NULL)
 		generate_introspection_xml(connection, data,
 						dbus_message_get_path(message));
-- =

1.7.10.2


--===============4599680621859541536==--

