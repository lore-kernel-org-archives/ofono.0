Content-Type: multipart/mixed; boundary="===============0582185380993242549=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/1] Add voice call boolean property for MO/MT distinction
Date: Tue, 04 Jan 2011 18:17:31 +0200
Message-ID: <1294157851-23271-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0582185380993242549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecall-api.txt |    5 +++++
 src/voicecall.c       |    6 +++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 4f38e6a..682b46b 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -92,6 +92,11 @@ Properties	string LineIdentification [readonly]
 			Contains the Name Identification information returned
 			by the network, if present.
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
index 97fc36b..2baf2d6 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -352,7 +352,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *callerid;
 	const char *timestr;
 	const char *name;
-	ofono_bool_t mpty;
+	ofono_bool_t mpty, originated;
 	dbus_bool_t emergency_call;
 =

 	status =3D call_status_to_string(call->status);
@@ -382,6 +382,10 @@ static void append_voicecall_properties(struct voiceca=
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


--===============0582185380993242549==--

