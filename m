Content-Type: multipart/mixed; boundary="===============1184975685051046136=="
MIME-Version: 1.0
From: marko.saukko@gmail.com
Subject: N950 patches 
Date: Mon, 12 Dec 2011 13:39:41 +0200
Message-ID: <1323689984-24866-1-git-send-email-marko.saukko@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1184975685051046136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

here is the initial set of patches for N950. The patch set is originally ma=
de by Aki Niemi.

NOTES:
- Separeted plugins/udev.c from the original patch to [Patch 2/3] and rebas=
ed it to apply on top of the new ofono upstream.
- Also not sure about the author of [Patch 3/3] and if that is still needed=
 or not.
- Dropped following part, which is also a problematic part as we need to be=
 able to separate the N900 from N950:

Index: ofono-0.48/plugins/ofono.rules
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ofono-0.48.orig/plugins/ofono.rules	2011-03-02 02:56:52.000000000 +0200
+++ ofono-0.48/plugins/ofono.rules	2011-05-06 14:49:50.250868443 +0300
@@ -354,8 +354,8 @@
 # Generic USB / PC Suite mode
 SUBSYSTEMS=3D=3D"usb", ENV{OFONO_DRIVER}=3D"isiusb", ENV{OFONO_ISI_ADDRESS=
}=3D"16"
 =

-# Nokia N900 modem
-SUBSYSTEMS=3D=3D"hsi", ENV{OFONO_DRIVER}=3D"n900", ENV{OFONO_ISI_ADDRESS}=
=3D"108"
+# Nokia N950 modem
+SUBSYSTEMS=3D=3D"hsi", ENV{OFONO_DRIVER}=3D"n950", ENV{OFONO_ISI_ADDRESS}=
=3D"108"
 =

 # STE u8500
 KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"

These patches used to work at some point but currently we are having issues=
 with the gprs on Mer/Nemo with N900 and N950. Also the N900 modem is recog=
nized as N950 modem with these patches.

Regards,
Marko


--===============1184975685051046136==--

