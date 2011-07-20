Content-Type: multipart/mixed; boundary="===============4643337558135224075=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 3/4] driver cdma-connman: add credential while setting up PPP
 if required
Date: Wed, 20 Jul 2011 11:26:39 +0200
Message-ID: <1311154000-32353-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311154000-32353-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4643337558135224075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 14c78b1..7f6bf5a 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -123,9 +123,14 @@ static gboolean setup_ppp(struct ofono_cdma_connman *c=
m)
 {
 	struct connman_data *cd =3D ofono_cdma_connman_get_data(cm);
 	GAtIO *io;
+	const char *username;
+	const char *password;
 =

 	DBG("");
 =

+	username =3D ofono_cdma_connman_get_username(cm);
+	password =3D ofono_cdma_connman_get_password(cm);
+
 	io =3D g_at_chat_get_io(cd->chat);
 =

 	g_at_chat_suspend(cd->chat);
@@ -145,6 +150,9 @@ static gboolean setup_ppp(struct ofono_cdma_connman *cm)
 	g_at_ppp_set_connect_function(cd->ppp, ppp_connect, cm);
 	g_at_ppp_set_disconnect_function(cd->ppp, ppp_disconnect, cm);
 =

+	if (username && password)
+		g_at_ppp_set_credentials(cd->ppp, username, password);
+
 	/* open the ppp connection */
 	g_at_ppp_open(cd->ppp, io);
 =

-- =

1.7.1


--===============4643337558135224075==--

