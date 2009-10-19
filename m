Content-Type: multipart/mixed; boundary="===============4664324809779182614=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: [PATCH] When setting the serial port,
 the previous settings need to  be preserved.
Date: Mon, 19 Oct 2009 19:18:38 +0200
Message-ID: <632f5f310910191018k2e122a0bi915e7f6ffbfe5cd6@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4664324809779182614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When setting the serial terminal before starting the daemon, this will
prevent the overwriting of settings.

Ryan

---
 gatchat/gattty.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gattty.c b/gatchat/gattty.c
index 63d26d4..ed0fadf 100644
--- a/gatchat/gattty.c
+++ b/gatchat/gattty.c
@@ -220,6 +220,7 @@ static int open_device(const char *tty, GHashTable *opt=
ions)
 	if (fd < 0)
 		return -1;

+	tcgetattr(fd,&ti);
 	tcflush(fd, TCIOFLUSH);
 	tcsetattr(fd, TCSANOW, &ti);

-- =

1.6.4.GIT

--===============4664324809779182614==--

