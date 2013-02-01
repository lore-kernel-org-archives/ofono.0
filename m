Content-Type: multipart/mixed; boundary="===============8064294323611414504=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] hfp_hf_bluez5: Remove unneeded modem hash lookup
Date: Fri, 01 Feb 2013 10:24:30 -0300
Message-ID: <1359725070-11626-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8064294323611414504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modem object is created when the Device Proxy is added, and it is
paired. Another path is when the Device "Paired" property changes
to True.
---
 plugins/hfp_hf_bluez5.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2f4a89e..543bf0f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -166,10 +166,6 @@ static struct ofono_modem *modem_register(const char *=
device,
 	struct ofono_modem *modem;
 	char *path;
 =

-	modem =3D g_hash_table_lookup(modem_hash, device);
-	if (modem !=3D NULL)
-		return modem;
-
 	path =3D g_strconcat("hfp", device, NULL);
 =

 	modem =3D ofono_modem_create(path, "hfp");
-- =

1.7.11.7


--===============8064294323611414504==--

