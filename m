Content-Type: multipart/mixed; boundary="===============2154100489920054404=="
MIME-Version: 1.0
From: Frank Vasquez <frankv@helium.com>
Subject: Re: ublox TOBY-R200
Date: Thu, 13 Sep 2018 12:18:49 -0700
Message-ID: <CAFJydPW3jJaJnU6zM=qJyQ60NqvzNvRC3HSgVL6DAWjqOyKcoQ@mail.gmail.com>
In-Reply-To: <CAKSBH7HGo9kVrd5Si3gDo6tjr4ZMPmobhJEUD-LFFHM824FigQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2154100489920054404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

The TOBY-R200 is an LTE module.  I see that the ublox oFono plugin supports
LTE on the TOBY-L2 so maybe it will work on the TOBY-R200 as well.  I think
many of the AT commands are the same across ublox cellular modems so yes
let's give testing a shot.

I am using Buildroot to build oFono for my Linux device.

###########################################################################=
#####
#
# ofono
#
###########################################################################=
#####

OFONO_VERSION =3D 1.21
OFONO_SOURCE =3D ofono-$(OFONO_VERSION).tar.xz
OFONO_SITE =3D $(BR2_KERNEL_MIRROR)/linux/network/ofono
OFONO_LICENSE =3D GPL-2.0
OFONO_LICENSE_FILES =3D COPYING
OFONO_DEPENDENCIES =3D \
host-pkgconf \
dbus \
libglib2 \
libcap-ng \
mobile-broadband-provider-info

OFONO_CONF_OPTS =3D \
--disable-test \
--with-dbusconfdir=3D/etc \
$(if $(BR2_INIT_SYSTEMD),--with-systemdunitdir=3D/usr/lib/systemd/system)

# N.B. Qualcomm QMI modem support requires O_CLOEXEC; so
# make sure that it is defined.
OFONO_CONF_ENV +=3D CFLAGS=3D"$(TARGET_CFLAGS) -D_GNU_SOURCE"

define OFONO_INSTALL_INIT_SYSV
$(INSTALL) -m 0755 -D package/ofono/S46ofono
$(TARGET_DIR)/etc/init.d/S46ofono
endef

define OFONO_INSTALL_INIT_SYSTEMD
mkdir -p $(TARGET_DIR)/etc/systemd/systemd/multi-user.target.wants
ln -fs ../../../../usr/lib/systemd/system/ofono.service \
$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
endef

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
OFONO_CONF_OPTS +=3D --enable-udev
OFONO_DEPENDENCIES +=3D udev
else
OFONO_CONF_OPTS +=3D --disable-udev
endif

ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
OFONO_CONF_OPTS +=3D --enable-bluetooth
OFONO_DEPENDENCIES +=3D bluez_utils
else
OFONO_CONF_OPTS +=3D --disable-bluetooth
endif

$(eval $(autotools-package))

I can modify the downloaded oFono source code (plugins and drivers
directories) and rebuild it as needed to test the TOBY-R200.

