Content-Type: multipart/mixed; boundary="===============6624561755737708536=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 02/26] gatio: add prototype to drain GAtIO read buffer
Date: Fri, 01 Apr 2011 10:56:04 +0200
Message-ID: <1301648188-7208-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6624561755737708536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatio.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatio.h b/gatchat/gatio.h
index ca9618f..16dd621 100644
--- a/gatchat/gatio.h
+++ b/gatchat/gatio.h
@@ -52,6 +52,8 @@ gboolean g_at_io_set_write_handler(GAtIO *io, GAtIOWriteF=
unc write_handler,
 void g_at_io_set_write_done(GAtIO *io, GAtDisconnectFunc func,
 				gpointer user_data);
 =

+void g_at_io_drain_ring_buffer(GAtIO *io, guint len);
+
 gsize g_at_io_write(GAtIO *io, const gchar *data, gsize count);
 =

 gboolean g_at_io_set_disconnect_function(GAtIO *io,
-- =

1.7.1


--===============6624561755737708536==--

