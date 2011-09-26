Content-Type: multipart/mixed; boundary="===============1291151852358142773=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 22/23] telit: add needed flags to proper connect the
 serial port
Date: Mon, 26 Sep 2011 14:27:15 -0300
Message-ID: <1317058036-32641-22-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317058036-32641-21-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1291151852358142773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 plugins/telit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 0c8061f..467a7b6 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -350,6 +350,8 @@ static int telit_sap_open(struct ofono_modem *modem)
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


--===============1291151852358142773==--

