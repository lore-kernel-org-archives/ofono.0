Content-Type: multipart/mixed; boundary="===============2987302810570413009=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: [PATCH 2/3] sim800: adding udev detection
Date: Tue, 25 Sep 2018 00:43:29 +0200
Message-ID: <1537829010-15668-2-git-send-email-vielclement@gmail.com>
In-Reply-To: <1537829010-15668-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2987302810570413009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: clem <vielclement@gmail.com>

---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 02d049e..3f019b8 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1300,6 +1300,7 @@ static struct {
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
+	{ "sim800",	setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
-- =

2.7.4


--===============2987302810570413009==--

