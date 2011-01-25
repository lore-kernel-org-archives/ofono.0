Content-Type: multipart/mixed; boundary="===============3468691763793666705=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: [PATCH 1/1] isimodem: Adding version isimodem and isimodem2.5
Date: Tue, 25 Jan 2011 13:10:22 +0100
Message-ID: <1295957422-28723-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3468691763793666705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding a version enum to differentiate between isimodem2.0 and isimodem2.5.

Needed for isimodem2.5 patches planned to follow shortly.

Best Regards,
Jessica


---
 drivers/isimodem/isimodem.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/isimodem/isimodem.h b/drivers/isimodem/isimodem.h
index 37191c7..a2a827d 100644
--- a/drivers/isimodem/isimodem.h
+++ b/drivers/isimodem/isimodem.h
@@ -19,6 +19,11 @@
  *
  */
 =

+enum isi_version {
+	ISI_20 =3D 0,
+	ISI_25 =3D 1
+};
+
 extern struct ofono_modem *isi_modem_by_interface(char const *ifname);
 =

 extern void isi_phonebook_init(void);
-- =

1.7.3.2


--===============3468691763793666705==--

