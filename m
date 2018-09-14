Content-Type: multipart/mixed; boundary="===============6759250650827498843=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: ublox TOBY-R200
Date: Fri, 14 Sep 2018 06:19:06 +0200
Message-ID: <CAKSBH7EzciXney5qCMcu94KiA1JA2rxRgEH2Aj8M-ntr3Xct3w@mail.gmail.com>
In-Reply-To: <CAFJydPWY9GRgW-=HFprZWj7m3JUCxO_WtVAH-WhSzz2BWxHPnw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6759250650827498843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frank,

both TOBYL2_COMPATIBLE_MODE and  TOBYL2_HIGH_THROUGHPUT_MODE behave the
same in the code.
(TOBYL2_MEDIUM_THROUGHPUT_MODE is recognized but discarded later in the
code)
Please replace the two attached files in the plugins directory.
Let me know if it works (it would be good to know which functionalities you
try out), and if so I can submit the changes as patches.

You don't need the udev rule for usb modems, it is recognized automatically.

Best Regards,
Giacinto





On Thu, Sep 13, 2018 at 10:51 PM Frank Vasquez <frankv@helium.com> wrote:

> Hi Giancito,
>
> I modified ublox.c as follows.
>
> enum supported_models {
>         SARA_G270                       =3D 1102,
>         TOBYL2_COMPATIBLE_MODE          =3D 1141,
>         TOBYL2_MEDIUM_THROUGHPUT_MODE   =3D 1143,
>         TOBYL2_HIGH_THROUGHPUT_MODE     =3D 1107,  /* was 1146 */
> };
>
> And still no luck.
>
> # ./list-modems
> #
>
> I see no evidence that oFono's ublox driver is being loaded even though I
> added the following line to 60-serial-rules in
> /etc/udev/rules.d/60-serial-rules.
>
> KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"ublox"
>
> I want TOBYL2_HIGH_THROUGHPUT_MODE because that's the mode that uses LTE.
>
> Cheers,
> Frank
>
>
> On Thu, Sep 13, 2018 at 12:18 PM Frank Vasquez <frankv@helium.com> wrot=
e:
>
>> Hi Giacinto,
>>
>> The TOBY-R200 is an LTE module.  I see that the ublox oFono plugin
>> supports LTE on the TOBY-L2 so maybe it will work on the TOBY-R200 as
>> well.  I think many of the AT commands are the same across ublox cellular
>> modems so yes let's give testing a shot.
>>
>> I am using Buildroot to build oFono for my Linux device.
>>
>>
>> ########################################################################=
########
>> #
>> # ofono
>> #
>>
>> ########################################################################=
########
>>
>> OFONO_VERSION =3D 1.21
>> OFONO_SOURCE =3D ofono-$(OFONO_VERSION).tar.xz
>> OFONO_SITE =3D $(BR2_KERNEL_MIRROR)/linux/network/ofono
>> OFONO_LICENSE =3D GPL-2.0
>> OFONO_LICENSE_FILES =3D COPYING
>> OFONO_DEPENDENCIES =3D \
>> host-pkgconf \
>> dbus \
>> libglib2 \
>> libcap-ng \
>> mobile-broadband-provider-info
>>
>> OFONO_CONF_OPTS =3D \
>> --disable-test \
>> --with-dbusconfdir=3D/etc \
>> $(if $(BR2_INIT_SYSTEMD),--with-systemdunitdir=3D/usr/lib/systemd/system)
>>
>> # N.B. Qualcomm QMI modem support requires O_CLOEXEC; so
>> # make sure that it is defined.
>> OFONO_CONF_ENV +=3D CFLAGS=3D"$(TARGET_CFLAGS) -D_GNU_SOURCE"
>>
>> define OFONO_INSTALL_INIT_SYSV
>> $(INSTALL) -m 0755 -D package/ofono/S46ofono
>> $(TARGET_DIR)/etc/init.d/S46ofono
>> endef
>>
>> define OFONO_INSTALL_INIT_SYSTEMD
>> mkdir -p $(TARGET_DIR)/etc/systemd/systemd/multi-user.target.wants
>> ln -fs ../../../../usr/lib/systemd/system/ofono.service \
>> $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
>> endef
>>
>> ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
>> OFONO_CONF_OPTS +=3D --enable-udev
>> OFONO_DEPENDENCIES +=3D udev
>> else
>> OFONO_CONF_OPTS +=3D --disable-udev
>> endif
>>
>> ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
>> OFONO_CONF_OPTS +=3D --enable-bluetooth
>> OFONO_DEPENDENCIES +=3D bluez_utils
>> else
>> OFONO_CONF_OPTS +=3D --disable-bluetooth
>> endif
>>
>> $(eval $(autotools-package))
>>
>> I can modify the downloaded oFono source code (plugins and drivers
>> directories) and rebuild it as needed to test the TOBY-R200.
>>
>> $ ls -l output/build/ofono-1.21
>> total 2528
>> -rw-r--r--  1 frank frank    835 Oct  5  2017 acinclude.m4
>> -rw-r--r--  1 frank frank 360491 Oct  5  2017 aclocal.m4
>> -rw-r--r--  1 frank frank   5356 Oct  5  2017 AUTHORS
>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 btio
>> -rw-r--r--  1 frank frank  30811 Oct  5  2017 ChangeLog
>> -rwxr-xr-x  1 frank frank   7333 Oct  5  2017 compile
>> -rwxr-xr-x  1 frank frank  43765 Sep 13 11:39 config.guess
>> -rw-r--r--  1 frank frank   2775 Sep 13 11:39 config.h
>> -rw-r--r--  1 frank frank   2492 Oct  5  2017 config.h.in
>> -rw-r--r--  1 frank frank  42877 Sep 13 11:39 config.log
>> -rwxr-xr-x  1 frank frank  67571 Sep 13 11:39 config.status
>> -rwxr-xr-x  1 frank frank  36171 Sep 13 11:39 config.sub
>> -rwxr-xr-x  1 frank frank 467689 Oct  5  2017 configure
>> -rw-r--r--  1 frank frank   8223 Oct  5  2017 configure.ac
>> -rw-r--r--  1 frank frank  18011 Jul 10  2009 COPYING
>> -rwxr-xr-x  1 frank frank  23566 Oct  5  2017 depcomp
>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 doc
>> drwxr-xr-x 25 frank frank   4096 Oct  5  2017 drivers
>> drwxr-xr-x  2 frank frank   4096 Sep 13 11:39 dundee
>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 examples
>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gatchat
>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gdbus
>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gisi
>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gril
>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 include
>> -rw-r--r--  1 frank frank   9478 Jul 10  2009 INSTALL
>> -rwxr-xr-x  1 frank frank  14431 Oct  5  2017 install-sh
>> -rwxr-xr-x  1 frank frank 294282 Sep 13 11:39 libtool
>> -rw-r--r--  1 frank frank 283940 Sep 13 11:39 ltmain.sh
>> -rw-r--r--  1 frank frank 283672 Oct  5  2017 ltmain.sh.orig
>> -rw-r--r--  1 frank frank 185608 Sep 13 11:39 Makefile
>> -rw-r--r--  1 frank frank  28755 Oct  5  2017 Makefile.am
>> -rw-r--r--  1 frank frank 204311 Oct  5  2017 Makefile.in
>> -rwxr-xr-x  1 frank frank   6872 Oct  5  2017 missing
>> -rw-r--r--  1 frank frank      0 Jul 10  2009 NEWS
>> -rw-r--r--  1 frank frank    310 Sep 13 11:39 ofono.pc
>> -rw-r--r--  1 frank frank    325 Feb  6  2011 ofono.pc.in
>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 plugins
>> -rw-r--r--  1 frank frank    886 Jul 19  2012 README
>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 src
>> -rw-r--r--  1 frank frank     23 Sep 13 11:39 stamp-h1
>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 test
>> -rwxr-xr-x  1 frank frank   4287 Sep 13  2015 test-driver
>> -rw-r--r--  1 frank frank  17996 May  3  2016 TODO
>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 tools
>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 unit
>>
>> Cheers,
>> Frank
>>
>>
>>
>> On Thu, Sep 13, 2018 at 11:48 AM Giacinto Cifelli <gciofono@gmail.com>
>> wrote:
>>
>>> hi Frank,
>>>
>>> your modem doesn't seem to be supported.
>>> There are these models:
>>> SARA_G270 =3D 1102,
>>> TOBYL2_COMPATIBLE_MODE =3D 1141,
>>> TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
>>> TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
>>> If your model is compatible with any of them, I can add  the 1107 for
>>> you for a test.
>>>
>>> from the PID, I would say it should be intermediate between the
>>> SARA_G260 and the TOBYL2_COMPATIBLE_MODE.
>>> Most likely it will work this latter, but maybe not all features...
>>>
>>> Are you willing to test?
>>>
>>> Best regards,
>>> Giacinto
>>>
>>>
>>>
>>> On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com> wro=
te:
>>>
>>>> Hi Giacinto,
>>>>
>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>
>>>> The usbutils version of lsusb is somewhat better.
>>>>
>>>> # lsusb
>>>> Bus 002 Device 001: ID 1d6b:0003
>>>> Bus 001 Device 002: ID 1546:1107
>>>> Bus 001 Device 001: ID 1d6b:0002
>>>> # lsusb -t
>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
>>>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>>>>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>>>>
>>>> And here is a relevant excerpt from lsusb -v.
>>>>
>>>> Bus 001 Device 002: ID 1546:1107
>>>> Device Descriptor:
>>>>   bLength                18
>>>>   bDescriptorType         1
>>>>   bcdUSB               2.00
>>>>   bDeviceClass          239
>>>>   bDeviceSubClass         2
>>>>   bDeviceProtocol         1
>>>>   bMaxPacketSize0        64
>>>>   idVendor           0x1546
>>>>   idProduct          0x1107
>>>>   bcdDevice           17.29
>>>>   iManufacturer           1 u-blox
>>>>   iProduct                2 u-blox Cellular Module
>>>>   iSerial                 3 352848080392646
>>>>   bNumConfigurations      1
>>>>   Configuration Descriptor:
>>>>     bLength                 9
>>>>     bDescriptorType         2
>>>>     wTotalLength          405
>>>>     bNumInterfaces         12
>>>>     bConfigurationValue     1
>>>>     iConfiguration          0
>>>>     bmAttributes         0xe0
>>>>       Self Powered
>>>>       Remote Wakeup
>>>>     MaxPower              100mA
>>>>     Interface Association:
>>>>       bLength                 8
>>>>       bDescriptorType        11
>>>>       bFirstInterface         0
>>>>       bInterfaceCount         2
>>>>       bFunctionClass          2
>>>>       bFunctionSubClass       2
>>>>       bFunctionProtocol       1
>>>>       iFunction               4 CDC ACM
>>>> ...
>>>>
>>>> Cheers,
>>>> Frank
>>>>
>>>>
>>>> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com>
>>>> wrote:
>>>>
>>>>> Hi Giacinto,
>>>>>
>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>
>>>>> # lsusb -t
>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>> Bus 001 Device 002: ID 1546:1107
>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>
>>>>> I am running BusyBox's stripped down version of lsusb that's why
>>>>> information is so lacking.
>>>>> I'll install usbutils on my device's Buildroot image and rerun the
>>>>> commands.
>>>>>
>>>>> Cheers,
>>>>> Frank
>>>>>
>>>>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.co=
m>
>>>>> wrote:
>>>>>
>>>>>> hi Frank,
>>>>>>
>>>>>> can you send the result of "lsusb" and "lsusb -t"?
>>>>>>
>>>>>> Giacinto
>>>>>>
>>>>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrot=
e:
>>>>>>
>>>>>>> Greetings,
>>>>>>>
>>>>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want to
>>>>>>> use connman to manage any cellular connection on that modem since c=
onnman
>>>>>>> is already managing ethernet and wifi connectivity.  oFono seems li=
ke the
>>>>>>> best option.  I see that there is already a ublox plugin for oFono =
but I
>>>>>>> don't think the TOBY-R200 is supported.  The cell module is soldere=
d onto
>>>>>>> the board and appears as a USB device.
>>>>>>>
>>>>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D=
2,
>>>>>>> SerialNumber=3D3
>>>>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>>>>
>>>>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Frank
>>>>>>> _______________________________________________
>>>>>>> ofono mailing list
>>>>>>> ofono(a)ofono.org
>>>>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>>>>
>>>>>>

