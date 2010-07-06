Content-Type: multipart/mixed; boundary="===============2995676767168338107=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] test-server: Use cfmakeraw to set TTY raw mode
Date: Tue, 06 Jul 2010 14:23:06 +0800
Message-ID: <1278397386-29822-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2995676767168338107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use cfmakeraw to disable echoing and special characters processing. If
we don't turn off ICRNL, TTY layer translates \r\n to \n\n.
---
 gatchat/test-server.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 25a1192..2911978 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -848,12 +848,10 @@ static void set_raw_mode(int fd)
 {
 	struct termios options;
 =

+	memset(&options, 0, sizeof(struct termios));
 	tcgetattr(fd, &options);
-
-	/* Set TTY as raw mode to disable echo back of input characters
-	 * when they are received from Modem to avoid feedback loop */
-	options.c_lflag &=3D ~(ICANON | ECHO | ECHOE | ISIG);
-
+	tcflush(fd, TCIOFLUSH);
+	cfmakeraw(&options);
 	tcsetattr(fd, TCSANOW, &options);
 }
 =

-- =

1.6.3.3


--===============2995676767168338107==--

