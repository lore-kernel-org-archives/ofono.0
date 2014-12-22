Content-Type: multipart/mixed; boundary="===============6455532666249481965=="
MIME-Version: 1.0
From: You-Sheng Yang <vicamo@gmail.com>
Subject: [PATCH 1/3] build: sort Makefile assignment list entries
Date: Tue, 23 Dec 2014 00:07:46 +0800
Message-ID: <1419264468-22351-1-git-send-email-vicamo@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6455532666249481965==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sort Makefile assignment list entries so that it's easier to track
what's added, removed, or missing.

Signed-off-by: You-Sheng Yang <vicamo@gmail.com>

diff --git a/Makefile.am b/Makefile.am
index 22249c4..6729e9b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,34 +1,58 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

 noinst_LTLIBRARIES =3D
 =

-pkginclude_HEADERS =3D include/log.h include/plugin.h include/history.h \
-			include/dbus.h include/modem.h include/types.h \
-			include/call-barring.h include/call-forwarding.h \
-			include/call-meter.h include/call-settings.h \
-			include/phonebook.h include/ussd.h \
-			include/sms.h include/sim.h include/message-waiting.h \
-			include/netreg.h include/voicecall.h include/devinfo.h \
-			include/cbs.h include/call-volume.h \
-			include/gprs.h include/gprs-context.h \
-			include/radio-settings.h include/stk.h \
-			include/audio-settings.h include/nettime.h \
-			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h include/sim-auth.h \
-			include/gprs-provision.h include/emulator.h \
-			include/location-reporting.h \
-			include/cdma-connman.h include/gnss.h \
-			include/private-network.h include/cdma-netreg.h \
-			include/cdma-provision.h include/handsfree.h \
-			include/handsfree-audio.h include/siri.h
-
-nodist_pkginclude_HEADERS =3D include/version.h
+pkginclude_HEADERS =3D \
+	include/audio-settings.h \
+	include/call-barring.h \
+	include/call-forwarding.h \
+	include/call-meter.h \
+	include/call-settings.h \
+	include/call-volume.h \
+	include/cbs.h \
+	include/cdma-connman.h \
+	include/cdma-netreg.h \
+	include/cdma-provision.h \
+	include/cdma-sms.h \
+	include/cdma-voicecall.h \
+	include/ctm.h \
+	include/dbus.h \
+	include/devinfo.h \
+	include/emulator.h \
+	include/gnss.h \
+	include/gprs-context.h \
+	include/gprs-provision.h \
+	include/gprs.h \
+	include/handsfree-audio.h \
+	include/handsfree.h \
+	include/history.h \
+	include/location-reporting.h \
+	include/log.h \
+	include/message-waiting.h \
+	include/modem.h \
+	include/netreg.h \
+	include/nettime.h \
+	include/phonebook.h \
+	include/plugin.h \
+	include/private-network.h \
+	include/radio-settings.h \
+	include/sim-auth.h \
+	include/sim.h \
+	include/siri.h \
+	include/sms.h \
+	include/stk.h \
+	include/types.h \
+	include/ussd.h \
+	include/voicecall.h
+
+nodist_pkginclude_HEADERS =3D \
+	include/version.h
 =

 local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
 				$(nodist_pkginclude_HEADERS), \
 					include/ofono/$(notdir $(file)))
 =

 pkgconfigdir =3D $(libdir)/pkgconfig
 pkgconfig_DATA =3D ofono.pc
 =

@@ -55,302 +79,361 @@ endif
 =

 builtin_modules =3D
 builtin_sources =3D
 builtin_libadd =3D
 builtin_cflags =3D
 =

 noinst_LTLIBRARIES +=3D gdbus/libgdbus-internal.la
 =

-gdbus_libgdbus_internal_la_SOURCES =3D gdbus/gdbus.h \
-				gdbus/mainloop.c gdbus/watch.c \
-				gdbus/object.c gdbus/client.c gdbus/polkit.c
-
-gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
-				gatchat/gatresult.h gatchat/gatresult.c \
-				gatchat/gatsyntax.h gatchat/gatsyntax.c \
-				gatchat/ringbuffer.h gatchat/ringbuffer.c \
-				gatchat/gatio.h	gatchat/gatio.c \
-				gatchat/crc-ccitt.h gatchat/crc-ccitt.c \
-				gatchat/gatmux.h gatchat/gatmux.c \
-				gatchat/gsm0710.h gatchat/gsm0710.c \
-				gatchat/gattty.h gatchat/gattty.c \
-				gatchat/gatutil.h gatchat/gatutil.c \
-				gatchat/gat.h \
-				gatchat/gatserver.h gatchat/gatserver.c \
-				gatchat/gatrawip.h gatchat/gatrawip.c \
-				gatchat/gathdlc.c gatchat/gathdlc.h \
-				gatchat/gatppp.c gatchat/gatppp.h \
-				gatchat/ppp.h gatchat/ppp_cp.h \
-				gatchat/ppp_cp.c gatchat/ppp_lcp.c \
-				gatchat/ppp_auth.c gatchat/ppp_net.c \
-				gatchat/ppp_ipcp.c gatchat/ppp_ipv6cp.c
-
-gisi_sources =3D gisi/client.c gisi/client.h gisi/common.h \
-				gisi/iter.c gisi/iter.h \
-				gisi/message.c gisi/message.h \
-				gisi/modem.c gisi/modem.h \
-				gisi/netlink.c gisi/netlink.h \
-				gisi/pep.c gisi/pep.h \
-				gisi/phonet.h \
-				gisi/pipe.c gisi/pipe.h \
-				gisi/server.c gisi/server.h \
-				gisi/socket.c gisi/socket.h
-
-btio_sources =3D btio/btio.h btio/btio.c
+gdbus_libgdbus_internal_la_SOURCES =3D \
+	gdbus/client.c \
+	gdbus/gdbus.h \
+	gdbus/mainloop.c \
+	gdbus/object.c \
+	gdbus/polkit.c \
+	gdbus/watch.c
+
+gatchat_sources =3D \
+	gatchat/crc-ccitt.c \
+	gatchat/crc-ccitt.h \
+	gatchat/gat.h \
+	gatchat/gatchat.c \
+	gatchat/gatchat.h \
+	gatchat/gathdlc.c \
+	gatchat/gathdlc.h \
+	gatchat/gatio.c \
+	gatchat/gatio.h \
+	gatchat/gatmux.c \
+	gatchat/gatmux.h \
+	gatchat/gatppp.c \
+	gatchat/gatppp.h \
+	gatchat/gatrawip.c \
+	gatchat/gatrawip.h \
+	gatchat/gatresult.c \
+	gatchat/gatresult.h \
+	gatchat/gatserver.c \
+	gatchat/gatserver.h \
+	gatchat/gatsyntax.c \
+	gatchat/gatsyntax.h \
+	gatchat/gattty.c \
+	gatchat/gattty.h \
+	gatchat/gatutil.c \
+	gatchat/gatutil.h \
+	gatchat/gsm0710.c \
+	gatchat/gsm0710.h \
+	gatchat/ppp.h \
+	gatchat/ppp_auth.c \
+	gatchat/ppp_cp.c \
+	gatchat/ppp_cp.h \
+	gatchat/ppp_ipcp.c \
+	gatchat/ppp_ipv6cp.c \
+	gatchat/ppp_lcp.c \
+	gatchat/ppp_net.c \
+	gatchat/ringbuffer.c \
+	gatchat/ringbuffer.h
+
+gisi_sources =3D \
+	gisi/client.c \
+	gisi/client.h \
+	gisi/common.h \
+	gisi/iter.c \
+	gisi/iter.h \
+	gisi/message.c \
+	gisi/message.h \
+	gisi/modem.c \
+	gisi/modem.h \
+	gisi/netlink.c \
+	gisi/netlink.h \
+	gisi/pep.c \
+	gisi/pep.h \
+	gisi/phonet.h \
+	gisi/pipe.c \
+	gisi/pipe.h \
+	gisi/server.c \
+	gisi/server.h \
+	gisi/socket.c \
+	gisi/socket.h
+
+btio_sources =3D \
+	btio/btio.c \
+	btio/btio.h
 =

 if UDEV
 builtin_modules +=3D udev
 builtin_sources +=3D plugins/udev.c
 builtin_cflags +=3D @UDEV_CFLAGS@
 builtin_libadd +=3D @UDEV_LIBS@
 =

 builtin_modules +=3D udevng
 builtin_sources +=3D plugins/udevng.c
 endif
 =

 if ISIMODEM
 builtin_modules +=3D isimodem
