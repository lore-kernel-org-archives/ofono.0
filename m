Content-Type: multipart/mixed; boundary="===============5790367498616659539=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 2/2] hfp_hf_bluez5: Add rejecting SCO connection
Date: Wed, 30 Jan 2013 10:32:45 -0300
Message-ID: <1359552765-9851-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359552765-9851-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5790367498616659539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch rejects the SCO incoming connection if there isn't a service
level connection associated with the Bluetooth address pair.
---
 plugins/hfp_hf_bluez5.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 45f4cdd..7af2968 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -412,8 +412,10 @@ static const GDBusMethodTable profile_methods[] =3D {
 static gboolean sco_accept(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	struct sockaddr_sco saddr;
+	struct sockaddr_sco laddr, raddr;
 	socklen_t alen;
+	char local[18], remote[18];
+	const char *address;
 	int sk, nsk;
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -421,14 +423,29 @@ static gboolean sco_accept(GIOChannel *io, GIOConditi=
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
+	bt_ba2str(&laddr.sco_bdaddr, local);
+	bt_ba2str(&raddr.sco_bdaddr, remote);
+
+	address =3D g_hash_table_lookup(slc_hash, remote);
+	if (g_strcmp0(address, local) !=3D 0) {
+		ofono_error("Rejecting SCO: SLC connection missing!");
+		close(nsk);
+		return TRUE;
+	}
 =

 	return TRUE;
 }
-- =

1.7.11.7


--===============5790367498616659539==--

