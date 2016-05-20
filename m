Content-Type: multipart/mixed; boundary="===============4991319097601603393=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH] radio-settings: fix WCDMA only in query rat mode
Date: Fri, 20 May 2016 11:20:17 +0530
Message-ID: <1463723417-8415-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4991319097601603393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/radio-settings.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index 7317950..d6d0ad9 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -198,6 +198,7 @@ static void ril_rat_mode_cb(struct ril_msg *message, gp=
ointer user_data)
 	 * capabilities, so it is sort of the default for MTK modems.
 	 */
 	switch (net_type) {
+	case PREF_NET_TYPE_WCDMA:
 	case PREF_NET_TYPE_GSM_WCDMA:
 	case PREF_NET_TYPE_GSM_WCDMA_AUTO:
 		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
-- =

1.9.1


--===============4991319097601603393==--