--===============6759250650827498843==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRnJhbmssPGRpdj48YnI+PC9kaXY+PGRpdj5ib3RowqA8c3BhbiBz
dHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5UT0JZTDJfQ09NUEFUSUJMRV9NT0RFIGFuZMKgPC9z
cGFuPjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPsKgPC9zcGFuPjxzcGFuIHN0eWxl
PSJjb2xvcjpyZ2IoODAsMCw4MCkiPlRPQllMMl9ISUdIX1RIUk9VR0hQVVRfTU9ERSBiZWhhdmUg
dGhlIHNhbWUgaW4gdGhlIGNvZGUuPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9y
OnJnYig4MCwwLDgwKSI+KDwvc3Bhbj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5U
T0JZTDJfTUVESVVNX1RIUk9VR0hQVVRfTU9ERSBpcyByZWNvZ25pemVkIGJ1dCBkaXNjYXJkZWQg
bGF0ZXIgaW4gdGhlIGNvZGUpPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJn
Yig4MCwwLDgwKSI+UGxlYXNlIHJlcGxhY2UgdGhlIHR3byBhdHRhY2hlZCBmaWxlcyBpbiB0aGUg
cGx1Z2lucyBkaXJlY3RvcnkuPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJn
Yig4MCwwLDgwKSI+TGV0IG1lIGtub3cgaWYgaXQgd29ya3MgKGl0IHdvdWxkIGJlIGdvb2QgdG8g
a25vdyB3aGljaCBmdW5jdGlvbmFsaXRpZXMgeW91IHRyeSBvdXQpLCBhbmQgaWYgc28gSSBjYW4g
c3VibWl0IHRoZSBjaGFuZ2VzIGFzIHBhdGNoZXMuPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5
bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxl
PSJjb2xvcjpyZ2IoODAsMCw4MCkiPllvdSBkb24mIzM5O3QgbmVlZCB0aGUgdWRldiBydWxlIGZv
ciB1c2IgbW9kZW1zLCBpdCBpcyByZWNvZ25pemVkIGF1dG9tYXRpY2FsbHkuPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+PGJyPjwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPkJlc3QgUmVnYXJkcyw8L3NwYW4+
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5HaWFjaW50bzwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPjxicj48L3NwYW4+
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj48YnI+PC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+PGJyPjwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPjxicj48L3NwYW4+PC9kaXY+
PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUs
IFNlcCAxMywgMjAxOCBhdCAxMDo1MSBQTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWls
dG86ZnJhbmt2QGhlbGl1bS5jb20iPmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAg
MCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYg
ZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPkhp
IEdpYW5jaXRvLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBtb2RpZmllZCB1YmxveC5jIGFzIGZvbGxv
d3MuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PmVudW0gc3VwcG9ydGVkX21vZGVscyB7
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTQVJBX0cyNzDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoD0gMTEwMiw8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFRPQllMMl9DT01QQVRJQkxF
X01PREXCoCDCoCDCoCDCoCDCoCA9IDExNDEsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBUT0JZTDJf
TUVESVVNX1RIUk9VR0hQVVRfTU9ERcKgIMKgPSAxMTQzLDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAg
VE9CWUwyX0hJR0hfVEhST1VHSFBVVF9NT0RFwqAgwqAgwqA9IDExMDcswqAgLyogd2FzIDExNDYg
Ki88L2Rpdj48ZGl2Pn07PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmQgc3RpbGwg
bm8gbHVjay48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+IyAuL2xpc3QtbW9kZW1zwqA8
L2Rpdj48ZGl2PiM8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2VlIG5vIGV2aWRl
bmNlIHRoYXQgb0Zvbm8mIzM5O3MgdWJsb3ggZHJpdmVyIGlzIGJlaW5nIGxvYWRlZCBldmVuIHRo
b3VnaCBJIGFkZGVkIHRoZSBmb2xsb3dpbmcgbGluZSB0byA2MC1zZXJpYWwtcnVsZXMgaW4gL2V0
Yy91ZGV2L3J1bGVzLmQvNjAtc2VyaWFsLXJ1bGVzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
S0VSTkVMPT0mcXVvdDt0dHlBQ00wJnF1b3Q7LCBFTlZ7T0ZPTk9fRFJJVkVSfT0mcXVvdDt1Ymxv
eCZxdW90Ozxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2FudCBUT0JZTDJfSElHSF9U
SFJPVUdIUFVUX01PREUgYmVjYXVzZSB0aGF0JiMzOTtzIHRoZSBtb2RlIHRoYXQgdXNlcyBMVEUu
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTI6MTggUE0g
RnJhbmsgVmFzcXVleiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJn
ZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+
PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8sPGRpdj48YnI+PC9kaXY+
PGRpdj5UaGUgVE9CWS1SMjAwIGlzIGFuIExURSBtb2R1bGUuwqAgSSBzZWUgdGhhdCB0aGUgdWJs
b3ggb0Zvbm8gcGx1Z2luIHN1cHBvcnRzIExURSBvbiB0aGUgVE9CWS1MMiBzbyBtYXliZSBpdCB3
aWxsIHdvcmsgb24gdGhlIFRPQlktUjIwMCBhcyB3ZWxsLsKgIEkgdGhpbmsgbWFueSBvZiB0aGUg
QVQgY29tbWFuZHMgYXJlIHRoZSBzYW1lIGFjcm9zcyB1YmxveCBjZWxsdWxhciBtb2RlbXMgc28g
eWVzIGxldCYjMzk7cyBnaXZlIHRlc3RpbmcgYSBzaG90LjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+SSBhbSB1c2luZyBCdWlsZHJvb3QgdG8gYnVpbGQgb0Zvbm8gZm9yIG15IExpbnV4IGRldmlj
ZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyM8
L2Rpdj48ZGl2PiM8L2Rpdj48ZGl2PiMgb2Zvbm88L2Rpdj48ZGl2PiM8L2Rpdj48ZGl2PiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PRk9OT19WRVJTSU9O
ID0gMS4yMTwvZGl2PjxkaXY+T0ZPTk9fU09VUkNFID0gb2Zvbm8tJChPRk9OT19WRVJTSU9OKS50
YXIueHo8L2Rpdj48ZGl2Pk9GT05PX1NJVEUgPSAkKEJSMl9LRVJORUxfTUlSUk9SKS9saW51eC9u
ZXR3b3JrL29mb25vPC9kaXY+PGRpdj5PRk9OT19MSUNFTlNFID0gR1BMLTIuMDwvZGl2PjxkaXY+
T0ZPTk9fTElDRU5TRV9GSUxFUyA9IENPUFlJTkc8L2Rpdj48ZGl2Pk9GT05PX0RFUEVOREVOQ0lF
UyA9IFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bh
bj5ob3N0LXBrZ2NvbmYgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13
cmFwIj4JPC9zcGFuPmRidXMgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZS13cmFwIj4JPC9zcGFuPmxpYmdsaWIyIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5saWJjYXAtbmcgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPm1vYmlsZS1icm9hZGJhbmQtcHJvdmlkZXIt
aW5mbzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9PUFRTID0gXDwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPi0tZGlzYWJsZS10
ZXN0IFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bh
bj4tLXdpdGgtZGJ1c2NvbmZkaXI9L2V0YyBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+JChpZiAkKEJSMl9JTklUX1NZU1RFTUQpLC0td2l0aC1z
eXN0ZW1kdW5pdGRpcj0vdXNyL2xpYi9zeXN0ZW1kL3N5c3RlbSk8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PiMgTi5CLiBRdWFsY29tbSBRTUkgbW9kZW0gc3VwcG9ydCByZXF1aXJlcyBPX0NMT0VY
RUM7IHNvPC9kaXY+PGRpdj4jIG1ha2Ugc3VyZSB0aGF0IGl0IGlzIGRlZmluZWQuPC9kaXY+PGRp
dj5PRk9OT19DT05GX0VOViArPSBDRkxBR1M9JnF1b3Q7JChUQVJHRVRfQ0ZMQUdTKSAtRF9HTlVf
U09VUkNFJnF1b3Q7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5kZWZpbmUgT0ZPTk9fSU5TVEFM
TF9JTklUX1NZU1Y8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+
CTwvc3Bhbj4kKElOU1RBTEwpIC1tIDA3NTUgLUQgcGFja2FnZS9vZm9uby9TNDZvZm9ubyAkKFRB
UkdFVF9ESVIpL2V0Yy9pbml0LmQvUzQ2b2Zvbm88L2Rpdj48ZGl2PmVuZGVmPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5kZWZpbmUgT0ZPTk9fSU5TVEFMTF9JTklUX1NZU1RFTUQ8L2Rpdj48ZGl2
PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5ta2RpciAtcCAkKFRB
UkdFVF9ESVIpL2V0Yy9zeXN0ZW1kL3N5c3RlbWQvbXVsdGktdXNlci50YXJnZXQud2FudHM8L2Rp
dj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5sbiAtZnMg
Li4vLi4vLi4vLi4vdXNyL2xpYi9zeXN0ZW1kL3N5c3RlbS9vZm9uby5zZXJ2aWNlIFw8L2Rpdj48
ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CQk8L3NwYW4+JChUQVJHRVRf
RElSKS9ldGMvc3lzdGVtZC9zeXN0ZW0vbXVsdGktdXNlci50YXJnZXQud2FudHM8L2Rpdj48ZGl2
PmVuZGVmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pZmVxICgkKEJSMl9QQUNLQUdFX0hBU19V
REVWKSx5KTwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9PUFRTICs9IC0tZW5hYmxlLXVkZXY8L2Rpdj48
ZGl2Pk9GT05PX0RFUEVOREVOQ0lFUyArPSB1ZGV2PC9kaXY+PGRpdj5lbHNlPC9kaXY+PGRpdj5P
Rk9OT19DT05GX09QVFMgKz0gLS1kaXNhYmxlLXVkZXY8L2Rpdj48ZGl2PmVuZGlmPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5pZmVxICgkKEJSMl9QQUNLQUdFX0JMVUVaX1VUSUxTKSx5KTwvZGl2
PjxkaXY+T0ZPTk9fQ09ORl9PUFRTICs9IC0tZW5hYmxlLWJsdWV0b290aDwvZGl2PjxkaXY+T0ZP
Tk9fREVQRU5ERU5DSUVTICs9IGJsdWV6X3V0aWxzPC9kaXY+PGRpdj5lbHNlPC9kaXY+PGRpdj5P
Rk9OT19DT05GX09QVFMgKz0gLS1kaXNhYmxlLWJsdWV0b290aDwvZGl2PjxkaXY+ZW5kaWY8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PiQoZXZhbCAkKGF1dG90b29scy1wYWNrYWdlKSk8L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgY2FuIG1vZGlmeSB0aGUgZG93bmxvYWRlZCBvRm9u
byBzb3VyY2UgY29kZSAocGx1Z2lucyBhbmQgZHJpdmVycyBkaXJlY3RvcmllcykgYW5kIHJlYnVp
bGQgaXQgYXMgbmVlZGVkIHRvIHRlc3QgdGhlIFRPQlktUjIwMC48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PjxkaXY+JCBscyAtbCBvdXRwdXQvYnVpbGQvb2Zvbm8tMS4yMTwvZGl2PjxkaXY+dG90
YWwgMjUyODwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCA4MzUgT2N0
wqAgNcKgIDIwMTcgYWNpbmNsdWRlLm00PC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBm
cmFuayAzNjA0OTEgT2N0wqAgNcKgIDIwMTcgYWNsb2NhbC5tNDwvZGl2PjxkaXY+LXJ3LXItLXIt
LcKgIDEgZnJhbmsgZnJhbmvCoCDCoDUzNTYgT2N0wqAgNcKgIDIwMTcgQVVUSE9SUzwvZGl2Pjxk
aXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgYnRp
bzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAzMDgxMSBPY3TCoCA1wqAg
MjAxNyBDaGFuZ2VMb2c8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgwqA3
MzMzIE9jdMKgIDXCoCAyMDE3IGNvbXBpbGU8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5r
IGZyYW5rwqAgNDM3NjUgU2VwIDEzIDExOjM5IGNvbmZpZy5ndWVzczwvZGl2PjxkaXY+LXJ3LXIt
LXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDI3NzUgU2VwIDEzIDExOjM5IGNvbmZpZy5oPC9kaXY+
PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgMjQ5MiBPY3TCoCA1wqAgMjAxNyA8
YSBocmVmPSJodHRwOi8vY29uZmlnLmguaW4iIHRhcmdldD0iX2JsYW5rIj5jb25maWcuaC5pbjwv
YT48L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgNDI4NzcgU2VwIDEzIDEx
OjM5IGNvbmZpZy5sb2c8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgNjc1
NzEgU2VwIDEzIDExOjM5IGNvbmZpZy5zdGF0dXM8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZy
YW5rIGZyYW5rwqAgMzYxNzEgU2VwIDEzIDExOjM5IGNvbmZpZy5zdWI8L2Rpdj48ZGl2Pi1yd3hy
LXhyLXjCoCAxIGZyYW5rIGZyYW5rIDQ2NzY4OSBPY3TCoCA1wqAgMjAxNyBjb25maWd1cmU8L2Rp
dj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqA4MjIzIE9jdMKgIDXCoCAyMDE3
IDxhIGhyZWY9Imh0dHA6Ly9jb25maWd1cmUuYWMiIHRhcmdldD0iX2JsYW5rIj5jb25maWd1cmUu
YWM8L2E+PC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDE4MDExIEp1bCAx
MMKgIDIwMDkgQ09QWUlORzwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCAy
MzU2NiBPY3TCoCA1wqAgMjAxNyBkZXBjb21wPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMiBmcmFu
ayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyBkb2M8L2Rpdj48ZGl2PmRyd3hyLXhyLXgg
MjUgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgZHJpdmVyczwvZGl2PjxkaXY+
ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IGR1bmRlZTwv
ZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIw
MTcgZXhhbXBsZXM8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCA0IGZyYW5rIGZyYW5rwqAgwqA0MDk2
IFNlcCAxMyAxMTozOSBnYXRjaGF0PC9kaXY+PGRpdj5kcnd4ci14ci14wqAgNCBmcmFuayBmcmFu
a8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgZ2RidXM8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZy
YW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBnaXNpPC9kaXY+PGRpdj5kcnd4ci14ci14
wqAgMyBmcmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgZ3JpbDwvZGl2PjxkaXY+ZHJ3
eHIteHIteMKgIDMgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IGluY2x1ZGU8L2Rp
dj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqA5NDc4IEp1bCAxMMKgIDIwMDkg
SU5TVEFMTDwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCAxNDQzMSBPY3TC
oCA1wqAgMjAxNyBpbnN0YWxsLXNoPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFu
ayAyOTQyODIgU2VwIDEzIDExOjM5IGxpYnRvb2w8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZy
YW5rIGZyYW5rIDI4Mzk0MCBTZXAgMTMgMTE6MzkgbHRtYWluLnNoPC9kaXY+PGRpdj4tcnctci0t
ci0twqAgMSBmcmFuayBmcmFuayAyODM2NzIgT2N0wqAgNcKgIDIwMTcgbHRtYWluLnNoLm9yaWc8
L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rIDE4NTYwOCBTZXAgMTMgMTE6Mzkg
TWFrZWZpbGU8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgMjg3NTUgT2N0
wqAgNcKgIDIwMTcgTWFrZWZpbGUuYW08L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZy
YW5rIDIwNDMxMSBPY3TCoCA1wqAgMjAxNyBNYWtlZmlsZS5pbjwvZGl2PjxkaXY+LXJ3eHIteHIt
eMKgIDEgZnJhbmsgZnJhbmvCoCDCoDY4NzIgT2N0wqAgNcKgIDIwMTcgbWlzc2luZzwvZGl2Pjxk
aXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCDCoCAwIEp1bCAxMMKgIDIwMDkgTkVX
UzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCAzMTAgU2VwIDEzIDEx
OjM5IG9mb25vLnBjPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDMy
NSBGZWLCoCA2wqAgMjAxMSA8YSBocmVmPSJodHRwOi8vb2Zvbm8ucGMuaW4iIHRhcmdldD0iX2Js
YW5rIj5vZm9uby5wYy5pbjwvYT48L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZyYW5rIGZyYW5r
wqAgwqA0MDk2IFNlcCAxMyAxMTozOSBwbHVnaW5zPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBm
cmFuayBmcmFua8KgIMKgIDg4NiBKdWwgMTnCoCAyMDEyIFJFQURNRTwvZGl2PjxkaXY+ZHJ3eHIt
eHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IHNyYzwvZGl2PjxkaXY+
LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCDCoDIzIFNlcCAxMyAxMTozOSBzdGFtcC1o
MTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKg
IDIwMTcgdGVzdDwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCDCoDQyODcg
U2VwIDEzwqAgMjAxNSB0ZXN0LWRyaXZlcjwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsg
ZnJhbmvCoCAxNzk5NiBNYXnCoCAzwqAgMjAxNiBUT0RPPC9kaXY+PGRpdj5kcnd4ci14ci14wqAg
MiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyB0b29sczwvZGl2PjxkaXY+ZHJ3
eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IHVuaXQ8L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAx
MTo0OCBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21h
aWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPmhpIEZyYW5rLDxkaXY+PGJyPjwvZGl2PjxkaXY+eW91ciBtb2RlbSBkb2VzbiYjMzk7dCBz
ZWVtIHRvIGJlIHN1cHBvcnRlZC48L2Rpdj48ZGl2PlRoZXJlIGFyZSB0aGVzZSBtb2RlbHM6PC9k
aXY+PGRpdj48ZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9z
cGFuPlNBUkFfRzI3MDxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CQkJPC9zcGFu
Pj0gMTEwMiw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwv
c3Bhbj5UT0JZTDJfQ09NUEFUSUJMRV9NT0RFPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13
cmFwIj4JCTwvc3Bhbj49IDExNDEsPGJyPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNw
YWNlOnByZS13cmFwIj4JPC9zcGFuPlRPQllMMl9NRURJVU1fVEhST1VHSFBVVF9NT0RFPHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPj0gMTE0Myw8L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5UT0JZTDJfSElHSF9USFJP
VUdIUFVUX01PREU8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+PSAx
MTQ2LDwvZGl2PjwvZGl2PjxkaXY+SWYgeW91ciBtb2RlbCBpcyBjb21wYXRpYmxlIHdpdGggYW55
IG9mIHRoZW0sIEkgY2FuIGFkZMKgIHRoZSAxMTA3IGZvciB5b3UgZm9yIGEgdGVzdC48YnI+PC9k
aXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5mcm9tIHRoZSBQSUQsIEkgd291bGQgc2F5IGl0
IHNob3VsZCBiZSBpbnRlcm1lZGlhdGUgYmV0d2VlbiB0aGUgU0FSQV9HMjYwIGFuZCB0aGUgVE9C
WUwyX0NPTVBBVElCTEVfTU9ERS48L2Rpdj48ZGl2Pk1vc3QgbGlrZWx5IGl0IHdpbGwgd29yayB0
aGlzIGxhdHRlciwgYnV0IG1heWJlIG5vdCBhbGwgZmVhdHVyZXMuLi48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PkFyZSB5b3Ugd2lsbGluZyB0byB0ZXN0PzwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+R2lhY2ludG88L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwg
U2VwIDEzLCAyMDE4IGF0IDc6NDggUE0gRnJhbmsgVmFzcXVleiAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmZyYW5rdkBoZWxpdW0uY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRp
diBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8sPC9kaXY+PGRpdiBkaXI9Imx0
ciI+PGJyPjwvZGl2PjxkaXYgZGlyPSJsdHIiPiZndDvCoDxzcGFuIHN0eWxlPSJjb2xvcjpyZ2Io
ODAsMCw4MCkiPmNhbiB5b3Ugc2VuZCB0aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFu
ZCAmcXVvdDtsc3VzYiAtdCZxdW90Oz88L3NwYW4+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJsdHIiPlRoZSB1c2J1dGlscyB2ZXJzaW9uIG9mIGxzdXNiIGlzIHNvbWV3
aGF0IGJldHRlci48L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PGRpdj48ZGl2PiMgbHN1c2I8L2Rp
dj48ZGl2PkJ1cyAwMDIgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAzwqDCoDwvZGl2PjxkaXY+QnVz
IDAwMSBEZXZpY2UgMDAyOiBJRCAxNTQ2OjExMDfCoMKgPC9kaXY+PGRpdj5CdXMgMDAxIERldmlj
ZSAwMDE6IElEIDFkNmI6MDAwMsKgwqA8L2Rpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2Pi86
wqAgQnVzIDAyLlBvcnQgMTogRGV2IDEsIENsYXNzPXJvb3RfaHViLCBEcml2ZXI9eGhjaS1oY2Qv
MXAsIDUwMDBNPC9kaXY+PGRpdj4vOsKgIEJ1cyAwMS5Qb3J0IDE6IERldiAxLCBDbGFzcz1yb290
X2h1YiwgRHJpdmVyPXhoY2ktaGNkLzFwLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAx
OiBEZXYgMiwgSWYgMCwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAg
wqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDEsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08
L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAyLCBDbGFzcz0sIERyaXZlcj1j
ZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMywgQ2xh
c3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2
IDIsIElmIDQsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxf
XyBQb3J0IDE6IERldiAyLCBJZiA1LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+
PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNiwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2Fj
bSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDcsIENsYXNzPSwg
RHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJ
ZiA4LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9y
dCAxOiBEZXYgMiwgSWYgOSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+
wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDEwLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0
ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMTEsIENsYXNzPSwgRHJp
dmVyPWNkY19hY20sIDQ4ME08L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBoZXJl
IGlzIGEgcmVsZXZhbnQgZXhjZXJwdCBmcm9tIGxzdXNiIC12LjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1NDY6MTEwNzwvZGl2PjxkaXY+RGV2
aWNlIERlc2NyaXB0b3I6PC9kaXY+PGRpdj7CoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgMTg8L2Rpdj48ZGl2PsKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgMTwvZGl2Pjxk
aXY+wqAgYmNkVVNCwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyLjAwPC9kaXY+PGRpdj7CoCBiRGV2
aWNlQ2xhc3PCoCDCoCDCoCDCoCDCoCAyMzk8L2Rpdj48ZGl2PsKgIGJEZXZpY2VTdWJDbGFzc8Kg
IMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgYkRldmljZVByb3RvY29swqAgwqAgwqAgwqAgwqAx
PC9kaXY+PGRpdj7CoCBiTWF4UGFja2V0U2l6ZTDCoCDCoCDCoCDCoCA2NDwvZGl2PjxkaXY+wqAg
aWRWZW5kb3LCoCDCoCDCoCDCoCDCoCDCoDB4MTU0NjwvZGl2PjxkaXY+wqAgaWRQcm9kdWN0wqAg
wqAgwqAgwqAgwqAgMHgxMTA3PC9kaXY+PGRpdj7CoCBiY2REZXZpY2XCoCDCoCDCoCDCoCDCoCDC
oDE3LjI5PC9kaXY+PGRpdj7CoCBpTWFudWZhY3R1cmVywqAgwqAgwqAgwqAgwqAgwqAxIHUtYmxv
eDwvZGl2PjxkaXY+wqAgaVByb2R1Y3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAyIHUtYmxveCBD
ZWxsdWxhciBNb2R1bGU8L2Rpdj48ZGl2PsKgIGlTZXJpYWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDMgMzUyODQ4MDgwMzkyNjQ2PC9kaXY+PGRpdj7CoCBiTnVtQ29uZmlndXJhdGlvbnPCoCDC
oCDCoCAxPC9kaXY+PGRpdj7CoCBDb25maWd1cmF0aW9uIERlc2NyaXB0b3I6PC9kaXY+PGRpdj7C
oCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5PC9kaXY+PGRpdj7CoCDCoCBi
RGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIHdUb3RhbExlbmd0
aMKgIMKgIMKgIMKgIMKgIDQwNTwvZGl2PjxkaXY+wqAgwqAgYk51bUludGVyZmFjZXPCoCDCoCDC
oCDCoCDCoDEyPC9kaXY+PGRpdj7CoCDCoCBiQ29uZmlndXJhdGlvblZhbHVlwqAgwqAgwqAxPC9k
aXY+PGRpdj7CoCDCoCBpQ29uZmlndXJhdGlvbsKgIMKgIMKgIMKgIMKgIDA8L2Rpdj48ZGl2PsKg
IMKgIGJtQXR0cmlidXRlc8KgIMKgIMKgIMKgIMKgMHhlMDwvZGl2PjxkaXY+wqAgwqAgwqAgU2Vs
ZiBQb3dlcmVkPC9kaXY+PGRpdj7CoCDCoCDCoCBSZW1vdGUgV2FrZXVwPC9kaXY+PGRpdj7CoCDC
oCBNYXhQb3dlcsKgIMKgIMKgIMKgIMKgIMKgIMKgIDEwMG1BPC9kaXY+PGRpdj7CoCDCoCBJbnRl
cmZhY2UgQXNzb2NpYXRpb246PC9kaXY+PGRpdj7CoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA4PC9kaXY+PGRpdj7CoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDC
oCDCoCAxMTwvZGl2PjxkaXY+wqAgwqAgwqAgYkZpcnN0SW50ZXJmYWNlwqAgwqAgwqAgwqAgwqAw
PC9kaXY+PGRpdj7CoCDCoCDCoCBiSW50ZXJmYWNlQ291bnTCoCDCoCDCoCDCoCDCoDI8L2Rpdj48
ZGl2PsKgIMKgIMKgIGJGdW5jdGlvbkNsYXNzwqAgwqAgwqAgwqAgwqAgMjwvZGl2PjxkaXY+wqAg
wqAgwqAgYkZ1bmN0aW9uU3ViQ2xhc3PCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIMKgIGJG
dW5jdGlvblByb3RvY29swqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCDCoCDCoCBpRnVuY3Rpb27C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQgQ0RDIEFDTTwvZGl2PjxkaXY+Li4uPC9kaXY+PC9kaXY+
PGRpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRp
dj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBh
dCAxMDoyMSBBTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1
bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2
IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5IaSBHaWFjaW50byw8ZGl2Pjxicj48L2Rpdj48ZGl2
PiZndDsgY2FuIHlvdSBzZW5kIHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZx
dW90O2xzdXNiIC10JnF1b3Q7PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4jIGxzdXNi
IC10PC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDE6IElEIDFkNmI6MDAwMjwvZGl2PjxkaXY+
QnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAxNTQ2OjExMDc8L2Rpdj48ZGl2PkJ1cyAwMDIgRGV2aWNl
IDAwMTogSUQgMWQ2YjowMDAzPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHJ1
bm5pbmcgQnVzeUJveCYjMzk7cyBzdHJpcHBlZCBkb3duIHZlcnNpb24gb2YgbHN1c2IgdGhhdCYj
Mzk7cyB3aHkgaW5mb3JtYXRpb24gaXMgc28gbGFja2luZy48L2Rpdj48ZGl2PkkmIzM5O2xsIGlu
c3RhbGwgdXNidXRpbHMgb24gbXkgZGV2aWNlJiMzOTtzIEJ1aWxkcm9vdCBpbWFnZSBhbmQgcmVy
dW4gdGhlIGNvbW1hbmRzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2Pjxk
aXY+RnJhbms8L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxk
aXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDM6NDkgQU0gR2lhY2ludG8gQ2lm
ZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxh
bmsiPmdjaW9mb25vQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVm
dDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0iYXV0byI+aGkgRnJh
bmssPGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+Y2FuIHlvdSBzZW5k
IHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZxdW90O2xzdXNiIC10JnF1b3Q7
PzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkdpYWNpbnRv
PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5P
biBUaHUsIDEzIFNlcCAyMDE4LCAwMDo0MSBGcmFuayBWYXNxdWV6LCAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdzLDxkaXY+
PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGFuIGVtYmVkZGVkIGRldmljZSB3aXRoIGEgdWJsb3ggVE9C
WS1SMjAwIG9uIGl0LsKgIEkgd2FudCB0byB1c2UgY29ubm1hbiB0byBtYW5hZ2UgYW55IGNlbGx1
bGFyIGNvbm5lY3Rpb24gb24gdGhhdCBtb2RlbSBzaW5jZSBjb25ubWFuIGlzIGFscmVhZHkgbWFu
YWdpbmcgZXRoZXJuZXQgYW5kIHdpZmkgY29ubmVjdGl2aXR5LsKgIG9Gb25vIHNlZW1zIGxpa2Ug
dGhlIGJlc3Qgb3B0aW9uLsKgIEkgc2VlIHRoYXQgdGhlcmUgaXMgYWxyZWFkeSBhIHVibG94IHBs
dWdpbiBmb3Igb0Zvbm8gYnV0IEkgZG9uJiMzOTt0IHRoaW5rIHRoZSBUT0JZLVIyMDAgaXMgc3Vw
cG9ydGVkLsKgIFRoZSBjZWxsIG1vZHVsZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBib2FyZCBhbmQg
YXBwZWFycyBhcyBhIFVTQiBkZXZpY2UuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PlvC
oCDCoCA2LjUxOTE5MF0gdXNiIDEtMTogTmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFBy
b2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTM8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTE5N10gdXNiIDEt
MTogUHJvZHVjdDogdS1ibG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5
MjA0XSB1c2IgMS0xOiBNYW51ZmFjdHVyZXI6IHUtYmxveDwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5
MjExXSB1c2IgMS0xOiBTZXJpYWxOdW1iZXI6IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBjYW4gc2VuZCBBVCBjb21tYW5kcyB0byB0aGUgbW9kZW0gb3Zl
ciAvZGV2L3R0eUFDTTAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRp
dj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWls
dG86b2Zvbm9Ab2Zvbm8ub3JnIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5vZm9u
b0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWls
bWFuL2xpc3RpbmZvL29mb25vIiByZWw9Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+
PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3Rl
PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1
b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============6759250650827498843==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ublox.c"