-builtin_sources +=3D $(gisi_sources) \
-			drivers/isimodem/isimodem.h \
-			drivers/isimodem/isimodem.c \
-			drivers/isimodem/mtc.h \
-			drivers/isimodem/debug.h \
-			drivers/isimodem/isiutil.h \
-			drivers/isimodem/debug.c \
-			drivers/isimodem/phonebook.c \
-			drivers/isimodem/devinfo.c \
-			drivers/isimodem/info.h \
-			drivers/isimodem/network-registration.c \
-			drivers/isimodem/network.h \
-			drivers/isimodem/infoserver.h \
-			drivers/isimodem/infoserver.c \
-			drivers/isimodem/voicecall.c \
-			drivers/isimodem/call.h \
-			drivers/isimodem/sms.c \
-			drivers/isimodem/sms.h \
-			drivers/isimodem/cbs.c \
-			drivers/isimodem/sim.c \
-			drivers/isimodem/sim.h \
-			drivers/isimodem/ussd.c \
-			drivers/isimodem/call-forwarding.c \
-			drivers/isimodem/call-settings.c \
-			drivers/isimodem/call-barring.c \
-			drivers/isimodem/call-meter.c \
-			drivers/isimodem/ss.h \
-			drivers/isimodem/radio-settings.c \
-			drivers/isimodem/gss.h \
-			drivers/isimodem/gprs.c \
-			drivers/isimodem/gprs-context.c \
-			drivers/isimodem/gpds.h \
-			drivers/isimodem/audio-settings.c \
-			drivers/isimodem/uicc.h \
-			drivers/isimodem/uicc.c \
-			drivers/isimodem/uicc-util.h \
-			drivers/isimodem/uicc-util.c
+builtin_sources +=3D \
+	$(gisi_sources) \
+	drivers/isimodem/audio-settings.c \
+	drivers/isimodem/call-barring.c \
+	drivers/isimodem/call-forwarding.c \
+	drivers/isimodem/call-meter.c \
+	drivers/isimodem/call-settings.c \
+	drivers/isimodem/call.h \
+	drivers/isimodem/cbs.c \
+	drivers/isimodem/debug.c \
+	drivers/isimodem/debug.h \
+	drivers/isimodem/devinfo.c \
+	drivers/isimodem/gpds.h \
+	drivers/isimodem/gprs-context.c \
+	drivers/isimodem/gprs.c \
+	drivers/isimodem/gss.h \
+	drivers/isimodem/info.h \
+	drivers/isimodem/infoserver.c \
+	drivers/isimodem/infoserver.h \
+	drivers/isimodem/isimodem.c \
+	drivers/isimodem/isimodem.h \
+	drivers/isimodem/isiutil.h \
+	drivers/isimodem/mtc.h \
+	drivers/isimodem/network-registration.c \
+	drivers/isimodem/network.h \
+	drivers/isimodem/phonebook.c \
+	drivers/isimodem/radio-settings.c \
+	drivers/isimodem/sim.c \
+	drivers/isimodem/sim.h \
+	drivers/isimodem/sms.c \
+	drivers/isimodem/sms.h \
+	drivers/isimodem/ss.h \
+	drivers/isimodem/uicc-util.c \
+	drivers/isimodem/uicc-util.h \
+	drivers/isimodem/uicc.c \
+	drivers/isimodem/uicc.h \
+	drivers/isimodem/ussd.c \
+	drivers/isimodem/voicecall.c
 =

 builtin_modules +=3D isiusb
 builtin_sources +=3D plugins/isiusb.c
 =

 builtin_modules +=3D n900
-builtin_sources +=3D plugins/n900.c plugins/nokia-gpio.h plugins/nokia-gpi=
o.c
+builtin_sources +=3D \
+	plugins/n900.c \
+	plugins/nokia-gpio.c \
+	plugins/nokia-gpio.h
 =

 builtin_modules +=3D u8500
 builtin_sources +=3D plugins/u8500.c
 endif
 =

 if QMIMODEM
-qmi_sources =3D drivers/qmimodem/qmi.h drivers/qmimodem/qmi.c \
-					drivers/qmimodem/ctl.h \
-					drivers/qmimodem/dms.h \
-					drivers/qmimodem/nas.h \
-					drivers/qmimodem/uim.h \
-					drivers/qmimodem/wms.h \
-					drivers/qmimodem/wds.h \
-					drivers/qmimodem/pds.h \
-					drivers/qmimodem/common.h
+qmi_sources =3D \
+	drivers/qmimodem/common.h \
+	drivers/qmimodem/ctl.h \
+	drivers/qmimodem/dms.h \
+	drivers/qmimodem/nas.h \
+	drivers/qmimodem/pds.h \
+	drivers/qmimodem/qmi.c \
+	drivers/qmimodem/qmi.h \
+	drivers/qmimodem/uim.h \
+	drivers/qmimodem/wds.h \
+	drivers/qmimodem/wms.h
 =

 builtin_modules +=3D qmimodem
