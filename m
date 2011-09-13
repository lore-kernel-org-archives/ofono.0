Content-Type: multipart/mixed; boundary="===============6256276868200283447=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v2 22/24] telit: add needed flags to proper connect the
 serial port
Date: Tue, 13 Sep 2011 15:58:30 -0300
Message-ID: <1315940312-1238-22-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1315940312-1238-21-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6256276868200283447==
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


--===============6256276868200283447==--

