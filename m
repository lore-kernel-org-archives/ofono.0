Content-Type: multipart/mixed; boundary="===============4241416309089568312=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 2/2] voicecall: try harder to avoid Dial mismatches
Date: Wed, 02 Feb 2011 00:22:10 +0200
Message-ID: <1296598930-3093-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1296598930-3093-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4241416309089568312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

There were some cases where Dial returned an incorrect call object,
e.g., after oFono crash and recover.
---
 src/voicecall.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 6246787..418e928 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1160,6 +1160,17 @@ static ofono_bool_t clir_string_to_clir(const char *=
clirstr,
 	}
 }
 =

+static void prepare_to_dial(struct ofono_voicecall *vc)
+{
+	GSList *l;
+	struct voicecall *v;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		v =3D l->data;
+		v->dial_result_handled =3D TRUE;
+	}
+}
+
 static struct ofono_call *synthesize_outgoing_call(struct ofono_voicecall =
*vc,
 							const char *number)
 {
@@ -1325,6 +1336,8 @@ static DBusMessage *manager_dial(DBusConnection *conn,
 =

 	vc->pending =3D dbus_message_ref(msg);
 =

+	prepare_to_dial(vc);
+
 	string_to_phone_number(number, &ph);
 =

 	vc->driver->dial(vc, &ph, clir, manager_dial_callback, vc);
@@ -2461,6 +2474,8 @@ static void dial_request_cb(const struct ofono_error =
*error, void *data)
 =

 static void dial_request(struct ofono_voicecall *vc)
 {
+	prepare_to_dial(vc);
+
 	vc->driver->dial(vc, &vc->dial_req->ph, OFONO_CLIR_OPTION_DEFAULT,
 				dial_request_cb, vc);
 }
-- =

1.7.1


--===============4241416309089568312==--

