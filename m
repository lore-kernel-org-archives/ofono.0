Content-Type: multipart/mixed; boundary="===============8349085125747933230=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 2/6] isimodem: Remove deregister implementation
Date: Wed, 19 Jan 2011 23:53:51 +0200
Message-ID: <1295474035-7142-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8349085125747933230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/network-registration.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 47aaeb1..6518968 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -663,14 +663,6 @@ error:
 	g_free(cbd);
 }
 =

-static void isi_deregister(struct ofono_netreg *netreg,
-				ofono_netreg_register_cb_t cb,
-				void *data)
-{
-	DBG("Not implemented.");
-	CALLBACK_WITH_FAILURE(cb, data);
-}
-
 static void rssi_ind_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_netreg *netreg =3D data;
@@ -859,7 +851,6 @@ static struct ofono_netreg_driver driver =3D {
 	.list_operators		=3D isi_list_operators,
 	.register_auto		=3D isi_register_auto,
 	.register_manual	=3D isi_register_manual,
-	.deregister		=3D isi_deregister,
 	.strength		=3D isi_strength,
 };
 =

-- =

1.7.1


--===============8349085125747933230==--