$ ls -l output/build/ofono-1.21
total 2528
-rw-r--r--  1 frank frank    835 Oct  5  2017 acinclude.m4
-rw-r--r--  1 frank frank 360491 Oct  5  2017 aclocal.m4
-rw-r--r--  1 frank frank   5356 Oct  5  2017 AUTHORS
drwxr-xr-x  2 frank frank   4096 Oct  5  2017 btio
-rw-r--r--  1 frank frank  30811 Oct  5  2017 ChangeLog
-rwxr-xr-x  1 frank frank   7333 Oct  5  2017 compile
-rwxr-xr-x  1 frank frank  43765 Sep 13 11:39 config.guess
-rw-r--r--  1 frank frank   2775 Sep 13 11:39 config.h
-rw-r--r--  1 frank frank   2492 Oct  5  2017 config.h.in
-rw-r--r--  1 frank frank  42877 Sep 13 11:39 config.log
-rwxr-xr-x  1 frank frank  67571 Sep 13 11:39 config.status
-rwxr-xr-x  1 frank frank  36171 Sep 13 11:39 config.sub
-rwxr-xr-x  1 frank frank 467689 Oct  5  2017 configure
-rw-r--r--  1 frank frank   8223 Oct  5  2017 configure.ac
-rw-r--r--  1 frank frank  18011 Jul 10  2009 COPYING
-rwxr-xr-x  1 frank frank  23566 Oct  5  2017 depcomp
drwxr-xr-x  2 frank frank   4096 Oct  5  2017 doc
drwxr-xr-x 25 frank frank   4096 Oct  5  2017 drivers
drwxr-xr-x  2 frank frank   4096 Sep 13 11:39 dundee
drwxr-xr-x  2 frank frank   4096 Oct  5  2017 examples
drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gatchat
drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gdbus
drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gisi
drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gril
drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 include
-rw-r--r--  1 frank frank   9478 Jul 10  2009 INSTALL
-rwxr-xr-x  1 frank frank  14431 Oct  5  2017 install-sh
-rwxr-xr-x  1 frank frank 294282 Sep 13 11:39 libtool
-rw-r--r--  1 frank frank 283940 Sep 13 11:39 ltmain.sh
-rw-r--r--  1 frank frank 283672 Oct  5  2017 ltmain.sh.orig
-rw-r--r--  1 frank frank 185608 Sep 13 11:39 Makefile
-rw-r--r--  1 frank frank  28755 Oct  5  2017 Makefile.am
-rw-r--r--  1 frank frank 204311 Oct  5  2017 Makefile.in
-rwxr-xr-x  1 frank frank   6872 Oct  5  2017 missing
-rw-r--r--  1 frank frank      0 Jul 10  2009 NEWS
-rw-r--r--  1 frank frank    310 Sep 13 11:39 ofono.pc
-rw-r--r--  1 frank frank    325 Feb  6  2011 ofono.pc.in
drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 plugins
-rw-r--r--  1 frank frank    886 Jul 19  2012 README
drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 src
-rw-r--r--  1 frank frank     23 Sep 13 11:39 stamp-h1
drwxr-xr-x  2 frank frank   4096 Oct  5  2017 test
-rwxr-xr-x  1 frank frank   4287 Sep 13  2015 test-driver
-rw-r--r--  1 frank frank  17996 May  3  2016 TODO
drwxr-xr-x  2 frank frank   4096 Oct  5  2017 tools
drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 unit

Cheers,
Frank



On Thu, Sep 13, 2018 at 11:48 AM Giacinto Cifelli <gciofono@gmail.com>
wrote:

> hi Frank,
>
> your modem doesn't seem to be supported.
> There are these models:
> SARA_G270 =3D 1102,
> TOBYL2_COMPATIBLE_MODE =3D 1141,
> TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
> TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
> If your model is compatible with any of them, I can add  the 1107 for you
> for a test.
>
> from the PID, I would say it should be intermediate between the SARA_G260
> and the TOBYL2_COMPATIBLE_MODE.
> Most likely it will work this latter, but maybe not all features...
>
> Are you willing to test?
>
> Best regards,
> Giacinto
>
>
>
> On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com> wrote:
>
>> Hi Giacinto,
>>
>> > can you send the result of "lsusb" and "lsusb -t"?
>>
>> The usbutils version of lsusb is somewhat better.
>>
>> # lsusb
>> Bus 002 Device 001: ID 1d6b:0003
>> Bus 001 Device 002: ID 1546:1107
>> Bus 001 Device 001: ID 1d6b:0002
>> # lsusb -t
>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>>
>> And here is a relevant excerpt from lsusb -v.
>>
>> Bus 001 Device 002: ID 1546:1107
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               2.00
>>   bDeviceClass          239
>>   bDeviceSubClass         2
>>   bDeviceProtocol         1
>>   bMaxPacketSize0        64
>>   idVendor           0x1546
>>   idProduct          0x1107
>>   bcdDevice           17.29
>>   iManufacturer           1 u-blox
>>   iProduct                2 u-blox Cellular Module
>>   iSerial                 3 352848080392646
>>   bNumConfigurations      1
>>   Configuration Descriptor:
>>     bLength                 9
>>     bDescriptorType         2
>>     wTotalLength          405
>>     bNumInterfaces         12
>>     bConfigurationValue     1
>>     iConfiguration          0
>>     bmAttributes         0xe0
>>       Self Powered
>>       Remote Wakeup
>>     MaxPower              100mA
>>     Interface Association:
>>       bLength                 8
>>       bDescriptorType        11
>>       bFirstInterface         0
>>       bInterfaceCount         2
>>       bFunctionClass          2
>>       bFunctionSubClass       2
>>       bFunctionProtocol       1
>>       iFunction               4 CDC ACM
>> ...
>>
>> Cheers,
>> Frank
>>
>>
>> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com> wro=
te:
>>
>>> Hi Giacinto,
>>>
>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>
>>> # lsusb -t
>>> Bus 001 Device 001: ID 1d6b:0002
>>> Bus 001 Device 002: ID 1546:1107
>>> Bus 002 Device 001: ID 1d6b:0003
>>>
>>> I am running BusyBox's stripped down version of lsusb that's why
>>> information is so lacking.
>>> I'll install usbutils on my device's Buildroot image and rerun the
>>> commands.
>>>
>>> Cheers,
>>> Frank
>>>
>>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.com>
>>> wrote:
>>>
>>>> hi Frank,
>>>>
>>>> can you send the result of "lsusb" and "lsusb -t"?
>>>>
>>>> Giacinto
>>>>
>>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrote:
>>>>
>>>>> Greetings,
>>>>>
>>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want to use
>>>>> connman to manage any cellular connection on that modem since connman=
 is
