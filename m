Content-Type: multipart/mixed; boundary="===============5746161807779948011=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH v4 3/4] voicecall: network emergency number list support
Date: Wed, 06 Apr 2011 07:26:42 -0700
Message-ID: <1302100003-5488-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1302100003-5488-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5746161807779948011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index b0f15fd..19ef479 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -49,6 +49,7 @@ struct ofono_voicecall {
 	GHashTable *en_list; /* emergency number list */
 	GSList *sim_en_list; /* Emergency numbers being read from SIM */
 	ofono_bool_t sim_en_list_ready;
+	char **nw_en_list; /* Emergency numbers from modem/network */
 	DBusMessage *pending;
 	struct ofono_sim *sim;
 	struct ofono_sim_context *sim_context;
@@ -2093,6 +2094,10 @@ static void set_new_ecc(struct ofono_voicecall *vc)
 	vc->en_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, NULL);
 =

+	/* Emergency numbers from modem/network */
+	if (vc->nw_en_list)
+		add_to_en_list(vc, vc->nw_en_list);
+
 	/* Emergency numbers read from SIM */
 	if (vc->sim_en_list_ready =3D=3D TRUE && vc->sim_en_list) {
 		for (l =3D vc->sim_en_list; l; l =3D l->next)
@@ -2175,6 +2180,15 @@ check:
 	set_new_ecc(vc);
 }
 =

+void ofono_voicecall_en_list_notify(struct ofono_voicecall *vc,
+						char **nw_en_list)
+{
+	g_strfreev(vc->nw_en_list);
+
+	vc->nw_en_list =3D g_strdupv(nw_en_list);
+	set_new_ecc(vc);
+}
+
 int ofono_voicecall_driver_register(const struct ofono_voicecall_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -2220,6 +2234,11 @@ static void voicecall_unregister(struct ofono_atom *=
atom)
 		vc->sim_en_list =3D NULL;
 	}
 =

+	if (vc->nw_en_list) {
+		g_strfreev(vc->nw_en_list);
+		vc->nw_en_list =3D NULL;
+	}
+
 	g_hash_table_destroy(vc->en_list);
 	vc->en_list =3D NULL;
 =

-- =

1.7.0.4


--===============5746161807779948011==--

