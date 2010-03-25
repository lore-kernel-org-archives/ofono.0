Content-Type: multipart/mixed; boundary="===============7085385408718105069=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/4] separate memory cleanup from PPP shutdown
Date: Wed, 24 Mar 2010 21:41:54 -0700
Message-ID: <1269492115-15412-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269492115-15412-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7085385408718105069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

don't free memory at PPP shutdown, because we need to be able to
send terminate traffic.  Free memory when we have reached the
PPP_DEAD phase instead.
---
 gatchat/gatppp.c |   25 +++++++------------------
 gatchat/ppp.c    |   23 ++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index 68c4dd1..8f19636 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -66,22 +66,8 @@ void g_at_ppp_set_disconnect_function(GAtPPP *ppp,
 =

 void g_at_ppp_shutdown(GAtPPP *ppp)
 {
-	/* close the ppp */
+	/* close the ppp link */
 	ppp_close(ppp);
-
-	/* clean up all the queues */
-	g_queue_free(ppp->event_queue);
-	g_queue_free(ppp->recv_queue);
-
-	/* cleanup modem channel */
-	g_source_remove(ppp->modem_watch);
-	g_io_channel_unref(ppp->modem);
-
-	/* remove lcp */
-	lcp_free(ppp->lcp);
-
-	/* remove auth */
-	auth_free(ppp->auth);
 }
 =

 void g_at_ppp_ref(GAtPPP *ppp)
@@ -91,10 +77,13 @@ void g_at_ppp_ref(GAtPPP *ppp)
 =

 void g_at_ppp_unref(GAtPPP *ppp)
 {
-	if (g_atomic_int_dec_and_test(&ppp->ref_count)) {
+	if (g_atomic_int_dec_and_test(&ppp->ref_count))
 		g_at_ppp_shutdown(ppp);
-		g_free(ppp);
-	}
+
+	/*
+	 * we can't free the link yet, because we need to terminate
+	 * the link first.
+	 */
 }
 =

 GAtPPP *g_at_ppp_new(GIOChannel *modem)
diff --git a/gatchat/ppp.c b/gatchat/ppp.c
index f3bfba7..d771c3f 100644
--- a/gatchat/ppp.c
+++ b/gatchat/ppp.c
@@ -372,7 +372,28 @@ static void ppp_authenticate(GAtPPP *ppp)
 =

 static void ppp_dead(GAtPPP *ppp)
 {
-	/* re-initialize everything */
+	/* notify interested parties */
+	if (ppp->disconnect_cb)
+		ppp->disconnect_cb(ppp, ppp->disconnect_data);
+
+	if (g_atomic_int_get(&ppp->ref_count))
+		return;
+
+	/* clean up all the queues */
+	g_queue_free(ppp->event_queue);
+	g_queue_free(ppp->recv_queue);
+
+	/* cleanup modem channel */
+	g_source_remove(ppp->modem_watch);
+	g_io_channel_unref(ppp->modem);
+
+	/* remove lcp */
+	lcp_free(ppp->lcp);
+
+	/* remove auth */
+	auth_free(ppp->auth);
+
+	g_free(ppp);
 }
 =

 static void ppp_network(GAtPPP *ppp)
-- =

1.6.6.1


--===============7085385408718105069==--

