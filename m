Content-Type: multipart/mixed; boundary="===============6636132191985847965=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 2/3] hfp_hf_bluez5: Add rejecting SCO connection
Date: Fri, 01 Feb 2013 14:51:37 -0300
Message-ID: <1359741098-27338-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359741098-27338-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6636132191985847965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch rejects the SCO incoming connection if there isn't a service
level connection associated with the Bluetooth remote device.
---
 plugins/hfp_hf_bluez5.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index abeeb4a..6a0f4a2 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -75,6 +75,15 @@ static void hfp_debug(const char *str, void *user_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

+static int modem_cmp(gconstpointer data, gconstpointer user_data)
+{
+	const char *address =3D user_data;
+	struct ofono_modem *modem =3D (struct ofono_modem *) data;
+	const char *remote =3D ofono_modem_get_string(modem, "Remote");
+
+	return g_strcmp0(address, remote);
+}
+
 static void slc_established(gpointer userdata)
 {
 	struct ofono_modem *modem =3D userdata;
@@ -369,7 +378,9 @@ static gboolean sco_accept(GIOChannel *io, GIOCondition=
 cond,
 							gpointer user_data)
 {
 	struct sockaddr_sco saddr;
+	GSList *l;
 	socklen_t alen;
+	char remote[18];
 	int sk, nsk;
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -384,7 +395,16 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 	if (nsk < 0)
 		return TRUE;
 =

-	/* TODO: Verify if the device has a modem */
+	bt_ba2str(&saddr.sco_bdaddr, remote);
+
+	l =3D g_slist_find_custom(slc_list, remote, modem_cmp);
+	if (l =3D=3D NULL) {
+		ofono_error("Rejecting SCO: SLC connection missing!");
+		close(nsk);
+		return TRUE;
+	}
+
+	/* TODO: Store the SCO reference to update the Media Transports */
 =

 	return TRUE;
 }
-- =

1.7.11.7


--===============6636132191985847965==--

