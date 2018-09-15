Content-Type: multipart/mixed; boundary="===============7888954230644004732=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: ublox TOBY-R200
Date: Sat, 15 Sep 2018 08:31:20 +0200
Message-ID: <CAKSBH7Gic+VDe6FQ=AiEUyRq=Fm=bdenW0zjpTc-fdsx-LmeXg@mail.gmail.com>
In-Reply-To: <CAFJydPWVt8Xmxz+weZ7qkmvVk1AXM6+6oEeBcxcvO9j_cD3mTA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7888954230644004732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frank,

I am happy that it started working.
Reviewing your email, I doubted that it was more a configure parameters
issue.
The rest below, I shall not top-post in this distribution list.

On Sat, Sep 15, 2018 at 2:54 AM Frank Vasquez <frankv@helium.com> wrote:

> Hi Giacinto,
>
> I applied your patch for the TOBY-R200 and the results look very promisin=
g.
>
> # ./list-modems
> [ /ublox_0 ]
>     Online =3D 1
>     Powered =3D 1
>     Lockdown =3D 0
>     Emergency =3D 0
>     Manufacturer =3D u-blox
>     Model =3D TOBY-R200
>     Revision =3D 30.31
>     Serial =3D 352848080392646
>     Interfaces =3D org.ofono.NetworkRegistration org.ofono.NetworkMonitor
> org.ofono.ConnectionManager org.ofono.LongTermEvolution
> org.ofono.AllowedAccessPoints org.ofono.VoiceCallManager
> org.ofono.SimManager
>     Features =3D net gprs sim
>     Type =3D hardware
>     [ org.ofono.NetworkRegistration ]
>         Status =3D searching
>         Mode =3D auto
>         Name =3D
>     [ org.ofono.NetworkMonitor ]
>     [ org.ofono.ConnectionManager ]
>         Attached =3D 0
>         Bearer =3D none
>         RoamingAllowed =3D 0
>         Powered =3D 1
>     [ org.ofono.LongTermEvolution ]
>         DefaultAccessPointName =3D
>     [ org.ofono.AllowedAccessPoints ]
>     [ org.ofono.VoiceCallManager ]
>         EmergencyNumbers =3D 112 911
>     [ org.ofono.SimManager ]
>         Present =3D 1
>         CardIdentifier =3D 8944501011176099176
>         SubscriberIdentity =3D 234507098609917
>         ServiceProviderName =3D Hologram
>         FixedDialing =3D 0
>         BarredDialing =3D 0
>         MobileCountryCode =3D 234
>         MobileNetworkCode =3D 50
>         SubscriberNumbers =3D
>         LockedPins =3D
>         PreferredLanguages =3D en
>         PinRequired =3D none
>         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
>
> # ./enable-modem
> Connecting modem /ublox_0...
> # ./create-internet-context hologram
> Found context /ublox_0/context1
> Setting APN to hologram
> # ./online-modem
> Setting modem /ublox_0 online...
> # ./activate-context
> Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS is
> not attached
>
>
Have you connected your antennas properly? Have you waited some 2 minutes
before trying the ./activate-context ?
If yes, then this module reports its attach status with some indicator not
recognized by ofono today (blind shot: +CEREG).



> As you can see I was unable to activate-context but I got pretty close.
> I'm willing to apply more code changes if it means I can get cellular
> integration with connman.
>

In general I test on Ubuntu with d-feed, so I don't know all the test
scripts, but there should be some to check whether the modem is reported
registered, to which technology, what the signal strength is, and if it is
reported attached.
If it is registered to LTE, it is attached, but ofono doesn't recognize it
automatically by radio technology, it needs a separate indicator.


