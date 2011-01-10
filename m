Content-Type: multipart/mixed; boundary="===============5935228109963664134=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 3/5] voicecall: Add ofono_voicecall_tty_notify api
Date: Mon, 10 Jan 2011 16:01:30 +0200
Message-ID: <1294668092-27896-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294668092-27896-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5935228109963664134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h |    2 ++
 src/voicecall.c     |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index e37d73b..6f1bdd2 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -144,6 +144,8 @@ void ofono_voicecall_notify(struct ofono_voicecall *vc,
 void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
 				enum ofono_disconnect_reason reason,
 				const struct ofono_error *error);
+void ofono_voicecall_tty_notify(struct ofono_voicecall *vc,
+				const struct ofono_call *call);
 =

 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d=
);
 void ofono_voicecall_driver_unregister(const struct ofono_voicecall_driver=
 *d);
diff --git a/src/voicecall.c b/src/voicecall.c
index da42fac..b55c727 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1990,6 +1990,18 @@ error:
 		g_free(v);
 }
 =

+void ofono_voicecall_tty_notify(struct ofono_voicecall *vc,
+				const struct ofono_call *call)
+{
+	GSList *l;
+
+	l =3D g_slist_find_custom(vc->call_list, GUINT_TO_POINTER(call->id),
+				call_compare_by_id);
+
+	if (l)
+		voicecall_set_call_tty(l->data, TRUE);
+}
+
 static void generic_callback(const struct ofono_error *error, void *data)
 {
 	struct ofono_voicecall *vc =3D data;
-- =

1.7.0.4


--===============5935228109963664134==--