LyoKICoKICogIG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBob255CiAqCiAqICBDb3B5cmlnaHQg
KEMpIDIwMTQgIFBoaWxpcCBQYWVwcy4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KICoKICogIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5CiAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIHZlcnNpb24gMiBhcwogKiAgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb24uCiAqCiAqICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0
aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiAqICBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCiAqICBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgogKgogKiAgWW91IHNob3VsZCBoYXZl
IHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKICogIGFs
b25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJl
CiAqICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdCwgRmlmdGggRmxvb3IsIEJvc3Rv
biwgTUEgIDAyMTEwLTEzMDEgIFVTQQogKgogKi8KCiNpZmRlZiBIQVZFX0NPTkZJR19ICiNpbmNs
dWRlIDxjb25maWcuaD4KI2VuZGlmCgojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgoKI2luY2x1ZGUgPGdsaWIuaD4KI2luY2x1ZGUgPGdhdGNoYXQuaD4KI2luY2x1ZGUgPGdh
dHR0eS5oPgoKI2RlZmluZSBPRk9OT19BUElfU1VCSkVDVF9UT19DSEFOR0UKI2luY2x1ZGUgPG9m
b25vL3BsdWdpbi5oPgojaW5jbHVkZSA8b2Zvbm8vbW9kZW0uaD4KI2luY2x1ZGUgPG9mb25vL2Rl
dmluZm8uaD4KI2luY2x1ZGUgPG9mb25vL25ldHJlZy5oPgojaW5jbHVkZSA8b2Zvbm8vc2ltLmg+
CiNpbmNsdWRlIDxvZm9uby9ncHJzLmg+CiNpbmNsdWRlIDxvZm9uby9ncHJzLWNvbnRleHQuaD4K
I2luY2x1ZGUgPG9mb25vL25ldG1vbi5oPgojaW5jbHVkZSA8b2Zvbm8vbHRlLmg+CiNpbmNsdWRl
IDxvZm9uby92b2ljZWNhbGwuaD4KCiNpbmNsdWRlIDxkcml2ZXJzL2F0bW9kZW0vYXR1dGlsLmg+
CiNpbmNsdWRlIDxkcml2ZXJzL2F0bW9kZW0vdmVuZG9yLmg+CgpzdGF0aWMgY29uc3QgY2hhciAq
bm9uZV9wcmVmaXhbXSA9IHsgTlVMTCB9OwoKZW51bSBzdXBwb3J0ZWRfbW9kZWxzIHsKCVNBUkFf
RzI3MAkJCT0gMTEwMiwKCVRPQllfUjIwMAkJCT0gMTEwNywKCVRPQllMMl9DT01QQVRJQkxFX01P
REUJCT0gMTE0MSwKCVRPQllMMl9NRURJVU1fVEhST1VHSFBVVF9NT0RFCT0gMTE0MywKCVRPQllM
Ml9ISUdIX1RIUk9VR0hQVVRfTU9ERQk9IDExNDYsCn07CgpzdHJ1Y3QgdWJsb3hfZGF0YSB7CglH
QXRDaGF0ICptb2RlbTsKCUdBdENoYXQgKmF1eDsKCWludCBtb2RlbF9pZDsKCWVudW0gb2Zvbm9f
dmVuZG9yIHZlbmRvcl9mYW1pbHk7Cn07CgpzdGF0aWMgdm9pZCB1YmxveF9kZWJ1Zyhjb25zdCBj
aGFyICpzdHIsIHZvaWQgKnVzZXJfZGF0YSkKewoJY29uc3QgY2hhciAqcHJlZml4ID0gdXNlcl9k
YXRhOwoKCW9mb25vX2luZm8oIiVzJXMiLCBwcmVmaXgsIHN0cik7Cn0KCnN0YXRpYyBpbnQgdWJs
b3hfcHJvYmUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSkKewoJc3RydWN0IHVibG94X2RhdGEg
KmRhdGE7CgoJREJHKCIlcCIsIG1vZGVtKTsKCglkYXRhID0gZ190cnlfbmV3MChzdHJ1Y3QgdWJs
b3hfZGF0YSwgMSk7CglpZiAoZGF0YSA9PSBOVUxMKQoJCXJldHVybiAtRU5PTUVNOwoKCW9mb25v
X21vZGVtX3NldF9kYXRhKG1vZGVtLCBkYXRhKTsKCglyZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQg
dWJsb3hfcmVtb3ZlKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pCnsKCXN0cnVjdCB1YmxveF9k
YXRhICpkYXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOwoKCURCRygiJXAiLCBtb2Rl
bSk7CgoJb2Zvbm9fbW9kZW1fc2V0X2RhdGEobW9kZW0sIE5VTEwpOwoJZ19hdF9jaGF0X3VucmVm
KGRhdGEtPmF1eCk7CglnX2F0X2NoYXRfdW5yZWYoZGF0YS0+bW9kZW0pOwoJZ19mcmVlKGRhdGEp
Owp9CgpzdGF0aWMgR0F0Q2hhdCAqb3Blbl9kZXZpY2Uoc3RydWN0IG9mb25vX21vZGVtICptb2Rl
bSwKCQkJCWNvbnN0IGNoYXIgKmtleSwgY2hhciAqZGVidWcpCnsKCWNvbnN0IGNoYXIgKmRldmlj
ZTsKCUdBdFN5bnRheCAqc3ludGF4OwoJR0lPQ2hhbm5lbCAqY2hhbm5lbDsKCUdBdENoYXQgKmNo
YXQ7CgoJZGV2aWNlID0gb2Zvbm9fbW9kZW1fZ2V0X3N0cmluZyhtb2RlbSwga2V5KTsKCWlmIChk
ZXZpY2UgPT0gTlVMTCkKCQlyZXR1cm4gTlVMTDsKCglEQkcoIiVzICVzIiwga2V5LCBkZXZpY2Up
OwoKCWNoYW5uZWwgPSBnX2F0X3R0eV9vcGVuKGRldmljZSwgTlVMTCk7CglpZiAoY2hhbm5lbCA9
PSBOVUxMKQoJCXJldHVybiBOVUxMOwoKCXN5bnRheCA9IGdfYXRfc3ludGF4X25ld19nc21fcGVy
bWlzc2l2ZSgpOwoJY2hhdCA9IGdfYXRfY2hhdF9uZXcoY2hhbm5lbCwgc3ludGF4KTsKCWdfYXRf
c3ludGF4X3VucmVmKHN5bnRheCk7CgoJZ19pb19jaGFubmVsX3VucmVmKGNoYW5uZWwpOwoKCWlm
IChjaGF0ID09IE5VTEwpCgkJcmV0dXJuIE5VTEw7CgoJaWYgKGdldGVudigiT0ZPTk9fQVRfREVC
VUciKSkKCQlnX2F0X2NoYXRfc2V0X2RlYnVnKGNoYXQsIHVibG94X2RlYnVnLCBkZWJ1Zyk7CgoJ
cmV0dXJuIGNoYXQ7Cn0KCnN0YXRpYyB2b2lkIGNmdW5fZW5hYmxlKGdib29sZWFuIG9rLCBHQXRS
ZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKQp7CglzdHJ1Y3Qgb2Zvbm9fbW9kZW0g
Km1vZGVtID0gdXNlcl9kYXRhOwoJc3RydWN0IHVibG94X2RhdGEgKiBkYXRhID0gb2Zvbm9fbW9k
ZW1fZ2V0X2RhdGEobW9kZW0pOwoKCURCRygib2sgJWQiLCBvayk7CgoJaWYgKCFvaykgewoJCWdf
YXRfY2hhdF91bnJlZihkYXRhLT5hdXgpOwoJCWRhdGEtPmF1eCA9IE5VTEw7CgkJZ19hdF9jaGF0
X3VucmVmKGRhdGEtPm1vZGVtKTsKCQlkYXRhLT5tb2RlbSA9IE5VTEw7CgkJb2Zvbm9fbW9kZW1f
c2V0X3Bvd2VyZWQobW9kZW0sIEZBTFNFKTsKCQlyZXR1cm47Cgl9CgoJaWYgKGRhdGEtPm1vZGVs
X2lkID09IFRPQllMMl9ISUdIX1RIUk9VR0hQVVRfTU9ERSkKCQkvKiB1c2UgYnJpZGdlZCBtb2Rl
IHVudGlsIHJvdXRlZCBtb2RlIHN1cHBvcnQgaXMgYWRkZWQgKi8KCQlnX2F0X2NoYXRfc2VuZChk
YXRhLT5hdXgsICJBVCtVQk1DT05GPTIiLCBub25lX3ByZWZpeCwKCQkJCQkJTlVMTCwgTlVMTCwg
TlVMTCk7CgoJb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQobW9kZW0sIFRSVUUpOwp9CgpzdGF0aWMg
aW50IHVibG94X2VuYWJsZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKQp7CglzdHJ1Y3QgdWJs
b3hfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTsKCWNvbnN0IGNoYXIg
Km1vZGVsX3N0ciA9IE5VTEw7CgoJREJHKCIlcCIsIG1vZGVtKTsKCgltb2RlbF9zdHIgPSBvZm9u
b19tb2RlbV9nZXRfc3RyaW5nKG1vZGVtLCAiTW9kZWwiKTsKCWlmIChtb2RlbF9zdHIgPT0gTlVM
TCkKCQlyZXR1cm4gLUVJTlZBTDsKCgkvKgoJICogVG9ieSBMMiBkZXZpY2VzIGFyZSBtb3JlIGNv
bXBsZXggYW5kIHNwZWNpYWwgdGhhbiBwcmV2aW91c2x5CgkgKiBzdXBwb3J0ZWQgVS1CbG94IGRl
dmljZXMuIFNvIHRoZXkgbmVlZCBhIHZlbmRvciBvZiB0aGVpciBvd24uCgkgKi8KCWRhdGEtPm1v
ZGVsX2lkID0gYXRvaShtb2RlbF9zdHIpOwoKCXN3aXRjaCAoZGF0YS0+bW9kZWxfaWQpIHsKCWNh
c2UgU0FSQV9HMjcwOgoJCWRhdGEtPnZlbmRvcl9mYW1pbHkgPSBPRk9OT19WRU5ET1JfVUJMT1g7
CgkJYnJlYWs7CgljYXNlIFRPQllfUjIwMDoKCWNhc2UgVE9CWUwyX0NPTVBBVElCTEVfTU9ERToK
CWNhc2UgVE9CWUwyX0hJR0hfVEhST1VHSFBVVF9NT0RFOgoJCWRhdGEtPnZlbmRvcl9mYW1pbHkg
PSBPRk9OT19WRU5ET1JfVUJMT1hfVE9CWV9MMjsKCQlicmVhazsKCWNhc2UgVE9CWUwyX01FRElV
TV9USFJPVUdIUFVUX01PREU6CgkJREJHKCJsb3cvbWVkaXVtIHRocm91Z2h0cHV0IHByb2ZpbGUg
dW5zdXBwb3J0ZWQiKTsKCQlicmVhazsKCWRlZmF1bHQ6CgkJREJHKCJ1bmtub3duIHVibG94IG1v
ZGVsIGlkICVkIiwgZGF0YS0+bW9kZWxfaWQpOwoJCXJldHVybiAtRUlOVkFMOwoJfQoKCWRhdGEt
PmF1eCA9IG9wZW5fZGV2aWNlKG1vZGVtLCAiQXV4IiwgIkF1eDogIik7CglpZiAoZGF0YS0+YXV4
ID09IE5VTEwpCgkJcmV0dXJuIC1FSU5WQUw7CgoJaWYgKGRhdGEtPnZlbmRvcl9mYW1pbHkgPT0g
T0ZPTk9fVkVORE9SX1VCTE9YKSB7CgkJZGF0YS0+bW9kZW0gPSBvcGVuX2RldmljZShtb2RlbSwg
Ik1vZGVtIiwgIk1vZGVtOiAiKTsKCQlpZiAoZGF0YS0+bW9kZW0gPT0gTlVMTCkgewoJCQlnX2F0
X2NoYXRfdW5yZWYoZGF0YS0+YXV4KTsKCQkJZGF0YS0+YXV4ID0gTlVMTDsKCQkJcmV0dXJuIC1F
SU87CgkJfQoKCQlnX2F0X2NoYXRfc2V0X3NsYXZlKGRhdGEtPm1vZGVtLCBkYXRhLT5hdXgpOwoK
CQlnX2F0X2NoYXRfc2VuZChkYXRhLT5tb2RlbSwgIkFURTAgK0NNRUU9MSIsIG5vbmVfcHJlZml4
LAoJCQkJCQlOVUxMLCBOVUxMLCBOVUxMKTsKCgkJZ19hdF9jaGF0X3NlbmQoZGF0YS0+bW9kZW0s
ICJBVCZDMCIsIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOwoJfQoKCS8qIFRoZSBtb2RlbSBjYW4g
dGFrZSBhIHdoaWxlIHRvIHdha2UgdXAgaWYganVzdCBwb3dlcmVkIG9uLiAqLwoJZ19hdF9jaGF0
X3NldF93YWtldXBfY29tbWFuZChkYXRhLT5hdXgsICJBVFxyIiwgMTAwMCwgMTEwMDApOwoKCWdf
YXRfY2hhdF9zZW5kKGRhdGEtPmF1eCwgIkFURTAgK0NNRUU9MSIsIG5vbmVfcHJlZml4LAoJCQkJ
CU5VTEwsIE5VTEwsIE5VTEwpOwoKCWdfYXRfY2hhdF9zZW5kKGRhdGEtPmF1eCwgIkFUK0NGVU49
NCIsIG5vbmVfcHJlZml4LAoJCQkJCWNmdW5fZW5hYmxlLCBtb2RlbSwgTlVMTCk7CgoJcmV0dXJu
IC1FSU5QUk9HUkVTUzsKfQoKc3RhdGljIHZvaWQgY2Z1bl9kaXNhYmxlKGdib29sZWFuIG9rLCBH
QXRSZXN1bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKQp7CglzdHJ1Y3Qgb2Zvbm9fbW9k
ZW0gKm1vZGVtID0gdXNlcl9kYXRhOwoJc3RydWN0IHVibG94X2RhdGEgKmRhdGEgPSBvZm9ub19t
b2RlbV9nZXRfZGF0YShtb2RlbSk7CgoJREJHKCIiKTsKCglnX2F0X2NoYXRfdW5yZWYoZGF0YS0+
YXV4KTsKCWRhdGEtPmF1eCA9IE5VTEw7CgoJaWYgKG9rKQoJCW9mb25vX21vZGVtX3NldF9wb3dl
cmVkKG1vZGVtLCBGQUxTRSk7Cn0KCnN0YXRpYyBpbnQgdWJsb3hfZGlzYWJsZShzdHJ1Y3Qgb2Zv
bm9fbW9kZW0gKm1vZGVtKQp7CglzdHJ1Y3QgdWJsb3hfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVt
X2dldF9kYXRhKG1vZGVtKTsKCglEQkcoIiVwIiwgbW9kZW0pOwoKCWdfYXRfY2hhdF9jYW5jZWxf
YWxsKGRhdGEtPm1vZGVtKTsKCWdfYXRfY2hhdF91bnJlZ2lzdGVyX2FsbChkYXRhLT5tb2RlbSk7
CglnX2F0X2NoYXRfdW5yZWYoZGF0YS0+bW9kZW0pOwoJZGF0YS0+bW9kZW0gPSBOVUxMOwoKCWdf
YXRfY2hhdF9jYW5jZWxfYWxsKGRhdGEtPmF1eCk7CglnX2F0X2NoYXRfdW5yZWdpc3Rlcl9hbGwo
ZGF0YS0+YXV4KTsKCglnX2F0X2NoYXRfc2VuZChkYXRhLT5hdXgsICJBVCtDRlVOPTAiLCBub25l
X3ByZWZpeCwKCQkJCQljZnVuX2Rpc2FibGUsIG1vZGVtLCBOVUxMKTsKCglyZXR1cm4gLUVJTlBS
T0dSRVNTOwp9CgpzdGF0aWMgdm9pZCBzZXRfb25saW5lX2NiKGdib29sZWFuIG9rLCBHQXRSZXN1
bHQgKnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKQp7CglzdHJ1Y3QgY2JfZGF0YSAqY2JkID0g
dXNlcl9kYXRhOwoJb2Zvbm9fbW9kZW1fb25saW5lX2NiX3QgY2IgPSBjYmQtPmNiOwoJc3RydWN0
IG9mb25vX2Vycm9yIGVycm9yOwoKCWRlY29kZV9hdF9lcnJvcigmZXJyb3IsIGdfYXRfcmVzdWx0
X2ZpbmFsX3Jlc3BvbnNlKHJlc3VsdCkpOwoJY2IoJmVycm9yLCBjYmQtPmRhdGEpOwp9CgpzdGF0
aWMgdm9pZCB1YmxveF9zZXRfb25saW5lKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0sIG9mb25v
X2Jvb2xfdCBvbmxpbmUsCgkJCQlvZm9ub19tb2RlbV9vbmxpbmVfY2JfdCBjYiwgdm9pZCAqdXNl
cl9kYXRhKQp7CglzdHJ1Y3QgdWJsb3hfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRh
KG1vZGVtKTsKCXN0cnVjdCBjYl9kYXRhICpjYmQgPSBjYl9kYXRhX25ldyhjYiwgdXNlcl9kYXRh
KTsKCWNoYXIgY29uc3QgKmNvbW1hbmQgPSBvbmxpbmUgPyAiQVQrQ0ZVTj0xIiA6ICJBVCtDRlVO
PTQiOwoKCURCRygibW9kZW0gJXAgJXMiLCBtb2RlbSwgb25saW5lID8gIm9ubGluZSIgOiAib2Zm
bGluZSIpOwoKCWlmIChnX2F0X2NoYXRfc2VuZChkYXRhLT5hdXgsIGNvbW1hbmQsIG5vbmVfcHJl
Zml4LCBzZXRfb25saW5lX2NiLAoJCQkJCWNiZCwgZ19mcmVlKSA+IDApCgkJcmV0dXJuOwoKCUNB
TExCQUNLX1dJVEhfRkFJTFVSRShjYiwgY2JkLT5kYXRhKTsKCglnX2ZyZWUoY2JkKTsKfQoKc3Rh
dGljIHZvaWQgdWJsb3hfcHJlX3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKQp7CglzdHJ1
Y3QgdWJsb3hfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTsKCXN0cnVj
dCBvZm9ub19zaW0gKnNpbTsKCglEQkcoIiVwIiwgbW9kZW0pOwoKCW9mb25vX2RldmluZm9fY3Jl
YXRlKG1vZGVtLCAwLCAiYXRtb2RlbSIsIGRhdGEtPmF1eCk7CgkvKgoJICogQ2FsbCBzdXBwb3J0
IGlzIHRlY2huaWNhbGx5IHBvc3NpYmxlIG9ubHkgYWZ0ZXIgc2ltIGluc2VydGlvbgoJICogd2l0
aCB0aGUgbW9kdWxlIG9ubGluZS4gSG93ZXZlciB0aGUgRU1FUkdFTkNZX1NFVFVQIHByb2NlZHVy
ZSBvZgoJICogdGhlIDNHUFAgVFNfMjQuMDA4IGlzIHRyaWdnZXJlZCBieSB0aGUgc2FtZSBBVCBj
b21tYW5kLAoJICogYW5kIG5hbWVseSAnQVREMTEyOycgYW5kICdBVEQ5MTE7Jy4gVGhlcmVmb3Jl
IGl0IG1ha2VzIHNlbnNlIHRvCgkgKiBhZGQgdGhlIHZvaWNlIHN1cHBvcnQgYXMgc29vbiBhcyBw
b3NzaWJsZS4KCSAqLwoJb2Zvbm9fdm9pY2VjYWxsX2NyZWF0ZShtb2RlbSwgMCwgImF0bW9kZW0i
LCBkYXRhLT5hdXgpOwoJc2ltID0gb2Zvbm9fc2ltX2NyZWF0ZShtb2RlbSwgZGF0YS0+dmVuZG9y
X2ZhbWlseSwgImF0bW9kZW0iLAoJCQkJCWRhdGEtPmF1eCk7CgoJaWYgKHNpbSkKCQlvZm9ub19z
aW1faW5zZXJ0ZWRfbm90aWZ5KHNpbSwgVFJVRSk7Cn0KCnN0YXRpYyB2b2lkIHVibG94X3Bvc3Rf
c2ltKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pCnsKCXN0cnVjdCB1YmxveF9kYXRhICpkYXRh
ID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOwoJc3RydWN0IG9mb25vX2dwcnMgKmdwcnM7
CglzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYzsKCUdBdENoYXQgKmNoYXQgPSBkYXRhLT5t
b2RlbSA/IGRhdGEtPm1vZGVtIDogZGF0YS0+YXV4OwoJY29uc3QgY2hhciAqZHJpdmVyID0gZGF0
YS0+bW9kZWxfaWQgPT0gVE9CWUwyX0hJR0hfVEhST1VHSFBVVF9NT0RFID8KCQkJCQkJInVibG94
bW9kZW0iIDogImF0bW9kZW0iOwoJLyogVG9ieSBMMjogQ3JlYXRlIHNhbWUgbnVtYmVyIG9mIGNv
bnRleHRzIGFzIHN1cHBvcnRlZCBQRFAgY29udGV4dHMuICovCglpbnQgbmNvbnRleHRzID0gZGF0
YS0+bW9kZWxfaWQgPT0gVE9CWUwyX0hJR0hfVEhST1VHSFBVVF9NT0RFID8gOCA6IDE7CgoJREJH
KCIlcCIsIG1vZGVtKTsKCglncHJzID0gb2Zvbm9fZ3Byc19jcmVhdGUobW9kZW0sIGRhdGEtPnZl
bmRvcl9mYW1pbHksICJhdG1vZGVtIiwKCQkJCQlkYXRhLT5hdXgpOwoKCXdoaWxlIChuY29udGV4
dHMpIHsKCQlnYyA9IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUobW9kZW0sIGRhdGEtPnZlbmRv
cl9mYW1pbHksCgkJCQkJCWRyaXZlciwgY2hhdCk7CgoJCWlmIChncHJzICYmIGdjKQoJCQlvZm9u
b19ncHJzX2FkZF9jb250ZXh0KGdwcnMsIGdjKTsKCgkJLS1uY29udGV4dHM7Cgl9CgoJb2Zvbm9f
bHRlX2NyZWF0ZShtb2RlbSwgMCwgInVibG94bW9kZW0iLCBkYXRhLT5hdXgpOwp9CgpzdGF0aWMg
dm9pZCB1YmxveF9wb3N0X29ubGluZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKQp7CglzdHJ1
Y3QgdWJsb3hfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTsKCglvZm9u
b19uZXRyZWdfY3JlYXRlKG1vZGVtLCBkYXRhLT52ZW5kb3JfZmFtaWx5LCAiYXRtb2RlbSIsIGRh
dGEtPmF1eCk7CgoJb2Zvbm9fbmV0bW9uX2NyZWF0ZShtb2RlbSwgZGF0YS0+dmVuZG9yX2ZhbWls
eSwgInVibG94bW9kZW0iLCBkYXRhLT5hdXgpOwp9CgpzdGF0aWMgc3RydWN0IG9mb25vX21vZGVt
X2RyaXZlciB1YmxveF9kcml2ZXIgPSB7CgkubmFtZQkJPSAidWJsb3giLAoJLnByb2JlCQk9IHVi
bG94X3Byb2JlLAoJLnJlbW92ZQkJPSB1YmxveF9yZW1vdmUsCgkuZW5hYmxlCQk9IHVibG94X2Vu
YWJsZSwKCS5kaXNhYmxlCT0gdWJsb3hfZGlzYWJsZSwKCS5zZXRfb25saW5lCT0gdWJsb3hfc2V0
X29ubGluZSwKCS5wcmVfc2ltCT0gdWJsb3hfcHJlX3NpbSwKCS5wb3N0X3NpbQk9IHVibG94X3Bv
c3Rfc2ltLAoJLnBvc3Rfb25saW5lCT0gdWJsb3hfcG9zdF9vbmxpbmUsCn07CgpzdGF0aWMgaW50
IHVibG94X2luaXQodm9pZCkKewoJcmV0dXJuIG9mb25vX21vZGVtX2RyaXZlcl9yZWdpc3Rlcigm
dWJsb3hfZHJpdmVyKTsKfQoKc3RhdGljIHZvaWQgdWJsb3hfZXhpdCh2b2lkKQp7CglvZm9ub19t
b2RlbV9kcml2ZXJfdW5yZWdpc3RlcigmdWJsb3hfZHJpdmVyKTsKfQoKT0ZPTk9fUExVR0lOX0RF
RklORSh1YmxveCwgInUtYmxveCBtb2RlbSBkcml2ZXIiLCBWRVJTSU9OLAoJCU9GT05PX1BMVUdJ
Tl9QUklPUklUWV9ERUZBVUxULCB1YmxveF9pbml0LCB1YmxveF9leGl0KQo=

--===============6759250650827498843==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="udevng.c"

