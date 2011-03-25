Content-Type: multipart/mixed; boundary="===============5773542970374300926=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] voicecall: add ofono_voicecall_en_list_notify api
Date: Fri, 25 Mar 2011 07:08:02 -0700
Message-ID: <1301062083-20416-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301062083-20416-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5773542970374300926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/voicecall.h |    3 +++
 src/voicecall.c     |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/voicecall.h b/include/voicecall.h
index f00eb08..3710646 100644
--- a/include/voicecall.h
+++ b/include/voicecall.h
@@ -140,6 +140,9 @@ struct ofono_voicecall_driver {
 			ofono_voicecall_cb_t cb, void *data);
 };
 =

+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+					GSList *nw_en_list);
+
 void ofono_voicecall_notify(struct ofono_voicecall *vc,
 				const struct ofono_call *call);
 void ofono_voicecall_disconnected(struct ofono_voicecall *vc, int id,
diff --git a/src/voicecall.c b/src/voicecall.c
index d6e8539..74fe910 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2150,6 +2150,18 @@ check:
 	set_new_ecc(vc);
 }
 =

+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+					GSList *new_en_list)
+{
+	GSList *l;
+
+	for (l =3D new_en_list; l; l =3D l->next)
+		vc->new_en_list =3D g_slist_prepend(vc->new_en_list,
+							g_strdup(l->data));
+
+	set_new_ecc(vc);
+}
+
 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.0.4


--===============5773542970374300926==--