-builtin_sources +=3D $(qmi_sources) \
-			drivers/qmimodem/util.h \
-			drivers/qmimodem/qmimodem.h \
-			drivers/qmimodem/qmimodem.c \
-			drivers/qmimodem/devinfo.c \
-			drivers/qmimodem/voicecall.c \
-			drivers/qmimodem/network-registration.c \
-			drivers/qmimodem/sim-legacy.c \
-			drivers/qmimodem/sim.c \
-			drivers/qmimodem/sms.c \
-			drivers/qmimodem/ussd.c \
-			drivers/qmimodem/gprs.c \
-			drivers/qmimodem/gprs-context.c \
-			drivers/qmimodem/radio-settings.c \
-			drivers/qmimodem/location-reporting.c
+builtin_sources +=3D \
+	$(qmi_sources) \
+	drivers/qmimodem/devinfo.c \
+	drivers/qmimodem/gprs-context.c \
+	drivers/qmimodem/gprs.c \
+	drivers/qmimodem/location-reporting.c \
+	drivers/qmimodem/network-registration.c \
+	drivers/qmimodem/qmimodem.c \
+	drivers/qmimodem/qmimodem.h \
+	drivers/qmimodem/radio-settings.c \
+	drivers/qmimodem/sim-legacy.c \
+	drivers/qmimodem/sim.c \
+	drivers/qmimodem/sms.c \
+	drivers/qmimodem/ussd.c \
+	drivers/qmimodem/util.h \
+	drivers/qmimodem/voicecall.c
 =

 builtin_modules +=3D gobi
 builtin_sources +=3D plugins/gobi.c
 endif
 =

 if ATMODEM
 builtin_modules +=3D atmodem
-builtin_sources +=3D $(gatchat_sources) \
-			drivers/atmodem/atmodem.h \
-			drivers/atmodem/atmodem.c \
-			drivers/atmodem/call-settings.c \
-			drivers/atmodem/sms.c \
-			drivers/atmodem/cbs.c \
-			drivers/atmodem/call-forwarding.c \
-			drivers/atmodem/call-meter.c \
-			drivers/atmodem/network-registration.c \
-			drivers/atmodem/sim.c \
-			drivers/atmodem/stk.c \
-			drivers/atmodem/stk.h \
-			drivers/atmodem/ussd.c \
-			drivers/atmodem/voicecall.c \
-			drivers/atmodem/call-barring.c \
-			drivers/atmodem/phonebook.c \
-			drivers/atmodem/devinfo.c \
-			drivers/atmodem/call-volume.c \
-			drivers/atmodem/vendor.h \
-			drivers/atmodem/atutil.h \
-			drivers/atmodem/atutil.c \
-			drivers/atmodem/gprs.c \
-			drivers/atmodem/gprs-context.c \
-			drivers/atmodem/sim-auth.c \
-			drivers/atmodem/gnss.c
+builtin_sources +=3D \
+	$(gatchat_sources) \
+	drivers/atmodem/atmodem.c \
+	drivers/atmodem/atmodem.h \
+	drivers/atmodem/atutil.c \
+	drivers/atmodem/atutil.h \
+	drivers/atmodem/call-barring.c \
+	drivers/atmodem/call-forwarding.c \
+	drivers/atmodem/call-meter.c \
+	drivers/atmodem/call-settings.c \
+	drivers/atmodem/call-volume.c \
+	drivers/atmodem/cbs.c \
+	drivers/atmodem/devinfo.c \
+	drivers/atmodem/gnss.c \
+	drivers/atmodem/gprs-context.c \
+	drivers/atmodem/gprs.c \
+	drivers/atmodem/network-registration.c \
+	drivers/atmodem/phonebook.c \
+	drivers/atmodem/sim-auth.c \
+	drivers/atmodem/sim.c \
+	drivers/atmodem/sms.c \
+	drivers/atmodem/stk.c \
+	drivers/atmodem/stk.h \
+	drivers/atmodem/ussd.c \
+	drivers/atmodem/vendor.h \
+	drivers/atmodem/voicecall.c
 =

 builtin_modules +=3D nwmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/nwmodem/nwmodem.h \
-			drivers/nwmodem/nwmodem.c \
-			drivers/nwmodem/radio-settings.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/nwmodem/nwmodem.c \
+	drivers/nwmodem/nwmodem.h \
+	drivers/nwmodem/radio-settings.c
 =

 builtin_modules +=3D swmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/swmodem/swmodem.h \
-			drivers/swmodem/swmodem.c \
-			drivers/swmodem/gprs-context.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/swmodem/gprs-context.c \
+	drivers/swmodem/swmodem.c \
+	drivers/swmodem/swmodem.h
 =

 builtin_modules +=3D ztemodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/ztemodem/ztemodem.h \
-			drivers/ztemodem/ztemodem.c \
-			drivers/ztemodem/radio-settings.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/ztemodem/radio-settings.c \
+	drivers/ztemodem/ztemodem.c \
+	drivers/ztemodem/ztemodem.h
 =

 builtin_modules +=3D iceramodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/iceramodem/iceramodem.h \
-			drivers/iceramodem/iceramodem.c \
-			drivers/iceramodem/gprs-context.c \
-			drivers/iceramodem/radio-settings.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/iceramodem/gprs-context.c \
+	drivers/iceramodem/iceramodem.c \
+	drivers/iceramodem/iceramodem.h \
+	drivers/iceramodem/radio-settings.c
 =

 builtin_modules +=3D huaweimodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/huaweimodem/huaweimodem.h \
-			drivers/huaweimodem/huaweimodem.c \
-			drivers/huaweimodem/ussd.c \
-			drivers/huaweimodem/voicecall.c \
-			drivers/huaweimodem/audio-settings.c \
-			drivers/huaweimodem/gprs-context.c \
-			drivers/huaweimodem/radio-settings.c \
-			drivers/huaweimodem/cdma-netreg.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/huaweimodem/audio-settings.c \
+	drivers/huaweimodem/cdma-netreg.c \
+	drivers/huaweimodem/gprs-context.c \
+	drivers/huaweimodem/huaweimodem.c \
+	drivers/huaweimodem/huaweimodem.h \
+	drivers/huaweimodem/radio-settings.c \
+	drivers/huaweimodem/ussd.c \
+	drivers/huaweimodem/voicecall.c
 =

 builtin_modules +=3D calypsomodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/calypsomodem/calypsomodem.h \
-			drivers/calypsomodem/calypsomodem.c \
-			drivers/calypsomodem/voicecall.c \
-			drivers/calypsomodem/stk.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/calypsomodem/calypsomodem.c \
+	drivers/calypsomodem/calypsomodem.h \
+	drivers/calypsomodem/stk.c \
+	drivers/calypsomodem/voicecall.c
 =

 builtin_modules +=3D mbmmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/mbmmodem/mbmmodem.h \
