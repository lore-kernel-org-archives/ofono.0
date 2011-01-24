Content-Type: multipart/mixed; boundary="===============0054524766363886230=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/2] Expose voice call direction synchronously (fix MeeGo
 #12717)
Date: Mon, 24 Jan 2011 13:02:02 +0200
Message-ID: <1295866923-3924-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0054524766363886230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, the call direction can only be inferred from the signals.
This adds a property to keep it visible also from GetCalls().
---
 src/voicecall.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 7e2b3f0..d454d9d 100644
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
@@ -391,6 +391,10 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 					&timestr);
 	}
 =

+	originated =3D call->direction =3D=3D CALL_DIRECTION_MOBILE_ORIGINATED;
+	ofono_dbus_dict_append(dict, "Originated", DBUS_TYPE_BOOLEAN,
+				&originated);
+
 	if (g_slist_find_custom(v->vc->multiparty_list,
 				GINT_TO_POINTER(call->id), call_compare_by_id))
 		mpty =3D TRUE;
-- =

1.7.1


--===============0054524766363886230==--

