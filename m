Content-Type: multipart/mixed; boundary="===============4760848801196707465=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 3/3] sim800: add udev detection
Date: Wed, 03 Oct 2018 15:28:23 +0200
Message-ID: <1538573303-4560-3-git-send-email-vielclement@gmail.com>
In-Reply-To: <1538573303-4560-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4760848801196707465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3c39e68..202519e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1300,6 +1300,7 @@ static struct {
 	{ "calypso",	setup_serial_modem	},
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
+	{ "sim800",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
-- =

2.7.4


--===============4760848801196707465==--