>
> Cheers,
> Frank
>
> On Thu, Sep 13, 2018 at 9:19 PM Giacinto Cifelli <gciofono@gmail.com>
> wrote:
>
>> Hi Frank,
>>
>> both TOBYL2_COMPATIBLE_MODE and  TOBYL2_HIGH_THROUGHPUT_MODE behave the
>> same in the code.
>> (TOBYL2_MEDIUM_THROUGHPUT_MODE is recognized but discarded later in the
>> code)
>> Please replace the two attached files in the plugins directory.
>> Let me know if it works (it would be good to know which functionalities
>> you try out), and if so I can submit the changes as patches.
>>
>> You don't need the udev rule for usb modems, it is recognized
>> automatically.
>>
>> Best Regards,
>> Giacinto
>>
>>
>>
>>
>>
>> On Thu, Sep 13, 2018 at 10:51 PM Frank Vasquez <frankv@helium.com> wro=
te:
>>
>>> Hi Giancito,
>>>
>>> I modified ublox.c as follows.
>>>
>>> enum supported_models {
>>>         SARA_G270                       =3D 1102,
>>>         TOBYL2_COMPATIBLE_MODE          =3D 1141,
>>>         TOBYL2_MEDIUM_THROUGHPUT_MODE   =3D 1143,
>>>         TOBYL2_HIGH_THROUGHPUT_MODE     =3D 1107,  /* was 1146 */
>>> };
>>>
>>> And still no luck.
>>>
>>> # ./list-modems
>>> #
>>>
>>> I see no evidence that oFono's ublox driver is being loaded even though
>>> I added the following line to 60-serial-rules in
>>> /etc/udev/rules.d/60-serial-rules.
>>>
>>> KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"ublox"
>>>
>>> I want TOBYL2_HIGH_THROUGHPUT_MODE because that's the mode that uses LT=
E.
>>>
>>> Cheers,
>>> Frank
>>>
>>>
>>> On Thu, Sep 13, 2018 at 12:18 PM Frank Vasquez <frankv@helium.com>
>>> wrote:
>>>
>>>> Hi Giacinto,
>>>>
>>>> The TOBY-R200 is an LTE module.  I see that the ublox oFono plugin
>>>> supports LTE on the TOBY-L2 so maybe it will work on the TOBY-R200 as
>>>> well.  I think many of the AT commands are the same across ublox cellu=
lar
>>>> modems so yes let's give testing a shot.
>>>>
>>>> I am using Buildroot to build oFono for my Linux device.
>>>>
>>>>
>>>> ######################################################################=
##########
>>>> #
>>>> # ofono
>>>> #
>>>>
>>>> ######################################################################=
##########
>>>>
>>>> OFONO_VERSION =3D 1.21
>>>> OFONO_SOURCE =3D ofono-$(OFONO_VERSION).tar.xz
>>>> OFONO_SITE =3D $(BR2_KERNEL_MIRROR)/linux/network/ofono
>>>> OFONO_LICENSE =3D GPL-2.0
>>>> OFONO_LICENSE_FILES =3D COPYING
>>>> OFONO_DEPENDENCIES =3D \
>>>> host-pkgconf \
>>>> dbus \
>>>> libglib2 \
>>>> libcap-ng \
>>>> mobile-broadband-provider-info
>>>>
>>>> OFONO_CONF_OPTS =3D \
>>>> --disable-test \
>>>> --with-dbusconfdir=3D/etc \
>>>> $(if $(BR2_INIT_SYSTEMD),--with-systemdunitdir=3D/usr/lib/systemd/syst=
em)
>>>>
>>>> # N.B. Qualcomm QMI modem support requires O_CLOEXEC; so
>>>> # make sure that it is defined.
>>>> OFONO_CONF_ENV +=3D CFLAGS=3D"$(TARGET_CFLAGS) -D_GNU_SOURCE"
>>>>
>>>> define OFONO_INSTALL_INIT_SYSV
>>>> $(INSTALL) -m 0755 -D package/ofono/S46ofono
>>>> $(TARGET_DIR)/etc/init.d/S46ofono
>>>> endef
>>>>
>>>> define OFONO_INSTALL_INIT_SYSTEMD
>>>> mkdir -p $(TARGET_DIR)/etc/systemd/systemd/multi-user.target.wants
>>>> ln -fs ../../../../usr/lib/systemd/system/ofono.service \
>>>> $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
>>>> endef
>>>>
>>>> ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
>>>> OFONO_CONF_OPTS +=3D --enable-udev
>>>> OFONO_DEPENDENCIES +=3D udev
>>>> else
>>>> OFONO_CONF_OPTS +=3D --disable-udev
>>>> endif
>>>>
>>>> ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
>>>> OFONO_CONF_OPTS +=3D --enable-bluetooth
>>>> OFONO_DEPENDENCIES +=3D bluez_utils
>>>> else
>>>> OFONO_CONF_OPTS +=3D --disable-bluetooth
>>>> endif
>>>>
>>>> $(eval $(autotools-package))
>>>>
>>>> I can modify the downloaded oFono source code (plugins and drivers
>>>> directories) and rebuild it as needed to test the TOBY-R200.
>>>>
>>>> $ ls -l output/build/ofono-1.21
>>>> total 2528
>>>> -rw-r--r--  1 frank frank    835 Oct  5  2017 acinclude.m4
>>>> -rw-r--r--  1 frank frank 360491 Oct  5  2017 aclocal.m4
>>>> -rw-r--r--  1 frank frank   5356 Oct  5  2017 AUTHORS
>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 btio
>>>> -rw-r--r--  1 frank frank  30811 Oct  5  2017 ChangeLog
>>>> -rwxr-xr-x  1 frank frank   7333 Oct  5  2017 compile
>>>> -rwxr-xr-x  1 frank frank  43765 Sep 13 11:39 config.guess
>>>> -rw-r--r--  1 frank frank   2775 Sep 13 11:39 config.h
>>>> -rw-r--r--  1 frank frank   2492 Oct  5  2017 config.h.in
>>>> -rw-r--r--  1 frank frank  42877 Sep 13 11:39 config.log
>>>> -rwxr-xr-x  1 frank frank  67571 Sep 13 11:39 config.status
>>>> -rwxr-xr-x  1 frank frank  36171 Sep 13 11:39 config.sub
>>>> -rwxr-xr-x  1 frank frank 467689 Oct  5  2017 configure
>>>> -rw-r--r--  1 frank frank   8223 Oct  5  2017 configure.ac
>>>> -rw-r--r--  1 frank frank  18011 Jul 10  2009 COPYING
>>>> -rwxr-xr-x  1 frank frank  23566 Oct  5  2017 depcomp
>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 doc
>>>> drwxr-xr-x 25 frank frank   4096 Oct  5  2017 drivers
>>>> drwxr-xr-x  2 frank frank   4096 Sep 13 11:39 dundee
>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 examples
>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gatchat
>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gdbus
>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gisi
>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gril
>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 include
>>>> -rw-r--r--  1 frank frank   9478 Jul 10  2009 INSTALL
>>>> -rwxr-xr-x  1 frank frank  14431 Oct  5  2017 install-sh
>>>> -rwxr-xr-x  1 frank frank 294282 Sep 13 11:39 libtool
>>>> -rw-r--r--  1 frank frank 283940 Sep 13 11:39 ltmain.sh
>>>> -rw-r--r--  1 frank frank 283672 Oct  5  2017 ltmain.sh.orig
>>>> -rw-r--r--  1 frank frank 185608 Sep 13 11:39 Makefile
>>>> -rw-r--r--  1 frank frank  28755 Oct  5  2017 Makefile.am
>>>> -rw-r--r--  1 frank frank 204311 Oct  5  2017 Makefile.in
>>>> -rwxr-xr-x  1 frank frank   6872 Oct  5  2017 missing
>>>> -rw-r--r--  1 frank frank      0 Jul 10  2009 NEWS
>>>> -rw-r--r--  1 frank frank    310 Sep 13 11:39 ofono.pc
>>>> -rw-r--r--  1 frank frank    325 Feb  6  2011 ofono.pc.in
>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 plugins
>>>> -rw-r--r--  1 frank frank    886 Jul 19  2012 README
>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 src
>>>> -rw-r--r--  1 frank frank     23 Sep 13 11:39 stamp-h1
>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 test
>>>> -rwxr-xr-x  1 frank frank   4287 Sep 13  2015 test-driver
>>>> -rw-r--r--  1 frank frank  17996 May  3  2016 TODO
>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 tools
>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 unit
>>>>
>>>> Cheers,
>>>> Frank
>>>>
>>>>
>>>>
>>>> On Thu, Sep 13, 2018 at 11:48 AM Giacinto Cifelli <gciofono@gmail.co=
m>
>>>> wrote:
>>>>
>>>>> hi Frank,
>>>>>
>>>>> your modem doesn't seem to be supported.
>>>>> There are these models:
>>>>> SARA_G270 =3D 1102,
>>>>> TOBYL2_COMPATIBLE_MODE =3D 1141,
>>>>> TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
>>>>> TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
>>>>> If your model is compatible with any of them, I can add  the 1107 for
>>>>> you for a test.
>>>>>
>>>>> from the PID, I would say it should be intermediate between the
>>>>> SARA_G260 and the TOBYL2_COMPATIBLE_MODE.
>>>>> Most likely it will work this latter, but maybe not all features...
>>>>>
>>>>> Are you willing to test?
>>>>>
>>>>> Best regards,
>>>>> Giacinto
>>>>>
>>>>>
>>>>>
>>>>> On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com>
>>>>> wrote:
>>>>>
>>>>>> Hi Giacinto,
>>>>>>
>>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>>
>>>>>> The usbutils version of lsusb is somewhat better.
>>>>>>
>>>>>> # lsusb
>>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>>> # lsusb -t
>>>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 50=
00M
>>>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 48=
0M
>>>>>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>
>>>>>> And here is a relevant excerpt from lsusb -v.
>>>>>>
>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>> Device Descriptor:
>>>>>>   bLength                18
>>>>>>   bDescriptorType         1
>>>>>>   bcdUSB               2.00
>>>>>>   bDeviceClass          239
>>>>>>   bDeviceSubClass         2
>>>>>>   bDeviceProtocol         1
>>>>>>   bMaxPacketSize0        64
>>>>>>   idVendor           0x1546
>>>>>>   idProduct          0x1107
>>>>>>   bcdDevice           17.29
>>>>>>   iManufacturer           1 u-blox
>>>>>>   iProduct                2 u-blox Cellular Module
>>>>>>   iSerial                 3 352848080392646
>>>>>>   bNumConfigurations      1
>>>>>>   Configuration Descriptor:
>>>>>>     bLength                 9
>>>>>>     bDescriptorType         2
>>>>>>     wTotalLength          405
>>>>>>     bNumInterfaces         12
>>>>>>     bConfigurationValue     1
>>>>>>     iConfiguration          0
>>>>>>     bmAttributes         0xe0
>>>>>>       Self Powered
>>>>>>       Remote Wakeup
>>>>>>     MaxPower              100mA
>>>>>>     Interface Association:
>>>>>>       bLength                 8
>>>>>>       bDescriptorType        11
>>>>>>       bFirstInterface         0
>>>>>>       bInterfaceCount         2
>>>>>>       bFunctionClass          2
>>>>>>       bFunctionSubClass       2
>>>>>>       bFunctionProtocol       1
>>>>>>       iFunction               4 CDC ACM
>>>>>> ...
>>>>>>
>>>>>> Cheers,
>>>>>> Frank
>>>>>>
>>>>>>
>>>>>> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com>
>>>>>> wrote:
>>>>>>
>>>>>>> Hi Giacinto,
>>>>>>>
>>>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>
>>>>>>> # lsusb -t
>>>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>>>
>>>>>>> I am running BusyBox's stripped down version of lsusb that's why
>>>>>>> information is so lacking.
>>>>>>> I'll install usbutils on my device's Buildroot image and rerun the
>>>>>>> commands.
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Frank
>>>>>>>
>>>>>>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <gciofono@gmail.=
com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> hi Frank,
>>>>>>>>
>>>>>>>> can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>>
>>>>>>>> Giacinto
>>>>>>>>
>>>>>>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> Greetings,
>>>>>>>>>
>>>>>>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want to
>>>>>>>>> use connman to manage any cellular connection on that modem since=
 connman
