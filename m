Content-Type: multipart/mixed; boundary="===============1895421353755721170=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/2] udev: isi modems do not use 'Device' property
Date: Tue, 12 Sep 2017 10:11:20 +0200
Message-ID: <20170912081120.29364-2-jonas@southpole.se>
In-Reply-To: <20170912081120.29364-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1895421353755721170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Neither the n900 nor u8500 drivers use this property so there's currently
no need to set it in the setup function.
---
 plugins/udevng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 9d00bb8..a4b99aa 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1013,8 +1013,6 @@ static gboolean setup_isi_serial(struct modem_info* m=
odem)
 	if (value)
 		ofono_modem_set_integer(modem->modem, "Address", atoi(value));
 =

-	ofono_modem_set_string(modem->modem, "Device", info->devnode);
-
 	return TRUE;
 }
 =

-- =

2.9.3


--===============1895421353755721170==--