-			drivers/mbmmodem/mbmmodem.c \
-			drivers/mbmmodem/gprs-context.c \
-			drivers/mbmmodem/stk.c \
-			drivers/mbmmodem/location-reporting.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/mbmmodem/gprs-context.c \
+	drivers/mbmmodem/location-reporting.c \
+	drivers/mbmmodem/mbmmodem.c \
+	drivers/mbmmodem/mbmmodem.h \
+	drivers/mbmmodem/stk.c
 =

 builtin_modules +=3D telitmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/telitmodem/telitmodem.h \
-			drivers/telitmodem/telitmodem.c \
-			drivers/telitmodem/location-reporting.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/telitmodem/location-reporting.c \
+	drivers/telitmodem/telitmodem.c \
+	drivers/telitmodem/telitmodem.h
 =

 builtin_modules +=3D hsomodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/hsomodem/hsomodem.h \
-			drivers/hsomodem/hsomodem.c \
-			drivers/hsomodem/gprs-context.c \
-			drivers/hsomodem/radio-settings.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/hsomodem/gprs-context.c \
+	drivers/hsomodem/hsomodem.c \
+	drivers/hsomodem/hsomodem.h \
+	drivers/hsomodem/radio-settings.c
 =

 builtin_modules +=3D ifxmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/ifxmodem/ifxmodem.h \
-			drivers/ifxmodem/ifxmodem.c \
-			drivers/ifxmodem/voicecall.c \
-			drivers/ifxmodem/audio-settings.c \
-			drivers/ifxmodem/radio-settings.c \
-			drivers/ifxmodem/gprs-context.c \
-			drivers/ifxmodem/stk.c \
-			drivers/ifxmodem/ctm.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/ifxmodem/audio-settings.c \
+	drivers/ifxmodem/ctm.c \
+	drivers/ifxmodem/gprs-context.c \
+	drivers/ifxmodem/ifxmodem.c \
+	drivers/ifxmodem/ifxmodem.h \
+	drivers/ifxmodem/radio-settings.c \
+	drivers/ifxmodem/stk.c \
+	drivers/ifxmodem/voicecall.c
 =

 builtin_modules +=3D stemodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/stemodem/stemodem.h \
-			drivers/stemodem/stemodem.c \
-			drivers/stemodem/voicecall.c \
-			drivers/stemodem/radio-settings.c \
-			drivers/stemodem/caif_rtnl.c \
-			drivers/stemodem/caif_rtnl.h \
-			drivers/stemodem/gprs-context.c \
-			drivers/stemodem/caif_socket.h \
-			drivers/stemodem/if_caif.h
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/stemodem/caif_rtnl.c \
+	drivers/stemodem/caif_rtnl.h \
+	drivers/stemodem/caif_socket.h \
+	drivers/stemodem/gprs-context.c \
+	drivers/stemodem/if_caif.h \
+	drivers/stemodem/radio-settings.c \
+	drivers/stemodem/stemodem.c \
+	drivers/stemodem/stemodem.h \
+	drivers/stemodem/voicecall.c
 =

 builtin_modules +=3D dunmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/dunmodem/dunmodem.h \
-			drivers/dunmodem/dunmodem.c \
-			drivers/dunmodem/network-registration.c \
-			drivers/dunmodem/gprs.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/dunmodem/dunmodem.c \
+	drivers/dunmodem/dunmodem.h \
+	drivers/dunmodem/gprs.c \
+	drivers/dunmodem/network-registration.c
 =

 builtin_modules +=3D hfpmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/hfpmodem/hfpmodem.h \
-			drivers/hfpmodem/hfpmodem.c \
-			drivers/hfpmodem/slc.h \
-			drivers/hfpmodem/slc.c \
-			drivers/hfpmodem/voicecall.c \
-			drivers/hfpmodem/network-registration.c \
-			drivers/hfpmodem/call-volume.c \
-			drivers/hfpmodem/devinfo.c \
-			drivers/hfpmodem/handsfree.c \
-			drivers/hfpmodem/siri.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/hfpmodem/call-volume.c \
+	drivers/hfpmodem/devinfo.c \
+	drivers/hfpmodem/handsfree.c \
+	drivers/hfpmodem/hfpmodem.c \
+	drivers/hfpmodem/hfpmodem.h \
+	drivers/hfpmodem/network-registration.c \
+	drivers/hfpmodem/siri.c \
+	drivers/hfpmodem/slc.c \
+	drivers/hfpmodem/slc.h \
+	drivers/hfpmodem/voicecall.c
 =

 builtin_modules +=3D speedupmodem
-builtin_sources +=3D drivers/atmodem/atutil.h \
-			drivers/speedupmodem/speedupmodem.h \
-			drivers/speedupmodem/speedupmodem.c \
-			drivers/speedupmodem/ussd.c
+builtin_sources +=3D \
+	drivers/atmodem/atutil.h \
+	drivers/speedupmodem/speedupmodem.c \
+	drivers/speedupmodem/speedupmodem.h \
+	drivers/speedupmodem/ussd.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
 builtin_sources +=3D plugins/phonesim.c
 =

 if DATAFILES
 dist_conf_DATA +=3D plugins/phonesim.conf
 endif
 endif
 =

 if CDMAMODEM
 builtin_modules +=3D cdmamodem
-builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
-			drivers/cdmamodem/cdmamodem.c \
-			drivers/cdmamodem/voicecall.c \
-			drivers/cdmamodem/devinfo.c \
-			drivers/cdmamodem/connman.c
+builtin_sources +=3D \
+	drivers/cdmamodem/cdmamodem.c \
+	drivers/cdmamodem/cdmamodem.h \
+	drivers/cdmamodem/connman.c \
+	drivers/cdmamodem/devinfo.c \
+	drivers/cdmamodem/voicecall.c
 endif
 =

 builtin_modules +=3D g1
 builtin_sources +=3D plugins/g1.c
 =

 builtin_modules +=3D wavecom
 builtin_sources +=3D plugins/wavecom.c
 =

@@ -430,54 +513,76 @@ builtin_modules +=3D quectel
 builtin_sources +=3D plugins/quectel.c
 =

 builtin_modules +=3D ublox
 builtin_sources +=3D plugins/ublox.c
 =

 if BLUETOOTH
 if BLUEZ4
 builtin_modules +=3D bluez4
-builtin_sources +=3D plugins/bluez4.c plugins/bluez4.h
+builtin_sources +=3D \
+	plugins/bluez4.c \
+	plugins/bluez4.h
 =

 builtin_modules +=3D telit
-builtin_sources +=3D plugins/telit.c plugins/bluez4.h
+builtin_sources +=3D \
+	plugins/bluez4.h \
+	plugins/telit.c
 =

 builtin_modules +=3D sap
-builtin_sources +=3D plugins/sap.c plugins/bluez4.h
+builtin_sources +=3D \
+	plugins/bluez4.h \
+	plugins/sap.c
 =

 builtin_modules +=3D hfp_bluez4
