Content-Type: multipart/mixed; boundary="===============6624304576495212003=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] hfp_hf_bluez5: Fix not considering that UUIDs change after
 creation
Date: Thu, 18 Apr 2013 14:50:38 -0300
Message-ID: <1366307438-19867-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6624304576495212003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For example, in the case of a incoming connection the device may be
created without UUIDs and the property changed is emitted later.
---
 plugins/hfp_hf_bluez5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2c67a21..2b9275b 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -744,7 +744,8 @@ static void property_changed(GDBusProxy *proxy, const c=
har *name,
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	if (g_str_equal("Paired", name) !=3D TRUE)
+	if (g_str_equal("Paired", name) !=3D TRUE &&
+					g_str_equal("UUIDs", name) !=3D TRUE)
 		return;
 =

 	modem_register_from_proxy(proxy, path);
-- =

1.8.2.1


--===============6624304576495212003==--

