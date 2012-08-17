Content-Type: multipart/mixed; boundary="===============2373349931592150722=="
MIME-Version: 1.0
From: Christopher Vogl <christopher.vogl@hale.at>
Subject: [PATCH 1/2] udevng: rename aux port from Data to Aux for telit.
Date: Fri, 17 Aug 2012 10:53:11 +0200
Message-ID: <1345193591-30179-2-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <50293379.7090003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2373349931592150722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Telit software user guide says:
USB AUX doesn't support any flow control method. Therefore, this port
isn't suitable for DATA service port.
We recommend this port should be used only for AT command and URC
processing.
---
 plugins/udevng.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 872039a..bd5e5e0 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -615,7 +615,7 @@ static gboolean setup_telit(struct modem_info *modem)
 	DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "Data", aux);
+	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "GPS", gps);
 =

 	return TRUE;
-- =

1.7.7.6


--
Scanned by MailScanner.


--===============2373349931592150722==--

