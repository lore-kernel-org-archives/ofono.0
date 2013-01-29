Content-Type: multipart/mixed; boundary="===============5195844000047338553=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 3/4] hfp_hf_bluez5: Add rejecting SCO connection
Date: Tue, 29 Jan 2013 17:38:39 -0300
Message-ID: <1359491920-15963-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359491920-15963-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5195844000047338553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch rejects the SCO incoming connection if there isn't a service
level connection associated with the Bluetooth address pair.
---
 plugins/hfp_hf_bluez5.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 49a84c5..28c57c3 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -63,11 +63,34 @@ struct hfp {
 	DBusMessage *msg;
 };
 =

+struct address_pair {
+	char local[18];
+	char remote[18];
+};
+
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 static guint sco_watch =3D 0;
 =

+static gboolean modem_cmp(gpointer key, gpointer value,
+						gpointer user_data)
+{
+	const struct address_pair *pair =3D user_data;
+	struct ofono_modem *modem =3D value;
+	const char *local, *remote;
+	int ret;
+
+	local =3D ofono_modem_get_string(modem, "Local");
+	remote =3D ofono_modem_get_string(modem, "Remote");
+
+	ret =3D g_strcmp0(pair->remote, remote);
+	if (ret !=3D 0)
+		return FALSE;
+
+	return g_strcmp0(pair->local, local) =3D=3D 0;
+}
+
 static void hfp_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -407,7 +430,9 @@ static const GDBusMethodTable profile_methods[] =3D {
 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	struct sockaddr_sco saddr;
+	struct ofono_modem *modem;
+	struct sockaddr_sco laddr, raddr;
+	struct address_pair pair;
 	socklen_t alen;
 	int sk, nsk;
 =

@@ -416,14 +441,29 @@ static gboolean sco_accept(GIOChannel *io, GIOConditi=
on cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

-	memset(&saddr, 0, sizeof(saddr));
-	alen =3D sizeof(saddr);
+	memset(&raddr, 0, sizeof(raddr));
+	alen =3D sizeof(raddr);
 =

-	nsk =3D accept(sk, (struct sockaddr *) &saddr, &alen);
+	nsk =3D accept(sk, (struct sockaddr *) &raddr, &alen);
 	if (nsk < 0)
 		return TRUE;
 =

-	/* TODO: Verify if the device has a modem */
+	memset(&laddr, 0, sizeof(laddr));
+	alen =3D sizeof(laddr);
+	if (getsockname(nsk, (struct sockaddr *) &laddr, &alen) < 0) {
+		close(nsk);
+		return TRUE;
+	}
+
+	bt_ba2str(&laddr.sco_bdaddr, pair.local);
+	bt_ba2str(&raddr.sco_bdaddr, pair.remote);
+
+	modem =3D g_hash_table_find(modem_hash, modem_cmp, &pair);
+	if (modem =3D=3D NULL) {
+		ofono_error("Rejecting SCO: SLC connection missing!");
+		close(nsk);
+		return TRUE;
+	}
 =

 	return TRUE;
 }
-- =

1.7.11.7


--===============5195844000047338553==--

