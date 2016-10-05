Content-Type: multipart/mixed; boundary="===============6539310051042271655=="
MIME-Version: 1.0
From: Antoine Aubert <a.aubert@overkiz.com>
Subject: [PATCH] gatmux: fix read channel remove on error.
Date: Wed, 05 Oct 2016 08:42:28 +0200
Message-ID: <1475649748-20537-1-git-send-email-a.aubert@overkiz.com>
In-Reply-To: <57F47081.9010406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6539310051042271655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of invalid IO, read_watch is not reset. This fix crash on destroy g=
atmux.
---
 gatchat/gatmux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 9beeece..074e340 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -598,6 +598,13 @@ void g_at_mux_unref(GAtMux *mux)
 	}
 }
 =

+static void read_watcher_destroy_notify(gpointer user_data)
+{
+	GAtMux *mux =3D user_data;
+
+	mux->read_watch =3D 0;
+}
+
 gboolean g_at_mux_start(GAtMux *mux)
 {
 	if (mux->channel =3D=3D NULL)
@@ -611,7 +618,7 @@ gboolean g_at_mux_start(GAtMux *mux)
 =

 	mux->read_watch =3D g_io_add_watch_full(mux->channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						received_data, mux, NULL);
+						received_data, mux, read_watcher_destroy_notify);
 =

 	mux->shutdown =3D FALSE;
 =

-- =

2.7.4


--===============6539310051042271655==--

