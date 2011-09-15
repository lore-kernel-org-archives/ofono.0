Content-Type: multipart/mixed; boundary="===============5945423554821590647=="
MIME-Version: 1.0
From: Paolo Pellegrino <paolo.pellegrino@zirak.it>
Subject: Re: Udev detection broken?
Date: Thu, 15 Sep 2011 16:33:32 +0200
Message-ID: <4E720CBC.2010507@zirak.it>
In-Reply-To: <4E71ADD3.7060305@makhutov.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5945423554821590647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Artem,

Il 15/09/2011 9.48, Artem Makhutov ha scritto:
> Hi,
> =

> Artem Makhutov schrieb:
>> Hello,
>> =

>> I am trying to setup ofono on my PC again, unfortunatly ofono
>> does not pick up the connected huawei modem. [...]
> =

> I have done some more testing. Looks like the "OFONO_DRIVER=3Dhuawei"
> is getting removed somehow by udev.
> =

> With "udevadm monitor --property" I can see that
> OFONO_DRIVER=3Dhuawei was set for
> /devices/pci0000:00/0000:00:02.1/usb1/1-3 But "udevadm info
> --query=3Dall --path=3D/devices/pci0000:00/0000:00:02.1/usb1/1-3" does
> not show it. Ofono also can't find it.
> =

> Any ideas that to do to trace down the problem?

We incurred in a similar problem some months ago, but we thought the
issue was related to some specific udev library version we were using
(v153 if I remember well).

Here is a patch we applied to ofono.rules to fix the problem, maybe it
will solve your issue, too:

@@ -0,0 +1,25 @@
+diff --git a/plugins/ofono.rules b/plugins/ofono.rules
+index 5a36380..bff8102 100644
+--- a/plugins/ofono.rules
++++ b/plugins/ofono.rules
+@@ -362,8 +362,18 @@ KERNEL=3D=3D"shrm0", ENV{OFONO_DRIVER}=3D"u8500"
+
+ LABEL=3D"ofono_isi_end"
+
+-SUBSYSTEM!=3D"usb", GOTO=3D"ofono_end"
+-ENV{DEVTYPE}!=3D"usb_device", GOTO=3D"ofono_end"
++# Possibly unmatched rules if CONFIG_USB_DEVICE_CLASS=3Dy
++# (deprecated config option)
++# See http://permalink.gmane.org/gmane.linux.lfs.devel/5791
++SUBSYSTEM!=3D"usb", GOTO=3D"test_usb_device"
++ENV{DEVTYPE}!=3D"usb_device", GOTO=3D"test_usb_device"
++GOTO=3D"set_ofono_driver"
++
++LABEL=3D"test_usb_device"
++# Workaround in case the above rules do not match
++SUBSYSTEM!=3D"usb_device", GOTO=3D"ofono_end"
++
++LABEL=3D"set_ofono_driver"
+
+ # Novatel Wireless
+ ATTRS{idVendor}=3D=3D"1410", ENV{OFONO_DRIVER}=3D"novatel"

Very likely it can be rewritten in some cleaner way.
It just falls back to checking usb_device as SUBSYSTEM in addition to
what it checks now (i.e., usb as SUBSYSTEM or usb_device as ENV{DEVTYPE}).
Also current checks could probably be removed as related to some
deprecated kernel configurations, but we left there for compatibility
reasons (they appear to be harmless after all).

Hope this patch may help! :)

> Some logs are attached.
> =

> Thanks, Artem
Regards,
  Paolo

--===============5945423554821590647==--

