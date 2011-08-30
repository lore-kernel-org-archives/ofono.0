Content-Type: multipart/mixed; boundary="===============3984611286717119810=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH] Add Direction property to voice call
Date: Tue, 30 Aug 2011 16:48:35 +0300
Message-ID: <1314712115-5068-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3984611286717119810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    6 ++++++
 src/voicecall.c       |    9 +++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 7eb41aa..6870905 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -110,6 +110,12 @@ Properties	string LineIdentification [readonly]
 			service with their network provider and would like
 			to know what line the call is coming in on.
 =

+                string Direction [readonly]
+                        Indicates whether the call is mobile-originated or
+                        mobile-terminated.
+
+                        Possible values: "mo", "mt"
+
 		string Name [readonly]
 =

 			Contains the Name Identification information returned
diff --git a/src/voicecall.c b/src/voicecall.c
index 2b4c209..833fe09 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -415,6 +415,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *callerid;
 	const char *timestr;
 	const char *name;
+        const char *direction;
 	ofono_bool_t mpty;
 	dbus_bool_t emergency_call;
 =

@@ -444,6 +445,14 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 =

 	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING, &name);
 =

+        if (call->direction =3D=3D CALL_DIRECTION_MOBILE_ORIGINATED)
+            direction =3D "mo";
+        else
+            direction =3D "mt";
+
+        ofono_dbus_dict_append(dict, "Direction", DBUS_TYPE_STRING,
+                                &direction);
+
 	if (call->status =3D=3D CALL_STATUS_ACTIVE ||
 			call->status =3D=3D CALL_STATUS_HELD ||
 			(call->status =3D=3D CALL_STATUS_DISCONNECTED &&
-- =

1.7.4.1


--===============3984611286717119810==--

