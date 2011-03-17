Content-Type: multipart/mixed; boundary="===============4504204751441606241=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 9/9] hsp_ag: add audio connection support
Date: Thu, 17 Mar 2011 19:55:48 +0100
Message-ID: <1300388148-925-10-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4504204751441606241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hsp_ag.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/plugins/hsp_ag.c b/plugins/hsp_ag.c
index 5a60269..73050aa 100644
--- a/plugins/hsp_ag.c
+++ b/plugins/hsp_ag.c
@@ -92,10 +92,30 @@ static const gchar *hsp_record =3D
 " </attribute>\n"
 "</record>\n";
 =

+static gboolean sco_unregister_cb(GIOChannel *channel,
+					GIOCondition cond, gpointer data)
+{
+	struct sco *sco =3D data;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		sco_unregister_server(sco);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void audio_connect_cb(struct ofono_emulator *em, void *data)
+{
+	struct sco *sco =3D data;
+	sco_connect(sco);
+}
+
 static void connect_cb(GIOChannel *channel, GError *err, gpointer data)
 {	int fd;
 	struct ofono_emulator *em;
 	struct ofono_modem *modem;
+	struct sco *sco;
 =

 	/* Pick the first powered modem */
 	modem =3D modems->data;
@@ -110,6 +130,13 @@ static void connect_cb(GIOChannel *channel, GError *er=
r, gpointer data)
 	ofono_emulator_register(em, fd);
 =

 	g_io_channel_set_close_on_unref(channel, FALSE);
+
+	sco =3D sco_register_server(channel);
+
+	ofono_emulator_set_audio_connect_handler(em, audio_connect_cb, sco);
+
+	g_io_add_watch(channel,	G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						sco_unregister_cb, sco);
 }
 =

 static void voicecall_watch(struct ofono_atom *atom,
-- =

1.7.1


--===============4504204751441606241==--