LyoKICoKICogIG9Gb25vIC0gT3BlbiBTb3VyY2UgVGVsZXBob255CiAqCiAqICBDb3B5cmlnaHQg
KEMpIDIwMDgtMjAxMSAgSW50ZWwgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuCiAq
CiAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQogKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKICogIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uLgogKgogKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCiAqICBidXQgV0lUSE9VVCBBTlkgV0FS
UkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgogKiAgTUVSQ0hBTlRB
QklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQogKiAg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KICoKICogIFlvdSBz
aG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlCiAqICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJl
ZSBTb2Z0d2FyZQogKiAgRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3QsIEZpZnRoIEZs
b29yLCBCb3N0b24sIE1BICAwMjExMC0xMzAxICBVU0EKICoKICovCgojaWZkZWYgSEFWRV9DT05G
SUdfSAojaW5jbHVkZSA8Y29uZmlnLmg+CiNlbmRpZgoKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNs
dWRlIDxjdHlwZS5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2lu
Y2x1ZGUgPHN0ZGlvLmg+CgojaW5jbHVkZSA8bGlidWRldi5oPgoKI2luY2x1ZGUgPGdsaWIuaD4K
CiNkZWZpbmUgT0ZPTk9fQVBJX1NVQkpFQ1RfVE9fQ0hBTkdFCiNpbmNsdWRlIDxvZm9uby9wbHVn
aW4uaD4KI2luY2x1ZGUgPG9mb25vL21vZGVtLmg+CiNpbmNsdWRlIDxvZm9uby9sb2cuaD4KCmVu
dW0gbW9kZW1fdHlwZSB7CglNT0RFTV9UWVBFX1VTQiwKCU1PREVNX1RZUEVfU0VSSUFMLAp9OwoK
c3RydWN0IG1vZGVtX2luZm8gewoJY2hhciAqc3lzcGF0aDsKCWNoYXIgKmRldm5hbWU7CgljaGFy
ICpkcml2ZXI7CgljaGFyICp2ZW5kb3I7CgljaGFyICptb2RlbDsKCWVudW0gbW9kZW1fdHlwZSB0
eXBlOwoJdW5pb24gewoJCUdTTGlzdCAqZGV2aWNlczsKCQlzdHJ1Y3Qgc2VyaWFsX2RldmljZV9p
bmZvKiBzZXJpYWw7Cgl9OwoJc3RydWN0IG9mb25vX21vZGVtICptb2RlbTsKCWNvbnN0IGNoYXIg
KnN5c2F0dHI7Cn07CgpzdHJ1Y3QgZGV2aWNlX2luZm8gewoJY2hhciAqZGV2cGF0aDsKCWNoYXIg
KmRldm5vZGU7CgljaGFyICppbnRlcmZhY2U7CgljaGFyICpudW1iZXI7CgljaGFyICpsYWJlbDsK
CWNoYXIgKnN5c2F0dHI7CgljaGFyICpzdWJzeXN0ZW07Cn07CgpzdHJ1Y3Qgc2VyaWFsX2Rldmlj
ZV9pbmZvIHsKCWNoYXIgKmRldnBhdGg7CgljaGFyICpkZXZub2RlOwoJY2hhciAqc3Vic3lzdGVt
OwoJc3RydWN0IHVkZXZfZGV2aWNlKiBkZXY7Cn07CgpzdGF0aWMgZ2Jvb2xlYW4gc2V0dXBfaXNp
KHN0cnVjdCBtb2RlbV9pbmZvICptb2RlbSkKewoJY29uc3QgY2hhciAqbm9kZSA9IE5VTEw7Cglp
bnQgYWRkciA9IDA7CglHU0xpc3QgKmxpc3Q7CgoJREJHKCIlcyIsIG1vZGVtLT5zeXNwYXRoKTsK
Cglmb3IgKGxpc3QgPSBtb2RlbS0+ZGV2aWNlczsgbGlzdDsgbGlzdCA9IGxpc3QtPm5leHQpIHsK
CQlzdHJ1Y3QgZGV2aWNlX2luZm8gKmluZm8gPSBsaXN0LT5kYXRhOwoKCQlEQkcoIiVzICVzICVz
ICVzICVzIiwgaW5mby0+ZGV2bm9kZSwgaW5mby0+aW50ZXJmYWNlLAoJCQkJaW5mby0+bnVtYmVy
LCBpbmZvLT5sYWJlbCwgaW5mby0+c3lzYXR0cik7CgoJCWlmIChnX3N0cmNtcDAoaW5mby0+c3lz
YXR0ciwgIjgyMCIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIy
LzI1NC8wIikgPT0gMCkKCQkJCWFkZHIgPSAxNjsKCgkJCW5vZGUgPSBpbmZvLT5kZXZub2RlOwoJ
CX0KCX0KCglpZiAobm9kZSA9PSBOVUxMKQoJCXJldHVybiBGQUxTRTsKCglEQkcoImludGVyZmFj
ZT0lcyBhZGRyZXNzPSVkIiwgbm9kZSwgYWRkcik7CgoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyht
b2RlbS0+bW9kZW0sICJJbnRlcmZhY2UiLCBub2RlKTsKCW9mb25vX21vZGVtX3NldF9pbnRlZ2Vy
KG1vZGVtLT5tb2RlbSwgIkFkZHJlc3MiLCBhZGRyKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGlj
IGdib29sZWFuIHNldHVwX21ibShzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW0pCnsKCWNvbnN0IGNo
YXIgKm1kbSA9IE5VTEwsICphcHAgPSBOVUxMLCAqbmV0d29yayA9IE5VTEwsICpncHMgPSBOVUxM
OwoJR1NMaXN0ICpsaXN0OwoKCURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0
ID0gbW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJc3RydWN0IGRl
dmljZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAlcyAlcyAlcyAlcyIsIGlu
Zm8tPmRldm5vZGUsIGluZm8tPmludGVyZmFjZSwKCQkJCWluZm8tPm51bWJlciwgaW5mby0+bGFi
ZWwsIGluZm8tPnN5c2F0dHIpOwoKCQlpZiAoZ19zdHJfaGFzX3N1ZmZpeChpbmZvLT5zeXNhdHRy
LCAiTW9kZW0iKSA9PSBUUlVFIHx8CgkJCQlnX3N0cl9oYXNfc3VmZml4KGluZm8tPnN5c2F0dHIs
CgkJCQkJCQkiTW9kZW0gMiIpID09IFRSVUUpIHsKCQkJaWYgKG1kbSA9PSBOVUxMKQoJCQkJbWRt
ID0gaW5mby0+ZGV2bm9kZTsKCQkJZWxzZQoJCQkJYXBwID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVs
c2UgaWYgKGdfc3RyX2hhc19zdWZmaXgoaW5mby0+c3lzYXR0ciwKCQkJCQkJIkdQUyBQb3J0Iikg
PT0gVFJVRSB8fAoJCQkJZ19zdHJfaGFzX3N1ZmZpeChpbmZvLT5zeXNhdHRyLAoJCQkJCQkiTW9k
dWxlIE5NRUEiKSA9PSBUUlVFKSB7CgkJCWdwcyA9IGluZm8tPmRldm5vZGU7CgkJfSBlbHNlIGlm
IChnX3N0cl9oYXNfc3VmZml4KGluZm8tPnN5c2F0dHIsCgkJCQkJCSJOZXR3b3JrIEFkYXB0ZXIi
KSA9PSBUUlVFIHx8CgkJCQlnX3N0cl9oYXNfc3VmZml4KGluZm8tPnN5c2F0dHIsCgkJCQkJCSJn
dyIpID09IFRSVUUgfHwKCQkJCWdfc3RyX2hhc19zdWZmaXgoaW5mby0+c3lzYXR0ciwKCQkJCQkJ
Ik5ldHdvcmtBZGFwdGVyIikgPT0gVFJVRSkgewoJCQluZXR3b3JrID0gaW5mby0+ZGV2bm9kZTsK
CQl9Cgl9CgoJaWYgKG1kbSA9PSBOVUxMIHx8IGFwcCA9PSBOVUxMKQoJCXJldHVybiBGQUxTRTsK
CglEQkcoIm1vZGVtPSVzIGRhdGE9JXMgbmV0d29yaz0lcyBncHM9JXMiLCBtZG0sIGFwcCwgbmV0
d29yaywgZ3BzKTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk1vZGVt
RGV2aWNlIiwgbWRtKTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiRGF0
YURldmljZSIsIGFwcCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkdQ
U0RldmljZSIsIGdwcyk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk5l
dHdvcmtJbnRlcmZhY2UiLCBuZXR3b3JrKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29s
ZWFuIHNldHVwX2hzbyhzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW0pCnsKCWNvbnN0IGNoYXIgKmN0
bCA9IE5VTEwsICphcHAgPSBOVUxMLCAqbWRtID0gTlVMTCwgKm5ldCA9IE5VTEw7CglHU0xpc3Qg
Kmxpc3Q7CgoJREJHKCIlcyIsIG1vZGVtLT5zeXNwYXRoKTsKCglmb3IgKGxpc3QgPSBtb2RlbS0+
ZGV2aWNlczsgbGlzdDsgbGlzdCA9IGxpc3QtPm5leHQpIHsKCQlzdHJ1Y3QgZGV2aWNlX2luZm8g
KmluZm8gPSBsaXN0LT5kYXRhOwoKCQlEQkcoIiVzICVzICVzICVzICVzIiwgaW5mby0+ZGV2bm9k
ZSwgaW5mby0+aW50ZXJmYWNlLAoJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCwgaW5mby0+
c3lzYXR0cik7CgoJCWlmIChnX3N0cmNtcDAoaW5mby0+c3lzYXR0ciwgIkNvbnRyb2wiKSA9PSAw
KQoJCQljdGwgPSBpbmZvLT5kZXZub2RlOwoJCWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5zeXNh
dHRyLCAiQXBwbGljYXRpb24iKSA9PSAwKQoJCQlhcHAgPSBpbmZvLT5kZXZub2RlOwoJCWVsc2Ug
aWYgKGdfc3RyY21wMChpbmZvLT5zeXNhdHRyLCAiTW9kZW0iKSA9PSAwKQoJCQltZG0gPSBpbmZv
LT5kZXZub2RlOwoJCWVsc2UgaWYgKGluZm8tPnN5c2F0dHIgPT0gTlVMTCAmJgoJCQkJZ19zdHJf
aGFzX3ByZWZpeChpbmZvLT5kZXZub2RlLCAiaHNvIikgPT0gVFJVRSkKCQkJbmV0ID0gaW5mby0+
ZGV2bm9kZTsKCX0KCglpZiAoY3RsID09IE5VTEwgfHwgYXBwID09IE5VTEwpCgkJcmV0dXJuIEZB
TFNFOwoKCURCRygiY29udHJvbD0lcyBhcHBsaWNhdGlvbj0lcyBtb2RlbT0lcyBuZXR3b3JrPSVz
IiwKCQkJCQkJY3RsLCBhcHAsIG1kbSwgbmV0KTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1v
ZGVtLT5tb2RlbSwgIkNvbnRyb2wiLCBjdGwpOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2Rl
bS0+bW9kZW0sICJBcHBsaWNhdGlvbiIsIGFwcCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1v
ZGVtLT5tb2RlbSwgIk1vZGVtIiwgbWRtKTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0t
Pm1vZGVtLCAiTmV0d29ya0ludGVyZmFjZSIsIG5ldCk7CgoJcmV0dXJuIFRSVUU7Cn0KCnN0YXRp
YyBnYm9vbGVhbiBzZXR1cF9nb2JpKHN0cnVjdCBtb2RlbV9pbmZvICptb2RlbSkKewoJY29uc3Qg
Y2hhciAqcW1pID0gTlVMTCwgKm1kbSA9IE5VTEwsICpuZXQgPSBOVUxMOwoJY29uc3QgY2hhciAq
Z3BzID0gTlVMTCwgKmRpYWcgPSBOVUxMOwoJR1NMaXN0ICpsaXN0OwoKCURCRygiJXMiLCBtb2Rl
bS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBs
aXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJ
REJHKCIlcyAlcyAlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUsIGluZm8tPmludGVyZmFjZSwK
CQkJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCwKCQkJCQkJaW5mby0+c3lzYXR0ciwgaW5m
by0+c3Vic3lzdGVtKTsKCgkJaWYgKGdfc3RyY21wMChpbmZvLT5zdWJzeXN0ZW0sICJ1c2JtaXNj
IikgPT0gMCkgLyogY2RjLXdkbSAqLwoJCQlxbWkgPSBpbmZvLT5kZXZub2RlOwoJCWVsc2UgaWYg
KGdfc3RyY21wMChpbmZvLT5zdWJzeXN0ZW0sICJuZXQiKSA9PSAwKSAvKiB3d2FuICovCgkJCW5l
dCA9IGluZm8tPmRldm5vZGU7CgkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPnN1YnN5c3RlbSwg
InR0eSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMjU1
LzI1NSIpID09IDApIHsKCQkJCWlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDAiKSA9PSAw
KQoJCQkJCWRpYWcgPSBpbmZvLT5kZXZub2RlOyAvKiBlYzIwICovCgkJCQllbHNlIGlmIChnX3N0
cmNtcDAoaW5mby0+bnVtYmVyLCAiMDEiKSA9PSAwKQoJCQkJCWRpYWcgPSBpbmZvLT5kZXZub2Rl
OyAvKiBnb2JpICovCgkJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDIiKSA9
PSAwKQoJCQkJCW1kbSA9IGluZm8tPmRldm5vZGU7IC8qIGdvYmkgKi8KCQkJCWVsc2UgaWYgKGdf
c3RyY21wMChpbmZvLT5udW1iZXIsICIwMyIpID09IDApCgkJCQkJZ3BzID0gaW5mby0+ZGV2bm9k
ZTsgLyogZ29iaSAqLwoJCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIy
NTUvMC8wIikgPT0gMCkgewoJCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMSIpID09
IDApCgkJCQkJZ3BzID0gaW5mby0+ZGV2bm9kZTsgLyogZWMyMCAqLwoJCQkJaWYgKGdfc3RyY21w
MChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsgLyog
ZWMyMCAqLwoJCQkJLyogaWdub3JlIHRoZSAzcmQgZGV2aWNlIHNlY29uZCBBVC9tZG0gaWZhY2Ug
Ki8KCQkJfQoJCX0KCX0KCglpZiAocW1pID09IE5VTEwgfHwgbWRtID09IE5VTEwgfHwgbmV0ID09
IE5VTEwpCgkJcmV0dXJuIEZBTFNFOwoKCURCRygicW1pPSVzIG5ldD0lcyBtZG09JXMgZ3BzPSVz
IGRpYWc9JXMiLCBxbWksIG5ldCwgbWRtLCBncHMsIGRpYWcpOwoKCW9mb25vX21vZGVtX3NldF9z
dHJpbmcobW9kZW0tPm1vZGVtLCAiRGV2aWNlIiwgcW1pKTsKCW9mb25vX21vZGVtX3NldF9zdHJp
bmcobW9kZW0tPm1vZGVtLCAiTW9kZW0iLCBtZG0pOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyht
b2RlbS0+bW9kZW0sICJEaWFnIiwgZGlhZyk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVt
LT5tb2RlbSwgIk5ldHdvcmtJbnRlcmZhY2UiLCBuZXQpOwoKCXJldHVybiBUUlVFOwp9CgpzdGF0
aWMgZ2Jvb2xlYW4gc2V0dXBfc2llcnJhKHN0cnVjdCBtb2RlbV9pbmZvICptb2RlbSkKewoJY29u
c3QgY2hhciAqbWRtID0gTlVMTCwgKmFwcCA9IE5VTEwsICpuZXQgPSBOVUxMLCAqZGlhZyA9IE5V
TEwsICpxbWkgPSBOVUxMOwoJR1NMaXN0ICpsaXN0OwoKCURCRygiJXMiLCBtb2RlbS0+c3lzcGF0
aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0
KSB7CgkJc3RydWN0IGRldmljZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAl
cyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUsIGluZm8tPmludGVyZmFjZSwKCQkJCWluZm8tPm51
bWJlciwgaW5mby0+bGFiZWwsIGluZm8tPnN1YnN5c3RlbSk7CgoJCWlmIChnX3N0cmNtcDAoaW5m
by0+aW50ZXJmYWNlLCAiMjU1LzI1NS8yNTUiKSA9PSAwKSB7CgkJCWlmIChnX3N0cmNtcDAoaW5m
by0+bnVtYmVyLCAiMDEiKSA9PSAwKQoJCQkJZGlhZyA9IGluZm8tPmRldm5vZGU7CgkJCWVsc2Ug
aWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMyIpID09IDApCgkJCQltZG0gPSBpbmZvLT5k
ZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDQiKSA9PSAwKQoJ
CQkJYXBwID0gaW5mby0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJl
ciwgIjA3IikgPT0gMCkKCQkJCW5ldCA9IGluZm8tPmRldm5vZGU7CgkJCWVsc2UgaWYgKGdfc3Ry
Y21wMChpbmZvLT5zdWJzeXN0ZW0sICJuZXQiKSA9PSAwKSB7CgkJCQkvKgoJCQkJICogV2hlbiB1
c2luZyB0aGUgdm9pY2UgZmlybXdhcmUgb24gYSBtYzczMDQKCQkJCSAqIHRoZSBzZWNvbmQgY2Rj
LXdkbSBpbnRlcmZhY2UgZG9lc24ndCBoYW5kbGUKCQkJCSAqIHFtaSBtZXNzYWdlcyBwcm9wZXJs
eS4KCQkJCSAqIFNvbWUgbW9kZW1zIHN0aWxsIGhhdmUgYSB3b3JraW5nIHNlY29uZAoJCQkJICog
Y2RjLXdkbSBpbnRlcmZhY2UsIHNvbWUgYXJlIG5vdC4gQnV0IGFsd2F5cwoJCQkJICogdGhlIGZp
cnN0IGludGVyZmFjZSB3b3Jrcy4KCQkJCSAqLwoJCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1i
ZXIsICIwOCIpID09IDApIHsKCQkJCQluZXQgPSBpbmZvLT5kZXZub2RlOwoJCQkJfSBlbHNlIGlm
IChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMGEiKSA9PSAwKSB7CgkJCQkJaWYgKG5ldCA9PSBO
VUxMKQoJCQkJCQluZXQgPSBpbmZvLT5kZXZub2RlOwoJCQkJfQoJCQl9IGVsc2UgaWYgKGdfc3Ry
Y21wMChpbmZvLT5zdWJzeXN0ZW0sICJ1c2JtaXNjIikgPT0gMCkgewoJCQkJaWYgKGdfc3RyY21w
MChpbmZvLT5udW1iZXIsICIwOCIpID09IDApIHsKCQkJCQlxbWkgPSBpbmZvLT5kZXZub2RlOwoJ
CQkJfSBlbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMGEiKSA9PSAwKSB7CgkJCQkJ
aWYgKHFtaSA9PSBOVUxMKQoJCQkJCQlxbWkgPSBpbmZvLT5kZXZub2RlOwoJCQkJfQoJCQl9CgkJ
fQoJfQoKCWlmIChxbWkgIT0gTlVMTCAmJiBuZXQgIT0gTlVMTCkgewoJCW9mb25vX21vZGVtX3Nl
dF9kcml2ZXIobW9kZW0tPm1vZGVtLCAiZ29iaSIpOwoJCWdvdG8gZG9uZTsKCX0KCglpZiAobWRt
ID09IE5VTEwgfHwgbmV0ID09IE5VTEwpCgkJcmV0dXJuIEZBTFNFOwoKZG9uZToKCURCRygibW9k
ZW09JXMgYXBwPSVzIG5ldD0lcyBkaWFnPSVzIHFtaT0lcyIsIG1kbSwgYXBwLCBuZXQsIGRpYWcs
IHFtaSk7CgoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJEZXZpY2UiLCBx
bWkpOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJNb2RlbSIsIG1kbSk7
CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkFwcCIsIGFwcCk7CglvZm9u
b19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkRpYWciLCBkaWFnKTsKCW9mb25vX21v
ZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiTmV0d29ya0ludGVyZmFjZSIsIG5ldCk7CgoJ
cmV0dXJuIFRSVUU7Cn0KCnN0YXRpYyBnYm9vbGVhbiBzZXR1cF9odWF3ZWkoc3RydWN0IG1vZGVt
X2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFyICpxbWkgPSBOVUxMLCAqbWRtID0gTlVMTCwgKm5l
dCA9IE5VTEw7Cgljb25zdCBjaGFyICpwY3VpID0gTlVMTCwgKmRpYWcgPSBOVUxMOwoJR1NMaXN0
ICpsaXN0OwoKCURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0t
PmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZv
ICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUs
IGluZm8tPmludGVyZmFjZSwKCQkJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCk7CgoJCWlm
IChnX3N0cmNtcDAoaW5mby0+bGFiZWwsICJtb2RlbSIpID09IDAgfHwKCQkJCWdfc3RyY21wMChp
bmZvLT5pbnRlcmZhY2UsICIyNTUvMS8xIikgPT0gMCB8fAoJCQkJZ19zdHJjbXAwKGluZm8tPmlu
dGVyZmFjZSwgIjI1NS8yLzEiKSA9PSAwIHx8CgkJCQlnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNl
LCAiMjU1LzMvMSIpID09IDAgfHwKCQkJCWdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUv
MS80OSIpID09IDApIHsKCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVsc2UgaWYgKGdfc3Ry
Y21wMChpbmZvLT5sYWJlbCwgInBjdWkiKSA9PSAwIHx8CgkJCQlnX3N0cmNtcDAoaW5mby0+aW50
ZXJmYWNlLCAiMjU1LzEvMiIpID09IDAgfHwKCQkJCWdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2Us
ICIyNTUvMi8yIikgPT0gMCB8fAoJCQkJZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8y
LzE4IikgPT0gMCB8fAoJCQkJZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8zLzE4Iikg
PT0gMCB8fAoJCQkJZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8xLzUwIikgPT0gMCkg
ewoJCQlwY3VpID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5s
YWJlbCwgImRpYWciKSA9PSAwIHx8CgkJCQlnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNlLCAiMjU1
LzEvMyIpID09IDAgfHwKCQkJCWdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMi8zIikg
PT0gMCB8fAoJCQkJZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8xLzUxIikgPT0gMCkg
ewoJCQlkaWFnID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5p
bnRlcmZhY2UsICIyNTUvMS84IikgPT0gMCB8fAoJCQkJZ19zdHJjbXAwKGluZm8tPmludGVyZmFj
ZSwgIjI1NS8xLzU2IikgPT0gMCkgewoJCQluZXQgPSBpbmZvLT5kZXZub2RlOwoJCX0gZWxzZSBp
ZiAoZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8xLzkiKSA9PSAwIHx8CgkJCQlnX3N0
cmNtcDAoaW5mby0+aW50ZXJmYWNlLCAiMjU1LzEvNTciKSA9PSAwKSB7CgkJCXFtaSA9IGluZm8t
PmRldm5vZGU7CgkJfSBlbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNlLCAiMjU1LzI1
NS8yNTUiKSA9PSAwKSB7CgkJCWlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDAiKSA9PSAw
KQoJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51
bWJlciwgIjAxIikgPT0gMCkKCQkJCXBjdWkgPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChn
X3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDIiKSA9PSAwKQoJCQkJcGN1aSA9IGluZm8tPmRldm5v
ZGU7CgkJCWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMyIpID09IDApCgkJCQlw
Y3VpID0gaW5mby0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwg
IjA0IikgPT0gMCkKCQkJCXBjdWkgPSBpbmZvLT5kZXZub2RlOwoJCX0KCX0KCglpZiAocW1pICE9
IE5VTEwgJiYgbmV0ICE9IE5VTEwpIHsKCQlvZm9ub19tb2RlbV9zZXRfZHJpdmVyKG1vZGVtLT5t
b2RlbSwgImdvYmkiKTsKCQlnb3RvIGRvbmU7Cgl9CgoJaWYgKG1kbSA9PSBOVUxMIHx8IHBjdWkg
PT0gTlVMTCkKCQlyZXR1cm4gRkFMU0U7Cgpkb25lOgoJREJHKCJtZG09JXMgcGN1aT0lcyBkaWFn
PSVzIHFtaT0lcyBuZXQ9JXMiLCBtZG0sIHBjdWksIGRpYWcsIHFtaSwgbmV0KTsKCglvZm9ub19t
b2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkRldmljZSIsIHFtaSk7CglvZm9ub19tb2Rl
bV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk1vZGVtIiwgbWRtKTsKCW9mb25vX21vZGVtX3Nl
dF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiUGN1aSIsIHBjdWkpOwoJb2Zvbm9fbW9kZW1fc2V0X3N0
cmluZyhtb2RlbS0+bW9kZW0sICJEaWFnIiwgZGlhZyk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5n
KG1vZGVtLT5tb2RlbSwgIk5ldHdvcmtJbnRlcmZhY2UiLCBuZXQpOwoKCXJldHVybiBUUlVFOwp9
CgpzdGF0aWMgZ2Jvb2xlYW4gc2V0dXBfc3BlZWR1cChzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW0p
CnsKCWNvbnN0IGNoYXIgKmF1eCA9IE5VTEwsICptZG0gPSBOVUxMOwoJR1NMaXN0ICpsaXN0OwoK
CURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmljZXM7
IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZvICppbmZvID0g
bGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUsIGluZm8tPmlu
dGVyZmFjZSwKCQkJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCk7CgoJCWlmIChnX3N0cmNt
cDAoaW5mby0+bGFiZWwsICJhdXgiKSA9PSAwKSB7CgkJCWF1eCA9IGluZm8tPmRldm5vZGU7CgkJ
CWlmIChtZG0gIT0gTlVMTCkKCQkJCWJyZWFrOwoJCX0gZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8t
PmxhYmVsLCAibW9kZW0iKSA9PSAwKSB7CgkJCW1kbSA9IGluZm8tPmRldm5vZGU7CgkJCWlmIChh
dXggIT0gTlVMTCkKCQkJCWJyZWFrOwoJCX0KCX0KCglpZiAoYXV4ID09IE5VTEwgfHwgbWRtID09
IE5VTEwpCgkJcmV0dXJuIEZBTFNFOwoKCURCRygiYXV4PSVzIG1vZGVtPSVzIiwgYXV4LCBtZG0p
OwoKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiQXV4IiwgYXV4KTsKCW9m
b25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiTW9kZW0iLCBtZG0pOwoKCXJldHVy
biBUUlVFOwp9CgpzdGF0aWMgZ2Jvb2xlYW4gc2V0dXBfbGlua3RvcChzdHJ1Y3QgbW9kZW1faW5m
byAqbW9kZW0pCnsKCWNvbnN0IGNoYXIgKmF1eCA9IE5VTEwsICptZG0gPSBOVUxMOwoJR1NMaXN0
ICpsaXN0OwoKCURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0t
PmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZv
ICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUs
IGluZm8tPmludGVyZmFjZSwKCQkJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCk7CgoJCWlm
IChnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNlLCAiMi8yLzEiKSA9PSAwKSB7CgkJCWlmIChnX3N0
cmNtcDAoaW5mby0+bnVtYmVyLCAiMDEiKSA9PSAwKQoJCQkJYXV4ID0gaW5mby0+ZGV2bm9kZTsK
CQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwgIjAzIikgPT0gMCkKCQkJCW1kbSA9
IGluZm8tPmRldm5vZGU7CgkJfQoJfQoKCWlmIChhdXggPT0gTlVMTCB8fCBtZG0gPT0gTlVMTCkK
CQlyZXR1cm4gRkFMU0U7CgoJREJHKCJhdXg9JXMgbW9kZW09JXMiLCBhdXgsIG1kbSk7CgoJb2Zv
bm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJBdXgiLCBhdXgpOwoJb2Zvbm9fbW9k
ZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJNb2RlbSIsIG1kbSk7CgoJcmV0dXJuIFRSVUU7
Cn0KCnN0YXRpYyBnYm9vbGVhbiBzZXR1cF9pY2VyYShzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW0p
CnsKCWNvbnN0IGNoYXIgKmF1eCA9IE5VTEwsICptZG0gPSBOVUxMLCAqbmV0ID0gTlVMTDsKCUdT
TGlzdCAqbGlzdDsKCglEQkcoIiVzIiwgbW9kZW0tPnN5c3BhdGgpOwoKCWZvciAobGlzdCA9IG1v
ZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0ID0gbGlzdC0+bmV4dCkgewoJCXN0cnVjdCBkZXZpY2Vf
aW5mbyAqaW5mbyA9IGxpc3QtPmRhdGE7CgoJCURCRygiJXMgJXMgJXMgJXMiLCBpbmZvLT5kZXZu
b2RlLCBpbmZvLT5pbnRlcmZhY2UsCgkJCQkJCWluZm8tPm51bWJlciwgaW5mby0+bGFiZWwpOwoK
CQlpZiAoZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjIvMi8xIikgPT0gMCkgewoJCQlpZiAo
Z19zdHJjbXAwKGluZm8tPm51bWJlciwgIjAwIikgPT0gMCkKCQkJCWF1eCA9IGluZm8tPmRldm5v
ZGU7CgkJCWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMSIpID09IDApCgkJCQlh
dXggPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAi
MDIiKSA9PSAwKQoJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAw
KGluZm8tPm51bWJlciwgIjAzIikgPT0gMCkKCQkJCW1kbSA9IGluZm8tPmRldm5vZGU7CgkJfSBl
bHNlIGlmIChnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNlLCAiMi82LzAiKSA9PSAwKSB7CgkJCWlm
IChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDUiKSA9PSAwKQoJCQkJbmV0ID0gaW5mby0+ZGV2
bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwgIjA2IikgPT0gMCkKCQkJ
CW5ldCA9IGluZm8tPmRldm5vZGU7CgkJCWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIs
ICIwNyIpID09IDApCgkJCQluZXQgPSBpbmZvLT5kZXZub2RlOwoJCX0KCX0KCglpZiAoYXV4ID09
IE5VTEwgfHwgbWRtID09IE5VTEwpCgkJcmV0dXJuIEZBTFNFOwoKCURCRygiYXV4PSVzIG1vZGVt
PSVzIG5ldD0lcyIsIGF1eCwgbWRtLCBuZXQpOwoKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9k
ZW0tPm1vZGVtLCAiQXV4IiwgYXV4KTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1v
ZGVtLCAiTW9kZW0iLCBtZG0pOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0s
ICJOZXR3b3JrSW50ZXJmYWNlIiwgbmV0KTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29s
ZWFuIHNldHVwX2FsY2F0ZWwoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFy
ICphdXggPSBOVUxMLCAqbWRtID0gTlVMTDsKCUdTTGlzdCAqbGlzdDsKCglEQkcoIiVzIiwgbW9k
ZW0tPnN5c3BhdGgpOwoKCWZvciAobGlzdCA9IG1vZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0ID0g
bGlzdC0+bmV4dCkgewoJCXN0cnVjdCBkZXZpY2VfaW5mbyAqaW5mbyA9IGxpc3QtPmRhdGE7CgoJ
CURCRygiJXMgJXMgJXMgJXMiLCBpbmZvLT5kZXZub2RlLCBpbmZvLT5pbnRlcmZhY2UsCgkJCQkJ
CWluZm8tPm51bWJlciwgaW5mby0+bGFiZWwpOwoKCQlpZiAoZ19zdHJjbXAwKGluZm8tPmxhYmVs
LCAiYXV4IikgPT0gMCkgewoJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAobWRtICE9IE5V
TEwpCgkJCQlicmVhazsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5sYWJlbCwgIm1vZGVt
IikgPT0gMCkgewoJCQltZG0gPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAoYXV4ICE9IE5VTEwpCgkJ
CQlicmVhazsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMjU1
LzI1NSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMyIpID09IDAp
CgkJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVt
YmVyLCAiMDUiKSA9PSAwKQoJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJaWYgKGF1
eCA9PSBOVUxMIHx8IG1kbSA9PSBOVUxMKQoJCXJldHVybiBGQUxTRTsKCglEQkcoImF1eD0lcyBt
b2RlbT0lcyIsIGF1eCwgbWRtKTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2Rl
bSwgIkF1eCIsIGF1eCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk1v
ZGVtIiwgbWRtKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX25vdmF0
ZWwoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFyICphdXggPSBOVUxMLCAq
bWRtID0gTlVMTDsKCUdTTGlzdCAqbGlzdDsKCglEQkcoIiVzIiwgbW9kZW0tPnN5c3BhdGgpOwoK
CWZvciAobGlzdCA9IG1vZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0ID0gbGlzdC0+bmV4dCkgewoJ
CXN0cnVjdCBkZXZpY2VfaW5mbyAqaW5mbyA9IGxpc3QtPmRhdGE7CgoJCURCRygiJXMgJXMgJXMg
JXMiLCBpbmZvLT5kZXZub2RlLCBpbmZvLT5pbnRlcmZhY2UsCgkJCQkJCWluZm8tPm51bWJlciwg
aW5mby0+bGFiZWwpOwoKCQlpZiAoZ19zdHJjbXAwKGluZm8tPmxhYmVsLCAiYXV4IikgPT0gMCkg
ewoJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAobWRtICE9IE5VTEwpCgkJCQlicmVhazsK
CQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5sYWJlbCwgIm1vZGVtIikgPT0gMCkgewoJCQlt
ZG0gPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAoYXV4ICE9IE5VTEwpCgkJCQlicmVhazsKCQl9IGVs
c2UgaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMjU1LzI1NSIpID09IDApIHsK
CQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMCIpID09IDApCgkJCQlhdXggPSBpbmZv
LT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDEiKSA9PSAw
KQoJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJaWYgKGF1eCA9PSBOVUxMIHx8IG1k
bSA9PSBOVUxMKQoJCXJldHVybiBGQUxTRTsKCglEQkcoImF1eD0lcyBtb2RlbT0lcyIsIGF1eCwg
bWRtKTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkF1eCIsIGF1eCk7
CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk1vZGVtIiwgbWRtKTsKCgly
ZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX25va2lhKHN0cnVjdCBtb2RlbV9p
bmZvICptb2RlbSkKewoJY29uc3QgY2hhciAqYXV4ID0gTlVMTCwgKm1kbSA9IE5VTEw7CglHU0xp
c3QgKmxpc3Q7CgoJREJHKCIlcyIsIG1vZGVtLT5zeXNwYXRoKTsKCglmb3IgKGxpc3QgPSBtb2Rl
bS0+ZGV2aWNlczsgbGlzdDsgbGlzdCA9IGxpc3QtPm5leHQpIHsKCQlzdHJ1Y3QgZGV2aWNlX2lu
Zm8gKmluZm8gPSBsaXN0LT5kYXRhOwoKCQlEQkcoIiVzICVzICVzICVzIiwgaW5mby0+ZGV2bm9k
ZSwgaW5mby0+aW50ZXJmYWNlLAoJCQkJCQlpbmZvLT5udW1iZXIsIGluZm8tPmxhYmVsKTsKCgkJ
aWYgKGdfc3RyY21wMChpbmZvLT5sYWJlbCwgImF1eCIpID09IDApIHsKCQkJYXV4ID0gaW5mby0+
ZGV2bm9kZTsKCQkJaWYgKG1kbSAhPSBOVUxMKQoJCQkJYnJlYWs7CgkJfSBlbHNlIGlmIChnX3N0
cmNtcDAoaW5mby0+bGFiZWwsICJtb2RlbSIpID09IDApIHsKCQkJbWRtID0gaW5mby0+ZGV2bm9k
ZTsKCQkJaWYgKGF1eCAhPSBOVUxMKQoJCQkJYnJlYWs7CgkJfSBlbHNlIGlmIChnX3N0cmNtcDAo
aW5mby0+aW50ZXJmYWNlLCAiMTAvMC8wIikgPT0gMCkgewoJCQlpZiAoZ19zdHJjbXAwKGluZm8t
Pm51bWJlciwgIjAyIikgPT0gMCkKCQkJCW1kbSA9IGluZm8tPmRldm5vZGU7CgkJCWVsc2UgaWYg
KGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwNCIpID09IDApCgkJCQlhdXggPSBpbmZvLT5kZXZu
b2RlOwoJCX0KCX0KCglpZiAoYXV4ID09IE5VTEwgfHwgbWRtID09IE5VTEwpCgkJcmV0dXJuIEZB
TFNFOwoKCURCRygiYXV4PSVzIG1vZGVtPSVzIiwgYXV4LCBtZG0pOwoKCW9mb25vX21vZGVtX3Nl
dF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiQXV4IiwgYXV4KTsKCW9mb25vX21vZGVtX3NldF9zdHJp
bmcobW9kZW0tPm1vZGVtLCAiTW9kZW0iLCBtZG0pOwoKCXJldHVybiBUUlVFOwp9CgpzdGF0aWMg
Z2Jvb2xlYW4gc2V0dXBfdGVsaXQoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBj
aGFyICptZG0gPSBOVUxMLCAqYXV4ID0gTlVMTCwgKmdwcyA9IE5VTEwsICpuZXQgPSBOVUxMOwoJ
R1NMaXN0ICpsaXN0OwoKCURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0g
bW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmlj
ZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAlcyAlcyAlcyIsIGluZm8tPmRl
dm5vZGUsIGluZm8tPmludGVyZmFjZSwKCQkJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCk7
CgoJCWlmIChnX3N0cmNtcDAoaW5mby0+bGFiZWwsICJhdXgiKSA9PSAwKSB7CgkJCWF1eCA9IGlu
Zm8tPmRldm5vZGU7CgkJCWlmIChtZG0gIT0gTlVMTCkKCQkJCWJyZWFrOwoJCX0gZWxzZSBpZiAo
Z19zdHJjbXAwKGluZm8tPmxhYmVsLCAibW9kZW0iKSA9PSAwKSB7CgkJCW1kbSA9IGluZm8tPmRl
dm5vZGU7CgkJCWlmIChhdXggIT0gTlVMTCkKCQkJCWJyZWFrOwoJCX0gZWxzZSBpZiAoZ19zdHJj
bXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8yNTUvMjU1IikgPT0gMCkgewoJCQlpZiAoZ19zdHJj
bXAwKGluZm8tPm51bWJlciwgIjAwIikgPT0gMCkKCQkJCW1kbSA9IGluZm8tPmRldm5vZGU7CgkJ
CWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCQlncHMgPSBp
bmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDMiKSA9
PSAwKQoJCQkJYXV4ID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZv
LT5pbnRlcmZhY2UsICIyLzIvMSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1i
ZXIsICIwMCIpID09IDApCgkJCQltZG0gPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0
cmNtcDAoaW5mby0+bnVtYmVyLCAiMDYiKSA9PSAwKQoJCQkJYXV4ID0gaW5mby0+ZGV2bm9kZTsK
CQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwgIjBhIikgPT0gMCkKCQkJCWdwcyA9
IGluZm8tPmRldm5vZGU7CgkJfSBlbHNlIGlmIChpbmZvLT5zeXNhdHRyICYmIChnX3N0cl9oYXNf
c3VmZml4KGluZm8tPnN5c2F0dHIsCgkJCQkJCSJDREMgTkNNIikgPT0gVFJVRSkpIHsKCQkJbmV0
ID0gaW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJaWYgKGF1eCA9PSBOVUxMIHx8IG1kbSA9PSBOVUxM
KQoJCXJldHVybiBGQUxTRTsKCglEQkcoIm1vZGVtPSVzIGF1eD0lcyBncHM9JXMgbmV0PSVzIiwg
bWRtLCBhdXgsIGdwcywgbmV0KTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2Rl
bSwgIk1vZGVtIiwgbWRtKTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAi
QXV4IiwgYXV4KTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiR1BTIiwg
Z3BzKTsKCglpZiAobmV0ICE9IE5VTEwpCgkJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+
bW9kZW0sICJOZXR3b3JrSW50ZXJmYWNlIiwgbmV0KTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGlj
IGdib29sZWFuIHNldHVwX3RlbGl0cW1pKHN0cnVjdCBtb2RlbV9pbmZvICptb2RlbSkKewoJY29u
c3QgY2hhciAqcW1pID0gTlVMTCwgKm5ldCA9IE5VTEw7CglHU0xpc3QgKmxpc3Q7CgoJREJHKCIl
cyIsIG1vZGVtLT5zeXNwYXRoKTsKCglmb3IgKGxpc3QgPSBtb2RlbS0+ZGV2aWNlczsgbGlzdDsg
bGlzdCA9IGxpc3QtPm5leHQpIHsKCQlzdHJ1Y3QgZGV2aWNlX2luZm8gKmluZm8gPSBsaXN0LT5k
YXRhOwoKCQlEQkcoIiVzICVzICVzICVzICVzIiwgaW5mby0+ZGV2bm9kZSwgaW5mby0+aW50ZXJm
YWNlLAoJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCwgaW5mby0+c3Vic3lzdGVtKTsKCgkJ
aWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMjU1LzI1NSIpID09IDAgJiYKCQkJ
CWdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMiIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChp
bmZvLT5zdWJzeXN0ZW0sICJuZXQiKSA9PSAwKQoJCQkJbmV0ID0gaW5mby0+ZGV2bm9kZTsKCQkJ
ZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPnN1YnN5c3RlbSwgInVzYm1pc2MiKSA9PSAwKQoJCQkJ
cW1pID0gaW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJaWYgKHFtaSA9PSBOVUxMIHx8IG5ldCA9PSBO
VUxMKQoJCXJldHVybiBGQUxTRTsKCglEQkcoInFtaT0lcyBuZXQ9JXMiLCBxbWksIG5ldCk7CgoJ
b2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJEZXZpY2UiLCBxbWkpOwoJb2Zv
bm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJOZXR3b3JrSW50ZXJmYWNlIiwgbmV0
KTsKCglvZm9ub19tb2RlbV9zZXRfYm9vbGVhbihtb2RlbS0+bW9kZW0sICJGb3JjZVNpbUxlZ2Fj
eSIsIFRSVUUpOwoJb2Zvbm9fbW9kZW1fc2V0X2Jvb2xlYW4obW9kZW0tPm1vZGVtLCAiQWx3YXlz
T25saW5lIiwgVFJVRSk7CglvZm9ub19tb2RlbV9zZXRfZHJpdmVyKG1vZGVtLT5tb2RlbSwgImdv
YmkiKTsKCglyZXR1cm4gVFJVRTsKfQoKLyogVE9ETzogTm90IHVzZWQgYXMgd2UgaGF2ZSBubyBz
aW1jb20gZHJpdmVyICovCnN0YXRpYyBnYm9vbGVhbiBzZXR1cF9zaW1jb20oc3RydWN0IG1vZGVt
X2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFyICptZG0gPSBOVUxMLCAqYXV4ID0gTlVMTCwgKmdw
cyA9IE5VTEwsICpkaWFnID0gTlVMTDsKCUdTTGlzdCAqbGlzdDsKCglEQkcoIiVzIiwgbW9kZW0t
PnN5c3BhdGgpOwoKCWZvciAobGlzdCA9IG1vZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0ID0gbGlz
dC0+bmV4dCkgewoJCXN0cnVjdCBkZXZpY2VfaW5mbyAqaW5mbyA9IGxpc3QtPmRhdGE7CgoJCURC
RygiJXMgJXMgJXMgJXMiLCBpbmZvLT5kZXZub2RlLCBpbmZvLT5pbnRlcmZhY2UsCgkJCQkJCWlu
Zm8tPm51bWJlciwgaW5mby0+bGFiZWwpOwoKCQlpZiAoZ19zdHJjbXAwKGluZm8tPmxhYmVsLCAi
YXV4IikgPT0gMCkgewoJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAobWRtICE9IE5VTEwp
CgkJCQlicmVhazsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5sYWJlbCwgIm1vZGVtIikg
PT0gMCkgewoJCQltZG0gPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAoYXV4ICE9IE5VTEwpCgkJCQli
cmVhazsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMjU1LzI1
NSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMCIpID09IDApCgkJ
CQlkaWFnID0gaW5mby0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJl
ciwgIjAxIikgPT0gMCkKCQkJCWdwcyA9IGluZm8tPmRldm5vZGU7CgkJCWVsc2UgaWYgKGdfc3Ry
Y21wMChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJ
CQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDMiKSA9PSAwKQoJCQkJbWRtID0g
aW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJaWYgKGF1eCA9PSBOVUxMIHx8IG1kbSA9PSBOVUxMKQoJ
CXJldHVybiBGQUxTRTsKCglEQkcoIm1vZGVtPSVzIGF1eD0lcyBncHM9JXMgZGlhZz0lcyIsIG1k
bSwgYXV4LCBncHMsIGRpYWcpOwoKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVt
LCAiTW9kZW0iLCBtZG0pOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJE
YXRhIiwgYXV4KTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiR1BTIiwg
Z3BzKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX3p0ZShzdHJ1Y3Qg
bW9kZW1faW5mbyAqbW9kZW0pCnsKCWNvbnN0IGNoYXIgKmF1eCA9IE5VTEwsICptZG0gPSBOVUxM
LCAqcWNkbSA9IE5VTEw7Cgljb25zdCBjaGFyICptb2RlbV9pbnRmOwoJR1NMaXN0ICpsaXN0OwoK
CURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJaWYgKGdfc3RyY21wMChtb2RlbS0+bW9kZWws
ICIwMDE2IikgPT0gMCB8fAoJCQkJZ19zdHJjbXAwKG1vZGVtLT5tb2RlbCwgIjAwMTciKSA9PSAw
IHx8CgkJCQlnX3N0cmNtcDAobW9kZW0tPm1vZGVsLCAiMDExNyIpID09IDApCgkJbW9kZW1faW50
ZiA9ICIwMiI7CgllbHNlCgkJbW9kZW1faW50ZiA9ICIwMyI7CgoJZm9yIChsaXN0ID0gbW9kZW0t
PmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZv
ICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUs
IGluZm8tPmludGVyZmFjZSwKCQkJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCk7CgoJCWlm
IChnX3N0cmNtcDAoaW5mby0+bGFiZWwsICJhdXgiKSA9PSAwKSB7CgkJCWF1eCA9IGluZm8tPmRl
dm5vZGU7CgkJCWlmIChtZG0gIT0gTlVMTCkKCQkJCWJyZWFrOwoJCX0gZWxzZSBpZiAoZ19zdHJj
bXAwKGluZm8tPmxhYmVsLCAibW9kZW0iKSA9PSAwKSB7CgkJCW1kbSA9IGluZm8tPmRldm5vZGU7
CgkJCWlmIChhdXggIT0gTlVMTCkKCQkJCWJyZWFrOwoJCX0gZWxzZSBpZiAoZ19zdHJjbXAwKGlu
Zm8tPmludGVyZmFjZSwgIjI1NS8yNTUvMjU1IikgPT0gMCkgewoJCQlpZiAoZ19zdHJjbXAwKGlu
Zm8tPm51bWJlciwgIjAwIikgPT0gMCkKCQkJCXFjZG0gPSBpbmZvLT5kZXZub2RlOwoJCQllbHNl
IGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDEiKSA9PSAwKQoJCQkJYXV4ID0gaW5mby0+
ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwgbW9kZW1faW50Zikg
PT0gMCkKCQkJCW1kbSA9IGluZm8tPmRldm5vZGU7CgkJfQoJfQoKCWlmIChhdXggPT0gTlVMTCB8
fCBtZG0gPT0gTlVMTCkKCQlyZXR1cm4gRkFMU0U7CgoJREJHKCJhdXg9JXMgbW9kZW09JXMgcWNk
bT0lcyIsIGF1eCwgbWRtLCBxY2RtKTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5t
b2RlbSwgIkF1eCIsIGF1eCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwg
Ik1vZGVtIiwgbWRtKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX3Nh
bXN1bmcoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFyICpjb250cm9sID0g
TlVMTCwgKm5ldHdvcmsgPSBOVUxMOwoJR1NMaXN0ICpsaXN0OwoKCURCRygiJXMiLCBtb2RlbS0+
c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0
LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJH
KCIlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUsIGluZm8tPmludGVyZmFjZSwKCQkJCQkJaW5m
by0+bnVtYmVyLCBpbmZvLT5sYWJlbCk7CgoJCWlmIChnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNl
LCAiMTAvMC8wIikgPT0gMCkKCQkJY29udHJvbCA9IGluZm8tPmRldm5vZGU7CgkJZWxzZSBpZiAo
Z19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8wLzAiKSA9PSAwKQoJCQluZXR3b3JrID0g
aW5mby0+ZGV2bm9kZTsKCX0KCglpZiAoY29udHJvbCA9PSBOVUxMICYmIG5ldHdvcmsgPT0gTlVM
TCkKCQlyZXR1cm4gRkFMU0U7CgoJREJHKCJjb250cm9sPSVzIG5ldHdvcms9JXMiLCBjb250cm9s
LCBuZXR3b3JrKTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkNvbnRy
b2xQb3J0IiwgY29udHJvbCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwg
Ik5ldHdvcmtJbnRlcmZhY2UiLCBuZXR3b3JrKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdi
b29sZWFuIHNldHVwX3F1ZWN0ZWwoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBj
aGFyICphdXggPSBOVUxMLCAqbWRtID0gTlVMTDsKCUdTTGlzdCAqbGlzdDsKCglEQkcoIiVzIiwg
bW9kZW0tPnN5c3BhdGgpOwoKCWZvciAobGlzdCA9IG1vZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0
ID0gbGlzdC0+bmV4dCkgewoJCXN0cnVjdCBkZXZpY2VfaW5mbyAqaW5mbyA9IGxpc3QtPmRhdGE7
CgoJCURCRygiJXMgJXMgJXMgJXMiLCBpbmZvLT5kZXZub2RlLCBpbmZvLT5pbnRlcmZhY2UsCgkJ
CQkJCWluZm8tPm51bWJlciwgaW5mby0+bGFiZWwpOwoKCQlpZiAoZ19zdHJjbXAwKGluZm8tPmxh
YmVsLCAiYXV4IikgPT0gMCkgewoJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAobWRtICE9
IE5VTEwpCgkJCQlicmVhazsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5sYWJlbCwgIm1v
ZGVtIikgPT0gMCkgewoJCQltZG0gPSBpbmZvLT5kZXZub2RlOwoJCQlpZiAoYXV4ICE9IE5VTEwp
CgkJCQlicmVhazsKCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUv
MjU1LzI1NSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMiIpID09
IDApCgkJCQlhdXggPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+
bnVtYmVyLCAiMDMiKSA9PSAwKQoJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJaWYg
KGF1eCA9PSBOVUxMIHx8IG1kbSA9PSBOVUxMKQoJCXJldHVybiBGQUxTRTsKCglEQkcoImF1eD0l
cyBtb2RlbT0lcyIsIGF1eCwgbWRtKTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5t
b2RlbSwgIkF1eCIsIGF1eCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwg
Ik1vZGVtIiwgbWRtKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX3F1
ZWN0ZWxxbWkoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFyICpxbWkgPSBO
VUxMLCAqbmV0ID0gTlVMTCwgKmdwcyA9IE5VTEwsICphdXggPSBOVUxMOwoJR1NMaXN0ICpsaXN0
OwoKCURCRygiJXMiLCBtb2RlbS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmlj
ZXM7IGxpc3Q7IGxpc3QgPSBnX3NsaXN0X25leHQobGlzdCkpIHsKCQlzdHJ1Y3QgZGV2aWNlX2lu
Zm8gKmluZm8gPSBsaXN0LT5kYXRhOwoKCQlEQkcoIiVzICVzICVzICVzICVzIiwgaW5mby0+ZGV2
bm9kZSwgaW5mby0+aW50ZXJmYWNlLAoJCQkJaW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCwgaW5m
by0+c3Vic3lzdGVtKTsKCgkJaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMjU1
LzI1NSIpID09IDAgJiYKCQkJCWdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwNCIpID09IDApIHsK
CQkJaWYgKGdfc3RyY21wMChpbmZvLT5zdWJzeXN0ZW0sICJuZXQiKSA9PSAwKQoJCQkJbmV0ID0g
aW5mby0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPnN1YnN5c3RlbSwgInVz
Ym1pc2MiKSA9PSAwKQoJCQkJcW1pID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVsc2UgaWYgKGdfc3Ry
Y21wMChpbmZvLT5pbnRlcmZhY2UsICIyNTUvMC8wIikgPT0gMCAmJgoJCQkJZ19zdHJjbXAwKGlu
Zm8tPm51bWJlciwgIjAxIikgPT0gMCkgewoJCQlncHMgPSBpbmZvLT5kZXZub2RlOwoJCX0gZWxz
ZSBpZiAoZ19zdHJjbXAwKGluZm8tPmludGVyZmFjZSwgIjI1NS8wLzAiKSA9PSAwICYmCgkJCQln
X3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDIiKSA9PSAwKSB7CgkJCWF1eCA9IGluZm8tPmRldm5v
ZGU7CgkJfQoJfQoKCURCRygicW1pPSVzIG5ldD0lcyIsIHFtaSwgbmV0KTsKCglpZiAocW1pID09
IE5VTEwgfHwgbmV0ID09IE5VTEwpCgkJcmV0dXJuIEZBTFNFOwoKCURCRygicW1pPSVzIG5ldD0l
cyIsIHFtaSwgbmV0KTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkRl
dmljZSIsIHFtaSk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk5ldHdv
cmtJbnRlcmZhY2UiLCBuZXQpOwoKCURCRygiZ3BzPSVzIGF1eD0lcyIsIGdwcywgYXV4KTsKCglp
ZiAoZ3BzKQoJCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiR1BTIiwgZ3Bz
KTsKCWlmIChhdXgpCgkJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJBdXgi
LCBhdXgpOwoKCW9mb25vX21vZGVtX3NldF9kcml2ZXIobW9kZW0tPm1vZGVtLCAiZ29iaSIpOwoK
CXJldHVybiBUUlVFOwp9CgpzdGF0aWMgZ2Jvb2xlYW4gc2V0dXBfbWJpbShzdHJ1Y3QgbW9kZW1f
aW5mbyAqbW9kZW0pCnsKCWNvbnN0IGNoYXIgKmN0bCA9IE5VTEwsICpuZXQgPSBOVUxMLCAqYXRj
bWQgPSBOVUxMOwoJR1NMaXN0ICpsaXN0OwoJY2hhciBkZXNjcmlwdG9yc1tQQVRIX01BWF07CgoJ
REJHKCIlcyBbJXM6JXNdIiwgbW9kZW0tPnN5c3BhdGgsIG1vZGVtLT52ZW5kb3IsIG1vZGVtLT5t
b2RlbCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5u
ZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJREJHKCIl
cyAlcyAlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUsIGluZm8tPmludGVyZmFjZSwKCQkJCQkJ
aW5mby0+bnVtYmVyLCBpbmZvLT5sYWJlbCwKCQkJCQkJaW5mby0+c3lzYXR0ciwgaW5mby0+c3Vi
c3lzdGVtKTsKCgkJaWYgKGdfc3RyY21wMChpbmZvLT5zdWJzeXN0ZW0sICJ1c2JtaXNjIikgPT0g
MCkgLyogY2RjLXdkbSAqLwoJCQljdGwgPSBpbmZvLT5kZXZub2RlOwoJCWVsc2UgaWYgKGdfc3Ry
Y21wMChpbmZvLT5zdWJzeXN0ZW0sICJuZXQiKSA9PSAwKSAvKiB3d2FuICovCgkJCW5ldCA9IGlu
Zm8tPmRldm5vZGU7CgkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPnN1YnN5c3RlbSwgInR0eSIp
ID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCQlh
dGNtZCA9IGluZm8tPmRldm5vZGU7CgkJfQoJfQoKCWlmIChjdGwgPT0gTlVMTCB8fCBuZXQgPT0g
TlVMTCkKCQlyZXR1cm4gRkFMU0U7CgoJREJHKCJjdGw9JXMgbmV0PSVzIGF0Y21kPSVzIiwgY3Rs
LCBuZXQsIGF0Y21kKTsKCglzcHJpbnRmKGRlc2NyaXB0b3JzLCAiJXMvZGVzY3JpcHRvcnMiLCBt
b2RlbS0+c3lzcGF0aCk7CgoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJE
ZXZpY2UiLCBjdGwpOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJOZXR3
b3JrSW50ZXJmYWNlIiwgbmV0KTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVt
LCAiRGVzY3JpcHRvckZpbGUiLCBkZXNjcmlwdG9ycyk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5n
KG1vZGVtLT5tb2RlbSwgIlZlbmRvciIsIG1vZGVtLT52ZW5kb3IpOwoJb2Zvbm9fbW9kZW1fc2V0
X3N0cmluZyhtb2RlbS0+bW9kZW0sICJNb2RlbCIsIG1vZGVtLT5tb2RlbCk7CgoJcmV0dXJuIFRS
VUU7Cn0KCnN0YXRpYyBnYm9vbGVhbiBzZXR1cF9zZXJpYWxfbW9kZW0oc3RydWN0IG1vZGVtX2lu
Zm8qIG1vZGVtKQp7CglzdHJ1Y3Qgc2VyaWFsX2RldmljZV9pbmZvKiBpbmZvOwoKCWluZm8gPSBt
b2RlbS0+c2VyaWFsOwoKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiRGV2
aWNlIiwgaW5mby0+ZGV2bm9kZSk7CgoJcmV0dXJuIFRSVUU7Cn0KCnN0YXRpYyBnYm9vbGVhbiBz
ZXR1cF90YzY1KHN0cnVjdCBtb2RlbV9pbmZvKiBtb2RlbSkKewoJb2Zvbm9fbW9kZW1fc2V0X2Ry
aXZlcihtb2RlbS0+bW9kZW0sICJjaW50ZXJpb24iKTsKCglyZXR1cm4gc2V0dXBfc2VyaWFsX21v
ZGVtKG1vZGVtKTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX2VoczYoc3RydWN0IG1vZGVtX2lu
Zm8qIG1vZGVtKQp7CglvZm9ub19tb2RlbV9zZXRfZHJpdmVyKG1vZGVtLT5tb2RlbSwgImNpbnRl
cmlvbiIpOwoKCXJldHVybiBzZXR1cF9zZXJpYWxfbW9kZW0obW9kZW0pOwp9CgpzdGF0aWMgZ2Jv
b2xlYW4gc2V0dXBfaWZ4KHN0cnVjdCBtb2RlbV9pbmZvKiBtb2RlbSkKewoJc3RydWN0IHNlcmlh
bF9kZXZpY2VfaW5mbyogaW5mbzsKCWNvbnN0IGNoYXIgKnZhbHVlOwoKCWluZm8gPSBtb2RlbS0+
c2VyaWFsOwoKCXZhbHVlID0gdWRldl9kZXZpY2VfZ2V0X3Byb3BlcnR5X3ZhbHVlKGluZm8tPmRl
diwgIk9GT05PX0lGWF9MRElTQyIpOwoJaWYgKHZhbHVlKQoJCW9mb25vX21vZGVtX3NldF9zdHJp
bmcobW9kZW0tPm1vZGVtLCAiTGluZURpc2NpcGxpbmUiLCB2YWx1ZSk7CgoJdmFsdWUgPSB1ZGV2
X2RldmljZV9nZXRfcHJvcGVydHlfdmFsdWUoaW5mby0+ZGV2LCAiT0ZPTk9fSUZYX0FVRElPIik7
CglpZiAodmFsdWUpCgkJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJBdWRp
b1NldHRpbmciLCB2YWx1ZSk7CgoJdmFsdWUgPSB1ZGV2X2RldmljZV9nZXRfcHJvcGVydHlfdmFs
dWUoaW5mby0+ZGV2LCAiT0ZPTk9fSUZYX0xPT1BCQUNLIik7CglpZiAodmFsdWUpCgkJb2Zvbm9f
bW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJBdWRpb0xvb3BiYWNrIiwgdmFsdWUpOwoK
CW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiRGV2aWNlIiwgaW5mby0+ZGV2
bm9kZSk7CgoJcmV0dXJuIFRSVUU7Cn0KCnN0YXRpYyBnYm9vbGVhbiBzZXR1cF93YXZlY29tKHN0
cnVjdCBtb2RlbV9pbmZvKiBtb2RlbSkKewoJc3RydWN0IHNlcmlhbF9kZXZpY2VfaW5mbyogaW5m
bzsKCWNvbnN0IGNoYXIgKnZhbHVlOwoKCWluZm8gPSBtb2RlbS0+c2VyaWFsOwoKCXZhbHVlID0g
dWRldl9kZXZpY2VfZ2V0X3Byb3BlcnR5X3ZhbHVlKGluZm8tPmRldiwKCQkJCQkJIk9GT05PX1dB
VkVDT01fTU9ERUwiKTsKCWlmICh2YWx1ZSkKCQlvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVt
LT5tb2RlbSwgIk1vZGVsIiwgdmFsdWUpOwoKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0t
Pm1vZGVtLCAiRGV2aWNlIiwgaW5mby0+ZGV2bm9kZSk7CgoJcmV0dXJuIFRSVUU7Cn0KCnN0YXRp
YyBnYm9vbGVhbiBzZXR1cF9pc2lfc2VyaWFsKHN0cnVjdCBtb2RlbV9pbmZvKiBtb2RlbSkKewoJ
c3RydWN0IHNlcmlhbF9kZXZpY2VfaW5mbyogaW5mbzsKCWNvbnN0IGNoYXIgKnZhbHVlOwoKCWlu
Zm8gPSBtb2RlbS0+c2VyaWFsOwoKCWlmIChnX3N0cmNtcDAodWRldl9kZXZpY2VfZ2V0X3N1YnN5
c3RlbShpbmZvLT5kZXYpLCAibmV0IikgIT0gMCkKCQlyZXR1cm4gRkFMU0U7CgoJdmFsdWUgPSB1
ZGV2X2RldmljZV9nZXRfc3lzYXR0cl92YWx1ZShpbmZvLT5kZXYsICJ0eXBlIik7CglpZiAoZ19z
dHJjbXAwKHZhbHVlLCAiODIwIikgIT0gMCkKCQlyZXR1cm4gRkFMU0U7CgoJLyogT0ssIHdlIHdh
bnQgdGhpcyBkZXZpY2UgdG8gYmUgYSBtb2RlbSAqLwoJdmFsdWUgPSB1ZGV2X2RldmljZV9nZXRf
c3lzbmFtZShpbmZvLT5kZXYpOwoJaWYgKHZhbHVlKQoJCW9mb25vX21vZGVtX3NldF9zdHJpbmco
bW9kZW0tPm1vZGVtLCAiSW50ZXJmYWNlIiwgdmFsdWUpOwoKCXZhbHVlID0gdWRldl9kZXZpY2Vf
Z2V0X3Byb3BlcnR5X3ZhbHVlKGluZm8tPmRldiwgIk9GT05PX0lTSV9BRERSRVNTIik7CglpZiAo
dmFsdWUpCgkJb2Zvbm9fbW9kZW1fc2V0X2ludGVnZXIobW9kZW0tPm1vZGVtLCAiQWRkcmVzcyIs
IGF0b2kodmFsdWUpKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX3Vi
bG94KHN0cnVjdCBtb2RlbV9pbmZvICptb2RlbSkKewoJY29uc3QgY2hhciAqYXV4ID0gTlVMTCwg
Km1kbSA9IE5VTEwsICpuZXQgPSBOVUxMOwoJR1NMaXN0ICpsaXN0OwoKCURCRygiJXMiLCBtb2Rl
bS0+c3lzcGF0aCk7CgoJZm9yIChsaXN0ID0gbW9kZW0tPmRldmljZXM7IGxpc3Q7IGxpc3QgPSBs
aXN0LT5uZXh0KSB7CgkJc3RydWN0IGRldmljZV9pbmZvICppbmZvID0gbGlzdC0+ZGF0YTsKCgkJ
REJHKCIlcyAlcyAlcyAlcyIsIGluZm8tPmRldm5vZGUsIGluZm8tPmludGVyZmFjZSwKCQkJCQlp
bmZvLT5udW1iZXIsIGluZm8tPmxhYmVsKTsKCgkJaWYgKGdfc3RyY21wMChpbmZvLT5sYWJlbCwg
ImF1eCIpID09IDApIHsKCQkJYXV4ID0gaW5mby0+ZGV2bm9kZTsKCQkJaWYgKG1kbSAhPSBOVUxM
KQoJCQkJYnJlYWs7CgkJfSBlbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bGFiZWwsICJtb2RlbSIp
ID09IDApIHsKCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQkJaWYgKGF1eCAhPSBOVUxMKQoJCQkJ
YnJlYWs7CgkJLyoKCQkgKiAiMi8yLzEiCgkJICogIC0gYSBjb21tb24gbW9kZW0gaW50ZXJmYWNl
IGJvdGggZm9yIG9sZGVyIG1vZGVscyBsaWtlIExJU0EsCgkJICogICAgYW5kIGZvciBuZXdlciBt
b2RlbHMgbGlrZSBUT0JZLgoJCSAqIEZvciBUT0JZLUwyLCBOZXR3b3JrSW50ZXJmYWNlIGNhbiBi
ZSBkZXRlY3RlZCBmb3IgZWFjaAoJCSAqIHByb2ZpbGU6CgkJICogIC0gbG93LW1lZGl1bSB0aHJv
dWdocHV0IHByb2ZpbGUgOiAyLzYvMAoJCSAqICAtIGZhaXJseSBiYWNrd2FyZC1jb21wYXRpYmxl
IHByb2ZpbGUgOiAxMC8wLzAKCQkgKiAgLSBoaWdoIHRocm91Z2hwdXQgcHJvZmlsZSA6IDIyNC8x
LzMKCQkgKi8KCQl9IGVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5pbnRlcmZhY2UsICIyLzIvMSIp
ID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCQlh
dXggPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAi
MDAiKSA9PSAwKQoJCQkJbWRtID0gaW5mby0+ZGV2bm9kZTsKCQl9IGVsc2UgaWYgKGdfc3RyY21w
MChpbmZvLT5pbnRlcmZhY2UsICIyLzYvMCIpID09IDAgfHwKCQkJCWdfc3RyY21wMChpbmZvLT5p
bnRlcmZhY2UsICIxMC8wLzAiKSA9PSAwIHx8CgkJCQlnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNl
LCAiMjI0LzEvMyIpID09IDApIHsKCQkJbmV0ID0gaW5mby0+ZGV2bm9kZTsKCQl9Cgl9CgoJLyog
QWJvcnQgb25seSBpZiBib3RoIGludGVyZmFjZXMgYXJlIE5VTEwsIGFzIGl0J3MgaGlnaGx5IHBv
c3NpYmxlIHRoYXQKCSAqIG9ubHkgb25lIG9mIDIgaW50ZXJmYWNlcyBpcyBhdmFpbGFibGUgZm9y
IFUtYmxveCBtb2RlbS4KCSAqLwoJaWYgKGF1eCA9PSBOVUxMICYmIG1kbSA9PSBOVUxMKQoJCXJl
dHVybiBGQUxTRTsKCglEQkcoImF1eD0lcyBtb2RlbT0lcyBuZXQ9JXMiLCBhdXgsIG1kbSwgbmV0
KTsKCglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkF1eCIsIGF1eCk7Cglv
Zm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk1vZGVtIiwgbWRtKTsKCW9mb25v
X21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiTW9kZWwiLCBtb2RlbS0+bW9kZWwpOwoJ
b2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJOZXR3b3JrSW50ZXJmYWNlIiwg
bmV0KTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX2dlbWFsdG8oc3Ry
dWN0IG1vZGVtX2luZm8qIG1vZGVtKQp7Cgljb25zdCBjaGFyICphcHAgPSBOVUxMLCAqZ3BzID0g
TlVMTCwgKm1kbSA9IE5VTEwsCgkJKm5ldCA9IE5VTEwsICpxbWkgPSBOVUxMOwoKCUdTTGlzdCAq
bGlzdDsKCglEQkcoIiVzIiwgbW9kZW0tPnN5c3BhdGgpOwoKCWZvciAobGlzdCA9IG1vZGVtLT5k
ZXZpY2VzOyBsaXN0OyBsaXN0ID0gbGlzdC0+bmV4dCkgewoJCXN0cnVjdCBkZXZpY2VfaW5mbyAq
aW5mbyA9IGxpc3QtPmRhdGE7CgoJCURCRygiJXMgJXMgJXMgJXMgJXMiLCBpbmZvLT5kZXZub2Rl
LCBpbmZvLT5pbnRlcmZhY2UsCgkJCQlpbmZvLT5udW1iZXIsIGluZm8tPmxhYmVsLCBpbmZvLT5z
dWJzeXN0ZW0pOwoKCQkvKiBQSFM4LVAgKi8KCQlpZiAoZ19zdHJjbXAwKGluZm8tPmludGVyZmFj
ZSwgIjI1NS8yNTUvMjU1IikgPT0gMCkgewoJCQlpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwg
IjAxIikgPT0gMCkKCQkJCWdwcyA9IGluZm8tPmRldm5vZGU7CgkJCWVsc2UgaWYgKGdfc3RyY21w
MChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCQlhcHAgPSBpbmZvLT5kZXZub2RlOwoJCQll
bHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDMiKSA9PSAwKQoJCQkJbWRtID0gaW5m
by0+ZGV2bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPnN1YnN5c3RlbSwgIm5ldCIp
ID09IDApCgkJCQluZXQgPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlmIChnX3N0cmNtcDAoaW5m
by0+c3Vic3lzdGVtLCAidXNibWlzYyIpID09IDApCgkJCQlxbWkgPSBpbmZvLT5kZXZub2RlOwoJ
CX0KCgkJLyogQ2ludGVyaW9uIEFMUzMsIFBMUzgtRSwgUExTOC1YICovCgkJaWYgKGdfc3RyY21w
MChpbmZvLT5pbnRlcmZhY2UsICIyLzIvMSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZv
LT5udW1iZXIsICIwMCIpID09IDApCgkJCQltZG0gPSBpbmZvLT5kZXZub2RlOwoJCQllbHNlIGlm
IChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDIiKSA9PSAwKQoJCQkJYXBwID0gaW5mby0+ZGV2
bm9kZTsKCQkJZWxzZSBpZiAoZ19zdHJjbXAwKGluZm8tPm51bWJlciwgIjA0IikgPT0gMCkKCQkJ
CWdwcyA9IGluZm8tPmRldm5vZGU7CgkJfQoJCWlmIChnX3N0cmNtcDAoaW5mby0+aW50ZXJmYWNl
LCAiMi82LzAiKSA9PSAwKSB7CgkJCWlmIChnX3N0cmNtcDAoaW5mby0+c3Vic3lzdGVtLCAibmV0
IikgPT0gMCkKCQkJCW5ldCA9IGluZm8tPmRldm5vZGU7CgkJfQoJfQoKCURCRygiYXBwbGljYXRp
b249JXMgZ3BzPSVzIG1vZGVtPSVzIG5ldHdvcms9JXMgcW1pPSVzIiwKCQkJYXBwLCBncHMsIG1k
bSwgbmV0LCBxbWkpOwoKCWlmIChhcHAgPT0gTlVMTCB8fCBtZG0gPT0gTlVMTCkKCQlyZXR1cm4g
RkFMU0U7CgoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJBcHBsaWNhdGlv
biIsIGFwcCk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIkdQUyIsIGdw
cyk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2RlbSwgIk1vZGVtIiwgbWRtKTsK
CW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiRGV2aWNlIiwgcW1pKTsKCW9m
b25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1vZGVtLCAiTW9kZWwiLCBtb2RlbS0+bW9kZWwp
OwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJOZXR3b3JrSW50ZXJmYWNl
IiwgbmV0KTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIGdib29sZWFuIHNldHVwX3htbTd4eHgo
c3RydWN0IG1vZGVtX2luZm8gKm1vZGVtKQp7Cgljb25zdCBjaGFyICptZG0gPSBOVUxMLCAqbmV0
ID0gTlVMTDsKCUdTTGlzdCAqbGlzdDsKCglEQkcoIiVzICVzXG4iLCBfX0RBVEVfXywgX19USU1F
X18pOwoJREJHKCIlcyAlcyAlcyAlcyAlcyAlc1xuIiwgbW9kZW0tPnN5c3BhdGgsIG1vZGVtLT5k
ZXZuYW1lLAoJCW1vZGVtLT5kcml2ZXIsIG1vZGVtLT52ZW5kb3IsIG1vZGVtLT5tb2RlbCwgbW9k
ZW0tPnN5c2F0dHIpOwoKCWZvciAobGlzdCA9IG1vZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0ID0g
bGlzdC0+bmV4dCkgewoJCXN0cnVjdCBkZXZpY2VfaW5mbyAqaW5mbyA9IGxpc3QtPmRhdGE7CgoJ
CURCRygiJXMgJXMgJXMgJXMgJXMgJXMgJXNcbiIsIGluZm8tPmRldnBhdGgsIGluZm8tPmRldm5v
ZGUsCgkJCQlpbmZvLT5pbnRlcmZhY2UsIGluZm8tPm51bWJlciwgaW5mby0+bGFiZWwsCgkJCQlp
bmZvLT5zeXNhdHRyLCBpbmZvLT5zdWJzeXN0ZW0pOwoKCQlpZiAoZ19zdHJjbXAwKGluZm8tPnN1
YnN5c3RlbSwgInR0eSIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIw
MiIpID09IDApCgkJCQltZG0gPSBpbmZvLT5kZXZub2RlOwoJCX0gZWxzZSBpZiAoZ19zdHJjbXAw
KGluZm8tPnN1YnN5c3RlbSwgIm5ldCIpID09IDApIHsKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5u
dW1iZXIsICIwMCIpID09IDApCgkJCQluZXQgPSBpbmZvLT5kZXZub2RlOwoJCX0KCX0KCglpZiAo
bWRtID09IE5VTEwgfHwgbmV0ID09IE5VTEwpCgkJcmV0dXJuIEZBTFNFOwoKCURCRygibW9kZW09
JXMgbmV0PSVzXG4iLCBtZG0sIG5ldCk7CgoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+
bW9kZW0sICJNb2RlbSIsIG1kbSk7CglvZm9ub19tb2RlbV9zZXRfc3RyaW5nKG1vZGVtLT5tb2Rl
bSwgIk5ldHdvcmtJbnRlcmZhY2UiLCBuZXQpOwoKCXJldHVybiBUUlVFOwp9CgpzdGF0aWMgZ2Jv
b2xlYW4gc2V0dXBfc2ltNzEwMChzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW0pCnsKCWNvbnN0IGNo
YXIgKmF0ID0gTlVMTCwgKnBwcCA9IE5VTEwsICpncHMgPSBOVUxMLCAqZGlhZyA9IE5VTEwsICph
dWRpbyA9IE5VTEw7CglHU0xpc3QgKmxpc3Q7CgoJREJHKCIlcyIsIG1vZGVtLT5zeXNwYXRoKTsK
Cglmb3IgKGxpc3QgPSBtb2RlbS0+ZGV2aWNlczsgbGlzdDsgbGlzdCA9IGxpc3QtPm5leHQpIHsK
CQlzdHJ1Y3QgZGV2aWNlX2luZm8gKmluZm8gPSBsaXN0LT5kYXRhOwoKCQlEQkcoIiVzICVzIiwg
aW5mby0+ZGV2bm9kZSwgaW5mby0+bnVtYmVyKTsKCgkJLyoKCQkgKiBTZXJpYWwgcG9ydCBsYXlv
dXQ6CgkJICogMDogUUNETS9ESUFHCgkJICogMTogTk1FQQoJCSAqIDI6IEFUCgkJICogMzogQVQv
UFBQCgkJICogNDogYXVkaW8KCQkgKgoJCSAqIC0tIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xp
c3RzL2xpbnV4LXVzYi9tc2cxMzU3MjguaHRtbAoJCSAqLwoJCWlmIChnX3N0cmNtcDAoaW5mby0+
bnVtYmVyLCAiMDAiKSA9PSAwKQoJCQlkaWFnID0gaW5mby0+ZGV2bm9kZTsKCQllbHNlIGlmIChn
X3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDEiKSA9PSAwKQoJCQlncHMgPSBpbmZvLT5kZXZub2Rl
OwoJCWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5udW1iZXIsICIwMiIpID09IDApCgkJCWF0ID0g
aW5mby0+ZGV2bm9kZTsKCQllbHNlIGlmIChnX3N0cmNtcDAoaW5mby0+bnVtYmVyLCAiMDMiKSA9
PSAwKQoJCQlwcHAgPSBpbmZvLT5kZXZub2RlOwoJCWVsc2UgaWYgKGdfc3RyY21wMChpbmZvLT5u
dW1iZXIsICIwNCIpID09IDApCgkJCWF1ZGlvID0gaW5mby0+ZGV2bm9kZTsKCX0KCglpZiAoYXQg
PT0gTlVMTCkKCQlyZXR1cm4gRkFMU0U7CgoJREJHKCJhdD0lcyBwcHA9JXMgZ3BzPSVzIGRpYWc9
JXMsIGF1ZGlvPSVzIiwgYXQsIHBwcCwgZ3BzLCBkaWFnLCBhdWRpbyk7CgoJb2Zvbm9fbW9kZW1f
c2V0X3N0cmluZyhtb2RlbS0+bW9kZW0sICJBVCIsIGF0KTsKCW9mb25vX21vZGVtX3NldF9zdHJp
bmcobW9kZW0tPm1vZGVtLCAiUFBQIiwgcHBwKTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9k
ZW0tPm1vZGVtLCAiR1BTIiwgZ3BzKTsKCW9mb25vX21vZGVtX3NldF9zdHJpbmcobW9kZW0tPm1v
ZGVtLCAiRGlhZyIsIGRpYWcpOwoJb2Zvbm9fbW9kZW1fc2V0X3N0cmluZyhtb2RlbS0+bW9kZW0s
ICJBdWRpbyIsIGF1ZGlvKTsKCglyZXR1cm4gVFJVRTsKfQoKc3RhdGljIHN0cnVjdCB7Cgljb25z
dCBjaGFyICpuYW1lOwoJZ2Jvb2xlYW4gKCpzZXR1cCkoc3RydWN0IG1vZGVtX2luZm8gKm1vZGVt
KTsKCWNvbnN0IGNoYXIgKnN5c2F0dHI7Cn0gZHJpdmVyX2xpc3RbXSA9IHsKCXsgImlzaXVzYiIs
CXNldHVwX2lzaSwJInR5cGUiCQkJfSwKCXsgIm1ibSIsCXNldHVwX21ibSwJImRldmljZS9pbnRl
cmZhY2UiCX0sCgl7ICJoc28iLAlzZXR1cF9oc28sCSJoc290eXBlIgkJfSwKCXsgImdvYmkiLAlz
ZXR1cF9nb2JpCX0sCgl7ICJzaWVycmEiLAlzZXR1cF9zaWVycmEJfSwKCXsgImh1YXdlaSIsCXNl
dHVwX2h1YXdlaQl9LAoJeyAic3BlZWR1cGNkbWEiLHNldHVwX3NwZWVkdXAJfSwKCXsgInNwZWVk
dXAiLAlzZXR1cF9zcGVlZHVwCX0sCgl7ICJsaW5rdG9wIiwJc2V0dXBfbGlua3RvcAl9LAoJeyAi
YWxjYXRlbCIsCXNldHVwX2FsY2F0ZWwJfSwKCXsgIm5vdmF0ZWwiLAlzZXR1cF9ub3ZhdGVsCX0s
Cgl7ICJub2tpYSIsCXNldHVwX25va2lhCX0sCgl7ICJ0ZWxpdCIsCXNldHVwX3RlbGl0LAkiZGV2
aWNlL2ludGVyZmFjZSIJfSwKCXsgInRlbGl0cW1pIiwJc2V0dXBfdGVsaXRxbWkJfSwKCXsgInNp
bWNvbSIsCXNldHVwX3NpbWNvbQl9LAoJeyAic2ltNzEwMCIsCXNldHVwX3NpbTcxMDAJfSwKCXsg
Inp0ZSIsCXNldHVwX3p0ZQl9LAoJeyAiaWNlcmEiLAlzZXR1cF9pY2VyYQl9LAoJeyAic2Ftc3Vu
ZyIsCXNldHVwX3NhbXN1bmcJfSwKCXsgInF1ZWN0ZWwiLAlzZXR1cF9xdWVjdGVsCX0sCgl7ICJx
dWVjdGVscW1pIiwJc2V0dXBfcXVlY3RlbHFtaX0sCgl7ICJ1YmxveCIsCXNldHVwX3VibG94CX0s
Cgl7ICJnZW1hbHRvIiwJc2V0dXBfZ2VtYWx0bwl9LAoJeyAieG1tN3h4eCIsCXNldHVwX3htbTd4
eHgJfSwKCXsgIm1iaW0iLAlzZXR1cF9tYmltCX0sCgkvKiBGb2xsb3dpbmcgYXJlIG5vbi1VU0Ig
bW9kZW1zICovCgl7ICJpZngiLAlzZXR1cF9pZngJCX0sCgl7ICJ1ODUwMCIsCXNldHVwX2lzaV9z
ZXJpYWwJfSwKCXsgIm45MDAiLAlzZXR1cF9pc2lfc2VyaWFsCX0sCgl7ICJjYWx5cHNvIiwJc2V0
dXBfc2VyaWFsX21vZGVtCX0sCgl7ICJjaW50ZXJpb24iLAlzZXR1cF9zZXJpYWxfbW9kZW0JfSwK
CXsgIm5va2lhY2RtYSIsCXNldHVwX3NlcmlhbF9tb2RlbQl9LAoJeyAic2ltOTAwIiwJc2V0dXBf
c2VyaWFsX21vZGVtCX0sCgl7ICJ3YXZlY29tIiwJc2V0dXBfd2F2ZWNvbQkJfSwKCXsgInRjNjUi
LAlzZXR1cF90YzY1CQl9LAoJeyAiZWhzNiIsCXNldHVwX2VoczYJCX0sCgl7IH0KfTsKCnN0YXRp
YyBHSGFzaFRhYmxlICptb2RlbV9saXN0OwoKc3RhdGljIGNvbnN0IGNoYXIgKmdldF9zeXNhdHRy
KGNvbnN0IGNoYXIgKmRyaXZlcikKewoJdW5zaWduZWQgaW50IGk7CgoJZm9yIChpID0gMDsgZHJp
dmVyX2xpc3RbaV0ubmFtZTsgaSsrKSB7CgkJaWYgKGdfc3RyX2VxdWFsKGRyaXZlcl9saXN0W2ld
Lm5hbWUsIGRyaXZlcikgPT0gVFJVRSkKCQkJcmV0dXJuIGRyaXZlcl9saXN0W2ldLnN5c2F0dHI7
Cgl9CgoJcmV0dXJuIE5VTEw7Cn0KCnN0YXRpYyB2b2lkIGRldmljZV9pbmZvX2ZyZWUoc3RydWN0
IGRldmljZV9pbmZvKiBpbmZvKQp7CglnX2ZyZWUoaW5mby0+ZGV2cGF0aCk7CglnX2ZyZWUoaW5m
by0+ZGV2bm9kZSk7CglnX2ZyZWUoaW5mby0+aW50ZXJmYWNlKTsKCWdfZnJlZShpbmZvLT5udW1i
ZXIpOwoJZ19mcmVlKGluZm8tPmxhYmVsKTsKCWdfZnJlZShpbmZvLT5zeXNhdHRyKTsKCWdfZnJl
ZShpbmZvLT5zdWJzeXN0ZW0pOwoJZ19mcmVlKGluZm8pOwp9CgpzdGF0aWMgdm9pZCBzZXJpYWxf
ZGV2aWNlX2luZm9fZnJlZShzdHJ1Y3Qgc2VyaWFsX2RldmljZV9pbmZvKiBpbmZvKQp7CglnX2Zy
ZWUoaW5mby0+ZGV2cGF0aCk7CglnX2ZyZWUoaW5mby0+ZGV2bm9kZSk7CglnX2ZyZWUoaW5mby0+
c3Vic3lzdGVtKTsKCXVkZXZfZGV2aWNlX3VucmVmKGluZm8tPmRldik7CglnX2ZyZWUoaW5mbyk7
Cn0KCnN0YXRpYyB2b2lkIGRlc3Ryb3lfbW9kZW0oZ3BvaW50ZXIgZGF0YSkKewoJc3RydWN0IG1v
ZGVtX2luZm8gKm1vZGVtID0gZGF0YTsKCUdTTGlzdCAqbGlzdDsKCglEQkcoIiVzIiwgbW9kZW0t
PnN5c3BhdGgpOwoKCW9mb25vX21vZGVtX3JlbW92ZShtb2RlbS0+bW9kZW0pOwoKCXN3aXRjaCAo
bW9kZW0tPnR5cGUpIHsKCWNhc2UgTU9ERU1fVFlQRV9VU0I6CgkJZm9yIChsaXN0ID0gbW9kZW0t
PmRldmljZXM7IGxpc3Q7IGxpc3QgPSBsaXN0LT5uZXh0KSB7CgkJCXN0cnVjdCBkZXZpY2VfaW5m
byAqaW5mbyA9IGxpc3QtPmRhdGE7CgoJCQlEQkcoIiVzIiwgaW5mby0+ZGV2bm9kZSk7CgkJCWRl
dmljZV9pbmZvX2ZyZWUoaW5mbyk7CgkJfQoKCQlnX3NsaXN0X2ZyZWUobW9kZW0tPmRldmljZXMp
OwoJCWJyZWFrOwoJY2FzZSBNT0RFTV9UWVBFX1NFUklBTDoKCQlzZXJpYWxfZGV2aWNlX2luZm9f
ZnJlZShtb2RlbS0+c2VyaWFsKTsKCQlicmVhazsKCX0KCglnX2ZyZWUobW9kZW0tPnN5c3BhdGgp
OwoJZ19mcmVlKG1vZGVtLT5kZXZuYW1lKTsKCWdfZnJlZShtb2RlbS0+ZHJpdmVyKTsKCWdfZnJl
ZShtb2RlbS0+dmVuZG9yKTsKCWdfZnJlZShtb2RlbS0+bW9kZWwpOwoJZ19mcmVlKG1vZGVtKTsK
fQoKc3RhdGljIGdib29sZWFuIGNoZWNrX3JlbW92ZShncG9pbnRlciBrZXksIGdwb2ludGVyIHZh
bHVlLCBncG9pbnRlciB1c2VyX2RhdGEpCnsKCXN0cnVjdCBtb2RlbV9pbmZvICptb2RlbSA9IHZh
bHVlOwoJY29uc3QgY2hhciAqZGV2cGF0aCA9IHVzZXJfZGF0YTsKCUdTTGlzdCAqbGlzdDsKCglz
d2l0Y2ggKG1vZGVtLT50eXBlKSB7CgljYXNlIE1PREVNX1RZUEVfVVNCOgoJCWZvciAobGlzdCA9
IG1vZGVtLT5kZXZpY2VzOyBsaXN0OyBsaXN0ID0gbGlzdC0+bmV4dCkgewoJCQlzdHJ1Y3QgZGV2
aWNlX2luZm8gKmluZm8gPSBsaXN0LT5kYXRhOwoKCQkJaWYgKGdfc3RyY21wMChpbmZvLT5kZXZw
YXRoLCBkZXZwYXRoKSA9PSAwKQoJCQkJcmV0dXJuIFRSVUU7CgkJfQoJCWJyZWFrOwoJY2FzZSBN
T0RFTV9UWVBFX1NFUklBTDoKCQlpZiAoZ19zdHJjbXAwKG1vZGVtLT5zZXJpYWwtPmRldnBhdGgs
IGRldnBhdGgpID09IDApCgkJCXJldHVybiBUUlVFOwoJCWJyZWFrOwoJfQoKCXJldHVybiBGQUxT
RTsKfQoKc3RhdGljIHZvaWQgcmVtb3ZlX2RldmljZShzdHJ1Y3QgdWRldl9kZXZpY2UgKmRldmlj
ZSkKewoJY29uc3QgY2hhciAqc3lzcGF0aDsKCglzeXNwYXRoID0gdWRldl9kZXZpY2VfZ2V0X3N5
c3BhdGgoZGV2aWNlKTsKCWlmIChzeXNwYXRoID09IE5VTEwpCgkJcmV0dXJuOwoKCURCRygiJXMi
LCBzeXNwYXRoKTsKCglnX2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUobW9kZW1fbGlzdCwgY2hl
Y2tfcmVtb3ZlLAoJCQkJCQkoY2hhciAqKSBzeXNwYXRoKTsKfQoKc3RhdGljIGdpbnQgY29tcGFy
ZV9kZXZpY2UoZ2NvbnN0cG9pbnRlciBhLCBnY29uc3Rwb2ludGVyIGIpCnsKCWNvbnN0IHN0cnVj
dCBkZXZpY2VfaW5mbyAqaW5mbzEgPSBhOwoJY29uc3Qgc3RydWN0IGRldmljZV9pbmZvICppbmZv
MiA9IGI7CgoJcmV0dXJuIGdfc3RyY21wMChpbmZvMS0+bnVtYmVyLCBpbmZvMi0+bnVtYmVyKTsK
fQoKLyoKICogSGVyZSB3ZSB0cnkgdG8gZmluZCB0aGUgIm1vZGVtIGRldmljZSIuCiAqCiAqIElu
IHRoaXMgdmFyaWFudCB3ZSBpZGVudGlmeSB0aGUgIm1vZGVtIGRldmljZSIgYXMgc2ltcGx5IHRo
ZSBkZXZpY2UKICogdGhhdCBoYXMgdGhlIE9GT05PX0RSSVZFUiBwcm9wZXJ0eS4gIElmIHRoZSBk
ZXZpY2Ugbm9kZSBkb2Vzbid0CiAqIGhhdmUgdGhpcyBwcm9wZXJ0eSBpdHNlbGYsIHRoZW4gd2Ug
ZG8gYSBicnV0ZSBmb3JjZSBzZWFyY2ggZm9yIGl0CiAqIHRocm91Z2ggdGhlIGRldmljZSBoaWVy
YXJjaHkuCiAqCiAqLwpzdGF0aWMgc3RydWN0IHVkZXZfZGV2aWNlKiBnZXRfc2VyaWFsX21vZGVt
X2RldmljZShzdHJ1Y3QgdWRldl9kZXZpY2UgKmRldikKewoJY29uc3QgY2hhciogZHJpdmVyOwoK
CXdoaWxlIChkZXYpIHsKCQlkcml2ZXIgPSB1ZGV2X2RldmljZV9nZXRfcHJvcGVydHlfdmFsdWUo
ZGV2LCAiT0ZPTk9fRFJJVkVSIik7CgkJaWYgKGRyaXZlcikKCQkJcmV0dXJuIGRldjsKCgkJZGV2
ID0gdWRldl9kZXZpY2VfZ2V0X3BhcmVudChkZXYpOwoJfQoKCXJldHVybiBOVUxMOwp9CgovKgog
KiBBZGQgJ2xlZ2FjeScgZGV2aWNlCiAqCiAqIFRoZSB0ZXJtIGxlZ2FjeSBpcyBhIGJpdCBtaXNs
ZWFkaW5nLCBidXQgdGhpcyBhZGRzIGRldmljZXMgYWNjb3JkaW5nCiAqIHRvIHRoZSBvcmlnaW5h
bCBvZm9ubyBtb2RlbC4KICoKICogLSBXZSBjYW5ub3QgYXNzdW1lIHRoYXQgdGhlc2UgYXJlIFVT
QiBkZXZpY2VzCiAqIC0gVGhlIG1vZGVtIGNvbnNpc3RzIG9mIG9ubHkgYSBzaW5nbGUgaW50ZXJm
YWNlCiAqIC0gVGhlIGRldmljZSBtdXN0IGhhdmUgYW4gT0ZPTk9fRFJJVkVSIHByb3BlcnR5IGZy
b20gdWRldgogKi8Kc3RhdGljIHZvaWQgYWRkX3NlcmlhbF9kZXZpY2Uoc3RydWN0IHVkZXZfZGV2
aWNlICpkZXYpCnsKCWNvbnN0IGNoYXIgKnN5c3BhdGgsICpkZXZwYXRoLCAqZGV2bmFtZSwgKmRl
dm5vZGU7CglzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW07CglzdHJ1Y3Qgc2VyaWFsX2RldmljZV9p
bmZvICppbmZvOwoJY29uc3QgY2hhciAqc3Vic3lzdGVtOwoJc3RydWN0IHVkZXZfZGV2aWNlKiBt
ZGV2OwoJY29uc3QgY2hhciogZHJpdmVyOwoKCW1kZXYgPSBnZXRfc2VyaWFsX21vZGVtX2Rldmlj
ZShkZXYpOwoJaWYgKCFtZGV2KSB7CgkJREJHKCJEZXZpY2UgaXMgbWlzc2luZyByZXF1aXJlZCBP
Rk9OT19EUklWRVIgcHJvcGVydHkiKTsKCQlyZXR1cm47Cgl9CgoJZHJpdmVyID0gdWRldl9kZXZp
Y2VfZ2V0X3Byb3BlcnR5X3ZhbHVlKG1kZXYsICJPRk9OT19EUklWRVIiKTsKCglzeXNwYXRoID0g
dWRldl9kZXZpY2VfZ2V0X3N5c3BhdGgobWRldik7CglkZXZuYW1lID0gdWRldl9kZXZpY2VfZ2V0
X2Rldm5vZGUobWRldik7CglkZXZwYXRoID0gdWRldl9kZXZpY2VfZ2V0X2RldnBhdGgobWRldik7
CgoJZGV2bm9kZSA9IHVkZXZfZGV2aWNlX2dldF9kZXZub2RlKGRldik7CgoJaWYgKCFzeXNwYXRo
IHx8ICFkZXZwYXRoKQoJCXJldHVybjsKCgltb2RlbSA9IGdfaGFzaF90YWJsZV9sb29rdXAobW9k
ZW1fbGlzdCwgc3lzcGF0aCk7CglpZiAobW9kZW0gPT0gTlVMTCkgewoJCW1vZGVtID0gZ190cnlf
bmV3MChzdHJ1Y3QgbW9kZW1faW5mbywgMSk7CgkJaWYgKG1vZGVtID09IE5VTEwpCgkJCXJldHVy
bjsKCgkJbW9kZW0tPnR5cGUgPSBNT0RFTV9UWVBFX1NFUklBTDsKCQltb2RlbS0+c3lzcGF0aCA9
IGdfc3RyZHVwKHN5c3BhdGgpOwoJCW1vZGVtLT5kZXZuYW1lID0gZ19zdHJkdXAoZGV2bmFtZSk7
CgkJbW9kZW0tPmRyaXZlciA9IGdfc3RyZHVwKGRyaXZlcik7CgoJCWdfaGFzaF90YWJsZV9yZXBs
YWNlKG1vZGVtX2xpc3QsIG1vZGVtLT5zeXNwYXRoLCBtb2RlbSk7Cgl9CgoJc3Vic3lzdGVtID0g
dWRldl9kZXZpY2VfZ2V0X3N1YnN5c3RlbShkZXYpOwoKCURCRygiJXMiLCBzeXNwYXRoKTsKCURC
RygiJXMiLCBkZXZwYXRoKTsKCURCRygiJXMgKCVzKSIsIGRldm5vZGUsIGRyaXZlcik7CgoJaW5m
byA9IGdfdHJ5X25ldzAoc3RydWN0IHNlcmlhbF9kZXZpY2VfaW5mbywgMSk7CglpZiAoaW5mbyA9
PSBOVUxMKQoJCXJldHVybjsKCglpbmZvLT5kZXZwYXRoID0gZ19zdHJkdXAoZGV2cGF0aCk7Cglp
bmZvLT5kZXZub2RlID0gZ19zdHJkdXAoZGV2bm9kZSk7CglpbmZvLT5zdWJzeXN0ZW0gPSBnX3N0
cmR1cChzdWJzeXN0ZW0pOwoJaW5mby0+ZGV2ID0gdWRldl9kZXZpY2VfcmVmKGRldik7CgoJbW9k
ZW0tPnNlcmlhbCA9IGluZm87Cn0KCnN0YXRpYyB2b2lkIGFkZF9kZXZpY2UoY29uc3QgY2hhciAq
c3lzcGF0aCwgY29uc3QgY2hhciAqZGV2bmFtZSwKCQkJY29uc3QgY2hhciAqZHJpdmVyLCBjb25z
dCBjaGFyICp2ZW5kb3IsCgkJCWNvbnN0IGNoYXIgKm1vZGVsLCBzdHJ1Y3QgdWRldl9kZXZpY2Ug
KmRldmljZSkKewoJc3RydWN0IHVkZXZfZGV2aWNlICp1c2JfaW50ZXJmYWNlOwoJY29uc3QgY2hh
ciAqZGV2cGF0aCwgKmRldm5vZGUsICppbnRlcmZhY2UsICpudW1iZXI7Cgljb25zdCBjaGFyICps
YWJlbCwgKnN5c2F0dHIsICpzdWJzeXN0ZW07CglzdHJ1Y3QgbW9kZW1faW5mbyAqbW9kZW07Cglz
dHJ1Y3QgZGV2aWNlX2luZm8gKmluZm87CglzdHJ1Y3QgdWRldl9kZXZpY2UgKnBhcmVudDsKCglk
ZXZwYXRoID0gdWRldl9kZXZpY2VfZ2V0X3N5c3BhdGgoZGV2aWNlKTsKCWlmIChkZXZwYXRoID09
IE5VTEwpCgkJcmV0dXJuOwoKCWRldm5vZGUgPSB1ZGV2X2RldmljZV9nZXRfZGV2bm9kZShkZXZp
Y2UpOwoJaWYgKGRldm5vZGUgPT0gTlVMTCkgewoJCWRldm5vZGUgPSB1ZGV2X2RldmljZV9nZXRf
cHJvcGVydHlfdmFsdWUoZGV2aWNlLCAiSU5URVJGQUNFIik7CgkJaWYgKGRldm5vZGUgPT0gTlVM
TCkKCQkJcmV0dXJuOwoJfQoKCXVzYl9pbnRlcmZhY2UgPSB1ZGV2X2RldmljZV9nZXRfcGFyZW50
X3dpdGhfc3Vic3lzdGVtX2RldnR5cGUoZGV2aWNlLAoJCQkJCQkidXNiIiwgInVzYl9pbnRlcmZh
Y2UiKTsKCWlmICh1c2JfaW50ZXJmYWNlID09IE5VTEwpCgkJcmV0dXJuOwoKCW1vZGVtID0gZ19o
YXNoX3RhYmxlX2xvb2t1cChtb2RlbV9saXN0LCBzeXNwYXRoKTsKCWlmIChtb2RlbSA9PSBOVUxM
KSB7CgkJbW9kZW0gPSBnX3RyeV9uZXcwKHN0cnVjdCBtb2RlbV9pbmZvLCAxKTsKCQlpZiAobW9k
ZW0gPT0gTlVMTCkKCQkJcmV0dXJuOwoKCQltb2RlbS0+dHlwZSA9IE1PREVNX1RZUEVfVVNCOwoJ
CW1vZGVtLT5zeXNwYXRoID0gZ19zdHJkdXAoc3lzcGF0aCk7CgkJbW9kZW0tPmRldm5hbWUgPSBn
X3N0cmR1cChkZXZuYW1lKTsKCQltb2RlbS0+ZHJpdmVyID0gZ19zdHJkdXAoZHJpdmVyKTsKCQlt
b2RlbS0+dmVuZG9yID0gZ19zdHJkdXAodmVuZG9yKTsKCQltb2RlbS0+bW9kZWwgPSBnX3N0cmR1
cChtb2RlbCk7CgoJCW1vZGVtLT5zeXNhdHRyID0gZ2V0X3N5c2F0dHIoZHJpdmVyKTsKCgkJZ19o
YXNoX3RhYmxlX3JlcGxhY2UobW9kZW1fbGlzdCwgbW9kZW0tPnN5c3BhdGgsIG1vZGVtKTsKCX0K
CglpbnRlcmZhY2UgPSB1ZGV2X2RldmljZV9nZXRfcHJvcGVydHlfdmFsdWUodXNiX2ludGVyZmFj
ZSwgIklOVEVSRkFDRSIpOwoJbnVtYmVyID0gdWRldl9kZXZpY2VfZ2V0X3Byb3BlcnR5X3ZhbHVl
KGRldmljZSwgIklEX1VTQl9JTlRFUkZBQ0VfTlVNIik7CgoJLyogSWYgZW52aXJvbm1lbnQgdmFy
aWFibGUgaXMgbm90IHNldCwgZ2V0IHZhbHVlIGZyb20gYXR0cmlidXRlcyAob3IgcGFyZW50J3Mg
b25lcykgKi8KCWlmIChudW1iZXIgPT0gTlVMTCkgewoJCW51bWJlciA9IHVkZXZfZGV2aWNlX2dl
dF9zeXNhdHRyX3ZhbHVlKGRldmljZSwKCQkJCQkJCSJiSW50ZXJmYWNlTnVtYmVyIik7CgoJCWlm
IChudW1iZXIgPT0gTlVMTCkgewoJCQlwYXJlbnQgPSB1ZGV2X2RldmljZV9nZXRfcGFyZW50KGRl
dmljZSk7CgkJCW51bWJlciA9IHVkZXZfZGV2aWNlX2dldF9zeXNhdHRyX3ZhbHVlKHBhcmVudCwK
CQkJCQkJCSJiSW50ZXJmYWNlTnVtYmVyIik7CgkJfQoJfQoKCWxhYmVsID0gdWRldl9kZXZpY2Vf
Z2V0X3Byb3BlcnR5X3ZhbHVlKGRldmljZSwgIk9GT05PX0xBQkVMIik7CglpZiAoIWxhYmVsKQoJ
CWxhYmVsID0gdWRldl9kZXZpY2VfZ2V0X3Byb3BlcnR5X3ZhbHVlKHVzYl9pbnRlcmZhY2UsCgkJ
CQkJCQkiT0ZPTk9fTEFCRUwiKTsKCglzdWJzeXN0ZW0gPSB1ZGV2X2RldmljZV9nZXRfc3Vic3lz
dGVtKGRldmljZSk7CgoJaWYgKG1vZGVtLT5zeXNhdHRyICE9IE5VTEwpCgkJc3lzYXR0ciA9IHVk
ZXZfZGV2aWNlX2dldF9zeXNhdHRyX3ZhbHVlKGRldmljZSwgbW9kZW0tPnN5c2F0dHIpOwoJZWxz
ZQoJCXN5c2F0dHIgPSBOVUxMOwoKCURCRygiJXMiLCBzeXNwYXRoKTsKCURCRygiJXMiLCBkZXZw
YXRoKTsKCURCRygiJXMgKCVzKSAlcyBbJXNdID09PiAlcyAlcyIsIGRldm5vZGUsIGRyaXZlciwK
CQkJCQlpbnRlcmZhY2UsIG51bWJlciwgbGFiZWwsIHN5c2F0dHIpOwoKCWluZm8gPSBnX3RyeV9u
ZXcwKHN0cnVjdCBkZXZpY2VfaW5mbywgMSk7CglpZiAoaW5mbyA9PSBOVUxMKQoJCXJldHVybjsK
CglpbmZvLT5kZXZwYXRoID0gZ19zdHJkdXAoZGV2cGF0aCk7CglpbmZvLT5kZXZub2RlID0gZ19z
dHJkdXAoZGV2bm9kZSk7CglpbmZvLT5pbnRlcmZhY2UgPSBnX3N0cmR1cChpbnRlcmZhY2UpOwoJ
aW5mby0+bnVtYmVyID0gZ19zdHJkdXAobnVtYmVyKTsKCWluZm8tPmxhYmVsID0gZ19zdHJkdXAo
bGFiZWwpOwoJaW5mby0+c3lzYXR0ciA9IGdfc3RyZHVwKHN5c2F0dHIpOwoJaW5mby0+c3Vic3lz
dGVtID0gZ19zdHJkdXAoc3Vic3lzdGVtKTsKCgltb2RlbS0+ZGV2aWNlcyA9IGdfc2xpc3RfaW5z
ZXJ0X3NvcnRlZChtb2RlbS0+ZGV2aWNlcywgaW5mbywKCQkJCQkJCWNvbXBhcmVfZGV2aWNlKTsK
fQoKc3RhdGljIHN0cnVjdCB7Cgljb25zdCBjaGFyICpkcml2ZXI7Cgljb25zdCBjaGFyICpkcnY7
Cgljb25zdCBjaGFyICp2aWQ7Cgljb25zdCBjaGFyICpwaWQ7Cn0gdmVuZG9yX2xpc3RbXSA9IHsK
CXsgImlzaXVzYiIsCSJjZGNfcGhvbmV0IgkJCX0sCgl7ICJsaW5rdG9wIiwJImNkY19hY20iLAki
MjMwZCIJCX0sCgl7ICJpY2VyYSIsCSJjZGNfYWNtIiwJIjE5ZDIiCQl9LAoJeyAiaWNlcmEiLAki
Y2RjX2V0aGVyIiwJIjE5ZDIiCQl9LAoJeyAiaWNlcmEiLAkiY2RjX2FjbSIsCSIwNGU4IiwgIjY4
NzIiCX0sCgl7ICJpY2VyYSIsCSJjZGNfZXRoZXIiLAkiMDRlOCIsICI2ODcyIgl9LAoJeyAiaWNl
cmEiLAkiY2RjX2FjbSIsCSIwNDIxIiwgIjA2MzMiCX0sCgl7ICJpY2VyYSIsCSJjZGNfZXRoZXIi
LAkiMDQyMSIsICIwNjMzIgl9LAoJeyAibWJtIiwJImNkY19hY20iLAkiMGJkYiIJCX0sCgl7ICJt
Ym0iLAkiY2RjX2V0aGVyIiwJIjBiZGIiCQl9LAoJeyAibWJtIiwJImNkY19uY20iLAkiMGJkYiIJ
CX0sCgl7ICJtYm0iLAkiY2RjX2FjbSIsCSIwZmNlIgkJfSwKCXsgIm1ibSIsCSJjZGNfZXRoZXIi
LAkiMGZjZSIJCX0sCgl7ICJtYm0iLAkiY2RjX25jbSIsCSIwZmNlIgkJfSwKCXsgIm1ibSIsCSJj
ZGNfYWNtIiwJIjQxM2MiCQl9LAoJeyAibWJtIiwJImNkY19ldGhlciIsCSI0MTNjIgkJfSwKCXsg
Im1ibSIsCSJjZGNfbmNtIiwJIjQxM2MiCQl9LAoJeyAibWJpbSIsCSJjZGNfbWJpbSIJCQl9LAoJ
eyAibWJtIiwJImNkY19hY20iLAkiMDNmMCIJCX0sCgl7ICJtYm0iLAkiY2RjX2V0aGVyIiwJIjAz
ZjAiCQl9LAoJeyAibWJtIiwJImNkY19uY20iLAkiMDNmMCIJCX0sCgl7ICJtYm0iLAkiY2RjX2Fj
bSIsCSIwOTMwIgkJfSwKCXsgIm1ibSIsCSJjZGNfZXRoZXIiLAkiMDkzMCIJCX0sCgl7ICJtYm0i
LAkiY2RjX25jbSIsCSIwOTMwIgkJfSwKCXsgImhzbyIsCSJoc28iCQkJCX0sCgl7ICJnb2JpIiwJ
InFtaV93d2FuIgkJCX0sCgl7ICJnb2JpIiwJInFjc2VyaWFsIgkJCX0sCgl7ICJzaWVycmEiLAki
cW1pX3d3YW4iLAkiMTE5OSIJCX0sCgl7ICJzaWVycmEiLAkicWNzZXJpYWwiLAkiMTE5OSIJCX0s
Cgl7ICJzaWVycmEiLAkic2llcnJhIgkJCX0sCgl7ICJzaWVycmEiLAkic2llcnJhX25ldCIJCQl9
LAoJeyAib3B0aW9uIiwJIm9wdGlvbiIsCSIwYWYwIgkJfSwKCXsgImh1YXdlaSIsCSJvcHRpb24i
LAkiMjAxZSIJCX0sCgl7ICJodWF3ZWkiLAkiY2RjX3dkbSIsCSIxMmQxIgkJfSwKCXsgImh1YXdl
aSIsCSJjZGNfZXRoZXIiLAkiMTJkMSIJCX0sCgl7ICJodWF3ZWkiLAkicW1pX3d3YW4iLAkiMTJk
MSIJCX0sCgl7ICJodWF3ZWkiLAkib3B0aW9uIiwJIjEyZDEiCQl9LAoJeyAic3BlZWR1cGNkbWEi
LCJvcHRpb24iLAkiMWM5ZSIsICI5ZTAwIgl9LAoJeyAic3BlZWR1cCIsCSJvcHRpb24iLAkiMWM5
ZSIJCX0sCgl7ICJzcGVlZHVwIiwJIm9wdGlvbiIsCSIyMDIwIgkJfSwKCXsgImFsY2F0ZWwiLAki
b3B0aW9uIiwJIjFiYmIiLCAiMDAxNyIJfSwKCXsgIm5vdmF0ZWwiLAkib3B0aW9uIiwJIjE0MTAi
CQl9LAoJeyAienRlIiwJIm9wdGlvbiIsCSIxOWQyIgkJfSwKCXsgInNpbWNvbSIsCSJvcHRpb24i
LAkiMDVjNiIsICI5MDAwIgl9LAoJeyAic2ltNzEwMCIsCSJvcHRpb24iLAkiMWUwZSIsICI5MDAx
Igl9LAoJeyAidGVsaXQiLAkidXNic2VyaWFsIiwJIjFiYzciCQl9LAoJeyAidGVsaXQiLAkib3B0
aW9uIiwJIjFiYzciCQl9LAoJeyAidGVsaXQiLAkiY2RjX2FjbSIsCSIxYmM3IiwgIjAwMjEiCX0s
Cgl7ICJ0ZWxpdHFtaSIsCSJxbWlfd3dhbiIsCSIxYmM3IiwgIjEyMDEiCX0sCgl7ICJ0ZWxpdHFt
aSIsCSJvcHRpb24iLAkiMWJjNyIsICIxMjAxIgl9LAoJeyAibm9raWEiLAkib3B0aW9uIiwJIjA0
MjEiLCAiMDYwZSIJfSwKCXsgIm5va2lhIiwJIm9wdGlvbiIsCSIwNDIxIiwgIjA2MjMiCX0sCgl7
ICJzYW1zdW5nIiwJIm9wdGlvbiIsCSIwNGU4IiwgIjY4ODkiCX0sCgl7ICJzYW1zdW5nIiwJImth
bG1pYSIJCQl9LAoJeyAicXVlY3RlbCIsCSJvcHRpb24iLAkiMDVjNiIsICI5MDkwIgl9LAoJeyAi
cXVlY3RlbHFtaSIsCSJxbWlfd3dhbiIsCSIyYzdjIiwgIjAxMjEiCX0sCgl7ICJxdWVjdGVscW1p
IiwJInFjc2VyaWFsIiwJIjJjN2MiLCAiMDEyMSIJfSwKCXsgInF1ZWN0ZWxxbWkiLAkicW1pX3d3
YW4iLAkiMmM3YyIsICIwMTI1Igl9LAoJeyAicXVlY3RlbHFtaSIsCSJxY3NlcmlhbCIsCSIyYzdj
IiwgIjAxMjUiCX0sCgl7ICJ1YmxveCIsCSJjZGNfYWNtIiwJIjE1NDYiLCAiMTEwMiIJfSwKCXsg
InVibG94IiwJImNkY19hY20iLAkiMTU0NiIsICIxMTA3Igl9LAoJeyAidWJsb3giLAkicm5kaXNf
aG9zdCIsCSIxNTQ2IiwgIjExNDYiCX0sCgl7ICJ1YmxveCIsCSJjZGNfYWNtIiwJIjE1NDYiLCAi
MTE0NiIJfSwKCXsgImdlbWFsdG8iLAkib3B0aW9uIiwJIjFlMmQiLAkiMDA1MyIJfSwKCXsgImdl
bWFsdG8iLAkiY2RjX3dkbSIsCSIxZTJkIiwJIjAwNTMiCX0sCgl7ICJnZW1hbHRvIiwJInFtaV93
d2FuIiwJIjFlMmQiLAkiMDA1MyIJfSwKCXsgImdlbWFsdG8iLAkiY2RjX2FjbSIsCSIxZTJkIiwJ
IjAwNjEiCX0sCgl7ICJnZW1hbHRvIiwJImNkY19ldGhlciIsCSIxZTJkIiwJIjAwNjEiCX0sCgl7
ICJ0ZWxpdCIsCSJjZGNfbmNtIiwJIjFiYzciLCAiMDAzNiIJfSwKCXsgInRlbGl0IiwJImNkY19h
Y20iLAkiMWJjNyIsICIwMDM2Igl9LAoJeyAieG1tN3h4eCIsCSJjZGNfYWNtIiwJIjgwODciCQl9
LAoJeyAieG1tN3h4eCIsCSJjZGNfbmNtIiwJIjgwODciCQl9LAoJeyB9Cn07CgpzdGF0aWMgdm9p
ZCBjaGVja191c2JfZGV2aWNlKHN0cnVjdCB1ZGV2X2RldmljZSAqZGV2aWNlKQp7CglzdHJ1Y3Qg
dWRldl9kZXZpY2UgKnVzYl9kZXZpY2U7Cgljb25zdCBjaGFyICpzeXNwYXRoLCAqZGV2bmFtZSwg
KmRyaXZlcjsKCWNvbnN0IGNoYXIgKnZlbmRvciA9IE5VTEwsICptb2RlbCA9IE5VTEw7CgoJdXNi
X2RldmljZSA9IHVkZXZfZGV2aWNlX2dldF9wYXJlbnRfd2l0aF9zdWJzeXN0ZW1fZGV2dHlwZShk
ZXZpY2UsCgkJCQkJCQkidXNiIiwgInVzYl9kZXZpY2UiKTsKCWlmICh1c2JfZGV2aWNlID09IE5V
TEwpCgkJcmV0dXJuOwoKCXN5c3BhdGggPSB1ZGV2X2RldmljZV9nZXRfc3lzcGF0aCh1c2JfZGV2
aWNlKTsKCWlmIChzeXNwYXRoID09IE5VTEwpCgkJcmV0dXJuOwoKCWRldm5hbWUgPSB1ZGV2X2Rl
dmljZV9nZXRfZGV2bm9kZSh1c2JfZGV2aWNlKTsKCWlmIChkZXZuYW1lID09IE5VTEwpCgkJcmV0
dXJuOwoKCXZlbmRvciA9IHVkZXZfZGV2aWNlX2dldF9wcm9wZXJ0eV92YWx1ZSh1c2JfZGV2aWNl
LCAiSURfVkVORE9SX0lEIik7Cgltb2RlbCA9IHVkZXZfZGV2aWNlX2dldF9wcm9wZXJ0eV92YWx1
ZSh1c2JfZGV2aWNlLCAiSURfTU9ERUxfSUQiKTsKCglkcml2ZXIgPSB1ZGV2X2RldmljZV9nZXRf
cHJvcGVydHlfdmFsdWUodXNiX2RldmljZSwgIk9GT05PX0RSSVZFUiIpOwoJaWYgKCFkcml2ZXIp
IHsKCQlzdHJ1Y3QgdWRldl9kZXZpY2UgKnVzYl9pbnRlcmZhY2UgPQoJCQl1ZGV2X2RldmljZV9n
ZXRfcGFyZW50X3dpdGhfc3Vic3lzdGVtX2RldnR5cGUoCgkJCQlkZXZpY2UsICJ1c2IiLCAidXNi
X2ludGVyZmFjZSIpOwoKCQlpZiAodXNiX2ludGVyZmFjZSkKCQkJZHJpdmVyID0gdWRldl9kZXZp
Y2VfZ2V0X3Byb3BlcnR5X3ZhbHVlKAoJCQkJCXVzYl9pbnRlcmZhY2UsICJPRk9OT19EUklWRVIi
KTsKCX0KCglpZiAoZHJpdmVyID09IE5VTEwpIHsKCQljb25zdCBjaGFyICpkcnY7CgkJdW5zaWdu
ZWQgaW50IGk7CgoJCWRydiA9IHVkZXZfZGV2aWNlX2dldF9wcm9wZXJ0eV92YWx1ZShkZXZpY2Us
ICJJRF9VU0JfRFJJVkVSIik7CgkJaWYgKGRydiA9PSBOVUxMKSB7CgkJCWRydiA9IHVkZXZfZGV2
aWNlX2dldF9kcml2ZXIoZGV2aWNlKTsKCQkJaWYgKGRydiA9PSBOVUxMKSB7CgkJCQlzdHJ1Y3Qg
dWRldl9kZXZpY2UgKnBhcmVudDsKCgkJCQlwYXJlbnQgPSB1ZGV2X2RldmljZV9nZXRfcGFyZW50
KGRldmljZSk7CgkJCQlpZiAocGFyZW50ID09IE5VTEwpCgkJCQkJcmV0dXJuOwoKCQkJCWRydiA9
IHVkZXZfZGV2aWNlX2dldF9kcml2ZXIocGFyZW50KTsKCQkJCWlmIChkcnYgPT0gTlVMTCkKCQkJ
CQlyZXR1cm47CgkJCX0KCQl9CgoKCQlEQkcoIiVzIFslczolc10iLCBkcnYsIHZlbmRvciwgbW9k
ZWwpOwoKCQlpZiAodmVuZG9yID09IE5VTEwgfHwgbW9kZWwgPT0gTlVMTCkKCQkJcmV0dXJuOwoK
CQlmb3IgKGkgPSAwOyB2ZW5kb3JfbGlzdFtpXS5kcml2ZXI7IGkrKykgewoJCQlpZiAoZ19zdHJf
ZXF1YWwodmVuZG9yX2xpc3RbaV0uZHJ2LCBkcnYpID09IEZBTFNFKQoJCQkJY29udGludWU7CgoJ
CQlpZiAodmVuZG9yX2xpc3RbaV0udmlkKSB7CgkJCQlpZiAoIWdfc3RyX2VxdWFsKHZlbmRvcl9s
aXN0W2ldLnZpZCwgdmVuZG9yKSkKCQkJCQljb250aW51ZTsKCQkJfQoKCQkJaWYgKHZlbmRvcl9s
aXN0W2ldLnBpZCkgewoJCQkJaWYgKCFnX3N0cl9lcXVhbCh2ZW5kb3JfbGlzdFtpXS5waWQsIG1v
ZGVsKSkKCQkJCQljb250aW51ZTsKCQkJfQoKCQkJZHJpdmVyID0gdmVuZG9yX2xpc3RbaV0uZHJp
dmVyOwoJCX0KCgkJaWYgKGRyaXZlciA9PSBOVUxMKQoJCQlyZXR1cm47Cgl9CgoJYWRkX2Rldmlj
ZShzeXNwYXRoLCBkZXZuYW1lLCBkcml2ZXIsIHZlbmRvciwgbW9kZWwsIGRldmljZSk7Cn0KCnN0
YXRpYyB2b2lkIGNoZWNrX2RldmljZShzdHJ1Y3QgdWRldl9kZXZpY2UgKmRldmljZSkKewoJY29u
c3QgY2hhciAqYnVzOwoKCWJ1cyA9IHVkZXZfZGV2aWNlX2dldF9wcm9wZXJ0eV92YWx1ZShkZXZp
Y2UsICJJRF9CVVMiKTsKCWlmIChidXMgPT0gTlVMTCkgewoJCWJ1cyA9IHVkZXZfZGV2aWNlX2dl
dF9zdWJzeXN0ZW0oZGV2aWNlKTsKCQlpZiAoYnVzID09IE5VTEwpCgkJCXJldHVybjsKCX0KCglp
ZiAoKGdfc3RyX2VxdWFsKGJ1cywgInVzYiIpID09IFRSVUUpIHx8CgkJCShnX3N0cl9lcXVhbChi
dXMsICJ1c2JtaXNjIikgPT0gVFJVRSkpCgkJY2hlY2tfdXNiX2RldmljZShkZXZpY2UpOwoJZWxz
ZQoJCWFkZF9zZXJpYWxfZGV2aWNlKGRldmljZSk7Cgp9CgpzdGF0aWMgZ2Jvb2xlYW4gY3JlYXRl
X21vZGVtKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsIGdwb2ludGVyIHVzZXJfZGF0YSkK
ewoJc3RydWN0IG1vZGVtX2luZm8gKm1vZGVtID0gdmFsdWU7Cgljb25zdCBjaGFyICpzeXNwYXRo
ID0ga2V5OwoJdW5zaWduZWQgaW50IGk7CgoJaWYgKG1vZGVtLT5tb2RlbSAhPSBOVUxMKQoJCXJl
dHVybiBGQUxTRTsKCglEQkcoIiVzIiwgc3lzcGF0aCk7CgoJaWYgKG1vZGVtLT5kZXZpY2VzID09
IE5VTEwpCgkJcmV0dXJuIFRSVUU7CgoJREJHKCJkcml2ZXI9JXMiLCBtb2RlbS0+ZHJpdmVyKTsK
Cgltb2RlbS0+bW9kZW0gPSBvZm9ub19tb2RlbV9jcmVhdGUoTlVMTCwgbW9kZW0tPmRyaXZlcik7
CglpZiAobW9kZW0tPm1vZGVtID09IE5VTEwpCgkJcmV0dXJuIFRSVUU7CgoJZm9yIChpID0gMDsg
ZHJpdmVyX2xpc3RbaV0ubmFtZTsgaSsrKSB7CgkJaWYgKGdfc3RyX2VxdWFsKGRyaXZlcl9saXN0
W2ldLm5hbWUsIG1vZGVtLT5kcml2ZXIpID09IEZBTFNFKQoJCQljb250aW51ZTsKCgkJaWYgKGRy
aXZlcl9saXN0W2ldLnNldHVwKG1vZGVtKSA9PSBUUlVFKSB7CgkJCW9mb25vX21vZGVtX3NldF9z
dHJpbmcobW9kZW0tPm1vZGVtLCAiU3lzdGVtUGF0aCIsCgkJCQkJCQkJc3lzcGF0aCk7CgkJCWlm
IChvZm9ub19tb2RlbV9yZWdpc3Rlcihtb2RlbS0+bW9kZW0pIDwgMCkgewoJCQkJREJHKCJjb3Vs
ZCBub3QgcmVnaXN0ZXIgbW9kZW0gJyVzJyIsIG1vZGVtLT5kcml2ZXIpOwoJCQkJcmV0dXJuIFRS
VUU7CgkJCX0KCgkJCXJldHVybiBGQUxTRTsKCQl9Cgl9CgoJcmV0dXJuIFRSVUU7Cn0KCnN0YXRp
YyB2b2lkIGVudW1lcmF0ZV9kZXZpY2VzKHN0cnVjdCB1ZGV2ICpjb250ZXh0KQp7CglzdHJ1Y3Qg
dWRldl9lbnVtZXJhdGUgKmVudW1lcmF0ZTsKCXN0cnVjdCB1ZGV2X2xpc3RfZW50cnkgKmVudHJ5
OwoKCURCRygiIik7CgoJZW51bWVyYXRlID0gdWRldl9lbnVtZXJhdGVfbmV3KGNvbnRleHQpOwoJ
aWYgKGVudW1lcmF0ZSA9PSBOVUxMKQoJCXJldHVybjsKCgl1ZGV2X2VudW1lcmF0ZV9hZGRfbWF0
Y2hfc3Vic3lzdGVtKGVudW1lcmF0ZSwgInR0eSIpOwoJdWRldl9lbnVtZXJhdGVfYWRkX21hdGNo
X3N1YnN5c3RlbShlbnVtZXJhdGUsICJ1c2IiKTsKCXVkZXZfZW51bWVyYXRlX2FkZF9tYXRjaF9z
dWJzeXN0ZW0oZW51bWVyYXRlLCAidXNibWlzYyIpOwoJdWRldl9lbnVtZXJhdGVfYWRkX21hdGNo
X3N1YnN5c3RlbShlbnVtZXJhdGUsICJuZXQiKTsKCXVkZXZfZW51bWVyYXRlX2FkZF9tYXRjaF9z
dWJzeXN0ZW0oZW51bWVyYXRlLCAiaHNpIik7CgoJdWRldl9lbnVtZXJhdGVfc2Nhbl9kZXZpY2Vz
KGVudW1lcmF0ZSk7CgoJZW50cnkgPSB1ZGV2X2VudW1lcmF0ZV9nZXRfbGlzdF9lbnRyeShlbnVt
ZXJhdGUpOwoJd2hpbGUgKGVudHJ5KSB7CgkJY29uc3QgY2hhciAqc3lzcGF0aCA9IHVkZXZfbGlz
dF9lbnRyeV9nZXRfbmFtZShlbnRyeSk7CgkJc3RydWN0IHVkZXZfZGV2aWNlICpkZXZpY2U7CgoJ
CWRldmljZSA9IHVkZXZfZGV2aWNlX25ld19mcm9tX3N5c3BhdGgoY29udGV4dCwgc3lzcGF0aCk7
CgkJaWYgKGRldmljZSAhPSBOVUxMKSB7CgkJCWNoZWNrX2RldmljZShkZXZpY2UpOwoJCQl1ZGV2
X2RldmljZV91bnJlZihkZXZpY2UpOwoJCX0KCgkJZW50cnkgPSB1ZGV2X2xpc3RfZW50cnlfZ2V0
X25leHQoZW50cnkpOwoJfQoKCXVkZXZfZW51bWVyYXRlX3VucmVmKGVudW1lcmF0ZSk7CgoJZ19o
YXNoX3RhYmxlX2ZvcmVhY2hfcmVtb3ZlKG1vZGVtX2xpc3QsIGNyZWF0ZV9tb2RlbSwgTlVMTCk7
Cn0KCnN0YXRpYyBzdHJ1Y3QgdWRldiAqdWRldl9jdHg7CnN0YXRpYyBzdHJ1Y3QgdWRldl9tb25p
dG9yICp1ZGV2X21vbjsKc3RhdGljIGd1aW50IHVkZXZfd2F0Y2ggPSAwOwpzdGF0aWMgZ3VpbnQg
dWRldl9kZWxheSA9IDA7CgpzdGF0aWMgZ2Jvb2xlYW4gY2hlY2tfbW9kZW1fbGlzdChncG9pbnRl
ciB1c2VyX2RhdGEpCnsKCXVkZXZfZGVsYXkgPSAwOwoKCURCRygiIik7CgoJZ19oYXNoX3RhYmxl
X2ZvcmVhY2hfcmVtb3ZlKG1vZGVtX2xpc3QsIGNyZWF0ZV9tb2RlbSwgTlVMTCk7CgoJcmV0dXJu
IEZBTFNFOwp9CgpzdGF0aWMgZ2Jvb2xlYW4gdWRldl9ldmVudChHSU9DaGFubmVsICpjaGFubmVs
LCBHSU9Db25kaXRpb24gY29uZCwKCQkJCQkJCWdwb2ludGVyIHVzZXJfZGF0YSkKewoJc3RydWN0
IHVkZXZfZGV2aWNlICpkZXZpY2U7Cgljb25zdCBjaGFyICphY3Rpb247CgoJaWYgKGNvbmQgJiAo
R19JT19FUlIgfCBHX0lPX0hVUCB8IEdfSU9fTlZBTCkpIHsKCQlvZm9ub193YXJuKCJFcnJvciB3
aXRoIHVkZXYgbW9uaXRvciBjaGFubmVsIik7CgkJdWRldl93YXRjaCA9IDA7CgkJcmV0dXJuIEZB
TFNFOwoJfQoKCWRldmljZSA9IHVkZXZfbW9uaXRvcl9yZWNlaXZlX2RldmljZSh1ZGV2X21vbik7
CglpZiAoZGV2aWNlID09IE5VTEwpCgkJcmV0dXJuIFRSVUU7CgoJYWN0aW9uID0gdWRldl9kZXZp
Y2VfZ2V0X2FjdGlvbihkZXZpY2UpOwoJaWYgKGFjdGlvbiA9PSBOVUxMKQoJCXJldHVybiBUUlVF
OwoKCWlmIChnX3N0cl9lcXVhbChhY3Rpb24sICJhZGQiKSA9PSBUUlVFKSB7CgkJaWYgKHVkZXZf
ZGVsYXkgPiAwKQoJCQlnX3NvdXJjZV9yZW1vdmUodWRldl9kZWxheSk7CgoJCWNoZWNrX2Rldmlj
ZShkZXZpY2UpOwoKCQl1ZGV2X2RlbGF5ID0gZ190aW1lb3V0X2FkZF9zZWNvbmRzKDEsIGNoZWNr
X21vZGVtX2xpc3QsIE5VTEwpOwoJfSBlbHNlIGlmIChnX3N0cl9lcXVhbChhY3Rpb24sICJyZW1v
dmUiKSA9PSBUUlVFKQoJCXJlbW92ZV9kZXZpY2UoZGV2aWNlKTsKCgl1ZGV2X2RldmljZV91bnJl
ZihkZXZpY2UpOwoKCXJldHVybiBUUlVFOwp9CgpzdGF0aWMgdm9pZCB1ZGV2X3N0YXJ0KHZvaWQp
CnsKCUdJT0NoYW5uZWwgKmNoYW5uZWw7CglpbnQgZmQ7CgoJREJHKCIiKTsKCglpZiAodWRldl9t
b25pdG9yX2VuYWJsZV9yZWNlaXZpbmcodWRldl9tb24pIDwgMCkgewoJCW9mb25vX2Vycm9yKCJG
YWlsZWQgdG8gZW5hYmxlIHVkZXYgbW9uaXRvciIpOwoJCXJldHVybjsKCX0KCgllbnVtZXJhdGVf
ZGV2aWNlcyh1ZGV2X2N0eCk7CgoJZmQgPSB1ZGV2X21vbml0b3JfZ2V0X2ZkKHVkZXZfbW9uKTsK
CgljaGFubmVsID0gZ19pb19jaGFubmVsX3VuaXhfbmV3KGZkKTsKCWlmIChjaGFubmVsID09IE5V
TEwpCgkJcmV0dXJuOwoKCXVkZXZfd2F0Y2ggPSBnX2lvX2FkZF93YXRjaChjaGFubmVsLAoJCQkJ
R19JT19JTiB8IEdfSU9fRVJSIHwgR19JT19IVVAgfCBHX0lPX05WQUwsCgkJCQkJCQl1ZGV2X2V2
ZW50LCBOVUxMKTsKCglnX2lvX2NoYW5uZWxfdW5yZWYoY2hhbm5lbCk7Cn0KCnN0YXRpYyBpbnQg
ZGV0ZWN0X2luaXQodm9pZCkKewoJdWRldl9jdHggPSB1ZGV2X25ldygpOwoJaWYgKHVkZXZfY3R4
ID09IE5VTEwpIHsKCQlvZm9ub19lcnJvcigiRmFpbGVkIHRvIGNyZWF0ZSB1ZGV2IGNvbnRleHQi
KTsKCQlyZXR1cm4gLUVJTzsKCX0KCgl1ZGV2X21vbiA9IHVkZXZfbW9uaXRvcl9uZXdfZnJvbV9u
ZXRsaW5rKHVkZXZfY3R4LCAidWRldiIpOwoJaWYgKHVkZXZfbW9uID09IE5VTEwpIHsKCQlvZm9u
b19lcnJvcigiRmFpbGVkIHRvIGNyZWF0ZSB1ZGV2IG1vbml0b3IiKTsKCQl1ZGV2X3VucmVmKHVk
ZXZfY3R4KTsKCQl1ZGV2X2N0eCA9IE5VTEw7CgkJcmV0dXJuIC1FSU87Cgl9CgoJbW9kZW1fbGlz
dCA9IGdfaGFzaF90YWJsZV9uZXdfZnVsbChnX3N0cl9oYXNoLCBnX3N0cl9lcXVhbCwKCQkJCQkJ
TlVMTCwgZGVzdHJveV9tb2RlbSk7CgoJdWRldl9tb25pdG9yX2ZpbHRlcl9hZGRfbWF0Y2hfc3Vi
c3lzdGVtX2RldnR5cGUodWRldl9tb24sICJ0dHkiLCBOVUxMKTsKCXVkZXZfbW9uaXRvcl9maWx0
ZXJfYWRkX21hdGNoX3N1YnN5c3RlbV9kZXZ0eXBlKHVkZXZfbW9uLCAidXNiIiwgTlVMTCk7Cgl1
ZGV2X21vbml0b3JfZmlsdGVyX2FkZF9tYXRjaF9zdWJzeXN0ZW1fZGV2dHlwZSh1ZGV2X21vbiwK
CQkJCQkJCSJ1c2JtaXNjIiwgTlVMTCk7Cgl1ZGV2X21vbml0b3JfZmlsdGVyX2FkZF9tYXRjaF9z
dWJzeXN0ZW1fZGV2dHlwZSh1ZGV2X21vbiwgIm5ldCIsIE5VTEwpOwoJdWRldl9tb25pdG9yX2Zp
bHRlcl9hZGRfbWF0Y2hfc3Vic3lzdGVtX2RldnR5cGUodWRldl9tb24sICJoc2kiLCBOVUxMKTsK
Cgl1ZGV2X21vbml0b3JfZmlsdGVyX3VwZGF0ZSh1ZGV2X21vbik7CgoJdWRldl9zdGFydCgpOwoK
CXJldHVybiAwOwp9CgpzdGF0aWMgdm9pZCBkZXRlY3RfZXhpdCh2b2lkKQp7CglpZiAodWRldl9k
ZWxheSA+IDApCgkJZ19zb3VyY2VfcmVtb3ZlKHVkZXZfZGVsYXkpOwoKCWlmICh1ZGV2X3dhdGNo
ID4gMCkKCQlnX3NvdXJjZV9yZW1vdmUodWRldl93YXRjaCk7CgoJaWYgKHVkZXZfY3R4ID09IE5V
TEwpCgkJcmV0dXJuOwoKCXVkZXZfbW9uaXRvcl9maWx0ZXJfcmVtb3ZlKHVkZXZfbW9uKTsKCgln
X2hhc2hfdGFibGVfZGVzdHJveShtb2RlbV9saXN0KTsKCgl1ZGV2X21vbml0b3JfdW5yZWYodWRl
dl9tb24pOwoJdWRldl91bnJlZih1ZGV2X2N0eCk7Cn0KCk9GT05PX1BMVUdJTl9ERUZJTkUodWRl
dm5nLCAidWRldiBoYXJkd2FyZSBkZXRlY3Rpb24iLCBWRVJTSU9OLAoJCU9GT05PX1BMVUdJTl9Q
UklPUklUWV9ERUZBVUxULCBkZXRlY3RfaW5pdCwgZGV0ZWN0X2V4aXQpCg==

--===============6759250650827498843==--

