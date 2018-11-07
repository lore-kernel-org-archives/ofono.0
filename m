Content-Type: multipart/mixed; boundary="===============5326491358948107672=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 3/3] sim800: add udev detection.
Date: Wed, 07 Nov 2018 15:00:27 +0100
Message-ID: <1541599227-3084-3-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5326491358948107672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff6e1fc..d0a849d 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1308,6 +1308,7 @@ static struct {
 	{ "calypso",	setup_serial_modem	},
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
+	{ "sim800",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
-- =

2.7.4


--===============5326491358948107672==--

