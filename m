Content-Type: multipart/mixed; boundary="===============7036911711384331595=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v2 3/4] voicecall: network emergency number list support
Date: Mon, 28 Mar 2011 06:58:08 -0700
Message-ID: <1301320689-25201-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301320689-25201-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7036911711384331595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 826e10c..e3b1135 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2172,6 +2172,19 @@ check:
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
+	vc->new_en_list =3D g_slist_reverse(vc->new_en_list);
+	set_new_ecc(vc);
+}
+
 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
-- =

1.7.0.4


--===============7036911711384331595==--

