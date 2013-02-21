Content-Type: multipart/mixed; boundary="===============5449335905851188809=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] hfpmodem: Fix segfault in CIEV GAtChat callback
Date: Thu, 21 Feb 2013 19:24:42 -0300
Message-ID: <1361485482-3235-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5449335905851188809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixes segmentation fault when the network registration
watch is called without being initialized. CIEV GAtChat callback can
be called before ofono_netreg_register().

=3D=3D15101=3D=3D Invalid read of size 8
=3D=3D15101=3D=3D    at 0x492B56: ofono_netreg_register (network.c:2073)
=3D=3D15101=3D=3D    by 0x47245E: hfp_netreg_probe (network-registration.c:=
311)
=3D=3D15101=3D=3D    by 0x492A8D: ofono_netreg_create (network.c:1881)
=3D=3D15101=3D=3D    by 0x4849D5: hfp_pre_sim (hfp_hf_bluez5.c:288)
=3D=3D15101=3D=3D    by 0x48C486: ofono_modem_set_powered (modem.c:1194)
=3D=3D15101=3D=3D    by 0x484E9D: slc_established (hfp_hf_bluez5.c:85)
=3D=3D15101=3D=3D    by 0x4702AD: chld_cb (slc.c:147)
=3D=3D15101=3D=3D    by 0x440457: at_chat_finish_command (gatchat.c:461)
=3D=3D15101=3D=3D    by 0x44109F: new_bytes (gatchat.c:532)
=3D=3D15101=3D=3D    by 0x4433B7: received_data (gatio.c:122)
=3D=3D15101=3D=3D    by 0x3CBAA47824: g_main_context_dispatch (gmain.c:2539)
=3D=3D15101=3D=3D    by 0x3CBAA47B57: g_main_context_iterate.isra.23
(gmain.c:3146)
=3D=3D15101=3D=3D  Address 0x18 is not stack'd, malloc'd or (recently) free=
'd
---
 drivers/hfpmodem/network-registration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
index 4b9f875..5a5e1f7 100644
--- a/drivers/hfpmodem/network-registration.c
+++ b/drivers/hfpmodem/network-registration.c
@@ -304,6 +304,9 @@ static gboolean hfp_netreg_register(gpointer user_data)
 =

 	ofono_netreg_register(netreg);
 =

+	g_at_chat_register(nd->chat, "+CIEV:", ciev_notify, FALSE,
+							netreg, NULL);
+
 	return FALSE;
 }
 =

@@ -321,9 +324,6 @@ static int hfp_netreg_probe(struct ofono_netreg *netreg=
, unsigned int vendor,
 =

 	ofono_netreg_set_data(netreg, nd);
 =

-	g_at_chat_register(nd->chat, "+CIEV:", ciev_notify, FALSE,
-				netreg, NULL);
-
 	nd->register_source =3D g_idle_add(hfp_netreg_register, netreg);
 =

 	return 0;
-- =

1.7.11.7


--===============5449335905851188809==--

