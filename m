Content-Type: multipart/mixed; boundary="===============2390398868328654978=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: implement net close
Date: Fri, 02 Apr 2010 16:45:24 -0700
Message-ID: <1270251924-5078-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2390398868328654978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp.h     |    1 +
 gatchat/ppp_net.c |   11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index fa3749c..7b09fa9 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -105,6 +105,7 @@ struct ppp_net_data {
 	GAtPPP *ppp;
 	char *if_name;
 	GIOChannel *channel;
+	gint watch;
 };
 =

 struct _GAtPPP {
diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 908da84..d07a988 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -64,8 +64,6 @@ void ppp_net_process_packet(struct ppp_net_data *data, gu=
int8 *packet)
 /*
  * packets received by the tun interface need to be written to
  * the modem.  So, just read a packet, write out to the modem
- *
- * TBD - how do we know we have a full packet?  Do we care?
  */
 static gboolean ppp_net_callback(GIOChannel *channel, GIOCondition cond,
 				gpointer userdata)
@@ -77,6 +75,9 @@ static gboolean ppp_net_callback(GIOChannel *channel, GIO=
Condition cond,
 	struct ppp_header *ppp =3D (struct ppp_header *) buf;
 	struct ppp_net_data *data =3D (struct ppp_net_data *) userdata;
 =

+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
 	if (cond & G_IO_IN) {
 		/* leave space to add PPP protocol field */
 		status =3D g_io_channel_read_chars(channel, buf + 2, MAX_PACKET,
@@ -93,7 +94,8 @@ static gboolean ppp_net_callback(GIOChannel *channel, GIO=
Condition cond,
 =

 void ppp_net_close(struct ppp_net_data *data)
 {
-	/* Not Implemented Yet */
+	g_source_remove(data->watch);
+	g_io_channel_unref(data->channel);
 }
 =

 void ppp_net_open(struct ppp_net_data *data)
@@ -101,7 +103,6 @@ void ppp_net_open(struct ppp_net_data *data)
 	int fd;
 	struct ifreq ifr;
 	GIOChannel *channel;
-	int signal_source;
 	int err;
 =

 	if (data =3D=3D NULL)
@@ -138,7 +139,7 @@ void ppp_net_open(struct ppp_net_data *data)
 	}
 	data->channel =3D channel;
 	g_io_channel_set_buffered(channel, FALSE);
-	signal_source =3D g_io_add_watch(channel,
+	data->watch =3D g_io_add_watch(channel,
 			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 			ppp_net_callback, (gpointer) data);
 }
-- =

1.6.6.1


--===============2390398868328654978==--