>>>>>>>>> is already managing ethernet and wifi connectivity.  oFono seems =
like the
>>>>>>>>> best option.  I see that there is already a ublox plugin for oFon=
o but I
>>>>>>>>> don't think the TOBY-R200 is supported.  The cell module is solde=
red onto
>>>>>>>>> the board and appears as a USB device.
>>>>>>>>>
>>>>>>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=
=3D2,
>>>>>>>>> SerialNumber=3D3
>>>>>>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>>>>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>>>>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>>>>>>
>>>>>>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>>>>>>
>>>>>>>>> Cheers,
>>>>>>>>> Frank
>>>>>>>>> _______________________________________________
>>>>>>>>> ofono mailing list
>>>>>>>>> ofono(a)ofono.org
>>>>>>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>>>>>>
>>>>>>>>

--===============7888954230644004732==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRnJhbmssPGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIGhhcHB5IHRo
YXQgaXQgc3RhcnRlZCB3b3JraW5nLjwvZGl2PjxkaXY+UmV2aWV3aW5nIHlvdXIgZW1haWwsIEkg
ZG91YnRlZCB0aGF0IGl0IHdhcyBtb3JlIGEgY29uZmlndXJlIHBhcmFtZXRlcnMgaXNzdWUuPC9k
aXY+PGRpdj5UaGUgcmVzdCBiZWxvdywgSSBzaGFsbCBub3QgdG9wLXBvc3QgaW4gdGhpcyBkaXN0
cmlidXRpb24gbGlzdC48L2Rpdj48ZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciI+T24gU2F0LCBTZXAgMTUsIDIwMTggYXQgMjo1NCBBTSBGcmFuayBWYXNxdWV6
ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iPmZyYW5rdkBoZWxpdW0uY29t
PC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRp
bmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PkhpIEdpYWNpbnRvLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhcHBsaWVkIHlvdXIgcGF0Y2ggZm9y
IHRoZSBUT0JZLVIyMDAgYW5kIHRoZSByZXN1bHRzIGxvb2sgdmVyeSBwcm9taXNpbmcuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PiMgLi9saXN0LW1vZGVtc8KgPC9kaXY+PGRpdj5bIC91
YmxveF8wIF08L2Rpdj48ZGl2PsKgIMKgIE9ubGluZSA9IDE8L2Rpdj48ZGl2PsKgIMKgIFBvd2Vy
ZWQgPSAxPC9kaXY+PGRpdj7CoCDCoCBMb2NrZG93biA9IDA8L2Rpdj48ZGl2PsKgIMKgIEVtZXJn
ZW5jeSA9IDA8L2Rpdj48ZGl2PsKgIMKgIE1hbnVmYWN0dXJlciA9IHUtYmxveDwvZGl2PjxkaXY+
wqAgwqAgTW9kZWwgPSBUT0JZLVIyMDA8L2Rpdj48ZGl2PsKgIMKgIFJldmlzaW9uID0gMzAuMzE8
L2Rpdj48ZGl2PsKgIMKgIFNlcmlhbCA9IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjxkaXY+wqAgwqAg
SW50ZXJmYWNlcyA9IG9yZy5vZm9uby5OZXR3b3JrUmVnaXN0cmF0aW9uIG9yZy5vZm9uby5OZXR3
b3JrTW9uaXRvciBvcmcub2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIgb3JnLm9mb25vLkxvbmdUZXJt
RXZvbHV0aW9uIG9yZy5vZm9uby5BbGxvd2VkQWNjZXNzUG9pbnRzIG9yZy5vZm9uby5Wb2ljZUNh
bGxNYW5hZ2VyIG9yZy5vZm9uby5TaW1NYW5hZ2VywqA8L2Rpdj48ZGl2PsKgIMKgIEZlYXR1cmVz
ID0gbmV0IGdwcnMgc2ltwqA8L2Rpdj48ZGl2PsKgIMKgIFR5cGUgPSBoYXJkd2FyZTwvZGl2Pjxk
aXY+wqAgwqAgWyBvcmcub2Zvbm8uTmV0d29ya1JlZ2lzdHJhdGlvbiBdPC9kaXY+PGRpdj7CoCDC
oCDCoCDCoCBTdGF0dXMgPSBzZWFyY2hpbmc8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIE1vZGUgPSBh
dXRvPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBOYW1lID3CoDwvZGl2PjxkaXY+wqAgwqAgWyBvcmcu
b2Zvbm8uTmV0d29ya01vbml0b3IgXTwvZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8uQ29ubmVj
dGlvbk1hbmFnZXIgXTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgQXR0YWNoZWQgPSAwPC9kaXY+PGRp
dj7CoCDCoCDCoCDCoCBCZWFyZXIgPSBub25lPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBSb2FtaW5n
QWxsb3dlZCA9IDA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFBvd2VyZWQgPSAxPC9kaXY+PGRpdj7C
oCDCoCBbIG9yZy5vZm9uby5Mb25nVGVybUV2b2x1dGlvbiBdPC9kaXY+PGRpdj7CoCDCoCDCoCDC
oCBEZWZhdWx0QWNjZXNzUG9pbnROYW1lID3CoDwvZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8u
QWxsb3dlZEFjY2Vzc1BvaW50cyBdPC9kaXY+PGRpdj7CoCDCoCBbIG9yZy5vZm9uby5Wb2ljZUNh
bGxNYW5hZ2VyIF08L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEVtZXJnZW5jeU51bWJlcnMgPSAxMTIg
OTExwqA8L2Rpdj48ZGl2PsKgIMKgIFsgb3JnLm9mb25vLlNpbU1hbmFnZXIgXTwvZGl2PjxkaXY+
wqAgwqAgwqAgwqAgUHJlc2VudCA9IDE8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIENhcmRJZGVudGlm
aWVyID0gODk0NDUwMTAxMTE3NjA5OTE3NjwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Vic2NyaWJl
cklkZW50aXR5ID0gMjM0NTA3MDk4NjA5OTE3PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTZXJ2aWNl
UHJvdmlkZXJOYW1lID0gSG9sb2dyYW08L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEZpeGVkRGlhbGlu
ZyA9IDA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEJhcnJlZERpYWxpbmcgPSAwPC9kaXY+PGRpdj7C
oCDCoCDCoCDCoCBNb2JpbGVDb3VudHJ5Q29kZSA9IDIzNDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAg
TW9iaWxlTmV0d29ya0NvZGUgPSA1MDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Vic2NyaWJlck51
bWJlcnMgPcKgPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBMb2NrZWRQaW5zID3CoDwvZGl2PjxkaXY+
wqAgwqAgwqAgwqAgUHJlZmVycmVkTGFuZ3VhZ2VzID0gZW7CoDwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgUGluUmVxdWlyZWQgPSBub25lPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBSZXRyaWVzID0gW3Bp
biA9IDNdIFtwaW4yID0gM10gW3B1ayA9IDEwXSBbcHVrMiA9IDEwXTwvZGl2PjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGRpdj4jIC4vZW5hYmxlLW1vZGVtwqA8L2Rpdj48ZGl2PkNvbm5lY3Rp
bmcgbW9kZW0gL3VibG94XzAuLi48L2Rpdj48ZGl2PiMgLi9jcmVhdGUtaW50ZXJuZXQtY29udGV4
dCBob2xvZ3JhbTwvZGl2PjxkaXY+Rm91bmQgY29udGV4dCAvdWJsb3hfMC9jb250ZXh0MTwvZGl2
PjxkaXY+U2V0dGluZyBBUE4gdG8gaG9sb2dyYW08L2Rpdj48ZGl2PiMgLi9vbmxpbmUtbW9kZW08
L2Rpdj48ZGl2PlNldHRpbmcgbW9kZW0gL3VibG94XzAgb25saW5lLi4uPC9kaXY+PGRpdj4jIC4v
YWN0aXZhdGUtY29udGV4dMKgPC9kaXY+PGRpdj5FcnJvciBhY3RpdmF0aW5nIC91YmxveF8wL2Nv
bnRleHQxOiBvcmcub2Zvbm8uRXJyb3IuTm90QXR0YWNoZWQ6IEdQUlMgaXMgbm90IGF0dGFjaGVk
PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+SGF2ZSB5b3UgY29ubmVjdGVkIHlvdXIgYW50ZW5uYXMgcHJv
cGVybHk/IEhhdmUgeW91IHdhaXRlZCBzb21lIDIgbWludXRlcyBiZWZvcmUgdHJ5aW5nIHRoZSAu
L2FjdGl2YXRlLWNvbnRleHQgPzwvZGl2PjxkaXY+SWYgeWVzLCB0aGVuIHRoaXMgbW9kdWxlIHJl
cG9ydHMgaXRzIGF0dGFjaCBzdGF0dXMgd2l0aCBzb21lIGluZGljYXRvciBub3QgcmVjb2duaXpl
ZCBieSBvZm9ubyB0b2RheSAoYmxpbmQgc2hvdDrCoCtDRVJFRykuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj7CoDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxl
ZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2
PjwvZGl2PjxkaXY+QXMgeW91IGNhbiBzZWUgSSB3YXMgdW5hYmxlIHRvIGFjdGl2YXRlLWNvbnRl
eHQgYnV0IEkgZ290IHByZXR0eSBjbG9zZS7CoCBJJiMzOTttIHdpbGxpbmcgdG8gYXBwbHkgbW9y
ZSBjb2RlIGNoYW5nZXMgaWYgaXQgbWVhbnMgSSBjYW4gZ2V0IGNlbGx1bGFyIGludGVncmF0aW9u
IHdpdGggY29ubm1hbi48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj5JbiBnZW5lcmFsIEkgdGVzdCBvbiBVYnVudHUgd2l0aCBkLWZlZWQsIHNv
IEkgZG9uJiMzOTt0IGtub3cgYWxsIHRoZSB0ZXN0IHNjcmlwdHMsIGJ1dCB0aGVyZSBzaG91bGQg
YmUgc29tZSB0byBjaGVjayB3aGV0aGVyIHRoZSBtb2RlbSBpcyByZXBvcnRlZCByZWdpc3RlcmVk
LCB0byB3aGljaCB0ZWNobm9sb2d5LCB3aGF0IHRoZSBzaWduYWwgc3RyZW5ndGggaXMsIGFuZCBp
ZiBpdCBpcyByZXBvcnRlZCBhdHRhY2hlZC48L2Rpdj48ZGl2PklmIGl0IGlzIHJlZ2lzdGVyZWQg
dG8gTFRFLCBpdCBpcyBhdHRhY2hlZCwgYnV0IG9mb25vIGRvZXNuJiMzOTt0IHJlY29nbml6ZSBp
dCBhdXRvbWF0aWNhbGx5IGJ5IHJhZGlvIHRlY2hub2xvZ3ksIGl0IG5lZWRzIGEgc2VwYXJhdGUg
aW5kaWNhdG9yLjwvZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29s
aWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBk
aXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgOToxOSBQTSBHaWFjaW50byBDaWZlbGxpICZs
dDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Z2Np
b2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPkhpIEZyYW5rLDxkaXY+
PGJyPjwvZGl2PjxkaXY+Ym90aMKgPHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+VE9C
WUwyX0NPTVBBVElCTEVfTU9ERSBhbmTCoDwvc3Bhbj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgw
LDAsODApIj7CoDwvc3Bhbj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5UT0JZTDJf
SElHSF9USFJPVUdIUFVUX01PREUgYmVoYXZlIHRoZSBzYW1lIGluIHRoZSBjb2RlLjwvc3Bhbj48
L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPig8L3NwYW4+PHNwYW4g
c3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+VE9CWUwyX01FRElVTV9USFJPVUdIUFVUX01PREUg
aXMgcmVjb2duaXplZCBidXQgZGlzY2FyZGVkIGxhdGVyIGluIHRoZSBjb2RlKTwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPlBsZWFzZSByZXBsYWNlIHRo
ZSB0d28gYXR0YWNoZWQgZmlsZXMgaW4gdGhlIHBsdWdpbnMgZGlyZWN0b3J5Ljwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPkxldCBtZSBrbm93IGlmIGl0
IHdvcmtzIChpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cgd2hpY2ggZnVuY3Rpb25hbGl0aWVzIHlv
dSB0cnkgb3V0KSwgYW5kIGlmIHNvIEkgY2FuIHN1Ym1pdCB0aGUgY2hhbmdlcyBhcyBwYXRjaGVz
Ljwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPjxicj48
L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5Zb3UgZG9u
JiMzOTt0IG5lZWQgdGhlIHVkZXYgcnVsZSBmb3IgdXNiIG1vZGVtcywgaXQgaXMgcmVjb2duaXpl
ZCBhdXRvbWF0aWNhbGx5Ljwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2Io
ODAsMCw4MCkiPjxicj48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgw
LDAsODApIj5CZXN0IFJlZ2FyZHMsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9y
OnJnYig4MCwwLDgwKSI+R2lhY2ludG88L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29s
b3I6cmdiKDgwLDAsODApIj48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9y
OnJnYig4MCwwLDgwKSI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpy
Z2IoODAsMCw4MCkiPjxicj48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdi
KDgwLDAsODApIj48YnI+PC9zcGFuPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTA6NTEgUE0gRnJh
bmsgVmFzcXVleiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJnZXQ9
Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRp
diBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhbmNpdG8sPGRp
dj48YnI+PC9kaXY+PGRpdj5JIG1vZGlmaWVkIHVibG94LmMgYXMgZm9sbG93cy48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PjxkaXY+ZW51bSBzdXBwb3J0ZWRfbW9kZWxzIHs8L2Rpdj48ZGl2PsKg
IMKgIMKgIMKgIFNBUkFfRzI3MMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPSAx
MTAyLDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgVE9CWUwyX0NPTVBBVElCTEVfTU9ERcKgIMKgIMKg
IMKgIMKgID0gMTE0MSw8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFRPQllMMl9NRURJVU1fVEhST1VH
SFBVVF9NT0RFwqAgwqA9IDExNDMsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBUT0JZTDJfSElHSF9U
SFJPVUdIUFVUX01PREXCoCDCoCDCoD0gMTEwNyzCoCAvKiB3YXMgMTE0NiAqLzwvZGl2PjxkaXY+
fTs8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBzdGlsbCBubyBsdWNrLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4jIC4vbGlzdC1tb2RlbXPCoDwvZGl2PjxkaXY+Izwv
ZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBzZWUgbm8gZXZpZGVuY2UgdGhhdCBvRm9u
byYjMzk7cyB1YmxveCBkcml2ZXIgaXMgYmVpbmcgbG9hZGVkIGV2ZW4gdGhvdWdoIEkgYWRkZWQg
dGhlIGZvbGxvd2luZyBsaW5lIHRvIDYwLXNlcmlhbC1ydWxlcyBpbiAvZXRjL3VkZXYvcnVsZXMu
ZC82MC1zZXJpYWwtcnVsZXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5LRVJORUw9PSZxdW90
O3R0eUFDTTAmcXVvdDssIEVOVntPRk9OT19EUklWRVJ9PSZxdW90O3VibG94JnF1b3Q7PGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3YW50IFRPQllMMl9ISUdIX1RIUk9VR0hQVVRfTU9E
RSBiZWNhdXNlIHRoYXQmIzM5O3MgdGhlIG1vZGUgdGhhdCB1c2VzIExURS48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRpdj48YnI+PC9kaXY+
PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAxMjoxOCBQTSBGcmFuayBWYXNxdWV6
ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5m
cmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRy
Ij48ZGl2IGRpcj0ibHRyIj5IaSBHaWFjaW50byw8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBUT0JZ
LVIyMDAgaXMgYW4gTFRFIG1vZHVsZS7CoCBJIHNlZSB0aGF0IHRoZSB1YmxveCBvRm9ubyBwbHVn
aW4gc3VwcG9ydHMgTFRFIG9uIHRoZSBUT0JZLUwyIHNvIG1heWJlIGl0IHdpbGwgd29yayBvbiB0
aGUgVE9CWS1SMjAwIGFzIHdlbGwuwqAgSSB0aGluayBtYW55IG9mIHRoZSBBVCBjb21tYW5kcyBh
cmUgdGhlIHNhbWUgYWNyb3NzIHVibG94IGNlbGx1bGFyIG1vZGVtcyBzbyB5ZXMgbGV0JiMzOTtz
IGdpdmUgdGVzdGluZyBhIHNob3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHVzaW5n
IEJ1aWxkcm9vdCB0byBidWlsZCBvRm9ubyBmb3IgbXkgTGludXggZGV2aWNlLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGRpdj4jIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIzwvZGl2PjxkaXY+Izwv
ZGl2PjxkaXY+IyBvZm9ubzwvZGl2PjxkaXY+IzwvZGl2PjxkaXY+IyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9GT05PX1ZFUlNJT04gPSAxLjIxPC9kaXY+
PGRpdj5PRk9OT19TT1VSQ0UgPSBvZm9uby0kKE9GT05PX1ZFUlNJT04pLnRhci54ejwvZGl2Pjxk
aXY+T0ZPTk9fU0lURSA9ICQoQlIyX0tFUk5FTF9NSVJST1IpL2xpbnV4L25ldHdvcmsvb2Zvbm88
L2Rpdj48ZGl2Pk9GT05PX0xJQ0VOU0UgPSBHUEwtMi4wPC9kaXY+PGRpdj5PRk9OT19MSUNFTlNF
X0ZJTEVTID0gQ09QWUlORzwvZGl2PjxkaXY+T0ZPTk9fREVQRU5ERU5DSUVTID0gXDwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmhvc3QtcGtnY29u
ZiBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+
ZGJ1cyBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3Nw
YW4+bGliZ2xpYjIgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFw
Ij4JPC9zcGFuPmxpYmNhcC1uZyBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlLXdyYXAiPgk8L3NwYW4+bW9iaWxlLWJyb2FkYmFuZC1wcm92aWRlci1pbmZvPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgPSBcPC9kaXY+PGRpdj48c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+LS1kaXNhYmxlLXRlc3QgXDwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPi0td2l0aC1kYnVz
Y29uZmRpcj0vZXRjIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3Jh
cCI+CTwvc3Bhbj4kKGlmICQoQlIyX0lOSVRfU1lTVEVNRCksLS13aXRoLXN5c3RlbWR1bml0ZGly
PS91c3IvbGliL3N5c3RlbWQvc3lzdGVtKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+IyBOLkIu
IFF1YWxjb21tIFFNSSBtb2RlbSBzdXBwb3J0IHJlcXVpcmVzIE9fQ0xPRVhFQzsgc288L2Rpdj48
ZGl2PiMgbWFrZSBzdXJlIHRoYXQgaXQgaXMgZGVmaW5lZC48L2Rpdj48ZGl2Pk9GT05PX0NPTkZf
RU5WICs9IENGTEFHUz0mcXVvdDskKFRBUkdFVF9DRkxBR1MpIC1EX0dOVV9TT1VSQ0UmcXVvdDs8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmRlZmluZSBPRk9OT19JTlNUQUxMX0lOSVRfU1lTVjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPiQoSU5T
VEFMTCkgLW0gMDc1NSAtRCBwYWNrYWdlL29mb25vL1M0Nm9mb25vICQoVEFSR0VUX0RJUikvZXRj
L2luaXQuZC9TNDZvZm9ubzwvZGl2PjxkaXY+ZW5kZWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PmRlZmluZSBPRk9OT19JTlNUQUxMX0lOSVRfU1lTVEVNRDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPm1rZGlyIC1wICQoVEFSR0VUX0RJUikvZXRj
L3N5c3RlbWQvc3lzdGVtZC9tdWx0aS11c2VyLnRhcmdldC53YW50czwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmxuIC1mcyAuLi8uLi8uLi8uLi91
c3IvbGliL3N5c3RlbWQvc3lzdGVtL29mb25vLnNlcnZpY2UgXDwvZGl2PjxkaXY+PHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCTwvc3Bhbj4kKFRBUkdFVF9ESVIpL2V0Yy9zeXN0
ZW1kL3N5c3RlbS9tdWx0aS11c2VyLnRhcmdldC53YW50czwvZGl2PjxkaXY+ZW5kZWY8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PmlmZXEgKCQoQlIyX1BBQ0tBR0VfSEFTX1VERVYpLHkpPC9kaXY+
PGRpdj5PRk9OT19DT05GX09QVFMgKz0gLS1lbmFibGUtdWRldjwvZGl2PjxkaXY+T0ZPTk9fREVQ
RU5ERU5DSUVTICs9IHVkZXY8L2Rpdj48ZGl2PmVsc2U8L2Rpdj48ZGl2Pk9GT05PX0NPTkZfT1BU
UyArPSAtLWRpc2FibGUtdWRldjwvZGl2PjxkaXY+ZW5kaWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PmlmZXEgKCQoQlIyX1BBQ0tBR0VfQkxVRVpfVVRJTFMpLHkpPC9kaXY+PGRpdj5PRk9OT19D
T05GX09QVFMgKz0gLS1lbmFibGUtYmx1ZXRvb3RoPC9kaXY+PGRpdj5PRk9OT19ERVBFTkRFTkNJ
RVMgKz0gYmx1ZXpfdXRpbHM8L2Rpdj48ZGl2PmVsc2U8L2Rpdj48ZGl2Pk9GT05PX0NPTkZfT1BU
UyArPSAtLWRpc2FibGUtYmx1ZXRvb3RoPC9kaXY+PGRpdj5lbmRpZjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+JChldmFsICQoYXV0b3Rvb2xzLXBhY2thZ2UpKTwvZGl2PjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+SSBjYW4gbW9kaWZ5IHRoZSBkb3dubG9hZGVkIG9Gb25vIHNvdXJjZSBjb2Rl
IChwbHVnaW5zIGFuZCBkcml2ZXJzIGRpcmVjdG9yaWVzKSBhbmQgcmVidWlsZCBpdCBhcyBuZWVk
ZWQgdG8gdGVzdCB0aGUgVE9CWS1SMjAwLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4k
IGxzIC1sIG91dHB1dC9idWlsZC9vZm9uby0xLjIxPC9kaXY+PGRpdj50b3RhbCAyNTI4PC9kaXY+
PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDgzNSBPY3TCoCA1wqAgMjAxNyBh
Y2luY2x1ZGUubTQ8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rIDM2MDQ5MSBP
Y3TCoCA1wqAgMjAxNyBhY2xvY2FsLm00PC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBm
cmFua8KgIMKgNTM1NiBPY3TCoCA1wqAgMjAxNyBBVVRIT1JTPC9kaXY+PGRpdj5kcnd4ci14ci14
wqAgMiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyBidGlvPC9kaXY+PGRpdj4t
cnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDMwODExIE9jdMKgIDXCoCAyMDE3IENoYW5nZUxv
ZzwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCDCoDczMzMgT2N0wqAgNcKg
IDIwMTcgY29tcGlsZTwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCA0Mzc2
NSBTZXAgMTMgMTE6MzkgY29uZmlnLmd1ZXNzPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFu
ayBmcmFua8KgIMKgMjc3NSBTZXAgMTMgMTE6MzkgY29uZmlnLmg8L2Rpdj48ZGl2Pi1ydy1yLS1y
LS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAyNDkyIE9jdMKgIDXCoCAyMDE3IDxhIGhyZWY9Imh0dHA6
Ly9jb25maWcuaC5pbiIgdGFyZ2V0PSJfYmxhbmsiPmNvbmZpZy5oLmluPC9hPjwvZGl2PjxkaXY+
LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCA0Mjg3NyBTZXAgMTMgMTE6MzkgY29uZmlnLmxv
ZzwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCA2NzU3MSBTZXAgMTMgMTE6
MzkgY29uZmlnLnN0YXR1czwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCAz
NjE3MSBTZXAgMTMgMTE6MzkgY29uZmlnLnN1YjwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJh
bmsgZnJhbmsgNDY3Njg5IE9jdMKgIDXCoCAyMDE3IGNvbmZpZ3VyZTwvZGl2PjxkaXY+LXJ3LXIt
LXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDgyMjMgT2N0wqAgNcKgIDIwMTcgPGEgaHJlZj0iaHR0
cDovL2NvbmZpZ3VyZS5hYyIgdGFyZ2V0PSJfYmxhbmsiPmNvbmZpZ3VyZS5hYzwvYT48L2Rpdj48
ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgMTgwMTEgSnVsIDEwwqAgMjAwOSBDT1BZ
SU5HPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIDIzNTY2IE9jdMKgIDXC
oCAyMDE3IGRlcGNvbXA8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAyIGZyYW5rIGZyYW5rwqAgwqA0
MDk2IE9jdMKgIDXCoCAyMDE3IGRvYzwvZGl2PjxkaXY+ZHJ3eHIteHIteCAyNSBmcmFuayBmcmFu
a8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyBkcml2ZXJzPC9kaXY+PGRpdj5kcnd4ci14ci14wqAg
MiBmcmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgZHVuZGVlPC9kaXY+PGRpdj5kcnd4
ci14ci14wqAgMiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyBleGFtcGxlczwv
ZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5
IGdhdGNoYXQ8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCA0IGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNl
cCAxMyAxMTozOSBnZGJ1czwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsgZnJhbmvCoCDC
oDQwOTYgU2VwIDEzIDExOjM5IGdpc2k8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZyYW5rIGZy
YW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBncmlsPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMyBm
cmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgaW5jbHVkZTwvZGl2PjxkaXY+LXJ3LXIt
LXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDk0NzggSnVsIDEwwqAgMjAwOSBJTlNUQUxMPC9kaXY+
PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIDE0NDMxIE9jdMKgIDXCoCAyMDE3IGlu
c3RhbGwtc2g8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rIDI5NDI4MiBTZXAg
MTMgMTE6MzkgbGlidG9vbDwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmsgMjgz
OTQwIFNlcCAxMyAxMTozOSBsdG1haW4uc2g8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5r
IGZyYW5rIDI4MzY3MiBPY3TCoCA1wqAgMjAxNyBsdG1haW4uc2gub3JpZzwvZGl2PjxkaXY+LXJ3
LXItLXItLcKgIDEgZnJhbmsgZnJhbmsgMTg1NjA4IFNlcCAxMyAxMTozOSBNYWtlZmlsZTwvZGl2
PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAyODc1NSBPY3TCoCA1wqAgMjAxNyBN
YWtlZmlsZS5hbTwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmsgMjA0MzExIE9j
dMKgIDXCoCAyMDE3IE1ha2VmaWxlLmluPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBm
cmFua8KgIMKgNjg3MiBPY3TCoCA1wqAgMjAxNyBtaXNzaW5nPC9kaXY+PGRpdj4tcnctci0tci0t
wqAgMSBmcmFuayBmcmFua8KgIMKgIMKgIDAgSnVsIDEwwqAgMjAwOSBORVdTPC9kaXY+PGRpdj4t
cnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDMxMCBTZXAgMTMgMTE6Mzkgb2Zvbm8ucGM8
L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgMzI1IEZlYsKgIDbCoCAy
MDExIDxhIGhyZWY9Imh0dHA6Ly9vZm9uby5wYy5pbiIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vLnBj
LmluPC9hPjwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2Vw
IDEzIDExOjM5IHBsdWdpbnM8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAg
wqAgODg2IEp1bCAxOcKgIDIwMTIgUkVBRE1FPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgNCBmcmFu
ayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6Mzkgc3JjPC9kaXY+PGRpdj4tcnctci0tci0twqAg
MSBmcmFuayBmcmFua8KgIMKgIMKgMjMgU2VwIDEzIDExOjM5IHN0YW1wLWgxPC9kaXY+PGRpdj5k
cnd4ci14ci14wqAgMiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyB0ZXN0PC9k
aXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIMKgNDI4NyBTZXAgMTPCoCAyMDE1
IHRlc3QtZHJpdmVyPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDE3OTk2
IE1hecKgIDPCoCAyMDE2IFRPRE88L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAyIGZyYW5rIGZyYW5r
wqAgwqA0MDk2IE9jdMKgIDXCoCAyMDE3IHRvb2xzPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgNCBm
cmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgdW5pdDwvZGl2PjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVv
dGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDExOjQ4IEFNIEdpYWNp
bnRvIENpZmVsbGkgJmx0OzxhIGhyZWY9Im1haWx0bzpnY2lvZm9ub0BnbWFpbC5jb20iIHRhcmdl
dD0iX2JsYW5rIj5nY2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+
PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+aGkgRnJhbmss
PGRpdj48YnI+PC9kaXY+PGRpdj55b3VyIG1vZGVtIGRvZXNuJiMzOTt0IHNlZW0gdG8gYmUgc3Vw
cG9ydGVkLjwvZGl2PjxkaXY+VGhlcmUgYXJlIHRoZXNlIG1vZGVsczo8L2Rpdj48ZGl2PjxkaXY+
PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+U0FSQV9HMjcw
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCQk8L3NwYW4+PSAxMTAyLDwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPlRPQllMMl9D
T01QQVRJQkxFX01PREU8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgkJPC9zcGFu
Pj0gMTE0MSw8YnI+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAi
Pgk8L3NwYW4+VE9CWUwyX01FRElVTV9USFJPVUdIUFVUX01PREU8c3BhbiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+PSAxMTQzLDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9Indo
aXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPlRPQllMMl9ISUdIX1RIUk9VR0hQVVRfTU9ERTxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj49IDExNDYsPC9kaXY+PC9k
aXY+PGRpdj5JZiB5b3VyIG1vZGVsIGlzIGNvbXBhdGlibGUgd2l0aCBhbnkgb2YgdGhlbSwgSSBj
YW4gYWRkwqAgdGhlIDExMDcgZm9yIHlvdSBmb3IgYSB0ZXN0Ljxicj48L2Rpdj48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PmZyb20gdGhlIFBJRCwgSSB3b3VsZCBzYXkgaXQgc2hvdWxkIGJlIGlu
dGVybWVkaWF0ZSBiZXR3ZWVuIHRoZSBTQVJBX0cyNjAgYW5kIHRoZSBUT0JZTDJfQ09NUEFUSUJM
RV9NT0RFLjwvZGl2PjxkaXY+TW9zdCBsaWtlbHkgaXQgd2lsbCB3b3JrIHRoaXMgbGF0dGVyLCBi
dXQgbWF5YmUgbm90IGFsbCBmZWF0dXJlcy4uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QXJl
IHlvdSB3aWxsaW5nIHRvIHRlc3Q/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2Fy
ZHMsPC9kaXY+PGRpdj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTgg
YXQgNzo0OCBQTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1
bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2
IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48
ZGl2IGRpcj0ibHRyIj5IaSBHaWFjaW50byw8L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+
PGRpdiBkaXI9Imx0ciI+Jmd0O8KgPHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+Y2Fu
IHlvdSBzZW5kIHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZxdW90O2xzdXNi
IC10JnF1b3Q7Pzwvc3Bhbj48L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+PGRpdiBkaXI9
Imx0ciI+VGhlIHVzYnV0aWxzIHZlcnNpb24gb2YgbHN1c2IgaXMgc29tZXdoYXQgYmV0dGVyLjwv
ZGl2PjxkaXYgZGlyPSJsdHIiPjxicj48ZGl2PjxkaXY+IyBsc3VzYjwvZGl2PjxkaXY+QnVzIDAw
MiBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDPCoMKgPC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAw
MDI6IElEIDE1NDY6MTEwN8KgwqA8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2aWNlIDAwMTogSUQgMWQ2
YjowMDAywqDCoDwvZGl2PjxkaXY+IyBsc3VzYiAtdDwvZGl2PjxkaXY+LzrCoCBCdXMgMDIuUG9y
dCAxOiBEZXYgMSwgQ2xhc3M9cm9vdF9odWIsIERyaXZlcj14aGNpLWhjZC8xcCwgNTAwME08L2Rp
dj48ZGl2Pi86wqAgQnVzIDAxLlBvcnQgMTogRGV2IDEsIENsYXNzPXJvb3RfaHViLCBEcml2ZXI9
eGhjaS1oY2QvMXAsIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAw
LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAx
OiBEZXYgMiwgSWYgMSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAg
wqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDIsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08
L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAzLCBDbGFzcz0sIERyaXZlcj1j
ZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNCwgQ2xh
c3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2
IDIsIElmIDUsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxf
XyBQb3J0IDE6IERldiAyLCBJZiA2LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+
PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNywgQ2xhc3M9LCBEcml2ZXI9Y2RjX2Fj
bSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDgsIENsYXNzPSwg
RHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJ
ZiA5LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9y
dCAxOiBEZXYgMiwgSWYgMTAsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2
PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAxMSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwg
NDgwTTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QW5kIGhlcmUgaXMgYSByZWxldmFu
dCBleGNlcnB0IGZyb20gbHN1c2IgLXYuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PkJ1
cyAwMDEgRGV2aWNlIDAwMjogSUQgMTU0NjoxMTA3PC9kaXY+PGRpdj5EZXZpY2UgRGVzY3JpcHRv
cjo8L2Rpdj48ZGl2PsKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxODwvZGl2Pjxk
aXY+wqAgYkRlc2NyaXB0b3JUeXBlwqAgwqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCBiY2RVU0LC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDIuMDA8L2Rpdj48ZGl2PsKgIGJEZXZpY2VDbGFzc8KgIMKg
IMKgIMKgIMKgIDIzOTwvZGl2PjxkaXY+wqAgYkRldmljZVN1YkNsYXNzwqAgwqAgwqAgwqAgwqAy
PC9kaXY+PGRpdj7CoCBiRGV2aWNlUHJvdG9jb2zCoCDCoCDCoCDCoCDCoDE8L2Rpdj48ZGl2PsKg
IGJNYXhQYWNrZXRTaXplMMKgIMKgIMKgIMKgIDY0PC9kaXY+PGRpdj7CoCBpZFZlbmRvcsKgIMKg
IMKgIMKgIMKgIMKgMHgxNTQ2PC9kaXY+PGRpdj7CoCBpZFByb2R1Y3TCoCDCoCDCoCDCoCDCoCAw
eDExMDc8L2Rpdj48ZGl2PsKgIGJjZERldmljZcKgIMKgIMKgIMKgIMKgIMKgMTcuMjk8L2Rpdj48
ZGl2PsKgIGlNYW51ZmFjdHVyZXLCoCDCoCDCoCDCoCDCoCDCoDEgdS1ibG94PC9kaXY+PGRpdj7C
oCBpUHJvZHVjdMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDIgdS1ibG94IENlbGx1bGFyIE1vZHVs
ZTwvZGl2PjxkaXY+wqAgaVNlcmlhbMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMyAzNTI4NDgw
ODAzOTI2NDY8L2Rpdj48ZGl2PsKgIGJOdW1Db25maWd1cmF0aW9uc8KgIMKgIMKgIDE8L2Rpdj48
ZGl2PsKgIENvbmZpZ3VyYXRpb24gRGVzY3JpcHRvcjo8L2Rpdj48ZGl2PsKgIMKgIGJMZW5ndGjC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDk8L2Rpdj48ZGl2PsKgIMKgIGJEZXNjcmlwdG9yVHlw
ZcKgIMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAgd1RvdGFsTGVuZ3RowqAgwqAgwqAgwqAg
wqAgNDA1PC9kaXY+PGRpdj7CoCDCoCBiTnVtSW50ZXJmYWNlc8KgIMKgIMKgIMKgIMKgMTI8L2Rp
dj48ZGl2PsKgIMKgIGJDb25maWd1cmF0aW9uVmFsdWXCoCDCoCDCoDE8L2Rpdj48ZGl2PsKgIMKg
IGlDb25maWd1cmF0aW9uwqAgwqAgwqAgwqAgwqAgMDwvZGl2PjxkaXY+wqAgwqAgYm1BdHRyaWJ1
dGVzwqAgwqAgwqAgwqAgwqAweGUwPC9kaXY+PGRpdj7CoCDCoCDCoCBTZWxmIFBvd2VyZWQ8L2Rp
dj48ZGl2PsKgIMKgIMKgIFJlbW90ZSBXYWtldXA8L2Rpdj48ZGl2PsKgIMKgIE1heFBvd2VywqAg
wqAgwqAgwqAgwqAgwqAgwqAgMTAwbUE8L2Rpdj48ZGl2PsKgIMKgIEludGVyZmFjZSBBc3NvY2lh
dGlvbjo8L2Rpdj48ZGl2PsKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDg8L2Rpdj48ZGl2PsKgIMKgIMKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIDExPC9kaXY+
PGRpdj7CoCDCoCDCoCBiRmlyc3RJbnRlcmZhY2XCoCDCoCDCoCDCoCDCoDA8L2Rpdj48ZGl2PsKg
IMKgIMKgIGJJbnRlcmZhY2VDb3VudMKgIMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAgwqAg
YkZ1bmN0aW9uQ2xhc3PCoCDCoCDCoCDCoCDCoCAyPC9kaXY+PGRpdj7CoCDCoCDCoCBiRnVuY3Rp
b25TdWJDbGFzc8KgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAgwqAgYkZ1bmN0aW9uUHJvdG9j
b2zCoCDCoCDCoCDCoDE8L2Rpdj48ZGl2PsKgIMKgIMKgIGlGdW5jdGlvbsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgNCBDREMgQUNNPC9kaXY+PGRpdj4uLi48L2Rpdj48L2Rpdj48ZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxf
cXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDEwOjIxIEFNIEZy
YW5rIFZhc3F1ZXogJmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZAaGVsaXVtLmNvbSIgdGFyZ2V0
PSJfYmxhbmsiPmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxk
aXYgZGlyPSJsdHIiPkhpIEdpYWNpbnRvLDxkaXY+PGJyPjwvZGl2PjxkaXY+Jmd0OyBjYW4geW91
IHNlbmQgdGhlIHJlc3VsdCBvZiAmcXVvdDtsc3VzYiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQm
cXVvdDs/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2
PkJ1cyAwMDEgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAyPC9kaXY+PGRpdj5CdXMgMDAxIERldmlj
ZSAwMDI6IElEIDE1NDY6MTEwNzwvZGl2PjxkaXY+QnVzIDAwMiBEZXZpY2UgMDAxOiBJRCAxZDZi
OjAwMDM8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gcnVubmluZyBCdXN5Qm94
JiMzOTtzIHN0cmlwcGVkIGRvd24gdmVyc2lvbiBvZiBsc3VzYiB0aGF0JiMzOTtzIHdoeSBpbmZv
cm1hdGlvbiBpcyBzbyBsYWNraW5nLjwvZGl2PjxkaXY+SSYjMzk7bGwgaW5zdGFsbCB1c2J1dGls
cyBvbiBteSBkZXZpY2UmIzM5O3MgQnVpbGRyb290IGltYWdlIGFuZCByZXJ1biB0aGUgY29tbWFu
ZHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2
PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+
T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMzo0OSBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBo
cmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Z2Npb2Zvbm9A
Z21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJhdXRvIj5oaSBGcmFuayw8ZGl2IGRpcj0i
YXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5jYW4geW91IHNlbmQgdGhlIHJlc3VsdCBv
ZiAmcXVvdDtsc3VzYiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQmcXVvdDs/PC9kaXY+PGRpdiBk
aXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+R2lhY2ludG88L2Rpdj48L2Rpdj48
YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgMTMgU2Vw
IDIwMTgsIDAwOjQxIEZyYW5rIFZhc3F1ZXosICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhl
bGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3Rl
Ojxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5HcmVldGluZ3MsPGRpdj48YnI+PC9kaXY+PGRp
dj5JIGhhdmUgYW4gZW1iZWRkZWQgZGV2aWNlIHdpdGggYSB1YmxveCBUT0JZLVIyMDAgb24gaXQu
wqAgSSB3YW50IHRvIHVzZSBjb25ubWFuIHRvIG1hbmFnZSBhbnkgY2VsbHVsYXIgY29ubmVjdGlv
biBvbiB0aGF0IG1vZGVtIHNpbmNlIGNvbm5tYW4gaXMgYWxyZWFkeSBtYW5hZ2luZyBldGhlcm5l
dCBhbmQgd2lmaSBjb25uZWN0aXZpdHkuwqAgb0Zvbm8gc2VlbXMgbGlrZSB0aGUgYmVzdCBvcHRp
b24uwqAgSSBzZWUgdGhhdCB0aGVyZSBpcyBhbHJlYWR5IGEgdWJsb3ggcGx1Z2luIGZvciBvRm9u
byBidXQgSSBkb24mIzM5O3QgdGhpbmsgdGhlIFRPQlktUjIwMCBpcyBzdXBwb3J0ZWQuwqAgVGhl
IGNlbGwgbW9kdWxlIGlzIHNvbGRlcmVkIG9udG8gdGhlIGJvYXJkIGFuZCBhcHBlYXJzIGFzIGEg
VVNCIGRldmljZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTkw
XSB1c2IgMS0xOiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJp
YWxOdW1iZXI9MzwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTk3XSB1c2IgMS0xOiBQcm9kdWN0OiB1
LWJsb3ggQ2VsbHVsYXIgTW9kdWxlPC9kaXY+PGRpdj5bwqAgwqAgNi41MTkyMDRdIHVzYiAxLTE6
IE1hbnVmYWN0dXJlcjogdS1ibG94PC9kaXY+PGRpdj5bwqAgwqAgNi41MTkyMTFdIHVzYiAxLTE6
IFNlcmlhbE51bWJlcjogMzUyODQ4MDgwMzkyNjQ2PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5JIGNhbiBzZW5kIEFUIGNvbW1hbmRzIHRvIHRoZSBtb2RlbSBvdmVyIC9kZXYvdHR5QUNN
MC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+
PC9kaXY+PC9kaXY+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9u
by5vcmciIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwv
YT48YnI+CjxhIGhyZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8v
b2Zvbm8iIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6
Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2tx
dW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxv
Y2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cjwv
YmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+
PC9kaXY+PC9kaXY+Cg==

--===============7888954230644004732==--

