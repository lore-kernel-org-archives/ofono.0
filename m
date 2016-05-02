Content-Type: multipart/mixed; boundary="===============6916310285619773297=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: [PATCH 1/3] Gobi: Enable SIM driver forcing
Date: Mon, 02 May 2016 18:33:12 +0200
Message-ID: <1462206794-14322-1-git-send-email-m.chaplet@kerlink.fr>
In-Reply-To: <57277020.8020900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6916310285619773297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let modem detect part overload default SIM driver by using an additional
property named "ForceSimLegacy" (boolean).

Signed-off-by: Martin Chaplet <m.chaplet@kerlink.fr>
---
 plugins/gobi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 4daa459..aad423d 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -418,7 +418,7 @@ static void gobi_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "qmimodem", data->device);
 =

-	if (data->features & GOBI_UIM)
+	if ( (data->features & GOBI_UIM) && !ofono_modem_get_boolean(modem, "Forc=
eSimLegacy") )
 		ofono_sim_create(modem, 0, "qmimodem", data->device);
 	else if (data->features & GOBI_DMS)
 		ofono_sim_create(modem, 0, "qmimodem-legacy", data->device);
-- =

1.9.1


--===============6916310285619773297==--

