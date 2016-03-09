Content-Type: multipart/mixed; boundary="===============3382645868677736657=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 03/19] plugins/udevng: ublox: set model string
Date: Wed, 09 Mar 2016 16:44:44 +0100
Message-ID: <1457538300-7183-4-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3382645868677736657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Necessary for supporting the ublox TOBY L2 modem.
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2170c90..4b84323 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -888,6 +888,7 @@ static gboolean setup_ublox(struct modem_info *modem)
 	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	ofono_modem_set_string(modem->modem, "Model", modem->model);
 =

 	return TRUE;
 }
-- =

2.5.0


--===============3382645868677736657==--

