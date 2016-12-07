Content-Type: multipart/mixed; boundary="===============3680053000930214985=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 2/2] rilmodem: set LTE preferred in rat mode
Date: Wed, 07 Dec 2016 08:41:26 +0530
Message-ID: <1481080286-21222-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3680053000930214985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/radio-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index d6d0ad9..36befca 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -111,7 +111,7 @@ static void ril_set_rat_mode(struct ofono_radio_setting=
s *rs,
 	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
 	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
 	struct parcel rilp;
-	int pref =3D PREF_NET_TYPE_GSM_WCDMA;
+	int pref =3D PREF_NET_TYPE_LTE_GSM_WCDMA;
 =

 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
-- =

1.9.1


--===============3680053000930214985==--

