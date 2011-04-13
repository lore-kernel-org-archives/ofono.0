Content-Type: multipart/mixed; boundary="===============0819296665770777402=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v3 2/6] voicecall: add API to find call by status
Date: Wed, 13 Apr 2011 18:05:30 +0200
Message-ID: <1302710734-6103-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302710734-6103-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0819296665770777402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h     |    3 +++
 src/voicecall.c |   16 ++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 156bc40..82d7e34 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -270,6 +270,9 @@ int __ofono_voicecall_tone_send(struct ofono_voicecall =
*vc,
 				ofono_voicecall_tone_cb_t cb, void *user_data);
 void __ofono_voicecall_tone_cancel(struct ofono_voicecall *vc, int id);
 =

+struct ofono_call *__ofono_voicecall_find_call_with_status(
+				struct ofono_voicecall *vc, int status);
+
 #include <ofono/sms.h>
 =

 struct sms;
diff --git a/src/voicecall.c b/src/voicecall.c
index 9878050..f2e03e5 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1098,6 +1098,22 @@ static gboolean voicecalls_have_incoming(struct ofon=
o_voicecall *vc)
 	return voicecalls_have_with_status(vc, CALL_STATUS_INCOMING);
 }
 =

+struct ofono_call *__ofono_voicecall_find_call_with_status(
+				struct ofono_voicecall *vc, int status)
+{
+	GSList *l;
+	struct voicecall *v;
+
+	for (l =3D vc->call_list; l; l =3D l->next) {
+		v =3D l->data;
+
+		if (v->call->status =3D=3D status)
+			return v->call;
+	}
+
+	return NULL;
+}
+
 static void voicecalls_multiparty_changed(GSList *old, GSList *new)
 {
 	GSList *o, *n;
-- =

1.7.1


--===============0819296665770777402==--

