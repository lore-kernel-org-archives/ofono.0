Content-Type: multipart/mixed; boundary="===============0411113576571534761=="
MIME-Version: 1.0
From: Frank Vasquez <frankv@helium.com>
Subject: Re: ublox TOBY-R200
Date: Thu, 13 Sep 2018 13:51:22 -0700
Message-ID: <CAFJydPWY9GRgW-=HFprZWj7m3JUCxO_WtVAH-WhSzz2BWxHPnw@mail.gmail.com>
In-Reply-To: <CAFJydPW3jJaJnU6zM=qJyQ60NqvzNvRC3HSgVL6DAWjqOyKcoQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0411113576571534761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giancito,

I modified ublox.c as follows.

enum supported_models {
        SARA_G270                       =3D 1102,
        TOBYL2_COMPATIBLE_MODE          =3D 1141,
        TOBYL2_MEDIUM_THROUGHPUT_MODE   =3D 1143,
        TOBYL2_HIGH_THROUGHPUT_MODE     =3D 1107,  /* was 1146 */
};

And still no luck.

# ./list-modems
#

I see no evidence that oFono's ublox driver is being loaded even though I
added the following line to 60-serial-rules in
/etc/udev/rules.d/60-serial-rules.

KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"ublox"

I want TOBYL2_HIGH_THROUGHPUT_MODE because that's the mode that uses LTE.

Cheers,
Frank


On Thu, Sep 13, 2018 at 12:18 PM Frank Vasquez <frankv@helium.com> wrote:

