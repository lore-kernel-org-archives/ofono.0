Content-Type: multipart/mixed; boundary="===============8917356207422963001=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 4/7] voicecall: Fix issue with invalid dbus path
Date: Wed, 06 Dec 2017 17:36:01 +0200
Message-ID: <20171206153604.15080-5-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8917356207422963001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix an error message from dbus about the path supplied not being valid.
Related to commit f58e7685b0078df470300b99cd89fb9b3c45d1c0

ofonod[19107]: src/voicecall.c:voicecall_dial_shortcut() check position
ofonod[19107]: src/voicecall.c:synthesize_outgoing_call() Registering new c=
all: 1
process 19107: arguments to dbus_message_iter_append_basic() were incorrect=
, assertion "_dbus_check_is_valid_path (*string_p)" failed in file ../../..=
/dbus/dbus-message.c line 2759.
This is normally a bug in some application using the D-Bus library.

---
 src/voicecall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/voicecall.c b/src/voicecall.c
index 67384cf2..ed6ea83f 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -28,6 +28,7 @@
 #include <time.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdlib.h>
 =

 #include <glib.h>
 #include <gdbus.h>
@@ -1592,6 +1593,7 @@ static void manager_dial_shortcut_callback(const stru=
ct ofono_error *error,
 	if (!v)
 		goto error;
 =

+	path =3D voicecall_build_path(vc, v->call);
 	reply =3D dbus_message_new_method_return(vc->pending);
 	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID);
-- =

2.11.0


--===============8917356207422963001==--

