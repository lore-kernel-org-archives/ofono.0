Content-Type: multipart/mixed; boundary="===============8122903506725108793=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 2/3] ublox: use common close_devices when modem disabled
Date: Wed, 25 Sep 2019 06:35:06 +0200
Message-ID: <20190925043507.29892-3-jonas@norrbonn.se>
In-Reply-To: <20190925043507.29892-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8122903506725108793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just reshuffling the code a bit and the 'disable' path can use the
close_devices() helper to finish up.  This also prevents a bug should
the CFUN command fail to disable the modem whereby the 'aux' device
remains open but the 'modem' device has already been closed.
---
 plugins/ublox.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/plugins/ublox.c b/plugins/ublox.c
index 60a734ce..22350462 100644
--- a/plugins/ublox.c
+++ b/plugins/ublox.c
@@ -269,15 +269,15 @@ static int ublox_enable(struct ofono_modem *modem)
 static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_dat=
a)
 {
 	struct ofono_modem *modem =3D user_data;
-	struct ublox_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("");
 =

-	g_at_chat_unref(data->aux);
-	data->aux =3D NULL;
+	if (!ok) {
+		ofono_error("Failed to disable modem");
+		return;
+	}
 =

-	if (ok)
-		ofono_modem_set_powered(modem, FALSE);
+	close_devices(modem);
 }
 =

 static int ublox_disable(struct ofono_modem *modem)
@@ -288,8 +288,6 @@ static int ublox_disable(struct ofono_modem *modem)
 =

 	g_at_chat_cancel_all(data->modem);
 	g_at_chat_unregister_all(data->modem);
-	g_at_chat_unref(data->modem);
-	data->modem =3D NULL;
 =

 	g_at_chat_cancel_all(data->aux);
 	g_at_chat_unregister_all(data->aux);
-- =

2.20.1


--===============8122903506725108793==--