> Hi Giacinto,
>
> The TOBY-R200 is an LTE module.  I see that the ublox oFono plugin
> supports LTE on the TOBY-L2 so maybe it will work on the TOBY-R200 as
> well.  I think many of the AT commands are the same across ublox cellular
> modems so yes let's give testing a shot.
>
> I am using Buildroot to build oFono for my Linux device.
>
>
> #########################################################################=
#######
> #
> # ofono
> #
>
> #########################################################################=
#######
>
> OFONO_VERSION =3D 1.21
> OFONO_SOURCE =3D ofono-$(OFONO_VERSION).tar.xz
> OFONO_SITE =3D $(BR2_KERNEL_MIRROR)/linux/network/ofono
> OFONO_LICENSE =3D GPL-2.0
> OFONO_LICENSE_FILES =3D COPYING
> OFONO_DEPENDENCIES =3D \
> host-pkgconf \
> dbus \
> libglib2 \
> libcap-ng \
> mobile-broadband-provider-info
>
> OFONO_CONF_OPTS =3D \
> --disable-test \
> --with-dbusconfdir=3D/etc \
> $(if $(BR2_INIT_SYSTEMD),--with-systemdunitdir=3D/usr/lib/systemd/system)
>
> # N.B. Qualcomm QMI modem support requires O_CLOEXEC; so
> # make sure that it is defined.
> OFONO_CONF_ENV +=3D CFLAGS=3D"$(TARGET_CFLAGS) -D_GNU_SOURCE"
>
> define OFONO_INSTALL_INIT_SYSV
> $(INSTALL) -m 0755 -D package/ofono/S46ofono
> $(TARGET_DIR)/etc/init.d/S46ofono
> endef
>
> define OFONO_INSTALL_INIT_SYSTEMD
> mkdir -p $(TARGET_DIR)/etc/systemd/systemd/multi-user.target.wants
> ln -fs ../../../../usr/lib/systemd/system/ofono.service \
> $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
> endef
>
> ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
> OFONO_CONF_OPTS +=3D --enable-udev
> OFONO_DEPENDENCIES +=3D udev
> else
> OFONO_CONF_OPTS +=3D --disable-udev
> endif
>
> ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
> OFONO_CONF_OPTS +=3D --enable-bluetooth
> OFONO_DEPENDENCIES +=3D bluez_utils
> else
> OFONO_CONF_OPTS +=3D --disable-bluetooth
> endif
>
> $(eval $(autotools-package))
>
> I can modify the downloaded oFono source code (plugins and drivers
> directories) and rebuild it as needed to test the TOBY-R200.
>
> $ ls -l output/build/ofono-1.21
> total 2528
> -rw-r--r--  1 frank frank    835 Oct  5  2017 acinclude.m4
> -rw-r--r--  1 frank frank 360491 Oct  5  2017 aclocal.m4
> -rw-r--r--  1 frank frank   5356 Oct  5  2017 AUTHORS
> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 btio
> -rw-r--r--  1 frank frank  30811 Oct  5  2017 ChangeLog
> -rwxr-xr-x  1 frank frank   7333 Oct  5  2017 compile
> -rwxr-xr-x  1 frank frank  43765 Sep 13 11:39 config.guess
> -rw-r--r--  1 frank frank   2775 Sep 13 11:39 config.h
> -rw-r--r--  1 frank frank   2492 Oct  5  2017 config.h.in
> -rw-r--r--  1 frank frank  42877 Sep 13 11:39 config.log
> -rwxr-xr-x  1 frank frank  67571 Sep 13 11:39 config.status
> -rwxr-xr-x  1 frank frank  36171 Sep 13 11:39 config.sub
> -rwxr-xr-x  1 frank frank 467689 Oct  5  2017 configure
> -rw-r--r--  1 frank frank   8223 Oct  5  2017 configure.ac
> -rw-r--r--  1 frank frank  18011 Jul 10  2009 COPYING
> -rwxr-xr-x  1 frank frank  23566 Oct  5  2017 depcomp
> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 doc
> drwxr-xr-x 25 frank frank   4096 Oct  5  2017 drivers
> drwxr-xr-x  2 frank frank   4096 Sep 13 11:39 dundee
> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 examples
> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gatchat
> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gdbus
> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gisi
> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gril
> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 include
> -rw-r--r--  1 frank frank   9478 Jul 10  2009 INSTALL
> -rwxr-xr-x  1 frank frank  14431 Oct  5  2017 install-sh
> -rwxr-xr-x  1 frank frank 294282 Sep 13 11:39 libtool
> -rw-r--r--  1 frank frank 283940 Sep 13 11:39 ltmain.sh
> -rw-r--r--  1 frank frank 283672 Oct  5  2017 ltmain.sh.orig
> -rw-r--r--  1 frank frank 185608 Sep 13 11:39 Makefile
> -rw-r--r--  1 frank frank  28755 Oct  5  2017 Makefile.am
> -rw-r--r--  1 frank frank 204311 Oct  5  2017 Makefile.in
> -rwxr-xr-x  1 frank frank   6872 Oct  5  2017 missing
> -rw-r--r--  1 frank frank      0 Jul 10  2009 NEWS
> -rw-r--r--  1 frank frank    310 Sep 13 11:39 ofono.pc
> -rw-r--r--  1 frank frank    325 Feb  6  2011 ofono.pc.in
> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 plugins
> -rw-r--r--  1 frank frank    886 Jul 19  2012 README
> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 src
> -rw-r--r--  1 frank frank     23 Sep 13 11:39 stamp-h1
> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 test
> -rwxr-xr-x  1 frank frank   4287 Sep 13  2015 test-driver
> -rw-r--r--  1 frank frank  17996 May  3  2016 TODO
> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 tools
> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 unit
>
> Cheers,
> Frank
>
>
>
> On Thu, Sep 13, 2018 at 11:48 AM Giacinto Cifelli <gciofono@gmail.com>
> wrote:
>
>> hi Frank,
>>
>> your modem doesn't seem to be supported.
>> There are these models:
>> SARA_G270 =3D 1102,
>> TOBYL2_COMPATIBLE_MODE =3D 1141,
>> TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
>> TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
>> If your model is compatible with any of them, I can add  the 1107 for you
>> for a test.
>>
>> from the PID, I would say it should be intermediate between the SARA_G260
>> and the TOBYL2_COMPATIBLE_MODE.
>> Most likely it will work this latter, but maybe not all features...
>>
>> Are you willing to test?
>>
>> Best regards,
>> Giacinto
>>
>>
>>
>> On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com> wrot=
e:
>>
>>> Hi Giacinto,
>>>
>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>
>>> The usbutils version of lsusb is somewhat better.
>>>
>>> # lsusb
>>> Bus 002 Device 001: ID 1d6b:0003
>>> Bus 001 Device 002: ID 1546:1107
>>> Bus 001 Device 001: ID 1d6b:0002
>>> # lsusb -t
>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
>>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>>>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>>>
>>> And here is a relevant excerpt from lsusb -v.
>>>
>>> Bus 001 Device 002: ID 1546:1107
>>> Device Descriptor:
>>>   bLength                18
>>>   bDescriptorType         1
>>>   bcdUSB               2.00
>>>   bDeviceClass          239
>>>   bDeviceSubClass         2
>>>   bDeviceProtocol         1
>>>   bMaxPacketSize0        64
>>>   idVendor           0x1546
>>>   idProduct          0x1107
>>>   bcdDevice           17.29
>>>   iManufacturer           1 u-blox
>>>   iProduct                2 u-blox Cellular Module
>>>   iSerial                 3 352848080392646
>>>   bNumConfigurations      1
>>>   Configuration Descriptor:
>>>     bLength                 9
>>>     bDescriptorType         2
>>>     wTotalLength          405
>>>     bNumInterfaces         12
>>>     bConfigurationValue     1
>>>     iConfiguration          0
>>>     bmAttributes         0xe0
>>>       Self Powered
>>>       Remote Wakeup
>>>     MaxPower              100mA
>>>     Interface Association:
>>>       bLength                 8
>>>       bDescriptorType        11
>>>       bFirstInterface         0
>>>       bInterfaceCount         2
>>>       bFunctionClass          2
>>>       bFunctionSubClass       2
>>>       bFunctionProtocol       1
>>>       iFunction               4 CDC ACM
>>> ...
>>>
>>> Cheers,
>>> Frank
>>>
>>>
>>> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com>
>>> wrote:
>>>
>>>> Hi Giacinto,
>>>>
>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>
>>>> # lsusb -t
>>>> Bus 001 Device 001: ID 1d6b:0002
>>>> Bus 001 Device 002: ID 1546:1107
>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>
>>>> I am running BusyBox's stripped down version of lsusb that's why
>>>> information is so lacking.
>>>> I'll install usbutils on my device's Buildroot image and rerun the
>>>> commands.
>>>>
>>>> Cheers,
>>>> Frank
>>>>
>>>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.com>
>>>> wrote:
>>>>
>>>>> hi Frank,
>>>>>
>>>>> can you send the result of "lsusb" and "lsusb -t"?
>>>>>
>>>>> Giacinto
>>>>>
>>>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com> wrote:
>>>>>
>>>>>> Greetings,
>>>>>>
>>>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want to
>>>>>> use connman to manage any cellular connection on that modem since co=
nnman
>>>>>> is already managing ethernet and wifi connectivity.  oFono seems lik=
e the
>>>>>> best option.  I see that there is already a ublox plugin for oFono b=
ut I
>>>>>> don't think the TOBY-R200 is supported.  The cell module is soldered=
 onto
