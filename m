Content-Type: multipart/mixed; boundary="===============1287587268876545962=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Wed, 24 Nov 2010 17:05:17 +0200
Message-ID: <1290611117-14026-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1287587268876545962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    5 +++++
 src/voicecall.c       |    6 +++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index f0ba316..f3cad7c 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -87,6 +87,11 @@ Properties	string LineIdentification [readonly]
 			"override category" option was not provisioned for
 			the current subscriber.
 =

+		boolean Originated [readonly]
+
+			Indicates whether the call was mobile-originated
+			(true) or mobile-terminated (false).
+
 		boolean Multiparty [readonly]
 =

 			Contains the indication if the voice call is part
diff --git a/src/voicecall.c b/src/voicecall.c
index 52baec3..045b492 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -322,7 +322,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *status;
 	const char *callerid;
 	const char *timestr;
-	ofono_bool_t mpty;
+	ofono_bool_t mpty, originated;
 =

 	status =3D call_status_to_string(call->status);
 	callerid =3D phone_number_to_string(&call->phone_number);
@@ -342,6 +342,10 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 					&timestr);
 	}
 =

+	originated =3D call->direction =3D=3D CALL_DIRECTION_MOBILE_ORIGINATED;
+	ofono_dbus_dict_append(dict, "Originated", DBUS_TYPE_BOOLEAN,
+				&originated);
+
 	if (g_slist_find_custom(v->vc->multiparty_list,
 				GINT_TO_POINTER(call->id),
 				call_compare_by_id))
-- =

1.7.1


--===============1287587268876545962==--

