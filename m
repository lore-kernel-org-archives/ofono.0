Content-Type: multipart/mixed; boundary="===============8359192788871290489=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 3/3] hfp_hf_bluez5: Add SCO channel tracking
Date: Fri, 01 Feb 2013 14:51:38 -0300
Message-ID: <1359741098-27338-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359741098-27338-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8359192788871290489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the SCO GIOChannel tracking. This is the initial step to
manage transport objects state changes and transport acquire.
---
 plugins/hfp_hf_bluez5.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 6a0f4a2..38643c6 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -60,6 +60,8 @@
 =

 struct hfp {
 	struct hfp_slc_info info;
+	GIOChannel *sco_io;
+	guint sco_watch;
 	DBusMessage *msg;
 };
 =

@@ -228,6 +230,12 @@ static void hfp_remove(struct ofono_modem *modem)
 =

 	g_at_chat_unref(info->chat);
 =

+	if (hfp->sco_watch > 0)
+		g_source_remove(hfp->sco_watch);
+
+	if (hfp->sco_io)
+		g_io_channel_unref(hfp->sco_io);
+
 	g_free(hfp);
 =

 	ofono_modem_set_data(modem, NULL);
@@ -374,10 +382,27 @@ static const GDBusMethodTable profile_methods[] =3D {
 	{ }
 };
 =

+static gboolean sco_channel_watch(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;
+
+	hfp->sco_watch =3D 0;
+
+	g_io_channel_unref(hfp->sco_io);
+	hfp->sco_io =3D NULL;
+
+	/* TODO: Change transport state */
+
+	return FALSE;
+}
+
 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct sockaddr_sco saddr;
+	struct ofono_modem *modem;
+	struct hfp *hfp;
 	GSList *l;
 	socklen_t alen;
 	char remote[18];
@@ -404,7 +429,11 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 		return TRUE;
 	}
 =

-	/* TODO: Store the SCO reference to update the Media Transports */
+	modem =3D l->data;
+	hfp =3D ofono_modem_get_data(modem);
+	hfp->sco_io =3D io;
+	hfp->sco_watch =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						sco_channel_watch, hfp);
 =

 	return TRUE;
 }
-- =

1.7.11.7


--===============8359192788871290489==--

