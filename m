Content-Type: multipart/mixed; boundary="===============3032094513609923103=="
MIME-Version: 1.0
From: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH 2/2] telit: Fix empty parameter list in function
Date: Fri, 30 Dec 2011 03:30:34 +0530
Message-ID: <1325196035-10461-3-git-send-email-syamsidhardh@gmail.com>
In-Reply-To: <1325196035-10461-1-git-send-email-syamsidhardh@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3032094513609923103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/telit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/telit.c b/plugins/telit.c
index 48087f2..6ae7249 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -436,7 +436,7 @@ static void rsen_disable_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	telit_disable(modem);
 }
 =

-static int telit_sap_open()
+static int telit_sap_open(void)
 {
 	const char *device =3D "/dev/ttyUSB4";
 	struct termios ti;
-- =

1.7.4.1


--===============3032094513609923103==--

