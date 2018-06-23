Content-Type: multipart/mixed; boundary="===============3585288399853786040=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] voicecall: Handle voicecall_dbus_register() return value
Date: Sat, 23 Jun 2018 19:08:41 +0300
Message-ID: <1529770121-13691-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3585288399853786040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FALSE means that struct voicecall passed in as a parameter
has been deallocated.
---
 src/voicecall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index e4f6a4c..194b75f 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1391,7 +1391,9 @@ static struct voicecall *synthesize_outgoing_call(str=
uct ofono_voicecall *vc,
 	v->detect_time =3D time(NULL);
 =

 	DBG("Registering new call: %d", call->id);
-	voicecall_dbus_register(v);
+
+	if (!voicecall_dbus_register(v))
+		return NULL;
 =

 	vc->call_list =3D g_slist_insert_sorted(vc->call_list, v, call_compare);
 =

-- =

1.9.1


--===============3585288399853786040==--

