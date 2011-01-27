Content-Type: multipart/mixed; boundary="===============5489197319696408487=="
MIME-Version: 1.0
From: Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [PATCH] n900: fix set online
Date: Thu, 27 Jan 2011 12:51:32 +0200
Message-ID: <1296125492-11795-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5489197319696408487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Invalid MTC_STATE_REQ messages were sent, causing failures in going
online.
---
 plugins/n900.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index 5b3a496..3d27b58 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -448,7 +448,7 @@ static void n900_set_online(struct ofono_modem *modem,
 	struct isi_cb_data *cbd =3D isi_cb_data_new(modem, cb, data);
 	const uint8_t req[] =3D {
 		MTC_STATE_REQ,
-		online ? MTC_NORMAL : MTC_RF_INACTIVE,
+		online ? MTC_NORMAL : MTC_RF_INACTIVE, 0
 	};
 =

 	DBG("(%p) with %s", modem, isi->ifname);
-- =

1.7.0.4


--===============5489197319696408487==--

