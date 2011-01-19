Content-Type: multipart/mixed; boundary="===============7955289030429718815=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/6] atmodem: Remove deregister implementation
Date: Wed, 19 Jan 2011 23:53:52 +0200
Message-ID: <1295474035-7142-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7955289030429718815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index e11c974..4b8cc34 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -557,25 +557,6 @@ error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void at_deregister(struct ofono_netreg *netreg,
-				ofono_netreg_register_cb_t cb, void *data)
-{
-	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-
-	if (cbd =3D=3D NULL)
-		goto error;
-
-	if (g_at_chat_send(nd->chat, "AT+COPS=3D2", none_prefix,
-				register_cb, cbd, g_free) > 0)
-		return;
-
-error:
-	g_free(cbd);
-
-	CALLBACK_WITH_FAILURE(cb, data);
-}
-
 static void csq_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -1342,7 +1323,6 @@ static struct ofono_netreg_driver driver =3D {
 	.list_operators			=3D at_list_operators,
 	.register_auto			=3D at_register_auto,
 	.register_manual		=3D at_register_manual,
-	.deregister			=3D at_deregister,
 	.strength			=3D at_signal_strength,
 };
 =

-- =

1.7.1


--===============7955289030429718815==--

