Content-Type: multipart/mixed; boundary="===============4594929458631434997=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] gprs: fix seg fault in case of NULL callback
Date: Mon, 01 Oct 2018 11:49:13 +0530
Message-ID: <1538374753-8613-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4594929458631434997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of AT callback if callback handler is NULL, check for null
before calling the success macro.

Logs:
ofonod[32496]: src/network.c:current_operator_callback() 0x157ad60, (nil)
ofonod[32496]: src/gprs.c:netreg_status_changed() 0
ofonod[32496]: src/gprs.c:gprs_netreg_update() attach: 0, driver_attached: 1
ofonod[32496]: src/gprs.c:ofono_gprs_detached_notify() /xmm7xxx_0
ofonod[32496]: drivers/ifxmodem/gprs-context.c:ifx_gprs_detach_shutdown()
ofonod[32496]: drivers/ifxmodem/gprs-context.c:ifx_gprs_deactivate_primary(=
) cid 0
ofonod[32496]: src/gprs.c:ofono_gprs_detached_notify() /xmm7xxx_0
ofonod[32496]: src/gprs.c:gprs_attach_callback() /xmm7xxx_0 error =3D 0
ofonod[32496]: drivers/ifxmodem/gprs-context.c:deactivate_cb() ok 0
ofonod[32496]: Aborting (signal 11) [./../src/ofonod]
ofonod[32496]: ++++++++ backtrace ++++++++
ofonod[32496]: +++++++++++++++++++++++++++
---
 drivers/ifxmodem/gprs-context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 43e81c5..885e41b 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -514,6 +514,9 @@ static void deactivate_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	if (gcd->vendor !=3D OFONO_VENDOR_XMM)
 		g_at_chat_resume(gcd->chat);
 =

+	if (!gcd->cb)
+		return;
+
 	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

-- =

2.7.4


--===============4594929458631434997==--

