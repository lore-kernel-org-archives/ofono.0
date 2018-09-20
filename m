Content-Type: multipart/mixed; boundary="===============0888667796852666451=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] mbim driver: call the release function in case MBIM OPEN fails
Date: Thu, 20 Sep 2018 06:47:42 +0200
Message-ID: <1537418862-24984-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0888667796852666451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbimmodem/mbim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mbimmodem/mbim.c b/drivers/mbimmodem/mbim.c
index 9fcf44b..f4132d0 100644
--- a/drivers/mbimmodem/mbim.c
+++ b/drivers/mbimmodem/mbim.c
@@ -781,6 +781,9 @@ static bool open_read_handler(struct l_io *io, void *us=
er_data)
 	/* Grab OPEN_DONE Status field */
 	if (l_get_le32(buf) !=3D 0) {
 		close(fd);
+		if (device->disconnect_handler)
+			device->disconnect_handler(device->ready_data);
+		device->is_ready =3D false;
 		return false;
 	}
 =

-- =

1.9.1


--===============0888667796852666451==--

