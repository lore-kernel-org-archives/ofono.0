Content-Type: multipart/mixed; boundary="===============7279451945817196155=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH] udev: Fix warning in compilation
Date: Tue, 21 Dec 2010 11:03:19 +0200
Message-ID: <1292922199-20434-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7279451945817196155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udev.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 837ee9c..3ca6af0 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -452,7 +452,6 @@ static void add_isi(struct ofono_modem *modem,
 static void add_calypso(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
-	struct udev_list_entry *entry;
 	const char *devnode;
 =

 	DBG("modem %p", modem);
-- =

1.7.1


--===============7279451945817196155==--

