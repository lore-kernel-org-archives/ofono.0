Content-Type: multipart/mixed; boundary="===============8956023470745946516=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 7/9] hfp_hf_bluez5: Add rejecting SCO connection
Date: Mon, 28 Jan 2013 11:44:17 -0300
Message-ID: <1359384259-5384-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359384259-5384-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8956023470745946516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch rejects the SCO incoming connection if there isn't a modem
(service level connection) associated with the address. At the moment,
only the remote address is verified.
---
 plugins/hfp_hf_bluez5.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index a4a0894..d79647b 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -67,6 +67,16 @@ static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 static guint sco_watch =3D 0;
 =

+static gboolean modem_address_cmp(gpointer key, gpointer value,
+						gpointer user_data)
+{
+	const char *dst =3D user_data;
+	struct ofono_modem *modem =3D value;
+	const char *address =3D ofono_modem_get_string(modem, "Address");
+
+	return g_strcmp0(address, dst) !=3D 0 ? FALSE : TRUE;
+}
+
 static void hfp_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -383,8 +393,10 @@ static const GDBusMethodTable profile_methods[] =3D {
 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	struct ofono_modem *modem;
 	struct sockaddr_sco saddr;
 	socklen_t optlen;
+	char dst[18];
 	int sk, nsk;
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -399,7 +411,13 @@ static gboolean sco_accept(GIOChannel *io, GIOConditio=
n cond,
 	if (nsk < 0)
 		return TRUE;
 =

-	/* TODO: Verify if the device has a modem */
+	bt_ba2str(&saddr.sco_bdaddr, dst);
+	modem =3D g_hash_table_find(modem_hash, modem_address_cmp, dst);
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


--===============8956023470745946516==--

