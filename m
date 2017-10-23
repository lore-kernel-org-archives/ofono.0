Content-Type: multipart/mixed; boundary="===============7200732177527701286=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] gatmux: Remove finalized watches from the list
Date: Mon, 23 Oct 2017 12:17:30 +0300
Message-ID: <1508750250-32765-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7200732177527701286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Leaving them there may result in invalid reads like this:

=3D=3D2312=3D=3D Invalid read of size 4
=3D=3D2312=3D=3D    at 0xAB8C0: dispatch_sources (gatmux.c:134)
=3D=3D2312=3D=3D    by 0xAC5D3: channel_close (gatmux.c:479)
=3D=3D2312=3D=3D    by 0x4AE8885: g_io_channel_shutdown (giochannel.c:523)
=3D=3D2312=3D=3D    by 0x4AE8A1D: g_io_channel_unref (giochannel.c:240)
=3D=3D2312=3D=3D    by 0xAC423: watch_finalize (gatmux.c:426)
=3D=3D2312=3D=3D    by 0x4AF2CC9: g_source_unref_internal (gmain.c:2048)
=3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy_internal (gmain.c:1230)
=3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy (gmain.c:1256)
=3D=3D2312=3D=3D    by 0x4AF5257: g_source_remove (gmain.c:2282)
=3D=3D2312=3D=3D    by 0xAB5CB: io_shutdown (gatio.c:325)
=3D=3D2312=3D=3D    by 0xAB667: g_at_io_unref (gatio.c:345)
=3D=3D2312=3D=3D    by 0xA72C7: at_chat_unref (gatchat.c:972)
=3D=3D2312=3D=3D    by 0xA829B: g_at_chat_unref (gatchat.c:1446)
=3D=3D2312=3D=3D  Address 0x51420f0 is 56 bytes inside a block of size 60 f=
ree'd
=3D=3D2312=3D=3D    at 0x4840B28: free (vg_replace_malloc.c:530)
=3D=3D2312=3D=3D    by 0x4AF2D33: g_source_unref_internal (gmain.c:2075)
=3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy_internal (gmain.c:1230)
=3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy (gmain.c:1256)
=3D=3D2312=3D=3D    by 0x4AF5257: g_source_remove (gmain.c:2282)
=3D=3D2312=3D=3D    by 0xAB46B: g_at_io_set_write_handler (gatio.c:283)
=3D=3D2312=3D=3D    by 0xA713F: at_chat_suspend (gatchat.c:938)
=3D=3D2312=3D=3D    by 0xA72B7: at_chat_unref (gatchat.c:971)
=3D=3D2312=3D=3D    by 0xA829B: g_at_chat_unref (gatchat.c:1446)
=3D=3D2312=3D=3D  Block was alloc'd at
=3D=3D2312=3D=3D    at 0x4841BF0: calloc (vg_replace_malloc.c:711)
=3D=3D2312=3D=3D    by 0x4AFB117: g_malloc0 (gmem.c:124)
=3D=3D2312=3D=3D    by 0x4AF401F: g_source_new (gmain.c:892)
=3D=3D2312=3D=3D    by 0xAC6A7: channel_create_watch (gatmux.c:506)
=3D=3D2312=3D=3D    by 0x4AE7C4F: g_io_add_watch_full (giochannel.c:649)
=3D=3D2312=3D=3D    by 0xAB4EB: g_at_io_set_write_handler (gatio.c:297)
=3D=3D2312=3D=3D    by 0xA7103: chat_wakeup_writer (gatchat.c:931)
=3D=3D2312=3D=3D    by 0xA753F: at_chat_send_common (gatchat.c:1045)
=3D=3D2312=3D=3D    by 0xA850F: g_at_chat_send (gatchat.c:1502)

It's also necessary to add additional references to the sources
for the duration of the dispatch_sources loop because any source
can be removed when any callback is invoked (and not necessarily
the one being dispatched).
---
 gatchat/gatmux.c | 109 +++++++++++++++++++++++++++++++++++++++------------=
