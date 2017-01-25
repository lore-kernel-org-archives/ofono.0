Content-Type: multipart/mixed; boundary="===============4470850876828756983=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 3/4] doc: description of Telit LE910V2 network setup
Date: Wed, 25 Jan 2017 11:41:27 +0100
Message-ID: <20170125104128.5254-4-gluedig@gmail.com>
In-Reply-To: <20170125104128.5254-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4470850876828756983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

NCM network interface on LE910V2 modem needs to be
configured in a specific way after connection is established.
---
 doc/telit-modem.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/telit-modem.txt b/doc/telit-modem.txt
index 1627fb4c..d4d367d7 100644
--- a/doc/telit-modem.txt
+++ b/doc/telit-modem.txt
@@ -17,3 +17,30 @@ GPS:
   After setting the configuration, a power cycle is required.
   Port Configiuration #8 is available since firmware 12.00.004. Firmware v=
ersion
   can be checked using 'AT+CGMR'.
+
+LE910 V2
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Default USB composition of LE910V2 uses PID 0x36 (AT#PORTCFG=3D0)
+and consists of 6 serial ports (CDC-ACM standard, /dev/ttyACMx)
+and 1 network adapter using CDC-NCM standard (wwanx or usbx).
+
+NCM interface configuration follows Telit documentation
+(both documents available on Telit Download Zone - registration required)
+"GE/HE/UE910, UL865, LE910 V2 Linux USB Driver - User Guide r0"
+(document 1VV0301255 Rev.0 - 2016-01-22)
+and "Telit LE910-V2 NCM SETUP r3"
+(document 1VV0301246 Rev.3 - 2016-11-29).
+
+After context is setup, NCM mode activated and PDP context activated
+connection configuration can be read using
+AT+CGPADDR=3Dcontext_id and AT+CGCONTRDP=3Dcontext_id commands.
+This is done automatically and results available via
+org.ofono.ConnectionContext.GetProperties DBus method.
+
+Then Linux network interface needs to be configured:
+    ifconfig <Interface> <Address> netmask <Netmask> up
+    route add default gw <Gateway>
+    arp -s <Gateway> 11:22:33:44:55:66
+
+Only after these steps network interface is usable.
-- =

2.11.0


--===============4470850876828756983==--

