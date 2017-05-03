Content-Type: multipart/mixed; boundary="===============8373510431751844465=="
MIME-Version: 1.0
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v4 3/5] hfp_hf_bluez5: Handle ServicesResolved signal
Date: Wed, 03 May 2017 16:10:53 +0300
Message-ID: <20170503131055.9652-3-luiz.dentz@gmail.com>
In-Reply-To: <20170503131055.9652-1-luiz.dentz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8373510431751844465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handling for ServicesResolved signal which tells when BlueZ
is done resolving the device services so the code will no longer ignore
devices that got its services resolved after Paired signal.
---
 plugins/hfp_hf_bluez5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 6e4e499..c04d740 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -815,7 +815,8 @@ static void property_changed(GDBusProxy *proxy, const c=
har *name,
 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	if (g_str_equal("Paired", name) !=3D TRUE)
+	if (g_str_equal("Paired", name) !=3D TRUE &&
+			g_str_equal("ServicesResolved", name) !=3D TRUE)
 		return;
 =

 	device_changed(proxy, path);
-- =

2.9.3


--===============8373510431751844465==--