-builtin_sources +=3D plugins/hfp_hf_bluez4.c plugins/bluez4.h
+builtin_sources +=3D \
+	plugins/bluez4.h \
+	plugins/hfp_hf_bluez4.c
 =

 builtin_modules +=3D hfp_ag_bluez4
-builtin_sources +=3D plugins/hfp_ag_bluez4.c plugins/bluez4.h
+builtin_sources +=3D \
+	plugins/bluez4.h \
+	plugins/hfp_ag_bluez4.c
 =

 builtin_modules +=3D dun_gw_bluez4
-builtin_sources +=3D plugins/dun_gw_bluez4.c plugins/bluez4.h
+builtin_sources +=3D \
+	plugins/bluez4.h \
+	plugins/dun_gw_bluez4.c
 =

 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
 else
 builtin_modules +=3D bluez5
-builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
+builtin_sources +=3D \
+	plugins/bluez5.c \
+	plugins/bluez5.h
 =

 builtin_modules +=3D hfp_bluez5
-builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
+builtin_sources +=3D \
+	plugins/bluez5.h \
+	plugins/hfp_hf_bluez5.c
 =

 builtin_modules +=3D hfp_ag_bluez5
-builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/bluez5.h
+builtin_sources +=3D \
+	plugins/bluez5.h \
+	plugins/hfp_ag_bluez5.c
 =

 builtin_modules +=3D dun_gw_bluez5
-builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
+builtin_sources +=3D \
+	plugins/bluez5.h \
+	plugins/dun_gw_bluez5.c
 endif
 endif
 endif
 =

 if PROVISION
-builtin_sources +=3D plugins/mbpi.h plugins/mbpi.c
+builtin_sources +=3D \
+	plugins/mbpi.c \
+	plugins/mbpi.h
 =

 builtin_modules +=3D provision
 builtin_sources +=3D plugins/provision.c
 =

 builtin_modules +=3D cdma_provision
 builtin_sources +=3D plugins/cdma-provision.c
 endif
 =

@@ -507,338 +612,521 @@ endif
 builtin_modules +=3D smart_messaging
 builtin_sources +=3D plugins/smart-messaging.c
 =

 builtin_modules +=3D push_notification
 builtin_sources +=3D plugins/push-notification.c
 =

 sbin_PROGRAMS =3D src/ofonod
 =

-src_ofonod_SOURCES =3D $(builtin_sources) src/ofono.ver \
-			src/main.c src/ofono.h src/log.c src/plugin.c \
-			src/modem.c src/common.h src/common.c \
-			src/manager.c src/dbus.c src/util.h src/util.c \
-			src/network.c src/voicecall.c src/ussd.c src/sms.c \
-			src/call-settings.c src/call-forwarding.c \
-			src/call-meter.c src/smsutil.h src/smsutil.c \
-			src/call-barring.c src/sim.c src/stk.c \
-			src/phonebook.c src/history.c src/message-waiting.c \
-			src/simutil.h src/simutil.c src/storage.h \
-			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
-			src/gprs.c src/idmap.h src/idmap.c \
-			src/radio-settings.c src/stkutil.h src/stkutil.c \
-			src/nettime.c src/stkagent.c src/stkagent.h \
-			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c src/sim-auth.c \
-			src/message.h src/message.c src/gprs-provision.c \
-			src/emulator.c src/location-reporting.c \
-			src/cdma-connman.c src/gnss.c \
-			src/gnssagent.c src/gnssagent.h \
-			src/cdma-smsutil.h src/cdma-smsutil.c \
-			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
-			src/cdma-provision.c src/handsfree.c \
-			src/handsfree-audio.c src/bluetooth.h \
-			src/hfp.h src/siri.c
-
-src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
-
-src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
-				-Wl,--version-script=3D$(srcdir)/src/ofono.ver
-
-BUILT_SOURCES =3D $(local_headers) src/builtin.h
-
-CLEANFILES =3D $(BUILT_SOURCES) $(rules_DATA)
+src_ofonod_SOURCES =3D \
+	$(builtin_sources) \
+	src/audio-settings.c \
+	src/bluetooth.h \
+	src/call-barring.c \
+	src/call-forwarding.c \
+	src/call-meter.c \
+	src/call-settings.c \
+	src/call-volume.c \
+	src/cbs.c \
+	src/cdma-connman.c \
+	src/cdma-netreg.c \
+	src/cdma-provision.c \
+	src/cdma-sms.c \
+	src/cdma-smsutil.c \
+	src/cdma-smsutil.h \
+	src/cdma-voicecall.c \
+	src/common.c \
+	src/common.h \
+	src/ctm.c \
+	src/dbus.c \
+	src/emulator.c \
+	src/gnss.c \
+	src/gnssagent.c \
+	src/gnssagent.h \
+	src/gprs-provision.c \
+	src/gprs.c \
+	src/handsfree-audio.c \
+	src/handsfree.c \
+	src/hfp.h \
+	src/history.c \
+	src/idmap.c \
+	src/idmap.h \
+	src/location-reporting.c \
+	src/log.c \
+	src/main.c \
+	src/manager.c \
+	src/message-waiting.c \
+	src/message.c \
+	src/message.h \
+	src/modem.c \
+	src/nettime.c \
+	src/network.c \
+	src/ofono.h \
+	src/ofono.ver \
+	src/phonebook.c \
+	src/plugin.c \
+	src/private-network.c \
+	src/radio-settings.c \
+	src/sim-auth.c \
+	src/sim.c \
+	src/simfs.c \
+	src/simfs.h \
+	src/simutil.c \
+	src/simutil.h \
+	src/siri.c \
+	src/sms.c \
+	src/smsagent.c \
+	src/smsagent.h \
+	src/smsutil.c \
+	src/smsutil.h \
+	src/stk.c \
+	src/stkagent.c \
+	src/stkagent.h \
+	src/stkutil.c \
+	src/stkutil.h \
+	src/storage.c \
+	src/storage.h \
+	src/ussd.c \
+	src/util.c \
+	src/util.h \
+	src/voicecall.c \
+	src/watch.c
+
+src_ofonod_LDADD =3D \
+	gdbus/libgdbus-internal.la \
+	$(builtin_libadd) \
+	@GLIB_LIBS@ \
+	@DBUS_LIBS@ \
+	-ldl
+
+src_ofonod_LDFLAGS =3D \
+	-Wl,--export-dynamic \
+	-Wl,--version-script=3D$(srcdir)/src/ofono.ver
+
+BUILT_SOURCES =3D \
+	$(local_headers) \
+	src/builtin.h
+
+CLEANFILES =3D \
+	$(BUILT_SOURCES) \
+	$(rules_DATA)
 =

 plugindir =3D $(pkglibdir)/plugins
 =

 if MAINTAINER_MODE
 build_plugindir =3D $(abs_top_srcdir)/plugins/.libs
 else
 build_plugindir =3D $(plugindir)
 endif
 =

-AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ $(builtin_cflags) \
-					-DOFONO_PLUGIN_BUILTIN \
-					-DPLUGINDIR=3D\""$(build_plugindir)"\"
-
-AM_CPPFLAGS =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
-			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
-			-I$(srcdir)/btio
-
-doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/release-faq.txt \
-		doc/manager-api.txt doc/modem-api.txt doc/network-api.txt \
-			doc/voicecallmanager-api.txt doc/voicecall-api.txt \
-			doc/call-forwarding-api.txt doc/call-settings-api.txt \
-			doc/call-meter-api.txt doc/call-barring-api.txt \
-			doc/supplementaryservices-api.txt \
-			doc/connman-api.txt doc/features.txt \
-			doc/pushnotification-api.txt \
-			doc/smartmessaging-api.txt \
-			doc/call-volume-api.txt doc/cell-broadcast-api.txt \
-			doc/messagemanager-api.txt doc/message-waiting-api.txt \
-			doc/phonebook-api.txt doc/radio-settings-api.txt \
-			doc/sim-api.txt doc/stk-api.txt \
-			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt doc/message-api.txt \
-			doc/location-reporting-api.txt \
-			doc/certification.txt doc/siri-api.txt \
-			doc/telit-modem.txt
-
-
-test_scripts =3D test/backtrace \
-		test/create-internet-context \
-		test/create-mms-context \
-		test/activate-context \
-		test/deactivate-context \
-		test/deactivate-all \
-		test/dial-number \
-		test/list-calls \
-		test/answer-calls \
-		test/reject-calls \
-		test/create-multiparty \
-		test/private-chat \
-		test/disable-modem \
-		test/enable-modem \
-		test/enter-pin \
-		test/reset-pin \
-		test/hangup-all \
-		test/hangup-active \
-		test/set-mms-details \
-		test/set-roaming-allowed \
-		test/list-contexts \
-		test/list-modems \
-		test/list-operators \
-		test/scan-for-operators \
-		test/get-operators\
-		test/monitor-ofono \
-		test/process-context-settings \
-		test/receive-sms \
-		test/remove-contexts \
-		test/send-sms \
-		test/set-mic-volume \
-		test/set-speaker-volume \
-		test/test-stk-menu \
-		test/test-advice-of-charge \
-		test/test-call-barring \
-		test/test-call-forwarding \
-		test/test-call-settings \
-		test/test-modem \
-		test/test-network-registration \
-		test/test-phonebook \
-		test/test-cbs \
-		test/test-ss \
-		test/test-ss-control-cb \
-		test/test-ss-control-cf \
-		test/test-ss-control-cs \
-		test/send-ussd \
-		test/cancel-ussd \
-		test/initiate-ussd \
-		test/offline-modem \
-		test/online-modem \
-		test/get-tech-preference \
-		test/set-tech-preference \
-		test/set-use-sms-reports \
-		test/set-cbs-topics \
-		test/enable-cbs \
-		test/lock-pin \
-		test/unlock-pin \
-		test/change-pin \
-		test/enable-gprs \
-		test/disable-gprs \
-		test/get-icon \
-		test/set-fast-dormancy \
-		test/test-push-notification \
-		test/test-smart-messaging \
-		test/send-vcard \
-		test/send-vcal \
-		test/set-tty \
-		test/set-gsm-band \
-		test/set-umts-band \
-		test/lockdown-modem \
-		test/set-call-forwarding \
-		test/cdma-list-call \
-		test/cdma-dial-number \
-		test/cdma-hangup \
-		test/cdma-set-credentials \
-		test/disable-call-forwarding \
-		test/list-messages \
-		test/test-sms \
-		test/test-message-waiting \
-		test/cdma-connman-disable \
-		test/cdma-connman-enable \
-		test/set-context-property \
-		test/test-gnss \
-		test/swap-calls \
-		test/release-and-answer \
-		test/release-and-swap \
-		test/hold-and-answer \
-		test/hangup-multiparty \
-		test/hangup-call \
-		test/display-icon \
-		test/set-msisdn \
-		test/set-ddr
+AM_CFLAGS =3D \
+	@DBUS_CFLAGS@ \
+	@GLIB_CFLAGS@ \
+	$(builtin_cflags) \
+	-DOFONO_PLUGIN_BUILTIN \
+	-DPLUGINDIR=3D\""$(build_plugindir)"\"
+
+AM_CPPFLAGS =3D \
+	-I$(builddir)/include \
+	-I$(builddir)/src \
+	-I$(srcdir)/src \
+	-I$(srcdir)/gdbus \
+	-I$(srcdir)/gisi \
+	-I$(srcdir)/gatchat \
+	-I$(srcdir)/btio
+
+doc_files =3D \
+	doc/audio-settings-api.txt \
+	doc/call-barring-api.txt \
+	doc/call-forwarding-api.txt \
+	doc/call-meter-api.txt \
+	doc/call-settings-api.txt \
+	doc/call-volume-api.txt \
+	doc/calypso-modem.txt \
+	doc/cell-broadcast-api.txt \
+	doc/certification.txt \
+	doc/connman-api.txt \
+	doc/features.txt \
+	doc/location-reporting-api.txt \
+	doc/manager-api.txt \
+	doc/message-api.txt \
+	doc/message-waiting-api.txt \
+	doc/messagemanager-api.txt \
+	doc/modem-api.txt \
+	doc/network-api.txt \
+	doc/ofono-paper.txt \
+	doc/overview.txt \
+	doc/phonebook-api.txt \
+	doc/pushnotification-api.txt \
+	doc/radio-settings-api.txt \
+	doc/release-faq.txt \
+	doc/sim-api.txt \
+	doc/siri-api.txt \
+	doc/smartmessaging-api.txt \
+	doc/stk-api.txt \
+	doc/supplementaryservices-api.txt \
+	doc/telit-modem.txt \
+	doc/text-telephony-api.txt \
+	doc/voicecall-api.txt \
+	doc/voicecallmanager-api.txt
+
+
+test_scripts =3D \
+	test/activate-context \
+	test/answer-calls \
+	test/backtrace \
+	test/cancel-ussd \
+	test/cdma-connman-disable \
+	test/cdma-connman-enable \
+	test/cdma-dial-number \
+	test/cdma-hangup \
+	test/cdma-list-call \
+	test/cdma-set-credentials \
+	test/change-pin \
+	test/create-internet-context \
+	test/create-mms-context \
+	test/create-multiparty \
+	test/deactivate-all \
+	test/deactivate-context \
+	test/dial-number \
+	test/disable-call-forwarding \
+	test/disable-gprs \
+	test/disable-modem \
+	test/display-icon \
+	test/enable-cbs \
+	test/enable-gprs \
+	test/enable-modem \
+	test/enter-pin \
+	test/get-icon \
+	test/get-operators \
+	test/get-tech-preference \
+	test/hangup-active \
+	test/hangup-all \
+	test/hangup-call \
+	test/hangup-multiparty \
+	test/hold-and-answer \
+	test/initiate-ussd \
+	test/list-calls \
+	test/list-contexts \
+	test/list-messages \
+	test/list-modems \
+	test/list-operators \
+	test/lock-pin \
+	test/lockdown-modem \
+	test/monitor-ofono \
+	test/offline-modem \
+	test/online-modem \
+	test/private-chat \
+	test/process-context-settings \
+	test/receive-sms \
+	test/reject-calls \
+	test/release-and-answer \
+	test/release-and-swap \
+	test/remove-contexts \
+	test/reset-pin \
+	test/scan-for-operators \
+	test/send-sms \
+	test/send-ussd \
+	test/send-vcal \
+	test/send-vcard \
+	test/set-call-forwarding \
+	test/set-cbs-topics \
+	test/set-context-property \
+	test/set-ddr \
+	test/set-fast-dormancy \
+	test/set-gsm-band \
+	test/set-mic-volume \
+	test/set-mms-details \
+	test/set-msisdn \
+	test/set-roaming-allowed \
+	test/set-speaker-volume \
+	test/set-tech-preference \
+	test/set-tty \
+	test/set-umts-band \
+	test/set-use-sms-reports \
+	test/swap-calls \
+	test/test-advice-of-charge \
+	test/test-call-barring \
+	test/test-call-forwarding \
+	test/test-call-settings \
+	test/test-cbs \
+	test/test-gnss \
+	test/test-message-waiting \
+	test/test-modem \
+	test/test-network-registration \
+	test/test-phonebook \
+	test/test-push-notification \
+	test/test-smart-messaging \
+	test/test-sms \
+	test/test-ss \
+	test/test-ss-control-cb \
+	test/test-ss-control-cf \
+	test/test-ss-control-cs \
+	test/test-stk-menu \
+	test/unlock-pin
 =

 if TEST
 testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
 endif
 =

