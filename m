Content-Type: multipart/mixed; boundary="===============4523055237564476534=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Fix sending User Cancel response to Set Up Call.
Date: Wed, 08 Sep 2010 19:59:56 +0200
Message-ID: <1283968796-5308-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1283968796-5308-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4523055237564476534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One of the clean-up commits changed the semantics of the dial request
callback's parameter (NULL if call setup failed, non-NULL if success
or user cancelled).
---
 src/stk.c       |    2 +-
 src/voicecall.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index b469467..b6ed4c3 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1419,7 +1419,7 @@ static void call_setup_connected(struct ofono_call *c=
all, void *data)
 	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
 	static unsigned char facility_rejected_result[] =3D { 0x9d };
 =

-	if (!call) {
+	if (!call || call->status =3D=3D CALL_STATUS_DISCONNECTED) {
 		memset(&rsp, 0, sizeof(rsp));
 =

 		rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
diff --git a/src/voicecall.c b/src/voicecall.c
index 3bd4dff..e536089 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -361,6 +361,16 @@ static DBusMessage *voicecall_deflect(DBusConnection *=
conn,
 	return NULL;
 }
 =

+static void dial_request_user_cancel(struct ofono_voicecall *vc,
+					struct voicecall *call)
+{
+	if (!vc->dial_req)
+		return;
+
+	if (!call || call =3D=3D vc->dial_req->call)
+		dial_request_finish(vc->dial_req->call->vc, TRUE);
+}
+
 static DBusMessage *voicecall_hangup(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -372,6 +382,8 @@ static DBusMessage *voicecall_hangup(DBusConnection *co=
nn,
 	if (vc->pending)
 		return __ofono_error_busy(msg);
 =

+	dial_request_user_cancel(vc, v);
+
 	switch (call->status) {
 	case CALL_STATUS_DISCONNECTED:
 		return __ofono_error_failed(msg);
@@ -1278,6 +1290,8 @@ static DBusMessage *manager_hangup_all(DBusConnection=
 *conn,
 		return reply;
 	}
 =

+	dial_request_user_cancel(vc, NULL);
+
 	vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
 =

 	vc->pending =3D dbus_message_ref(msg);
-- =

1.7.1.86.g0e460.dirty


--===============4523055237564476534==--