>>>>>> the board and appears as a USB device.
>>>>>>
>>>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2,
>>>>>> SerialNumber=3D3
>>>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>>>
>>>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>>>
>>>>>> Cheers,
>>>>>> Frank
>>>>>> _______________________________________________
>>>>>> ofono mailing list
>>>>>> ofono(a)ofono.org
>>>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>>>
>>>>>

--===============0411113576571534761==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+SGkgR2lhbmNpdG8sPGRpdj48YnI+PC9kaXY+PGRpdj5JIG1vZGlmaWVkIHVibG94LmMgYXMg
Zm9sbG93cy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+ZW51bSBzdXBwb3J0ZWRfbW9k
ZWxzIHs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFNBUkFfRzI3MMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPSAxMTAyLDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgVE9CWUwyX0NPTVBB
VElCTEVfTU9ERcKgIMKgIMKgIMKgIMKgID0gMTE0MSw8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFRP
QllMMl9NRURJVU1fVEhST1VHSFBVVF9NT0RFwqAgwqA9IDExNDMsPC9kaXY+PGRpdj7CoCDCoCDC
oCDCoCBUT0JZTDJfSElHSF9USFJPVUdIUFVUX01PREXCoCDCoCDCoD0gMTEwNyzCoCAvKiB3YXMg
MTE0NiAqLzwvZGl2PjxkaXY+fTs8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBz
dGlsbCBubyBsdWNrLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4jIC4vbGlzdC1tb2Rl
bXPCoDwvZGl2PjxkaXY+IzwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBzZWUgbm8g
ZXZpZGVuY2UgdGhhdCBvRm9ubyYjMzk7cyB1YmxveCBkcml2ZXIgaXMgYmVpbmcgbG9hZGVkIGV2
ZW4gdGhvdWdoIEkgYWRkZWQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIDYwLXNlcmlhbC1ydWxlcyBp
biAvZXRjL3VkZXYvcnVsZXMuZC82MC1zZXJpYWwtcnVsZXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5LRVJORUw9PSZxdW90O3R0eUFDTTAmcXVvdDssIEVOVntPRk9OT19EUklWRVJ9PSZxdW90
O3VibG94JnF1b3Q7PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3YW50IFRPQllMMl9I
SUdIX1RIUk9VR0hQVVRfTU9ERSBiZWNhdXNlIHRoYXQmIzM5O3MgdGhlIG1vZGUgdGhhdCB1c2Vz
IExURS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9k
aXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAxMjox
OCBQTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20i
PmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFw
eCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPjxkaXYgZGlyPSJsdHIiPkhpIEdpYWNpbnRvLDxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlIFRP
QlktUjIwMCBpcyBhbiBMVEUgbW9kdWxlLsKgIEkgc2VlIHRoYXQgdGhlIHVibG94IG9Gb25vIHBs
dWdpbiBzdXBwb3J0cyBMVEUgb24gdGhlIFRPQlktTDIgc28gbWF5YmUgaXQgd2lsbCB3b3JrIG9u
IHRoZSBUT0JZLVIyMDAgYXMgd2VsbC7CoCBJIHRoaW5rIG1hbnkgb2YgdGhlIEFUIGNvbW1hbmRz
IGFyZSB0aGUgc2FtZSBhY3Jvc3MgdWJsb3ggY2VsbHVsYXIgbW9kZW1zIHNvIHllcyBsZXQmIzM5
O3MgZ2l2ZSB0ZXN0aW5nIGEgc2hvdC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gdXNp
bmcgQnVpbGRyb290IHRvIGJ1aWxkIG9Gb25vIGZvciBteSBMaW51eCBkZXZpY2UuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48ZGl2PiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjPC9kaXY+PGRpdj4j
PC9kaXY+PGRpdj4jIG9mb25vPC9kaXY+PGRpdj4jPC9kaXY+PGRpdj4jIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T0ZPTk9fVkVSU0lPTiA9IDEuMjE8L2Rp
dj48ZGl2Pk9GT05PX1NPVVJDRSA9IG9mb25vLSQoT0ZPTk9fVkVSU0lPTikudGFyLnh6PC9kaXY+
PGRpdj5PRk9OT19TSVRFID0gJChCUjJfS0VSTkVMX01JUlJPUikvbGludXgvbmV0d29yay9vZm9u
bzwvZGl2PjxkaXY+T0ZPTk9fTElDRU5TRSA9IEdQTC0yLjA8L2Rpdj48ZGl2Pk9GT05PX0xJQ0VO
U0VfRklMRVMgPSBDT1BZSU5HPC9kaXY+PGRpdj5PRk9OT19ERVBFTkRFTkNJRVMgPSBcPC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+aG9zdC1wa2dj
b25mIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bh
bj5kYnVzIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwv
c3Bhbj5saWJnbGliMiBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdy
YXAiPgk8L3NwYW4+bGliY2FwLW5nIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUtd3JhcCI+CTwvc3Bhbj5tb2JpbGUtYnJvYWRiYW5kLXByb3ZpZGVyLWluZm88L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pk9GT05PX0NPTkZfT1BUUyA9IFw8L2Rpdj48ZGl2PjxzcGFuIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj4tLWRpc2FibGUtdGVzdCBcPC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+LS13aXRoLWRi
dXNjb25mZGlyPS9ldGMgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13
cmFwIj4JPC9zcGFuPiQoaWYgJChCUjJfSU5JVF9TWVNURU1EKSwtLXdpdGgtc3lzdGVtZHVuaXRk
aXI9L3Vzci9saWIvc3lzdGVtZC9zeXN0ZW0pPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4jIE4u
Qi4gUXVhbGNvbW0gUU1JIG1vZGVtIHN1cHBvcnQgcmVxdWlyZXMgT19DTE9FWEVDOyBzbzwvZGl2
PjxkaXY+IyBtYWtlIHN1cmUgdGhhdCBpdCBpcyBkZWZpbmVkLjwvZGl2PjxkaXY+T0ZPTk9fQ09O
Rl9FTlYgKz0gQ0ZMQUdTPSZxdW90OyQoVEFSR0VUX0NGTEFHUykgLURfR05VX1NPVVJDRSZxdW90
OzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+ZGVmaW5lIE9GT05PX0lOU1RBTExfSU5JVF9TWVNW
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+JChJ
TlNUQUxMKSAtbSAwNzU1IC1EIHBhY2thZ2Uvb2Zvbm8vUzQ2b2Zvbm8gJChUQVJHRVRfRElSKS9l
dGMvaW5pdC5kL1M0Nm9mb25vPC9kaXY+PGRpdj5lbmRlZjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+ZGVmaW5lIE9GT05PX0lOU1RBTExfSU5JVF9TWVNURU1EPC9kaXY+PGRpdj48c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+bWtkaXIgLXAgJChUQVJHRVRfRElSKS9l
dGMvc3lzdGVtZC9zeXN0ZW1kL211bHRpLXVzZXIudGFyZ2V0LndhbnRzPC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+bG4gLWZzIC4uLy4uLy4uLy4u
L3Vzci9saWIvc3lzdGVtZC9zeXN0ZW0vb2Zvbm8uc2VydmljZSBcPC9kaXY+PGRpdj48c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgkJPC9zcGFuPiQoVEFSR0VUX0RJUikvZXRjL3N5
c3RlbWQvc3lzdGVtL211bHRpLXVzZXIudGFyZ2V0LndhbnRzPC9kaXY+PGRpdj5lbmRlZjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+aWZlcSAoJChCUjJfUEFDS0FHRV9IQVNfVURFVikseSk8L2Rp
dj48ZGl2Pk9GT05PX0NPTkZfT1BUUyArPSAtLWVuYWJsZS11ZGV2PC9kaXY+PGRpdj5PRk9OT19E
RVBFTkRFTkNJRVMgKz0gdWRldjwvZGl2PjxkaXY+ZWxzZTwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9P
UFRTICs9IC0tZGlzYWJsZS11ZGV2PC9kaXY+PGRpdj5lbmRpZjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+aWZlcSAoJChCUjJfUEFDS0FHRV9CTFVFWl9VVElMUykseSk8L2Rpdj48ZGl2Pk9GT05P
X0NPTkZfT1BUUyArPSAtLWVuYWJsZS1ibHVldG9vdGg8L2Rpdj48ZGl2Pk9GT05PX0RFUEVOREVO
Q0lFUyArPSBibHVlel91dGlsczwvZGl2PjxkaXY+ZWxzZTwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9P
UFRTICs9IC0tZGlzYWJsZS1ibHVldG9vdGg8L2Rpdj48ZGl2PmVuZGlmPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj4kKGV2YWwgJChhdXRvdG9vbHMtcGFja2FnZSkpPC9kaXY+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5JIGNhbiBtb2RpZnkgdGhlIGRvd25sb2FkZWQgb0Zvbm8gc291cmNlIGNv
ZGUgKHBsdWdpbnMgYW5kIGRyaXZlcnMgZGlyZWN0b3JpZXMpIGFuZCByZWJ1aWxkIGl0IGFzIG5l
ZWRlZCB0byB0ZXN0IHRoZSBUT0JZLVIyMDAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2
PiQgbHMgLWwgb3V0cHV0L2J1aWxkL29mb25vLTEuMjE8L2Rpdj48ZGl2PnRvdGFsIDI1Mjg8L2Rp
dj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgODM1IE9jdMKgIDXCoCAyMDE3
IGFjaW5jbHVkZS5tNDwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmsgMzYwNDkx
IE9jdMKgIDXCoCAyMDE3IGFjbG9jYWwubTQ8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5r
IGZyYW5rwqAgwqA1MzU2IE9jdMKgIDXCoCAyMDE3IEFVVEhPUlM8L2Rpdj48ZGl2PmRyd3hyLXhy
LXjCoCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IE9jdMKgIDXCoCAyMDE3IGJ0aW88L2Rpdj48ZGl2
Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgMzA4MTEgT2N0wqAgNcKgIDIwMTcgQ2hhbmdl
TG9nPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIMKgNzMzMyBPY3TCoCA1
wqAgMjAxNyBjb21waWxlPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIDQz
NzY1IFNlcCAxMyAxMTozOSBjb25maWcuZ3Vlc3M8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZy
YW5rIGZyYW5rwqAgwqAyNzc1IFNlcCAxMyAxMTozOSBjb25maWcuaDwvZGl2PjxkaXY+LXJ3LXIt
LXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDI0OTIgT2N0wqAgNcKgIDIwMTcgPGEgaHJlZj0iaHR0
cDovL2NvbmZpZy5oLmluIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmlnLmguaW48L2E+PC9kaXY+PGRp
dj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDQyODc3IFNlcCAxMyAxMTozOSBjb25maWcu
bG9nPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIDY3NTcxIFNlcCAxMyAx
MTozOSBjb25maWcuc3RhdHVzPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8Kg
IDM2MTcxIFNlcCAxMyAxMTozOSBjb25maWcuc3ViPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBm
cmFuayBmcmFuayA0Njc2ODkgT2N0wqAgNcKgIDIwMTcgY29uZmlndXJlPC9kaXY+PGRpdj4tcnct
ci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgODIyMyBPY3TCoCA1wqAgMjAxNyA8YSBocmVmPSJo
dHRwOi8vY29uZmlndXJlLmFjIiB0YXJnZXQ9Il9ibGFuayI+Y29uZmlndXJlLmFjPC9hPjwvZGl2
PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAxODAxMSBKdWwgMTDCoCAyMDA5IENP
UFlJTkc8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgMjM1NjYgT2N0wqAg
NcKgIDIwMTcgZGVwY29tcDwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJhbmvCoCDC
oDQwOTYgT2N0wqAgNcKgIDIwMTcgZG9jPC9kaXY+PGRpdj5kcnd4ci14ci14IDI1IGZyYW5rIGZy
YW5rwqAgwqA0MDk2IE9jdMKgIDXCoCAyMDE3IGRyaXZlcnM8L2Rpdj48ZGl2PmRyd3hyLXhyLXjC
oCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBkdW5kZWU8L2Rpdj48ZGl2PmRy
d3hyLXhyLXjCoCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IE9jdMKgIDXCoCAyMDE3IGV4YW1wbGVz
PC9kaXY+PGRpdj5kcnd4ci14ci14wqAgNCBmcmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6
MzkgZ2F0Y2hhdDwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYg
U2VwIDEzIDExOjM5IGdkYnVzPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMyBmcmFuayBmcmFua8Kg
IMKgNDA5NiBTZXAgMTMgMTE6MzkgZ2lzaTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsg
ZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IGdyaWw8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAz
IGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBpbmNsdWRlPC9kaXY+PGRpdj4tcnct
ci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgOTQ3OCBKdWwgMTDCoCAyMDA5IElOU1RBTEw8L2Rp
dj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgMTQ0MzEgT2N0wqAgNcKgIDIwMTcg
aW5zdGFsbC1zaDwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmsgMjk0MjgyIFNl
cCAxMyAxMTozOSBsaWJ0b29sPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFuayAy
ODM5NDAgU2VwIDEzIDExOjM5IGx0bWFpbi5zaDwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJh
bmsgZnJhbmsgMjgzNjcyIE9jdMKgIDXCoCAyMDE3IGx0bWFpbi5zaC5vcmlnPC9kaXY+PGRpdj4t
cnctci0tci0twqAgMSBmcmFuayBmcmFuayAxODU2MDggU2VwIDEzIDExOjM5IE1ha2VmaWxlPC9k
aXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDI4NzU1IE9jdMKgIDXCoCAyMDE3
IE1ha2VmaWxlLmFtPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFuayAyMDQzMTEg
T2N0wqAgNcKgIDIwMTcgTWFrZWZpbGUuaW48L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5r
IGZyYW5rwqAgwqA2ODcyIE9jdMKgIDXCoCAyMDE3IG1pc3Npbmc8L2Rpdj48ZGl2Pi1ydy1yLS1y
LS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgwqAgMCBKdWwgMTDCoCAyMDA5IE5FV1M8L2Rpdj48ZGl2
Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgMzEwIFNlcCAxMyAxMTozOSBvZm9uby5w
YzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCAzMjUgRmViwqAgNsKg
IDIwMTEgPGEgaHJlZj0iaHR0cDovL29mb25vLnBjLmluIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm8u
cGMuaW48L2E+PC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMyBmcmFuayBmcmFua8KgIMKgNDA5NiBT
ZXAgMTMgMTE6MzkgcGx1Z2luczwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvC
oCDCoCA4ODYgSnVsIDE5wqAgMjAxMiBSRUFETUU8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCA0IGZy
YW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBzcmM8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3C
oCAxIGZyYW5rIGZyYW5rwqAgwqAgwqAyMyBTZXAgMTMgMTE6Mzkgc3RhbXAtaDE8L2Rpdj48ZGl2
PmRyd3hyLXhyLXjCoCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IE9jdMKgIDXCoCAyMDE3IHRlc3Q8
L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgwqA0Mjg3IFNlcCAxM8KgIDIw
MTUgdGVzdC1kcml2ZXI8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgMTc5
OTYgTWF5wqAgM8KgIDIwMTYgVE9ETzwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJh
bmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgdG9vbHM8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCA0
IGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSB1bml0PC9kaXY+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTE6NDggQU0gR2lh
Y2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPmdjaW9mb25vQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRy
Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0i
bHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5oaSBGcmFu
ayw8ZGl2Pjxicj48L2Rpdj48ZGl2PnlvdXIgbW9kZW0gZG9lc24mIzM5O3Qgc2VlbSB0byBiZSBz
dXBwb3J0ZWQuPC9kaXY+PGRpdj5UaGVyZSBhcmUgdGhlc2UgbW9kZWxzOjwvZGl2PjxkaXY+PGRp
dj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5TQVJBX0cy
NzA8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgkJCTwvc3Bhbj49IDExMDIsPC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+VE9CWUwy
X0NPTVBBVElCTEVfTU9ERTxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CQk8L3Nw
YW4+PSAxMTQxLDxicj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3Jh
cCI+CTwvc3Bhbj5UT0JZTDJfTUVESVVNX1RIUk9VR0hQVVRfTU9ERTxzcGFuIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj49IDExNDMsPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+VE9CWUwyX0hJR0hfVEhST1VHSFBVVF9NT0RF
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPj0gMTE0Niw8L2Rpdj48
L2Rpdj48ZGl2PklmIHlvdXIgbW9kZWwgaXMgY29tcGF0aWJsZSB3aXRoIGFueSBvZiB0aGVtLCBJ
IGNhbiBhZGTCoCB0aGUgMTEwNyBmb3IgeW91IGZvciBhIHRlc3QuPGJyPjwvZGl2PjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+ZnJvbSB0aGUgUElELCBJIHdvdWxkIHNheSBpdCBzaG91bGQgYmUg
aW50ZXJtZWRpYXRlIGJldHdlZW4gdGhlIFNBUkFfRzI2MCBhbmQgdGhlIFRPQllMMl9DT01QQVRJ
QkxFX01PREUuPC9kaXY+PGRpdj5Nb3N0IGxpa2VseSBpdCB3aWxsIHdvcmsgdGhpcyBsYXR0ZXIs
IGJ1dCBtYXliZSBub3QgYWxsIGZlYXR1cmVzLi4uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5B
cmUgeW91IHdpbGxpbmcgdG8gdGVzdD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgcmVn
YXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAx
OCBhdCA3OjQ4IFBNIEZyYW5rIFZhc3F1ZXogJmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZAaGVs
aXVtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PjxkaXYgZGlyPSJsdHIiPkhpIEdpYWNpbnRvLDwvZGl2PjxkaXYgZGlyPSJsdHIiPjxicj48L2Rp
dj48ZGl2IGRpcj0ibHRyIj4mZ3Q7wqA8c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5j
YW4geW91IHNlbmQgdGhlIHJlc3VsdCBvZiAmcXVvdDtsc3VzYiZxdW90OyBhbmQgJnF1b3Q7bHN1
c2IgLXQmcXVvdDs/PC9zcGFuPjwvZGl2PjxkaXYgZGlyPSJsdHIiPjxicj48L2Rpdj48ZGl2IGRp
cj0ibHRyIj5UaGUgdXNidXRpbHMgdmVyc2lvbiBvZiBsc3VzYiBpcyBzb21ld2hhdCBiZXR0ZXIu
PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXY+PGRpdj4jIGxzdXNiPC9kaXY+PGRpdj5CdXMg
MDAyIERldmljZSAwMDE6IElEIDFkNmI6MDAwM8KgwqA8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2aWNl
IDAwMjogSUQgMTU0NjoxMTA3wqDCoDwvZGl2PjxkaXY+QnVzIDAwMSBEZXZpY2UgMDAxOiBJRCAx
ZDZiOjAwMDLCoMKgPC9kaXY+PGRpdj4jIGxzdXNiIC10PC9kaXY+PGRpdj4vOsKgIEJ1cyAwMi5Q
b3J0IDE6IERldiAxLCBDbGFzcz1yb290X2h1YiwgRHJpdmVyPXhoY2ktaGNkLzFwLCA1MDAwTTwv
ZGl2PjxkaXY+LzrCoCBCdXMgMDEuUG9ydCAxOiBEZXYgMSwgQ2xhc3M9cm9vdF9odWIsIERyaXZl
cj14aGNpLWhjZC8xcCwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElm
IDAsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0
IDE6IERldiAyLCBJZiAxLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7C
oCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMiwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgw
TTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDMsIENsYXNzPSwgRHJpdmVy
PWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA0LCBD
bGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBE
ZXYgMiwgSWYgNSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAg
fF9fIFBvcnQgMTogRGV2IDIsIElmIDYsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rp
dj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA3LCBDbGFzcz0sIERyaXZlcj1jZGNf
YWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgOCwgQ2xhc3M9
LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIs
IElmIDksIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQ
b3J0IDE6IERldiAyLCBJZiAxMCwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2Pjxk
aXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDExLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNt
LCA0ODBNPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmQgaGVyZSBpcyBhIHJlbGV2
YW50IGV4Y2VycHQgZnJvbSBsc3VzYiAtdi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+
QnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAxNTQ2OjExMDc8L2Rpdj48ZGl2PkRldmljZSBEZXNjcmlw
dG9yOjwvZGl2PjxkaXY+wqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE4PC9kaXY+
PGRpdj7CoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCDCoDE8L2Rpdj48ZGl2PsKgIGJjZFVT
QsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMi4wMDwvZGl2PjxkaXY+wqAgYkRldmljZUNsYXNzwqAg
wqAgwqAgwqAgwqAgMjM5PC9kaXY+PGRpdj7CoCBiRGV2aWNlU3ViQ2xhc3PCoCDCoCDCoCDCoCDC
oDI8L2Rpdj48ZGl2PsKgIGJEZXZpY2VQcm90b2NvbMKgIMKgIMKgIMKgIMKgMTwvZGl2PjxkaXY+
wqAgYk1heFBhY2tldFNpemUwwqAgwqAgwqAgwqAgNjQ8L2Rpdj48ZGl2PsKgIGlkVmVuZG9ywqAg
wqAgwqAgwqAgwqAgwqAweDE1NDY8L2Rpdj48ZGl2PsKgIGlkUHJvZHVjdMKgIMKgIMKgIMKgIMKg
IDB4MTEwNzwvZGl2PjxkaXY+wqAgYmNkRGV2aWNlwqAgwqAgwqAgwqAgwqAgwqAxNy4yOTwvZGl2
PjxkaXY+wqAgaU1hbnVmYWN0dXJlcsKgIMKgIMKgIMKgIMKgIMKgMSB1LWJsb3g8L2Rpdj48ZGl2
PsKgIGlQcm9kdWN0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMiB1LWJsb3ggQ2VsbHVsYXIgTW9k
dWxlPC9kaXY+PGRpdj7CoCBpU2VyaWFswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAzIDM1Mjg0
ODA4MDM5MjY0NjwvZGl2PjxkaXY+wqAgYk51bUNvbmZpZ3VyYXRpb25zwqAgwqAgwqAgMTwvZGl2
PjxkaXY+wqAgQ29uZmlndXJhdGlvbiBEZXNjcmlwdG9yOjwvZGl2PjxkaXY+wqAgwqAgYkxlbmd0
aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOTwvZGl2PjxkaXY+wqAgwqAgYkRlc2NyaXB0b3JU
eXBlwqAgwqAgwqAgwqAgwqAyPC9kaXY+PGRpdj7CoCDCoCB3VG90YWxMZW5ndGjCoCDCoCDCoCDC
oCDCoCA0MDU8L2Rpdj48ZGl2PsKgIMKgIGJOdW1JbnRlcmZhY2VzwqAgwqAgwqAgwqAgwqAxMjwv
ZGl2PjxkaXY+wqAgwqAgYkNvbmZpZ3VyYXRpb25WYWx1ZcKgIMKgIMKgMTwvZGl2PjxkaXY+wqAg
wqAgaUNvbmZpZ3VyYXRpb27CoCDCoCDCoCDCoCDCoCAwPC9kaXY+PGRpdj7CoCDCoCBibUF0dHJp
YnV0ZXPCoCDCoCDCoCDCoCDCoDB4ZTA8L2Rpdj48ZGl2PsKgIMKgIMKgIFNlbGYgUG93ZXJlZDwv
ZGl2PjxkaXY+wqAgwqAgwqAgUmVtb3RlIFdha2V1cDwvZGl2PjxkaXY+wqAgwqAgTWF4UG93ZXLC
oCDCoCDCoCDCoCDCoCDCoCDCoCAxMDBtQTwvZGl2PjxkaXY+wqAgwqAgSW50ZXJmYWNlIEFzc29j
aWF0aW9uOjwvZGl2PjxkaXY+wqAgwqAgwqAgYkxlbmd0aMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgODwvZGl2PjxkaXY+wqAgwqAgwqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgMTE8L2Rp
dj48ZGl2PsKgIMKgIMKgIGJGaXJzdEludGVyZmFjZcKgIMKgIMKgIMKgIMKgMDwvZGl2PjxkaXY+
wqAgwqAgwqAgYkludGVyZmFjZUNvdW50wqAgwqAgwqAgwqAgwqAyPC9kaXY+PGRpdj7CoCDCoCDC
oCBiRnVuY3Rpb25DbGFzc8KgIMKgIMKgIMKgIMKgIDI8L2Rpdj48ZGl2PsKgIMKgIMKgIGJGdW5j
dGlvblN1YkNsYXNzwqAgwqAgwqAgwqAyPC9kaXY+PGRpdj7CoCDCoCDCoCBiRnVuY3Rpb25Qcm90
b2NvbMKgIMKgIMKgIMKgMTwvZGl2PjxkaXY+wqAgwqAgwqAgaUZ1bmN0aW9uwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqA0IENEQyBBQ008L2Rpdj48ZGl2Pi4uLjwvZGl2PjwvZGl2PjxkaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTA6MjEgQU0g
RnJhbmsgVmFzcXVleiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJn
ZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+
PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8sPGRpdj48YnI+PC9kaXY+PGRpdj4mZ3Q7IGNhbiB5
b3Ugc2VuZCB0aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFuZCAmcXVvdDtsc3VzYiAt
dCZxdW90Oz88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+IyBsc3VzYiAtdDwvZGl2Pjxk
aXY+QnVzIDAwMSBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDI8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2
aWNlIDAwMjogSUQgMTU0NjoxMTA3PC9kaXY+PGRpdj5CdXMgMDAyIERldmljZSAwMDE6IElEIDFk
NmI6MDAwMzwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSBydW5uaW5nIEJ1c3lC
b3gmIzM5O3Mgc3RyaXBwZWQgZG93biB2ZXJzaW9uIG9mIGxzdXNiIHRoYXQmIzM5O3Mgd2h5IGlu
Zm9ybWF0aW9uIGlzIHNvIGxhY2tpbmcuPC9kaXY+PGRpdj5JJiMzOTtsbCBpbnN0YWxsIHVzYnV0
aWxzIG9uIG15IGRldmljZSYjMzk7cyBCdWlsZHJvb3QgaW1hZ2UgYW5kIHJlcnVuIHRoZSBjb21t
YW5kcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9k
aXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRy
Ij5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAzOjQ5IEFNIEdpYWNpbnRvIENpZmVsbGkgJmx0Ozxh
IGhyZWY9Im1haWx0bzpnY2lvZm9ub0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5nY2lvZm9u
b0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9ImF1dG8iPmhpIEZyYW5rLDxkaXYgZGly
PSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPmNhbiB5b3Ugc2VuZCB0aGUgcmVzdWx0
IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFuZCAmcXVvdDtsc3VzYiAtdCZxdW90Oz88L2Rpdj48ZGl2
IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5HaWFjaW50bzwvZGl2PjwvZGl2
Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCAxMyBT
ZXAgMjAxOCwgMDA6NDEgRnJhbmsgVmFzcXVleiwgJmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZA
aGVsaXVtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3Jv
dGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPkdyZWV0aW5ncyw8ZGl2Pjxicj48L2Rpdj48
ZGl2PkkgaGF2ZSBhbiBlbWJlZGRlZCBkZXZpY2Ugd2l0aCBhIHVibG94IFRPQlktUjIwMCBvbiBp
dC7CoCBJIHdhbnQgdG8gdXNlIGNvbm5tYW4gdG8gbWFuYWdlIGFueSBjZWxsdWxhciBjb25uZWN0
aW9uIG9uIHRoYXQgbW9kZW0gc2luY2UgY29ubm1hbiBpcyBhbHJlYWR5IG1hbmFnaW5nIGV0aGVy
bmV0IGFuZCB3aWZpIGNvbm5lY3Rpdml0eS7CoCBvRm9ubyBzZWVtcyBsaWtlIHRoZSBiZXN0IG9w
dGlvbi7CoCBJIHNlZSB0aGF0IHRoZXJlIGlzIGFscmVhZHkgYSB1YmxveCBwbHVnaW4gZm9yIG9G
b25vIGJ1dCBJIGRvbiYjMzk7dCB0aGluayB0aGUgVE9CWS1SMjAwIGlzIHN1cHBvcnRlZC7CoCBU
aGUgY2VsbCBtb2R1bGUgaXMgc29sZGVyZWQgb250byB0aGUgYm9hcmQgYW5kIGFwcGVhcnMgYXMg
YSBVU0IgZGV2aWNlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5bwqAgwqAgNi41MTkx
OTBdIHVzYiAxLTE6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1mcj0xLCBQcm9kdWN0PTIsIFNl
cmlhbE51bWJlcj0zPC9kaXY+PGRpdj5bwqAgwqAgNi41MTkxOTddIHVzYiAxLTE6IFByb2R1Y3Q6
IHUtYmxveCBDZWxsdWxhciBNb2R1bGU8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTIwNF0gdXNiIDEt
MTogTWFudWZhY3R1cmVyOiB1LWJsb3g8L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTIxMV0gdXNiIDEt
MTogU2VyaWFsTnVtYmVyOiAzNTI4NDgwODAzOTI2NDY8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkkgY2FuIHNlbmQgQVQgY29tbWFuZHMgdG8gdGhlIG1vZGVtIG92ZXIgL2Rldi90dHlB
Q00wLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rp
dj48L2Rpdj48L2Rpdj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX188YnI+Cm9mb25vIG1haWxpbmcgbGlzdDxicj4KPGEgaHJlZj0ibWFpbHRvOm9mb25vQG9m
b25vLm9yZyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+b2Zvbm9Ab2Zvbm8ub3Jn
PC9hPjxicj4KPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5m
by9vZm9ubyIgcmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9hPjxicj4KPC9ibG9j
a3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9i
bG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============0411113576571534761==--

