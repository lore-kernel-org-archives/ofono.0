Content-Type: multipart/mixed; boundary="===============0458848037447154048=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Mon, 22 Apr 2013 19:53:44 -0300
Message-ID: <1366671224-8777-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0458848037447154048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Even for outgoing pairing requests we may receive the UUIDs property
changed after the device is paired and try to register it twice.

The easiest way to reproduce this is when Extended Inquiry Response is
supported.

When the device is paired, we receive the "Paired" PropertyChanged,
inside modem_register_from_proxy(), g_dbus_proxy_get_property() gets
the UUIDs extracted from the EIR data.  Later, when the service
discovery is finished, the UUIDs property is re-sent and both may
contain the HFP AG UUID.

Valgrind log:

ofonod[8157]: src/modem.c:ofono_modem_create() name: hfp/org/bluez/hci0/dev=
_40_98_4E_32_D7_39, type: hfp
ofonod[8157]: src/modem.c:set_modem_property() modem 0x66a2db0 property Rem=
ote
ofonod[8157]: src/modem.c:set_modem_property() modem 0x66a2db0 property Dev=
icePath
ofonod[8157]: src/modem.c:ofono_modem_register() 0x66a2db0
ofonod[8157]: plugins/hfp_hf_bluez5.c:hfp_probe() modem: 0x66a2db0
ofonod[8157]: Modem register failed on path /hfp/org/bluez/hci0/dev_40_98_4=
E_32_D7_39
ofonod[8157]: plugins/hfp_hf_bluez5.c:hfp_remove() modem: 0x66a2db0
ofonod[8157]: plugins/hfp_hf_bluez5.c:profile_new_connection() Profile hand=
ler NewConnection
ofonod[8157]: src/modem.c:get_modem_property() modem 0x66a2db0 property Dev=
icePath
=3D=3D8157=3D=3D Invalid write of size 4
=3D=3D8157=3D=3D    at 0x4712A5: hfp_slc_info_init (slc.c:59)
=3D=3D8157=3D=3D    by 0x486B00: profile_new_connection (hfp_hf_bluez5.c:16=
8)
=3D=3D8157=3D=3D    by 0x412C70: process_message.isra.4 (object.c:258)
=3D=3D8157=3D=3D    by 0x5381984: _dbus_object_tree_dispatch_and_unlock (in=
 /usr/lib64/libdbus-1.so.3.7.2)
=3D=3D8157=3D=3D    by 0x5373C4F: dbus_connection_dispatch (in /usr/lib64/l=
ibdbus-1.so.3.7.2)
=3D=3D8157=3D=3D    by 0x4107B7: message_dispatch (mainloop.c:76)
=3D=3D8157=3D=3D    by 0x5089BCA: g_timeout_dispatch (in /usr/lib64/libglib=
-2.0.so.0.3400.2)
=3D=3D8157=3D=3D    by 0x5089044: g_main_context_dispatch (in /usr/lib64/li=
bglib-2.0.so.0.3400.2)
=3D=3D8157=3D=3D    by 0x5089377: g_main_context_iterate.isra.24 (in /usr/l=
ib64/libglib-2.0.so.0.3400.2)
=3D=3D8157=3D=3D    by 0x5089771: g_main_loop_run (in /usr/lib64/libglib-2.=
0.so.0.3400.2)
=3D=3D8157=3D=3D    by 0x41042B: main (main.c:249)
=3D=3D8157=3D=3D  Address 0x8 is not stack'd, malloc'd or (recently) free'd
=3D=3D8157=3D=3D
---
 plugins/hfp_hf_bluez5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 2b9275b..86d8c72 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -713,6 +713,12 @@ static void modem_register_from_proxy(GDBusProxy *prox=
y, const char *path)
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
 		return;
 =

+	modem =3D ofono_modem_find(device_path_compare, (void *) path);
+	if (modem) {
+		DBG("Modem for device %s already registered", path);
+		return;
+	}
+
 	dbus_message_iter_get_basic(&iter, &remote);
 =

 	modem =3D modem_register(path, remote, alias);
-- =

1.8.2.1


--===============0458848037447154048==--

