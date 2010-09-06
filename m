Content-Type: multipart/mixed; boundary="===============5891321560805564424=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [originated PATCH 2/2] voicecall: add "Originated" property
Date: Mon, 06 Sep 2010 18:09:28 +0300
Message-ID: <1283785768-4509-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1283785768-4509-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5891321560805564424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/voicecall.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 2833fc6..d61ddd1 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -234,6 +234,7 @@ static void append_voicecall_properties(struct voicecal=
l *v,
 	const char *callerid;
 	const char *timestr;
 	ofono_bool_t mpty;
+	ofono_bool_t mo;
 =

 	status =3D call_status_to_string(call->status);
 	callerid =3D phone_number_to_string(&call->phone_number);
@@ -262,6 +263,13 @@ static void append_voicecall_properties(struct voiceca=
ll *v,
 =

 	ofono_dbus_dict_append(dict, "Multiparty", DBUS_TYPE_BOOLEAN, &mpty);
 =

+	if (call->direction)
+		mo =3D FALSE;
+	else
+		mo =3D TRUE;
+
+	ofono_dbus_dict_append(dict, "Originated", DBUS_TYPE_BOOLEAN, &mo);
+
 	if (v->message)
 		ofono_dbus_dict_append(dict, "Information", DBUS_TYPE_STRING,
 					&v->message);
-- =

1.7.0.4


--===============5891321560805564424==--