>>>>> already managing ethernet and wifi connectivity.  oFono seems like th=
e best
>>>>> option.  I see that there is already a ublox plugin for oFono but I d=
on't
>>>>> think the TOBY-R200 is supported.  The cell module is soldered onto t=
he
>>>>> board and appears as a USB device.
>>>>>
>>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
>>>>> SerialNumber=3D3
>>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>>
>>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>>
>>>>> Cheers,
>>>>> Frank
>>>>> _______________________________________________
>>>>> ofono mailing list
>>>>> ofono(a)ofono.org
>>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>>
>>>>

--===============2154100489920054404==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8s
PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgVE9CWS1SMjAwIGlzIGFuIExURSBtb2R1bGUuwqAgSSBz
ZWUgdGhhdCB0aGUgdWJsb3ggb0Zvbm8gcGx1Z2luIHN1cHBvcnRzIExURSBvbiB0aGUgVE9CWS1M
MiBzbyBtYXliZSBpdCB3aWxsIHdvcmsgb24gdGhlIFRPQlktUjIwMCBhcyB3ZWxsLsKgIEkgdGhp
bmsgbWFueSBvZiB0aGUgQVQgY29tbWFuZHMgYXJlIHRoZSBzYW1lIGFjcm9zcyB1YmxveCBjZWxs
dWxhciBtb2RlbXMgc28geWVzIGxldCYjMzk7cyBnaXZlIHRlc3RpbmcgYSBzaG90LjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBhbSB1c2luZyBCdWlsZHJvb3QgdG8gYnVpbGQgb0Zvbm8gZm9y
IG15IExpbnV4IGRldmljZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+IyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyM8L2Rpdj48ZGl2PiM8L2Rpdj48ZGl2PiMgb2Zvbm88L2Rpdj48ZGl2PiM8
L2Rpdj48ZGl2PiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5PRk9OT19WRVJTSU9OID0gMS4yMTwvZGl2PjxkaXY+T0ZPTk9fU09VUkNFID0gb2Zvbm8tJChP
Rk9OT19WRVJTSU9OKS50YXIueHo8L2Rpdj48ZGl2Pk9GT05PX1NJVEUgPSAkKEJSMl9LRVJORUxf
TUlSUk9SKS9saW51eC9uZXR3b3JrL29mb25vPC9kaXY+PGRpdj5PRk9OT19MSUNFTlNFID0gR1BM
LTIuMDwvZGl2PjxkaXY+T0ZPTk9fTElDRU5TRV9GSUxFUyA9IENPUFlJTkc8L2Rpdj48ZGl2Pk9G
T05PX0RFUEVOREVOQ0lFUyA9IFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+aG9zdC1wa2djb25mIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+ZGJ1cyBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmxpYmdsaWIyIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+bGliY2FwLW5nIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bW9iaWxlLWJyb2FkYmFuZC1wcm92aWRlci1pbmZvPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgPSBcPC9kaXY+PGRpdj48c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi0tZGlzYWJsZS10ZXN0IFw8L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LS13aXRoLWRidXNjb25mZGly
PS9ldGMgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4k
KGlmICQoQlIyX0lOSVRfU1lTVEVNRCksLS13aXRoLXN5c3RlbWR1bml0ZGlyPS91c3IvbGliL3N5
c3RlbWQvc3lzdGVtKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+IyBOLkIuIFF1YWxjb21tIFFN
SSBtb2RlbSBzdXBwb3J0IHJlcXVpcmVzIE9fQ0xPRVhFQzsgc288L2Rpdj48ZGl2PiMgbWFrZSBz
dXJlIHRoYXQgaXQgaXMgZGVmaW5lZC48L2Rpdj48ZGl2Pk9GT05PX0NPTkZfRU5WICs9IENGTEFH
Uz0mcXVvdDskKFRBUkdFVF9DRkxBR1MpIC1EX0dOVV9TT1VSQ0UmcXVvdDs8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PmRlZmluZSBPRk9OT19JTlNUQUxMX0lOSVRfU1lTVjwvZGl2PjxkaXY+PHNw
YW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4kKElOU1RBTEwpIC1tIDA3NTUgLUQg
cGFja2FnZS9vZm9uby9TNDZvZm9ubyAkKFRBUkdFVF9ESVIpL2V0Yy9pbml0LmQvUzQ2b2Zvbm88
L2Rpdj48ZGl2PmVuZGVmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5kZWZpbmUgT0ZPTk9fSU5T
VEFMTF9JTklUX1NZU1RFTUQ8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+bWtkaXIgLXAgJChUQVJHRVRfRElSKS9ldGMvc3lzdGVtZC9zeXN0ZW1kL211bHRp
LXVzZXIudGFyZ2V0LndhbnRzPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmxuIC1mcyAuLi8uLi8uLi8uLi91c3IvbGliL3N5c3RlbWQvc3lzdGVtL29mb25v
LnNlcnZpY2UgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CQk8L3Nw
YW4+JChUQVJHRVRfRElSKS9ldGMvc3lzdGVtZC9zeXN0ZW0vbXVsdGktdXNlci50YXJnZXQud2Fu
dHM8L2Rpdj48ZGl2PmVuZGVmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pZmVxICgkKEJSMl9Q
QUNLQUdFX0hBU19VREVWKSx5KTwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9PUFRTICs9IC0tZW5hYmxl
LXVkZXY8L2Rpdj48ZGl2Pk9GT05PX0RFUEVOREVOQ0lFUyArPSB1ZGV2PC9kaXY+PGRpdj5lbHNl
PC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgKz0gLS1kaXNhYmxlLXVkZXY8L2Rpdj48ZGl2PmVu
ZGlmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pZmVxICgkKEJSMl9QQUNLQUdFX0JMVUVaX1VU
SUxTKSx5KTwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9PUFRTICs9IC0tZW5hYmxlLWJsdWV0b290aDwv
ZGl2PjxkaXY+T0ZPTk9fREVQRU5ERU5DSUVTICs9IGJsdWV6X3V0aWxzPC9kaXY+PGRpdj5lbHNl
PC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgKz0gLS1kaXNhYmxlLWJsdWV0b290aDwvZGl2Pjxk
aXY+ZW5kaWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiQoZXZhbCAkKGF1dG90b29scy1wYWNr
YWdlKSk8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgY2FuIG1vZGlmeSB0aGUgZG93
bmxvYWRlZCBvRm9ubyBzb3VyY2UgY29kZSAocGx1Z2lucyBhbmQgZHJpdmVycyBkaXJlY3Rvcmll
cykgYW5kIHJlYnVpbGQgaXQgYXMgbmVlZGVkIHRvIHRlc3QgdGhlIFRPQlktUjIwMC48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+JCBscyAtbCBvdXRwdXQvYnVpbGQvb2Zvbm8tMS4yMTwv
ZGl2PjxkaXY+dG90YWwgMjUyODwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvC
oCDCoCA4MzUgT2N0wqAgNcKgIDIwMTcgYWNpbmNsdWRlLm00PC9kaXY+PGRpdj4tcnctci0tci0t
wqAgMSBmcmFuayBmcmFuayAzNjA0OTEgT2N0wqAgNcKgIDIwMTcgYWNsb2NhbC5tNDwvZGl2Pjxk
aXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDUzNTYgT2N0wqAgNcKgIDIwMTcgQVVU
SE9SUzwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAg
NcKgIDIwMTcgYnRpbzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAzMDgx
MSBPY3TCoCA1wqAgMjAxNyBDaGFuZ2VMb2c8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5r
IGZyYW5rwqAgwqA3MzMzIE9jdMKgIDXCoCAyMDE3IGNvbXBpbGU8L2Rpdj48ZGl2Pi1yd3hyLXhy
LXjCoCAxIGZyYW5rIGZyYW5rwqAgNDM3NjUgU2VwIDEzIDExOjM5IGNvbmZpZy5ndWVzczwvZGl2
PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDI3NzUgU2VwIDEzIDExOjM5IGNv
bmZpZy5oPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgMjQ5MiBPY3TC
oCA1wqAgMjAxNyA8YSBocmVmPSJodHRwOi8vY29uZmlnLmguaW4iPmNvbmZpZy5oLmluPC9hPjwv
ZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCA0Mjg3NyBTZXAgMTMgMTE6Mzkg
Y29uZmlnLmxvZzwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCA2NzU3MSBT
ZXAgMTMgMTE6MzkgY29uZmlnLnN0YXR1czwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsg
ZnJhbmvCoCAzNjE3MSBTZXAgMTMgMTE6MzkgY29uZmlnLnN1YjwvZGl2PjxkaXY+LXJ3eHIteHIt
eMKgIDEgZnJhbmsgZnJhbmsgNDY3Njg5IE9jdMKgIDXCoCAyMDE3IGNvbmZpZ3VyZTwvZGl2Pjxk
aXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDgyMjMgT2N0wqAgNcKgIDIwMTcgPGEg
aHJlZj0iaHR0cDovL2NvbmZpZ3VyZS5hYyI+Y29uZmlndXJlLmFjPC9hPjwvZGl2PjxkaXY+LXJ3
LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAxODAxMSBKdWwgMTDCoCAyMDA5IENPUFlJTkc8L2Rp
dj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgMjM1NjYgT2N0wqAgNcKgIDIwMTcg
ZGVwY29tcDwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0
wqAgNcKgIDIwMTcgZG9jPC9kaXY+PGRpdj5kcnd4ci14ci14IDI1IGZyYW5rIGZyYW5rwqAgwqA0
MDk2IE9jdMKgIDXCoCAyMDE3IGRyaXZlcnM8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAyIGZyYW5r
IGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBkdW5kZWU8L2Rpdj48ZGl2PmRyd3hyLXhyLXjC
oCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IE9jdMKgIDXCoCAyMDE3IGV4YW1wbGVzPC9kaXY+PGRp
dj5kcnd4ci14ci14wqAgNCBmcmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgZ2F0Y2hh
dDwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDEx
OjM5IGdkYnVzPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMyBmcmFuayBmcmFua8KgIMKgNDA5NiBT
ZXAgMTMgMTE6MzkgZ2lzaTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsgZnJhbmvCoCDC
oDQwOTYgU2VwIDEzIDExOjM5IGdyaWw8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZyYW5rIGZy
YW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBpbmNsdWRlPC9kaXY+PGRpdj4tcnctci0tci0twqAg
MSBmcmFuayBmcmFua8KgIMKgOTQ3OCBKdWwgMTDCoCAyMDA5IElOU1RBTEw8L2Rpdj48ZGl2Pi1y
d3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgMTQ0MzEgT2N0wqAgNcKgIDIwMTcgaW5zdGFsbC1z
aDwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmsgMjk0MjgyIFNlcCAxMyAxMToz
OSBsaWJ0b29sPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFuayAyODM5NDAgU2Vw
IDEzIDExOjM5IGx0bWFpbi5zaDwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmsg
MjgzNjcyIE9jdMKgIDXCoCAyMDE3IGx0bWFpbi5zaC5vcmlnPC9kaXY+PGRpdj4tcnctci0tci0t
wqAgMSBmcmFuayBmcmFuayAxODU2MDggU2VwIDEzIDExOjM5IE1ha2VmaWxlPC9kaXY+PGRpdj4t
cnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDI4NzU1IE9jdMKgIDXCoCAyMDE3IE1ha2VmaWxl
LmFtPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFuayAyMDQzMTEgT2N0wqAgNcKg
IDIwMTcgTWFrZWZpbGUuaW48L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAg
wqA2ODcyIE9jdMKgIDXCoCAyMDE3IG1pc3Npbmc8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZy
YW5rIGZyYW5rwqAgwqAgwqAgMCBKdWwgMTDCoCAyMDA5IE5FV1M8L2Rpdj48ZGl2Pi1ydy1yLS1y
LS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgMzEwIFNlcCAxMyAxMTozOSBvZm9uby5wYzwvZGl2Pjxk
aXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCAzMjUgRmViwqAgNsKgIDIwMTEgPGEg
aHJlZj0iaHR0cDovL29mb25vLnBjLmluIj5vZm9uby5wYy5pbjwvYT48L2Rpdj48ZGl2PmRyd3hy
LXhyLXjCoCAzIGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBwbHVnaW5zPC9kaXY+
PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDg4NiBKdWwgMTnCoCAyMDEyIFJF
QURNRTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEz
IDExOjM5IHNyYzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCDCoDIz
IFNlcCAxMyAxMTozOSBzdGFtcC1oMTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJh
bmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgdGVzdDwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEg
ZnJhbmsgZnJhbmvCoCDCoDQyODcgU2VwIDEzwqAgMjAxNSB0ZXN0LWRyaXZlcjwvZGl2PjxkaXY+
LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAxNzk5NiBNYXnCoCAzwqAgMjAxNiBUT0RPPC9k
aXY+PGRpdj5kcnd4ci14ci14wqAgMiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAx
NyB0b29sczwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2Vw
IDEzIDExOjM5IHVuaXQ8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rp
dj48ZGl2PkZyYW5rPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBU
aHUsIFNlcCAxMywgMjAxOCBhdCAxMTo0OCBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVm
PSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIj5nY2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3
cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFl
eCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9
Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBk
aXI9Imx0ciI+aGkgRnJhbmssPGRpdj48YnI+PC9kaXY+PGRpdj55b3VyIG1vZGVtIGRvZXNuJiMz
OTt0IHNlZW0gdG8gYmUgc3VwcG9ydGVkLjwvZGl2PjxkaXY+VGhlcmUgYXJlIHRoZXNlIG1vZGVs
czo8L2Rpdj48ZGl2PjxkaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAi
Pgk8L3NwYW4+U0FSQV9HMjcwPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCQk8
L3NwYW4+PSAxMTAyLDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFw
Ij4JPC9zcGFuPlRPQllMMl9DT01QQVRJQkxFX01PREU8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlLXdyYXAiPgkJPC9zcGFuPj0gMTE0MSw8YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+VE9CWUwyX01FRElVTV9USFJPVUdIUFVUX01PREU8
c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+PSAxMTQzLDwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPlRPQllMMl9ISUdI
X1RIUk9VR0hQVVRfTU9ERTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bh
bj49IDExNDYsPC9kaXY+PC9kaXY+PGRpdj5JZiB5b3VyIG1vZGVsIGlzIGNvbXBhdGlibGUgd2l0
aCBhbnkgb2YgdGhlbSwgSSBjYW4gYWRkwqAgdGhlIDExMDcgZm9yIHlvdSBmb3IgYSB0ZXN0Ljxi
cj48L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmZyb20gdGhlIFBJRCwgSSB3b3VsZCBz
YXkgaXQgc2hvdWxkIGJlIGludGVybWVkaWF0ZSBiZXR3ZWVuIHRoZSBTQVJBX0cyNjAgYW5kIHRo
ZSBUT0JZTDJfQ09NUEFUSUJMRV9NT0RFLjwvZGl2PjxkaXY+TW9zdCBsaWtlbHkgaXQgd2lsbCB3
b3JrIHRoaXMgbGF0dGVyLCBidXQgbWF5YmUgbm90IGFsbCBmZWF0dXJlcy4uLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+QXJlIHlvdSB3aWxsaW5nIHRvIHRlc3Q/PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5CZXN0IHJlZ2FyZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24g
VGh1LCBTZXAgMTMsIDIwMTggYXQgNzo0OCBQTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJt
YWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNv
bTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRy
Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5IaSBHaWFjaW50byw8L2Rpdj48ZGl2IGRp
cj0ibHRyIj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+Jmd0O8KgPHNwYW4gc3R5bGU9ImNvbG9y
OnJnYig4MCwwLDgwKSI+Y2FuIHlvdSBzZW5kIHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVv
dDsgYW5kICZxdW90O2xzdXNiIC10JnF1b3Q7Pzwvc3Bhbj48L2Rpdj48ZGl2IGRpcj0ibHRyIj48
YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+VGhlIHVzYnV0aWxzIHZlcnNpb24gb2YgbHN1c2IgaXMg
c29tZXdoYXQgYmV0dGVyLjwvZGl2PjxkaXYgZGlyPSJsdHIiPjxicj48ZGl2PjxkaXY+IyBsc3Vz
YjwvZGl2PjxkaXY+QnVzIDAwMiBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDPCoMKgPC9kaXY+PGRp
dj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1NDY6MTEwN8KgwqA8L2Rpdj48ZGl2PkJ1cyAwMDEg
RGV2aWNlIDAwMTogSUQgMWQ2YjowMDAywqDCoDwvZGl2PjxkaXY+IyBsc3VzYiAtdDwvZGl2Pjxk
aXY+LzrCoCBCdXMgMDIuUG9ydCAxOiBEZXYgMSwgQ2xhc3M9cm9vdF9odWIsIERyaXZlcj14aGNp
LWhjZC8xcCwgNTAwME08L2Rpdj48ZGl2Pi86wqAgQnVzIDAxLlBvcnQgMTogRGV2IDEsIENsYXNz
PXJvb3RfaHViLCBEcml2ZXI9eGhjaS1oY2QvMXAsIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQ
b3J0IDE6IERldiAyLCBJZiAwLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRp
dj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwg
NDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDIsIENsYXNzPSwgRHJp
dmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAz
LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAx
OiBEZXYgMiwgSWYgNCwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAg
wqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDUsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08
L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA2LCBDbGFzcz0sIERyaXZlcj1j
ZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNywgQ2xh
c3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2
IDIsIElmIDgsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxf
XyBQb3J0IDE6IERldiAyLCBJZiA5LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+
PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMTAsIENsYXNzPSwgRHJpdmVyPWNkY19h
Y20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAxMSwgQ2xhc3M9
LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QW5k
IGhlcmUgaXMgYSByZWxldmFudCBleGNlcnB0IGZyb20gbHN1c2IgLXYuPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj48ZGl2PkJ1cyAwMDEgRGV2aWNlIDAwMjogSUQgMTU0NjoxMTA3PC9kaXY+PGRp
dj5EZXZpY2UgRGVzY3JpcHRvcjo8L2Rpdj48ZGl2PsKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAxODwvZGl2PjxkaXY+wqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqAxPC9k
aXY+PGRpdj7CoCBiY2RVU0LCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDIuMDA8L2Rpdj48ZGl2PsKg
IGJEZXZpY2VDbGFzc8KgIMKgIMKgIMKgIMKgIDIzOTwvZGl2PjxkaXY+wqAgYkRldmljZVN1YkNs
YXNzwqAgwqAgwqAgwqAgwqAyPC9kaXY+PGRpdj7CoCBiRGV2aWNlUHJvdG9jb2zCoCDCoCDCoCDC
oCDCoDE8L2Rpdj48ZGl2PsKgIGJNYXhQYWNrZXRTaXplMMKgIMKgIMKgIMKgIDY0PC9kaXY+PGRp
dj7CoCBpZFZlbmRvcsKgIMKgIMKgIMKgIMKgIMKgMHgxNTQ2PC9kaXY+PGRpdj7CoCBpZFByb2R1
Y3TCoCDCoCDCoCDCoCDCoCAweDExMDc8L2Rpdj48ZGl2PsKgIGJjZERldmljZcKgIMKgIMKgIMKg
IMKgIMKgMTcuMjk8L2Rpdj48ZGl2PsKgIGlNYW51ZmFjdHVyZXLCoCDCoCDCoCDCoCDCoCDCoDEg
dS1ibG94PC9kaXY+PGRpdj7CoCBpUHJvZHVjdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDIgdS1i
bG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+wqAgaVNlcmlhbMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgMyAzNTI4NDgwODAzOTI2NDY8L2Rpdj48ZGl2PsKgIGJOdW1Db25maWd1cmF0aW9u
c8KgIMKgIMKgIDE8L2Rpdj48ZGl2PsKgIENvbmZpZ3VyYXRpb24gRGVzY3JpcHRvcjo8L2Rpdj48
ZGl2PsKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDk8L2Rpdj48ZGl2PsKg
IMKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAgd1RvdGFs
TGVuZ3RowqAgwqAgwqAgwqAgwqAgNDA1PC9kaXY+PGRpdj7CoCDCoCBiTnVtSW50ZXJmYWNlc8Kg
IMKgIMKgIMKgIMKgMTI8L2Rpdj48ZGl2PsKgIMKgIGJDb25maWd1cmF0aW9uVmFsdWXCoCDCoCDC
oDE8L2Rpdj48ZGl2PsKgIMKgIGlDb25maWd1cmF0aW9uwqAgwqAgwqAgwqAgwqAgMDwvZGl2Pjxk
aXY+wqAgwqAgYm1BdHRyaWJ1dGVzwqAgwqAgwqAgwqAgwqAweGUwPC9kaXY+PGRpdj7CoCDCoCDC
oCBTZWxmIFBvd2VyZWQ8L2Rpdj48ZGl2PsKgIMKgIMKgIFJlbW90ZSBXYWtldXA8L2Rpdj48ZGl2
PsKgIMKgIE1heFBvd2VywqAgwqAgwqAgwqAgwqAgwqAgwqAgMTAwbUE8L2Rpdj48ZGl2PsKgIMKg
IEludGVyZmFjZSBBc3NvY2lhdGlvbjo8L2Rpdj48ZGl2PsKgIMKgIMKgIGJMZW5ndGjCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDg8L2Rpdj48ZGl2PsKgIMKgIMKgIGJEZXNjcmlwdG9yVHlwZcKg
IMKgIMKgIMKgIDExPC9kaXY+PGRpdj7CoCDCoCDCoCBiRmlyc3RJbnRlcmZhY2XCoCDCoCDCoCDC
oCDCoDA8L2Rpdj48ZGl2PsKgIMKgIMKgIGJJbnRlcmZhY2VDb3VudMKgIMKgIMKgIMKgIMKgMjwv
ZGl2PjxkaXY+wqAgwqAgwqAgYkZ1bmN0aW9uQ2xhc3PCoCDCoCDCoCDCoCDCoCAyPC9kaXY+PGRp
dj7CoCDCoCDCoCBiRnVuY3Rpb25TdWJDbGFzc8KgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAg
wqAgYkZ1bmN0aW9uUHJvdG9jb2zCoCDCoCDCoCDCoDE8L2Rpdj48ZGl2PsKgIMKgIMKgIGlGdW5j
dGlvbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNCBDREMgQUNNPC9kaXY+PGRpdj4uLi48L2Rpdj48
L2Rpdj48ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAy
MDE4IGF0IDEwOjIxIEFNIEZyYW5rIFZhc3F1ZXogJmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZA
aGVsaXVtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3Jv
dGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPkhpIEdpYWNpbnRvLDxkaXY+PGJyPjwvZGl2
PjxkaXY+Jmd0OyBjYW4geW91IHNlbmQgdGhlIHJlc3VsdCBvZiAmcXVvdDtsc3VzYiZxdW90OyBh
bmQgJnF1b3Q7bHN1c2IgLXQmcXVvdDs/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PiMg
bHN1c2IgLXQ8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAyPC9kaXY+
PGRpdj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1NDY6MTEwNzwvZGl2PjxkaXY+QnVzIDAwMiBE
ZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDM8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkg
YW0gcnVubmluZyBCdXN5Qm94JiMzOTtzIHN0cmlwcGVkIGRvd24gdmVyc2lvbiBvZiBsc3VzYiB0
aGF0JiMzOTtzIHdoeSBpbmZvcm1hdGlvbiBpcyBzbyBsYWNraW5nLjwvZGl2PjxkaXY+SSYjMzk7
bGwgaW5zdGFsbCB1c2J1dGlscyBvbiBteSBkZXZpY2UmIzM5O3MgQnVpbGRyb290IGltYWdlIGFu
ZCByZXJ1biB0aGUgY29tbWFuZHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9k
aXY+PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90
ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMzo0OSBBTSBHaWFjaW50
byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9
Il9ibGFuayI+Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJhdXRvIj5o
aSBGcmFuayw8ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5jYW4geW91
IHNlbmQgdGhlIHJlc3VsdCBvZiAmcXVvdDtsc3VzYiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQm
cXVvdDs/PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+R2lh
Y2ludG88L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJs
dHIiPk9uIFRodSwgMTMgU2VwIDIwMTgsIDAwOjQxIEZyYW5rIFZhc3F1ZXosICZsdDs8YSBocmVm
PSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVt
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5HcmVldGluZ3Ms
PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgYW4gZW1iZWRkZWQgZGV2aWNlIHdpdGggYSB1Ymxv
eCBUT0JZLVIyMDAgb24gaXQuwqAgSSB3YW50IHRvIHVzZSBjb25ubWFuIHRvIG1hbmFnZSBhbnkg
Y2VsbHVsYXIgY29ubmVjdGlvbiBvbiB0aGF0IG1vZGVtIHNpbmNlIGNvbm5tYW4gaXMgYWxyZWFk
eSBtYW5hZ2luZyBldGhlcm5ldCBhbmQgd2lmaSBjb25uZWN0aXZpdHkuwqAgb0Zvbm8gc2VlbXMg
bGlrZSB0aGUgYmVzdCBvcHRpb24uwqAgSSBzZWUgdGhhdCB0aGVyZSBpcyBhbHJlYWR5IGEgdWJs
b3ggcGx1Z2luIGZvciBvRm9ubyBidXQgSSBkb24mIzM5O3QgdGhpbmsgdGhlIFRPQlktUjIwMCBp
cyBzdXBwb3J0ZWQuwqAgVGhlIGNlbGwgbW9kdWxlIGlzIHNvbGRlcmVkIG9udG8gdGhlIGJvYXJk
IGFuZCBhcHBlYXJzIGFzIGEgVVNCIGRldmljZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxk
aXY+W8KgIMKgIDYuNTE5MTkwXSB1c2IgMS0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9
MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9MzwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTk3XSB1
c2IgMS0xOiBQcm9kdWN0OiB1LWJsb3ggQ2VsbHVsYXIgTW9kdWxlPC9kaXY+PGRpdj5bwqAgwqAg
Ni41MTkyMDRdIHVzYiAxLTE6IE1hbnVmYWN0dXJlcjogdS1ibG94PC9kaXY+PGRpdj5bwqAgwqAg
Ni41MTkyMTFdIHVzYiAxLTE6IFNlcmlhbE51bWJlcjogMzUyODQ4MDgwMzkyNjQ2PC9kaXY+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGNhbiBzZW5kIEFUIGNvbW1hbmRzIHRvIHRoZSBtb2Rl
bSBvdmVyIC9kZXYvdHR5QUNNMC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rp
dj48ZGl2PkZyYW5rPC9kaXY+PC9kaXY+PC9kaXY+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9
Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
Pm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3Jn
L21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJn
ZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9u
bzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2Nr
cXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============2154100489920054404==--

