Content-Type: multipart/mixed; boundary="===============8594043421608044401=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] udev: Add check for serial before string operation
Date: Fri, 20 Aug 2010 11:10:39 +0800
Message-ID: <1282273839-4990-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8594043421608044401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

'serial' could be NULL in some case. So it need to add check before
doing string operation.
---
 plugins/udev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 84399de..6720a0c 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -86,7 +86,7 @@ static const char *get_serial(struct udev_device *udev_de=
vice)
 		entry =3D udev_list_entry_get_next(entry);
 	}
 =

-	if (strpbrk(serial, ".-_?*") !=3D NULL)
+	if (serial && strpbrk(serial, ".-_?*") !=3D NULL)
 		return NULL;
 =

 	return serial;
-- =

1.7.0.4


--===============8594043421608044401==--

