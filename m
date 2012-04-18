Content-Type: multipart/mixed; boundary="===============0935084021526900006=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 1/3] atutil: Add destroyer in at_util_sim_state_query_new
 prototype
Date: Wed, 18 Apr 2012 14:16:08 +0200
Message-ID: <1334751370-5134-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1334751370-5134-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0935084021526900006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c |    8 +++++++-
 drivers/atmodem/atutil.h |    3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 0c6aab4..7c46dc5 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -45,6 +45,7 @@ struct at_util_sim_state_query {
 	guint num_times;
 	at_util_sim_inserted_cb_t cb;
 	void *userdata;
+	GDestroyNotify data_destroy;
 };
 =

 static gboolean cpin_check(gpointer userdata);
@@ -574,7 +575,8 @@ static gboolean cpin_check(gpointer userdata)
 struct at_util_sim_state_query *at_util_sim_state_query_new(GAtChat *chat,
 						guint interval, guint num_times,
 						at_util_sim_inserted_cb_t cb,
-						void *userdata)
+						void *userdata,
+						GDestroyNotify data_destroy)
 {
 	struct at_util_sim_state_query *req;
 =

@@ -585,6 +587,7 @@ struct at_util_sim_state_query *at_util_sim_state_query=
_new(GAtChat *chat,
 	req->num_times =3D num_times;
 	req->cb =3D cb;
 	req->userdata =3D userdata;
+	req->data_destroy =3D data_destroy;
 =

 	cpin_check(req);
 =

@@ -599,5 +602,8 @@ void at_util_sim_state_query_free(struct at_util_sim_st=
ate_query *req)
 	if (req->cpin_poll_source > 0)
 		g_source_remove(req->cpin_poll_source);
 =

+	if (req->data_destroy)
+		req->data_destroy(req->userdata);
+
 	g_free(req);
 }
diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index 5046547..5ab9901 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -79,7 +79,8 @@ gboolean at_util_parse_attr(GAtResult *result, const char=
 *prefix,
 struct at_util_sim_state_query *at_util_sim_state_query_new(GAtChat *chat,
 						guint interval, guint num_times,
 						at_util_sim_inserted_cb_t cb,
-						void *userdata);
+						void *userdata,
+						GDestroyNotify data_destroy);
 void at_util_sim_state_query_free(struct at_util_sim_state_query *req);
 =

 struct cb_data {
-- =

1.7.5.4


--===============0935084021526900006==--