-EXTRA_DIST =3D src/genbuiltin plugins/ofono.rules plugins/ofono-speedup.ru=
les \
-				$(doc_files) $(test_scripts)
+EXTRA_DIST =3D \
+	src/genbuiltin \
+	plugins/ofono.rules \
+	plugins/ofono-speedup.rules \
+	$(doc_files) \
+	$(test_scripts)
 =

 dist_man_MANS =3D doc/ofonod.8
 =

 =

 unit_objects =3D
 =

-unit_tests =3D unit/test-common unit/test-util unit/test-idmap \
-				unit/test-simutil unit/test-stkutil \
-				unit/test-sms unit/test-cdmasms
-
-noinst_PROGRAMS =3D $(unit_tests) \
-			unit/test-sms-root unit/test-mux unit/test-caif
-
-unit_test_common_SOURCES =3D unit/test-common.c src/common.c src/util.c
+unit_tests =3D \
+	unit/test-cdmasms \
+	unit/test-common \
+	unit/test-idmap \
+	unit/test-simutil \
+	unit/test-sms \
+	unit/test-stkutil \
+	unit/test-util
+
+noinst_PROGRAMS =3D \
+	$(unit_tests) \
+	unit/test-caif \
+	unit/test-mux \
+	unit/test-sms-root
+
+unit_test_common_SOURCES =3D \
+	src/common.c \
+	src/util.c \
+	unit/test-common.c
 unit_test_common_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_common_OBJECTS)
 =

-unit_test_util_SOURCES =3D unit/test-util.c src/util.c
+unit_test_util_SOURCES =3D \
+	src/util.c \
+	unit/test-util.c
 unit_test_util_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_utils_OBJECTS)
 =

-unit_test_idmap_SOURCES =3D unit/test-idmap.c src/idmap.c
+unit_test_idmap_SOURCES =3D \
+	src/idmap.c \
+	unit/test-idmap.c
 unit_test_idmap_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_idmap_OBJECTS)
 =

-unit_test_simutil_SOURCES =3D unit/test-simutil.c src/util.c \
-                                src/simutil.c src/smsutil.c src/storage.c
+unit_test_simutil_SOURCES =3D \
+	src/simutil.c \
+	src/smsutil.c \
+	src/storage.c \
+	src/util.c \
+	unit/test-simutil.c
 unit_test_simutil_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_simutil_OBJECTS)
 =

-unit_test_stkutil_SOURCES =3D unit/test-stkutil.c unit/stk-test-data.h \
-				src/util.c \
-                                src/storage.c src/smsutil.c \
-                                src/simutil.c src/stkutil.c
+unit_test_stkutil_SOURCES =3D \
+	src/simutil.c \
+	src/smsutil.c \
+	src/stkutil.c \
+	src/storage.c \
+	src/util.c \
+	unit/stk-test-data.h \
+	unit/test-stkutil.c
 unit_test_stkutil_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_stkutil_OBJECTS)
 =

-unit_test_sms_SOURCES =3D unit/test-sms.c src/util.c src/smsutil.c src/sto=
rage.c
+unit_test_sms_SOURCES =3D \
+	src/smsutil.c \
+	src/storage.c \
+	src/util.c \
+	unit/test-sms.c
 unit_test_sms_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_sms_OBJECTS)
 =

-unit_test_cdmasms_SOURCES =3D unit/test-cdmasms.c src/cdma-smsutil.c
+unit_test_cdmasms_SOURCES =3D \
+	src/cdma-smsutil.c \
+	unit/test-cdmasms.c
 unit_test_cdmasms_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_cdmasms_OBJECTS)
 =

-unit_test_sms_root_SOURCES =3D unit/test-sms-root.c \
-					src/util.c src/smsutil.c src/storage.c
+unit_test_sms_root_SOURCES =3D \
+	src/smsutil.c \
+	src/storage.c \
+	src/util.c \
+	unit/test-sms-root.c
 unit_test_sms_root_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_sms_root_OBJECTS)
 =

-unit_test_mux_SOURCES =3D unit/test-mux.c $(gatchat_sources)
+unit_test_mux_SOURCES =3D \
+	$(gatchat_sources) \
+	unit/test-mux.c
 unit_test_mux_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_mux_OBJECTS)
 =

-unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_sources) \
-					drivers/stemodem/caif_socket.h \
-					drivers/stemodem/if_caif.h
+unit_test_caif_SOURCES =3D \
+	$(gatchat_sources) \
+	drivers/stemodem/caif_socket.h \
+	drivers/stemodem/if_caif.h \
+	unit/test-caif.c
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

 TESTS =3D $(unit_tests)
 =

 if TOOLS
-noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-enable \
-			tools/get-location tools/lookup-apn \
-			tools/lookup-provider-name tools/tty-redirector
+noinst_PROGRAMS +=3D \
+	tools/auto-enable \
+	tools/get-location \
+	tools/huawei-audio \
+	tools/lookup-apn \
+	tools/lookup-provider-name \
+	tools/tty-redirector
 =

 tools_huawei_audio_SOURCES =3D tools/huawei-audio.c
-tools_huawei_audio_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_=
LIBS@
+tools_huawei_audio_LDADD =3D \
+	gdbus/libgdbus-internal.la \
+	@GLIB_LIBS@ \
+	@DBUS_LIBS@
 =

 tools_auto_enable_SOURCES =3D tools/auto-enable.c
-tools_auto_enable_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_L=
IBS@
+tools_auto_enable_LDADD =3D \
+	gdbus/libgdbus-internal.la \
+	@GLIB_LIBS@ \
+	@DBUS_LIBS@
 =

 tools_get_location_SOURCES =3D tools/get-location.c
-tools_get_location_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
-
-tools_lookup_apn_SOURCES =3D plugins/mbpi.c plugins/mbpi.h tools/lookup-ap=
n.c
+tools_get_location_LDADD =3D \
+	@GLIB_LIBS@ \
+	@DBUS_LIBS@
+
+tools_lookup_apn_SOURCES =3D \
+	plugins/mbpi.c \
+	plugins/mbpi.h \
+	tools/lookup-apn.c
 tools_lookup_apn_LDADD =3D @GLIB_LIBS@
 =

-tools_lookup_provider_name_SOURCES =3D plugins/mbpi.c plugins/mbpi.h \
-				tools/lookup-provider-name.c
+tools_lookup_provider_name_SOURCES =3D \
+	plugins/mbpi.c \
+	plugins/mbpi.h \
+	tools/lookup-provider-name.c
 tools_lookup_provider_name_LDADD =3D @GLIB_LIBS@
 =

 tools_tty_redirector_SOURCES =3D tools/tty-redirector.c
 tools_tty_redirector_LDADD =3D @GLIB_LIBS@
 =

 if QMIMODEM
 noinst_PROGRAMS +=3D tools/qmi
 =

-tools_qmi_SOURCES =3D $(qmi_sources) tools/qmi.c
+tools_qmi_SOURCES =3D \
+	$(qmi_sources) \
+	tools/qmi.c
 tools_qmi_LDADD =3D @GLIB_LIBS@
 endif
 =

 if MAINTAINER_MODE
 noinst_PROGRAMS +=3D tools/stktest
 =

-tools_stktest_SOURCES =3D $(gatchat_sources) tools/stktest.c \
-				unit/stk-test-data.h
-tools_stktest_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
+tools_stktest_SOURCES =3D \
+	$(gatchat_sources) \
+	tools/stktest.c \
+	unit/stk-test-data.h
+tools_stktest_LDADD =3D \
+	gdbus/libgdbus-internal.la \
+	@GLIB_LIBS@ \
+	@DBUS_LIBS@
 endif
 endif
 =

 if BLUETOOTH
 if DUNDEE
 sbin_PROGRAMS +=3D dundee/dundee
 =

-dundee_common_sources =3D $(gatchat_sources) \
-			src/log.c src/dbus.c dundee/dundee.h dundee/main.c \
-			dundee/dbus.c dundee/manager.c dundee/device.c
-
-dundee_dundee_LDADD =3D $(builtin_libadd) gdbus/libgdbus-internal.la \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+dundee_common_sources =3D \
+	$(gatchat_sources) \
+	dundee/dbus.c \
+	dundee/device.c \
+	dundee/dundee.h \
+	dundee/main.c \
+	dundee/manager.c \
+	src/dbus.c \
+	src/log.c
+
+dundee_dundee_LDADD =3D \
+	$(builtin_libadd) \
+	gdbus/libgdbus-internal.la \
+	@GLIB_LIBS@ \
+	@DBUS_LIBS@ \
+	-ldl
 =

 if DATAFILES
 dist_dbusconf_DATA +=3D dundee/dundee.conf
 =

 if SYSTEMD
 systemdunit_DATA +=3D dundee/dundee.service
 endif
 endif
 =

 if BLUEZ4
-dundee_dundee_SOURCES =3D $(dundee_common_sources) $(btio_sources) \
-			plugins/bluez4.c dundee/bluez4.c
+dundee_dundee_SOURCES =3D \
+	$(dundee_common_sources) \
+	$(btio_sources) \
+	dundee/bluez4.c \
+	plugins/bluez4.c
 else
-dundee_dundee_SOURCES =3D $(dundee_common_sources) plugins/bluez5.c \
-			dundee/bluez5.c
+dundee_dundee_SOURCES =3D \
+	$(dundee_common_sources) \
+	dundee/bluez5.c \
+	plugins/bluez5.c
 endif
 endif
 endif
 =

-noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
+noinst_PROGRAMS +=3D \
+	gatchat/gsmdial \
+	gatchat/test-qcdm \
+	gatchat/test-server
 =

-gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
+gatchat_gsmdial_SOURCES =3D \
+	$(gatchat_sources) \
+	gatchat/gsmdial.c
 gatchat_gsmdial_LDADD =3D @GLIB_LIBS@
 =

-gatchat_test_server_SOURCES =3D gatchat/test-server.c $(gatchat_sources)
-gatchat_test_server_LDADD =3D @GLIB_LIBS@ -lutil
+gatchat_test_server_SOURCES =3D \
+	$(gatchat_sources) \
+	gatchat/test-server.c
+gatchat_test_server_LDADD =3D \
+	@GLIB_LIBS@ \
+	-lutil
 =

-gatchat_test_qcdm_SOURCES =3D gatchat/test-qcdm.c $(gatchat_sources)
+gatchat_test_qcdm_SOURCES =3D \
+	$(gatchat_sources) \
+	gatchat/test-qcdm.c
 gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
 =

 =

-DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles \
-				--enable-dundee --enable-tools
-
-MAINTAINERCLEANFILES =3D Makefile.in \
-	aclocal.m4 configure config.h.in config.sub config.guess \
-	ltmain.sh depcomp compile missing install-sh mkinstalldirs
+DISTCHECK_CONFIGURE_FLAGS =3D \
+	--disable-datafiles \
+	--enable-dundee \
+	--enable-tools
+
+MAINTAINERCLEANFILES =3D \
+	Makefile.in \
+	aclocal.m4 \
+	compile \
+	config.guess \
+	config.h.in \
+	config.sub \
+	configure \
+	depcomp \
+	install-sh \
+	ltmain.sh \
+	missing \
+	mkinstalldirs
 =

 =

 src/builtin.h: src/genbuiltin config.status
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 =

 plugins/%.rules:
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 =

-- =

2.1.4


--===============6455532666249481965==--

