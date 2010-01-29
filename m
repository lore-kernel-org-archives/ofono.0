Content-Type: multipart/mixed; boundary="===============4764183052615646137=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: [PATCH 1/2] bluetooth: improve dbus logging a little bit
Date: Fri, 29 Jan 2010 12:44:25 -0200
Message-ID: <1264776266-7646-2-git-send-email-jprvita@gmail.com>
In-Reply-To: <1264776266-7646-1-git-send-email-jprvita@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4764183052615646137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jo=C3=A3o Paulo Rechi Vita <jprvita@profusion.mobi>

---
 src/modules/bluetooth/bluetooth-util.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/modules/bluetooth/bluetooth-util.c b/src/modules/bluetooth=
/bluetooth-util.c
index 47d6200..d3f3bfe 100644
--- a/src/modules/bluetooth/bluetooth-util.c
+++ b/src/modules/bluetooth/bluetooth-util.c
@@ -292,9 +292,10 @@ static int parse_audio_property(pa_bluetooth_discovery=
 *u, int *state, DBusMessa
             const char *value;
             dbus_message_iter_get_basic(&variant_i, &value);
 =

-            if (pa_streq(key, "State"))
+            if (pa_streq(key, "State")) {
                 *state =3D pa_bt_audio_state_from_string(value);
-/*             pa_log_debug("Value %s", value); */
+                pa_log_debug("dbus: property 'State' changed to value '%s'=
", value);
+            }
 =

             break;
         }
-- =

1.6.3.3


--===============4764183052615646137==--

