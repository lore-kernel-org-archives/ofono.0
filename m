Content-Type: multipart/mixed; boundary="===============7771062773240343482=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/9] cbs: Watch for changes to relevant SIM files.
Date: Tue, 15 Feb 2011 08:58:56 +0100
Message-ID: <1297756739-2958-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7771062773240343482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cbs.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/src/cbs.c b/src/cbs.c
index cf8fc10..c58ff89 100644
--- a/src/cbs.c
+++ b/src/cbs.c
@@ -68,6 +68,7 @@ struct ofono_cbs {
 	GSList *efcbmir_contents;
 	unsigned short efcbmid_length;
 	GSList *efcbmid_contents;
+	gboolean efcbmid_update;
 	guint reset_source;
 	int lac;
 	int ci;
@@ -852,6 +853,7 @@ static void sim_cbmid_read_cb(int ok, int length, int r=
ecord,
 	int i;
 	char *str;
 	GSList *contents =3D NULL;
+	char *topic_str;
 =

 	if (!ok)
 		goto done;
@@ -886,7 +888,33 @@ static void sim_cbmid_read_cb(int ok, int length, int =
record,
 	g_free(str);
 =

 done:
-	cbs_got_file_contents(cbs);
+	if (cbs->efcbmid_update) {
+		topic_str =3D cbs_topics_to_str(cbs, cbs->topics);
+		cbs->driver->set_topics(cbs, topic_str,
+					cbs_set_powered_cb, cbs);
+		g_free(topic_str);
+
+		cbs->efcbmid_update =3D FALSE;
+	} else
+		cbs_got_file_contents(cbs);
+}
+
+static void cbs_efcbmid_changed(int id, void *userdata)
+{
+	struct ofono_cbs *cbs =3D userdata;
+
+	if (cbs->efcbmid_length) {
+		cbs->efcbmid_length =3D 0;
+		g_slist_foreach(cbs->efcbmid_contents, (GFunc) g_free, NULL);
+		g_slist_free(cbs->efcbmid_contents);
+		cbs->efcbmid_contents =3D NULL;
+	}
+
+	cbs->efcbmid_update =3D TRUE;
+
+	ofono_sim_read(cbs->sim_context, SIM_EFCBMID_FILEID,
+			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+			sim_cbmid_read_cb, cbs);
 }
 =

 static void cbs_got_imsi(struct ofono_cbs *cbs)
@@ -929,6 +957,8 @@ static void cbs_got_imsi(struct ofono_cbs *cbs)
 	ofono_sim_read(cbs->sim_context, SIM_EFCBMID_FILEID,
 			OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
 			sim_cbmid_read_cb, cbs);
+	ofono_sim_add_file_watch(cbs->sim_context, SIM_EFCBMID_FILEID,
+					cbs_efcbmid_changed, cbs, NULL);
 }
 =

 static gboolean reset_base_station_name(gpointer user)
-- =

1.7.1.86.g0e460.dirty


--===============7771062773240343482==--

