Content-Type: multipart/mixed; boundary="===============3735143805760676078=="
MIME-Version: 1.0
From: Andrew Earl <andrewx.earl@intel.com>
Subject: [PATCH] handsfree: correct crash on connect of hfp
Date: Tue, 22 Apr 2014 16:22:40 +0100
Message-ID: <1398180160-14584-2-git-send-email-andrewx.earl@intel.com>
In-Reply-To: <1398180160-14584-1-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3735143805760676078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/handsfree.c b/src/handsfree.c
index d713731..3fc8d50 100644
--- a/src/handsfree.c
+++ b/src/handsfree.c
@@ -189,6 +189,7 @@ static void append_subscriber_numbers(GSList *subscribe=
r_numbers,
 	GSList *l;
 	const char *subscriber_number_string;
 	char arraysig[3];
+	const char *key =3D "SubscriberNumbers";
 =

 	arraysig[0] =3D DBUS_TYPE_ARRAY;
 	arraysig[1] =3D DBUS_TYPE_STRING;
@@ -197,7 +198,7 @@ static void append_subscriber_numbers(GSList *subscribe=
r_numbers,
 	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
 					NULL, &entry);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-					"SubscriberNumbers");
+					&key);
 	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
 					arraysig, &variant);
 	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
-- =

1.7.11.7


--===============3735143805760676078==--

