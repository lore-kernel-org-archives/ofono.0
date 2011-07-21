Content-Type: multipart/mixed; boundary="===============1099277225982478125=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 3/4] driver cdma-connman: pass credentials into activate
 function
Date: Thu, 21 Jul 2011 06:40:43 +0200
Message-ID: <1311223244-26904-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311223244-26904-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1099277225982478125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/cdmamodem/connman.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/cdmamodem/connman.c b/drivers/cdmamodem/connman.c
index 14c78b1..ce9a748 100644
--- a/drivers/cdmamodem/connman.c
+++ b/drivers/cdmamodem/connman.c
@@ -56,6 +56,8 @@ struct connman_data {
 	GAtChat *chat;
 	GAtPPP *ppp;
 	enum state state;
+	char username[OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH + 1];
 	union {
 		ofono_cdma_connman_cb_t down_cb;	/* Down callback */
 		ofono_cdma_connman_up_cb_t up_cb;	/* Up callback */
@@ -145,6 +147,8 @@ static gboolean setup_ppp(struct ofono_cdma_connman *cm)
 	g_at_ppp_set_connect_function(cd->ppp, ppp_connect, cm);
 	g_at_ppp_set_disconnect_function(cd->ppp, ppp_disconnect, cm);
 =

+	g_at_ppp_set_credentials(cd->ppp, cd->username, cd->password);
+
 	/* open the ppp connection */
 	g_at_ppp_open(cd->ppp, io);
 =

@@ -175,6 +179,8 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 }
 =

 static void cdma_connman_activate(struct ofono_cdma_connman *cm,
+					const char *username,
+					const char *password,
 					ofono_cdma_connman_up_cb_t cb,
 					void *data)
 {
@@ -185,6 +191,9 @@ static void cdma_connman_activate(struct ofono_cdma_con=
nman *cm,
 =

 	cd->up_cb =3D cb;
 	cd->cb_data =3D data;
+	strcpy(cd->username, username);
+	strcpy(cd->password, password);
+
 	cd->state =3D STATE_ENABLING;
 =

 	sprintf(buf, "ATD#777");
-- =

1.7.1


--===============1099277225982478125==--