----
 1 file changed, 77 insertions(+), 32 deletions(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 0e275b5..909eca6 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -116,66 +116,109 @@ static inline void debug(GAtMux *mux, const char *fo=
rmat, ...)
 =

 static void dispatch_sources(GAtMuxChannel *channel, GIOCondition conditio=
n)
 {
-	GAtMuxWatch *source;
 	GSList *c;
 	GSList *p;
-	GSList *t;
+	GSList *refs;
+
+	/*
+	 * Don't reference destroyed sources, they may have zero reference
+	 * count if this function is invoked from the source's finalize
+	 * callback, in which case incrementing and then decrementing
+	 * the count would result in double free (first when we decrement
+	 * the reference count and then when we return from the finalize
+	 * callback).
+	 */
 =

 	p =3D NULL;
-	c =3D channel->sources;
+	refs =3D NULL;
 =

-	while (c) {
-		gboolean destroy =3D FALSE;
+	for (c =3D channel->sources; c; c =3D c->next) {
+		GSource *s =3D c->data;
+
+		if (!g_source_is_destroyed(s)) {
+			GSList *l =3D g_slist_append(NULL, g_source_ref(s));
+
+			if (p)
+				p->next =3D l;
+			else
+				refs =3D l;
 =

-		source =3D c->data;
+			p =3D l;
+		}
+	}
 =

-		debug(channel->mux, "checking source: %p", source);
+	/*
+	 * Keep the references to all sources for the duration of the loop.
+	 * Callbacks may add and remove the sources, i.e. channel->sources
+	 * may keep changing during the loop.
+	 */
 =

-		if (condition & source->condition) {
+	for (c =3D refs; c; c =3D c->next) {
+		GAtMuxWatch *w =3D c->data;
+		GSource *s =3D &w->source;
+
+		if (g_source_is_destroyed(s))
+			continue;
+
+		debug(channel->mux, "checking source: %p", s);
+
+		if (condition & w->condition) {
 			gpointer user_data =3D NULL;
 			GSourceFunc callback =3D NULL;
-			GSourceCallbackFuncs *cb_funcs;
-			gpointer cb_data;
-			gboolean (*dispatch) (GSource *, GSourceFunc, gpointer);
-
-			debug(channel->mux, "dispatching source: %p", source);
+			GSourceCallbackFuncs *cb_funcs =3D s->callback_funcs;
+			gpointer cb_data =3D s->callback_data;
+			gboolean destroy;
 =

-			dispatch =3D source->source.source_funcs->dispatch;
-			cb_funcs =3D source->source.callback_funcs;
-			cb_data =3D source->source.callback_data;
+			debug(channel->mux, "dispatching source: %p", s);
 =

-			if (cb_funcs)
+			if (cb_funcs) {
 				cb_funcs->ref(cb_data);
+				cb_funcs->get(cb_data, s, &callback,
+								&user_data);
+			}
 =

-			if (cb_funcs)
-				cb_funcs->get(cb_data, (GSource *) source,
-						&callback, &user_data);
-
-			destroy =3D !dispatch((GSource *) source, callback,
-						user_data);
+			destroy =3D !s->source_funcs->dispatch(s, callback,
+								user_data);
 =

 			if (cb_funcs)
 				cb_funcs->unref(cb_data);
+
+			if (destroy) {
+				debug(channel->mux, "removing source: %p", s);
+				g_source_destroy(s);
+			}
 		}
+	}
 =

-		if (destroy) {
-			debug(channel->mux, "removing source: %p", source);
+	/*
+	 * Remove destroyed sources from channel->sources. During this
+	 * loop we are not invoking any callbacks, so the consistency is
+	 * guaranteed.
+	 */
 =

-			g_source_destroy((GSource *) source);
+	p =3D NULL;
+	c =3D channel->sources;
 =

+	while (c) {
+		GSList *n =3D c->next;
+		GSource *s =3D c->data;
+
+		if (g_source_is_destroyed(s)) {
 			if (p)
-				p->next =3D c->next;
+				p->next =3D n;
 			else
-				channel->sources =3D c->next;
+				channel->sources =3D n;
 =

-			t =3D c;
-			c =3D c->next;
-			g_slist_free_1(t);
+			g_slist_free_1(c);
 		} else {
 			p =3D c;
-			c =3D c->next;
 		}
+
+		c =3D n;
 	}
+
+	/* Release temporary references */
+	g_slist_free_full(refs, (GDestroyNotify) g_source_unref);
 }
 =

 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
@@ -422,7 +465,9 @@ static gboolean watch_dispatch(GSource *source, GSource=
Func callback,
 static void watch_finalize(GSource *source)
 {
 	GAtMuxWatch *watch =3D (GAtMuxWatch *) source;
+	GAtMuxChannel *dlc =3D (GAtMuxChannel *) watch->channel;
 =

+	dlc->sources =3D g_slist_remove(dlc->sources, watch);
 	g_io_channel_unref(watch->channel);
 }
 =

-- =

1.9.1


--===============7200732177527701286==--

