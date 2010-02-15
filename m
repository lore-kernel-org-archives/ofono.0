Content-Type: multipart/mixed; boundary="===============2253519465634260506=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/3] hfp: add watch to trigger HUP of the file descriptor
Date: Mon, 15 Feb 2010 17:26:35 -0200
Message-ID: <1266261996-15507-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1266261996-15507-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2253519465634260506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 411cfc1..3776dc6 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -482,6 +482,20 @@ error:
 	service_level_conn_failed(modem);
 }
 =

+static gboolean hfp_fd_disconnected_cb(GIOChannel *chan, GIOCondition cond,
+		struct ofono_modem *modem)
+{
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		ofono_modem_set_powered(modem, FALSE);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 /* either oFono or Phone could request SLC connection */
 static int service_level_connection(struct ofono_modem *modem, int fd)
 {
@@ -498,6 +512,9 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 		return -EIO;
 	}
 =

+	g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+	                        (GIOFunc) hfp_fd_disconnected_cb, modem);
+
 	syntax =3D g_at_syntax_new_gsmv1();
 	chat =3D g_at_chat_new(io, syntax);
 	g_at_syntax_unref(syntax);
-- =

1.6.4.4


--===============2253519465634260506==--

