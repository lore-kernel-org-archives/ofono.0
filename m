Content-Type: multipart/mixed; boundary="===============5045079110297225944=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 17/21] telit: add needed flags to proper connect the
 serial port
Date: Tue, 27 Sep 2011 18:04:16 -0300
Message-ID: <1317157460-17012-17-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-16-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5045079110297225944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 7674b09..404f74e 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -350,6 +350,8 @@ static int telit_sap_open()
 	memset(&ti, 0, sizeof(ti));
 	cfmakeraw(&ti);
 =

+	ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
+
 	tcflush(fd, TCIOFLUSH);
 	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
 		close(fd);
-- =

1.7.6.2


--===============5045079110297225944==--

