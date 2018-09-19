Content-Type: multipart/mixed; boundary="===============2897685241108312726=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: ublox TOBY-R200
Date: Wed, 19 Sep 2018 05:02:45 +0200
Message-ID: <CAKSBH7F5T1ziRrwY72e-LFkr7Kn2q3cx_5wPQPn_9G5iVUUQKQ@mail.gmail.com>
In-Reply-To: <CAKSBH7Gic+VDe6FQ=AiEUyRq=Fm=bdenW0zjpTc-fdsx-LmeXg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2897685241108312726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frank,

is it working? I had a look at ublox specification, and I think you need
some more support in ofono for establishing the LTE default bearer.
I will take this back once I have submitted some patches for this support
(and have been accepted).

Best regards,
Giacinto


On Sat, Sep 15, 2018 at 8:31 AM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> Hi Frank,
>
> I am happy that it started working.
> Reviewing your email, I doubted that it was more a configure parameters
> issue.
> The rest below, I shall not top-post in this distribution list.
>
> On Sat, Sep 15, 2018 at 2:54 AM Frank Vasquez <frankv@helium.com> wrote:
>
>> Hi Giacinto,
>>
>> I applied your patch for the TOBY-R200 and the results look very
>> promising.
>>
>> # ./list-modems
>> [ /ublox_0 ]
>>     Online =3D 1
>>     Powered =3D 1
>>     Lockdown =3D 0
>>     Emergency =3D 0
>>     Manufacturer =3D u-blox
>>     Model =3D TOBY-R200
>>     Revision =3D 30.31
>>     Serial =3D 352848080392646
>>     Interfaces =3D org.ofono.NetworkRegistration org.ofono.NetworkMonitor
>> org.ofono.ConnectionManager org.ofono.LongTermEvolution
>> org.ofono.AllowedAccessPoints org.ofono.VoiceCallManager
>> org.ofono.SimManager
>>     Features =3D net gprs sim
>>     Type =3D hardware
>>     [ org.ofono.NetworkRegistration ]
>>         Status =3D searching
>>         Mode =3D auto
>>         Name =3D
>>     [ org.ofono.NetworkMonitor ]
>>     [ org.ofono.ConnectionManager ]
>>         Attached =3D 0
>>         Bearer =3D none
>>         RoamingAllowed =3D 0
>>         Powered =3D 1
>>     [ org.ofono.LongTermEvolution ]
>>         DefaultAccessPointName =3D
>>     [ org.ofono.AllowedAccessPoints ]
>>     [ org.ofono.VoiceCallManager ]
>>         EmergencyNumbers =3D 112 911
>>     [ org.ofono.SimManager ]
>>         Present =3D 1
>>         CardIdentifier =3D 8944501011176099176
>>         SubscriberIdentity =3D 234507098609917
>>         ServiceProviderName =3D Hologram
>>         FixedDialing =3D 0
>>         BarredDialing =3D 0
>>         MobileCountryCode =3D 234
>>         MobileNetworkCode =3D 50
>>         SubscriberNumbers =3D
>>         LockedPins =3D
>>         PreferredLanguages =3D en
>>         PinRequired =3D none
>>         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
>>
>> # ./enable-modem
>> Connecting modem /ublox_0...
>> # ./create-internet-context hologram
>> Found context /ublox_0/context1
>> Setting APN to hologram
>> # ./online-modem
>> Setting modem /ublox_0 online...
>> # ./activate-context
>> Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS is
>> not attached
>>
>>
> Have you connected your antennas properly? Have you waited some 2 minutes
> before trying the ./activate-context ?
> If yes, then this module reports its attach status with some indicator not
> recognized by ofono today (blind shot: +CEREG).
>
>
>
>> As you can see I was unable to activate-context but I got pretty close.
>> I'm willing to apply more code changes if it means I can get cellular
>> integration with connman.
>>
>
> In general I test on Ubuntu with d-feed, so I don't know all the test
> scripts, but there should be some to check whether the modem is reported
> registered, to which technology, what the signal strength is, and if it is
> reported attached.
> If it is registered to LTE, it is attached, but ofono doesn't recognize it
> automatically by radio technology, it needs a separate indicator.
>
>
>>
>> Cheers,
>> Frank
>>
>> On Thu, Sep 13, 2018 at 9:19 PM Giacinto Cifelli <gciofono@gmail.com>
>> wrote:
>>
>>> Hi Frank,
>>>
>>> both TOBYL2_COMPATIBLE_MODE and  TOBYL2_HIGH_THROUGHPUT_MODE behave the
>>> same in the code.
>>> (TOBYL2_MEDIUM_THROUGHPUT_MODE is recognized but discarded later in the
>>> code)
>>> Please replace the two attached files in the plugins directory.
>>> Let me know if it works (it would be good to know which functionalities
>>> you try out), and if so I can submit the changes as patches.
>>>
>>> You don't need the udev rule for usb modems, it is recognized
>>> automatically.
>>>
>>> Best Regards,
>>> Giacinto
>>>
>>>
>>>
>>>
>>>
>>> On Thu, Sep 13, 2018 at 10:51 PM Frank Vasquez <frankv@helium.com>
>>> wrote:
>>>
>>>> Hi Giancito,
>>>>
>>>> I modified ublox.c as follows.
>>>>
>>>> enum supported_models {
>>>>         SARA_G270                       =3D 1102,
>>>>         TOBYL2_COMPATIBLE_MODE          =3D 1141,
>>>>         TOBYL2_MEDIUM_THROUGHPUT_MODE   =3D 1143,
>>>>         TOBYL2_HIGH_THROUGHPUT_MODE     =3D 1107,  /* was 1146 */
>>>> };
>>>>
>>>> And still no luck.
>>>>
>>>> # ./list-modems
>>>> #
>>>>
>>>> I see no evidence that oFono's ublox driver is being loaded even though
>>>> I added the following line to 60-serial-rules in
>>>> /etc/udev/rules.d/60-serial-rules.
>>>>
>>>> KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"ublox"
>>>>
>>>> I want TOBYL2_HIGH_THROUGHPUT_MODE because that's the mode that uses
>>>> LTE.
>>>>
>>>> Cheers,
>>>> Frank
>>>>
>>>>
>>>> On Thu, Sep 13, 2018 at 12:18 PM Frank Vasquez <frankv@helium.com>
>>>> wrote:
>>>>
>>>>> Hi Giacinto,
>>>>>
>>>>> The TOBY-R200 is an LTE module.  I see that the ublox oFono plugin
>>>>> supports LTE on the TOBY-L2 so maybe it will work on the TOBY-R200 as
>>>>> well.  I think many of the AT commands are the same across ublox cell=
ular
>>>>> modems so yes let's give testing a shot.
>>>>>
>>>>> I am using Buildroot to build oFono for my Linux device.
>>>>>
>>>>>
>>>>> #####################################################################=
###########
>>>>> #
>>>>> # ofono
>>>>> #
>>>>>
>>>>> #####################################################################=
###########
>>>>>
>>>>> OFONO_VERSION =3D 1.21
>>>>> OFONO_SOURCE =3D ofono-$(OFONO_VERSION).tar.xz
>>>>> OFONO_SITE =3D $(BR2_KERNEL_MIRROR)/linux/network/ofono
>>>>> OFONO_LICENSE =3D GPL-2.0
>>>>> OFONO_LICENSE_FILES =3D COPYING
>>>>> OFONO_DEPENDENCIES =3D \
>>>>> host-pkgconf \
>>>>> dbus \
>>>>> libglib2 \
>>>>> libcap-ng \
>>>>> mobile-broadband-provider-info
>>>>>
>>>>> OFONO_CONF_OPTS =3D \
>>>>> --disable-test \
>>>>> --with-dbusconfdir=3D/etc \
>>>>> $(if $(BR2_INIT_SYSTEMD),--with-systemdunitdir=3D/usr/lib/systemd/sys=
tem)
>>>>>
>>>>> # N.B. Qualcomm QMI modem support requires O_CLOEXEC; so
>>>>> # make sure that it is defined.
>>>>> OFONO_CONF_ENV +=3D CFLAGS=3D"$(TARGET_CFLAGS) -D_GNU_SOURCE"
>>>>>
>>>>> define OFONO_INSTALL_INIT_SYSV
>>>>> $(INSTALL) -m 0755 -D package/ofono/S46ofono
>>>>> $(TARGET_DIR)/etc/init.d/S46ofono
>>>>> endef
>>>>>
>>>>> define OFONO_INSTALL_INIT_SYSTEMD
>>>>> mkdir -p $(TARGET_DIR)/etc/systemd/systemd/multi-user.target.wants
>>>>> ln -fs ../../../../usr/lib/systemd/system/ofono.service \
>>>>> $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
>>>>> endef
>>>>>
>>>>> ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
>>>>> OFONO_CONF_OPTS +=3D --enable-udev
>>>>> OFONO_DEPENDENCIES +=3D udev
>>>>> else
>>>>> OFONO_CONF_OPTS +=3D --disable-udev
>>>>> endif
>>>>>
>>>>> ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
>>>>> OFONO_CONF_OPTS +=3D --enable-bluetooth
>>>>> OFONO_DEPENDENCIES +=3D bluez_utils
>>>>> else
>>>>> OFONO_CONF_OPTS +=3D --disable-bluetooth
>>>>> endif
>>>>>
>>>>> $(eval $(autotools-package))
>>>>>
>>>>> I can modify the downloaded oFono source code (plugins and drivers
>>>>> directories) and rebuild it as needed to test the TOBY-R200.
>>>>>
>>>>> $ ls -l output/build/ofono-1.21
>>>>> total 2528
>>>>> -rw-r--r--  1 frank frank    835 Oct  5  2017 acinclude.m4
>>>>> -rw-r--r--  1 frank frank 360491 Oct  5  2017 aclocal.m4
>>>>> -rw-r--r--  1 frank frank   5356 Oct  5  2017 AUTHORS
>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 btio
>>>>> -rw-r--r--  1 frank frank  30811 Oct  5  2017 ChangeLog
>>>>> -rwxr-xr-x  1 frank frank   7333 Oct  5  2017 compile
>>>>> -rwxr-xr-x  1 frank frank  43765 Sep 13 11:39 config.guess
>>>>> -rw-r--r--  1 frank frank   2775 Sep 13 11:39 config.h
>>>>> -rw-r--r--  1 frank frank   2492 Oct  5  2017 config.h.in
>>>>> -rw-r--r--  1 frank frank  42877 Sep 13 11:39 config.log
>>>>> -rwxr-xr-x  1 frank frank  67571 Sep 13 11:39 config.status
>>>>> -rwxr-xr-x  1 frank frank  36171 Sep 13 11:39 config.sub
>>>>> -rwxr-xr-x  1 frank frank 467689 Oct  5  2017 configure
>>>>> -rw-r--r--  1 frank frank   8223 Oct  5  2017 configure.ac
>>>>> -rw-r--r--  1 frank frank  18011 Jul 10  2009 COPYING
>>>>> -rwxr-xr-x  1 frank frank  23566 Oct  5  2017 depcomp
>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 doc
>>>>> drwxr-xr-x 25 frank frank   4096 Oct  5  2017 drivers
>>>>> drwxr-xr-x  2 frank frank   4096 Sep 13 11:39 dundee
>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 examples
>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gatchat
>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gdbus
>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gisi
>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gril
>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 include
>>>>> -rw-r--r--  1 frank frank   9478 Jul 10  2009 INSTALL
>>>>> -rwxr-xr-x  1 frank frank  14431 Oct  5  2017 install-sh
>>>>> -rwxr-xr-x  1 frank frank 294282 Sep 13 11:39 libtool
>>>>> -rw-r--r--  1 frank frank 283940 Sep 13 11:39 ltmain.sh
>>>>> -rw-r--r--  1 frank frank 283672 Oct  5  2017 ltmain.sh.orig
>>>>> -rw-r--r--  1 frank frank 185608 Sep 13 11:39 Makefile
>>>>> -rw-r--r--  1 frank frank  28755 Oct  5  2017 Makefile.am
>>>>> -rw-r--r--  1 frank frank 204311 Oct  5  2017 Makefile.in
>>>>> -rwxr-xr-x  1 frank frank   6872 Oct  5  2017 missing
>>>>> -rw-r--r--  1 frank frank      0 Jul 10  2009 NEWS
>>>>> -rw-r--r--  1 frank frank    310 Sep 13 11:39 ofono.pc
>>>>> -rw-r--r--  1 frank frank    325 Feb  6  2011 ofono.pc.in
>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 plugins
>>>>> -rw-r--r--  1 frank frank    886 Jul 19  2012 README
>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 src
>>>>> -rw-r--r--  1 frank frank     23 Sep 13 11:39 stamp-h1
>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 test
>>>>> -rwxr-xr-x  1 frank frank   4287 Sep 13  2015 test-driver
>>>>> -rw-r--r--  1 frank frank  17996 May  3  2016 TODO
>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 tools
>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 unit
>>>>>
>>>>> Cheers,
>>>>> Frank
>>>>>
>>>>>
>>>>>
>>>>> On Thu, Sep 13, 2018 at 11:48 AM Giacinto Cifelli <gciofono@gmail.c=
om>
>>>>> wrote:
>>>>>
>>>>>> hi Frank,
>>>>>>
>>>>>> your modem doesn't seem to be supported.
>>>>>> There are these models:
>>>>>> SARA_G270 =3D 1102,
>>>>>> TOBYL2_COMPATIBLE_MODE =3D 1141,
>>>>>> TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
>>>>>> TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
>>>>>> If your model is compatible with any of them, I can add  the 1107 for
>>>>>> you for a test.
>>>>>>
>>>>>> from the PID, I would say it should be intermediate between the
>>>>>> SARA_G260 and the TOBYL2_COMPATIBLE_MODE.
>>>>>> Most likely it will work this latter, but maybe not all features...
>>>>>>
>>>>>> Are you willing to test?
>>>>>>
>>>>>> Best regards,
>>>>>> Giacinto
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com>
>>>>>> wrote:
>>>>>>
>>>>>>> Hi Giacinto,
>>>>>>>
>>>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>
>>>>>>> The usbutils version of lsusb is somewhat better.
>>>>>>>
>>>>>>> # lsusb
>>>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>>>> # lsusb -t
>>>>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5=
000M
>>>>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 4=
80M
>>>>>>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>
>>>>>>> And here is a relevant excerpt from lsusb -v.
>>>>>>>
>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>> Device Descriptor:
>>>>>>>   bLength                18
>>>>>>>   bDescriptorType         1
>>>>>>>   bcdUSB               2.00
>>>>>>>   bDeviceClass          239
>>>>>>>   bDeviceSubClass         2
>>>>>>>   bDeviceProtocol         1
>>>>>>>   bMaxPacketSize0        64
>>>>>>>   idVendor           0x1546
>>>>>>>   idProduct          0x1107
>>>>>>>   bcdDevice           17.29
>>>>>>>   iManufacturer           1 u-blox
>>>>>>>   iProduct                2 u-blox Cellular Module
>>>>>>>   iSerial                 3 352848080392646
>>>>>>>   bNumConfigurations      1
>>>>>>>   Configuration Descriptor:
>>>>>>>     bLength                 9
>>>>>>>     bDescriptorType         2
>>>>>>>     wTotalLength          405
>>>>>>>     bNumInterfaces         12
>>>>>>>     bConfigurationValue     1
>>>>>>>     iConfiguration          0
>>>>>>>     bmAttributes         0xe0
>>>>>>>       Self Powered
>>>>>>>       Remote Wakeup
>>>>>>>     MaxPower              100mA
>>>>>>>     Interface Association:
>>>>>>>       bLength                 8
>>>>>>>       bDescriptorType        11
>>>>>>>       bFirstInterface         0
>>>>>>>       bInterfaceCount         2
>>>>>>>       bFunctionClass          2
>>>>>>>       bFunctionSubClass       2
>>>>>>>       bFunctionProtocol       1
>>>>>>>       iFunction               4 CDC ACM
>>>>>>> ...
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Frank
>>>>>>>
>>>>>>>
>>>>>>> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Hi Giacinto,
>>>>>>>>
>>>>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>>
>>>>>>>> # lsusb -t
>>>>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>>>>
>>>>>>>> I am running BusyBox's stripped down version of lsusb that's why
>>>>>>>> information is so lacking.
>>>>>>>> I'll install usbutils on my device's Buildroot image and rerun the
>>>>>>>> commands.
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Frank
>>>>>>>>
>>>>>>>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <
>>>>>>>> gciofono(a)gmail.com> wrote:
>>>>>>>>
>>>>>>>>> hi Frank,
>>>>>>>>>
>>>>>>>>> can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>>>
>>>>>>>>> Giacinto
>>>>>>>>>
>>>>>>>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com>
>>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>> Greetings,
>>>>>>>>>>
>>>>>>>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want
>>>>>>>>>> to use connman to manage any cellular connection on that modem s=
ince
>>>>>>>>>> connman is already managing ethernet and wifi connectivity.  oFo=
no seems
>>>>>>>>>> like the best option.  I see that there is already a ublox plugi=
n for oFono
>>>>>>>>>> but I don't think the TOBY-R200 is supported.  The cell module i=
s soldered
>>>>>>>>>> onto the board and appears as a USB device.
>>>>>>>>>>
>>>>>>>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1, Product=
=3D2,
>>>>>>>>>> SerialNumber=3D3
>>>>>>>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>>>>>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>>>>>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>>>>>>>
>>>>>>>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>>>>>>>
>>>>>>>>>> Cheers,
>>>>>>>>>> Frank
>>>>>>>>>> _______________________________________________
>>>>>>>>>> ofono mailing list
>>>>>>>>>> ofono(a)ofono.org
>>>>>>>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>>>>>>>
>>>>>>>>>

--===============2897685241108312726==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgRnJhbmssPGRpdj48YnI+PC9kaXY+PGRpdj5pcyBpdCB3b3JraW5n
PyBJIGhhZCBhIGxvb2sgYXQgdWJsb3ggc3BlY2lmaWNhdGlvbiwgYW5kIEkgdGhpbmsgeW91IG5l
ZWQgc29tZSBtb3JlIHN1cHBvcnQgaW4gb2Zvbm8gZm9yIGVzdGFibGlzaGluZyB0aGUgTFRFIGRl
ZmF1bHQgYmVhcmVyLjwvZGl2PjxkaXY+SSB3aWxsIHRha2UgdGhpcyBiYWNrIG9uY2UgSSBoYXZl
IHN1Ym1pdHRlZCBzb21lIHBhdGNoZXMgZm9yIHRoaXMgc3VwcG9ydCAoYW5kIGhhdmUgYmVlbiBh
Y2NlcHRlZCkuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMsPC9kaXY+PGRp
dj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gU2F0LCBTZXAgMTUsIDIwMTggYXQgODozMSBBTSBH
aWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIj5n
Y2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+SGkgRnJhbmssPGRp
dj48YnI+PC9kaXY+PGRpdj5JIGFtIGhhcHB5IHRoYXQgaXQgc3RhcnRlZCB3b3JraW5nLjwvZGl2
PjxkaXY+UmV2aWV3aW5nIHlvdXIgZW1haWwsIEkgZG91YnRlZCB0aGF0IGl0IHdhcyBtb3JlIGEg
Y29uZmlndXJlIHBhcmFtZXRlcnMgaXNzdWUuPC9kaXY+PGRpdj5UaGUgcmVzdCBiZWxvdywgSSBz
aGFsbCBub3QgdG9wLXBvc3QgaW4gdGhpcyBkaXN0cmlidXRpb24gbGlzdC48L2Rpdj48ZGl2Pjxi
cj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gU2F0LCBTZXAgMTUs
IDIwMTggYXQgMjo1NCBBTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2
QGhlbGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdy
b3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5IaSBHaWFjaW50
byw8ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYXBwbGllZCB5b3VyIHBhdGNoIGZvciB0aGUgVE9CWS1S
MjAwIGFuZCB0aGUgcmVzdWx0cyBsb29rIHZlcnkgcHJvbWlzaW5nLjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGRpdj4jIC4vbGlzdC1tb2RlbXPCoDwvZGl2PjxkaXY+WyAvdWJsb3hfMCBdPC9k
aXY+PGRpdj7CoCDCoCBPbmxpbmUgPSAxPC9kaXY+PGRpdj7CoCDCoCBQb3dlcmVkID0gMTwvZGl2
PjxkaXY+wqAgwqAgTG9ja2Rvd24gPSAwPC9kaXY+PGRpdj7CoCDCoCBFbWVyZ2VuY3kgPSAwPC9k
aXY+PGRpdj7CoCDCoCBNYW51ZmFjdHVyZXIgPSB1LWJsb3g8L2Rpdj48ZGl2PsKgIMKgIE1vZGVs
ID0gVE9CWS1SMjAwPC9kaXY+PGRpdj7CoCDCoCBSZXZpc2lvbiA9IDMwLjMxPC9kaXY+PGRpdj7C
oCDCoCBTZXJpYWwgPSAzNTI4NDgwODAzOTI2NDY8L2Rpdj48ZGl2PsKgIMKgIEludGVyZmFjZXMg
PSBvcmcub2Zvbm8uTmV0d29ya1JlZ2lzdHJhdGlvbiBvcmcub2Zvbm8uTmV0d29ya01vbml0b3Ig
b3JnLm9mb25vLkNvbm5lY3Rpb25NYW5hZ2VyIG9yZy5vZm9uby5Mb25nVGVybUV2b2x1dGlvbiBv
cmcub2Zvbm8uQWxsb3dlZEFjY2Vzc1BvaW50cyBvcmcub2Zvbm8uVm9pY2VDYWxsTWFuYWdlciBv
cmcub2Zvbm8uU2ltTWFuYWdlcsKgPC9kaXY+PGRpdj7CoCDCoCBGZWF0dXJlcyA9IG5ldCBncHJz
IHNpbcKgPC9kaXY+PGRpdj7CoCDCoCBUeXBlID0gaGFyZHdhcmU8L2Rpdj48ZGl2PsKgIMKgIFsg
b3JnLm9mb25vLk5ldHdvcmtSZWdpc3RyYXRpb24gXTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Rh
dHVzID0gc2VhcmNoaW5nPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBNb2RlID0gYXV0bzwvZGl2Pjxk
aXY+wqAgwqAgwqAgwqAgTmFtZSA9wqA8L2Rpdj48ZGl2PsKgIMKgIFsgb3JnLm9mb25vLk5ldHdv
cmtNb25pdG9yIF08L2Rpdj48ZGl2PsKgIMKgIFsgb3JnLm9mb25vLkNvbm5lY3Rpb25NYW5hZ2Vy
IF08L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEF0dGFjaGVkID0gMDwvZGl2PjxkaXY+wqAgwqAgwqAg
wqAgQmVhcmVyID0gbm9uZTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgUm9hbWluZ0FsbG93ZWQgPSAw
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBQb3dlcmVkID0gMTwvZGl2PjxkaXY+wqAgwqAgWyBvcmcu
b2Zvbm8uTG9uZ1Rlcm1Fdm9sdXRpb24gXTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgRGVmYXVsdEFj
Y2Vzc1BvaW50TmFtZSA9wqA8L2Rpdj48ZGl2PsKgIMKgIFsgb3JnLm9mb25vLkFsbG93ZWRBY2Nl
c3NQb2ludHMgXTwvZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8uVm9pY2VDYWxsTWFuYWdlciBd
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBFbWVyZ2VuY3lOdW1iZXJzID0gMTEyIDkxMcKgPC9kaXY+
PGRpdj7CoCDCoCBbIG9yZy5vZm9uby5TaW1NYW5hZ2VyIF08L2Rpdj48ZGl2PsKgIMKgIMKgIMKg
IFByZXNlbnQgPSAxPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBDYXJkSWRlbnRpZmllciA9IDg5NDQ1
MDEwMTExNzYwOTkxNzY8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFN1YnNjcmliZXJJZGVudGl0eSA9
IDIzNDUwNzA5ODYwOTkxNzwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU2VydmljZVByb3ZpZGVyTmFt
ZSA9IEhvbG9ncmFtPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBGaXhlZERpYWxpbmcgPSAwPC9kaXY+
PGRpdj7CoCDCoCDCoCDCoCBCYXJyZWREaWFsaW5nID0gMDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAg
TW9iaWxlQ291bnRyeUNvZGUgPSAyMzQ8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIE1vYmlsZU5ldHdv
cmtDb2RlID0gNTA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFN1YnNjcmliZXJOdW1iZXJzID3CoDwv
ZGl2PjxkaXY+wqAgwqAgwqAgwqAgTG9ja2VkUGlucyA9wqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKg
IFByZWZlcnJlZExhbmd1YWdlcyA9IGVuwqA8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFBpblJlcXVp
cmVkID0gbm9uZTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgUmV0cmllcyA9IFtwaW4gPSAzXSBbcGlu
MiA9IDNdIFtwdWsgPSAxMF0gW3B1azIgPSAxMF08L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PjxkaXY+IyAuL2VuYWJsZS1tb2RlbcKgPC9kaXY+PGRpdj5Db25uZWN0aW5nIG1vZGVtIC91
YmxveF8wLi4uPC9kaXY+PGRpdj4jIC4vY3JlYXRlLWludGVybmV0LWNvbnRleHQgaG9sb2dyYW08
L2Rpdj48ZGl2PkZvdW5kIGNvbnRleHQgL3VibG94XzAvY29udGV4dDE8L2Rpdj48ZGl2PlNldHRp
bmcgQVBOIHRvIGhvbG9ncmFtPC9kaXY+PGRpdj4jIC4vb25saW5lLW1vZGVtPC9kaXY+PGRpdj5T
ZXR0aW5nIG1vZGVtIC91YmxveF8wIG9ubGluZS4uLjwvZGl2PjxkaXY+IyAuL2FjdGl2YXRlLWNv
bnRleHTCoDwvZGl2PjxkaXY+RXJyb3IgYWN0aXZhdGluZyAvdWJsb3hfMC9jb250ZXh0MTogb3Jn
Lm9mb25vLkVycm9yLk5vdEF0dGFjaGVkOiBHUFJTIGlzIG5vdCBhdHRhY2hlZDwvZGl2PjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48
L2Rpdj48ZGl2PkhhdmUgeW91IGNvbm5lY3RlZCB5b3VyIGFudGVubmFzIHByb3Blcmx5PyBIYXZl
IHlvdSB3YWl0ZWQgc29tZSAyIG1pbnV0ZXMgYmVmb3JlIHRyeWluZyB0aGUgLi9hY3RpdmF0ZS1j
b250ZXh0ID88L2Rpdj48ZGl2PklmIHllcywgdGhlbiB0aGlzIG1vZHVsZSByZXBvcnRzIGl0cyBh
dHRhY2ggc3RhdHVzIHdpdGggc29tZSBpbmRpY2F0b3Igbm90IHJlY29nbml6ZWQgYnkgb2Zvbm8g
dG9kYXkgKGJsaW5kIHNob3Q6wqArQ0VSRUcpLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqA8
YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj48L2Rpdj48ZGl2
PkFzIHlvdSBjYW4gc2VlIEkgd2FzIHVuYWJsZSB0byBhY3RpdmF0ZS1jb250ZXh0IGJ1dCBJIGdv
dCBwcmV0dHkgY2xvc2UuwqAgSSYjMzk7bSB3aWxsaW5nIHRvIGFwcGx5IG1vcmUgY29kZSBjaGFu
Z2VzIGlmIGl0IG1lYW5zIEkgY2FuIGdldCBjZWxsdWxhciBpbnRlZ3JhdGlvbiB3aXRoIGNvbm5t
YW4uPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2Pjxk
aXY+SW4gZ2VuZXJhbCBJIHRlc3Qgb24gVWJ1bnR1IHdpdGggZC1mZWVkLCBzbyBJIGRvbiYjMzk7
dCBrbm93IGFsbCB0aGUgdGVzdCBzY3JpcHRzLCBidXQgdGhlcmUgc2hvdWxkIGJlIHNvbWUgdG8g
Y2hlY2sgd2hldGhlciB0aGUgbW9kZW0gaXMgcmVwb3J0ZWQgcmVnaXN0ZXJlZCwgdG8gd2hpY2gg
dGVjaG5vbG9neSwgd2hhdCB0aGUgc2lnbmFsIHN0cmVuZ3RoIGlzLCBhbmQgaWYgaXQgaXMgcmVw
b3J0ZWQgYXR0YWNoZWQuPC9kaXY+PGRpdj5JZiBpdCBpcyByZWdpc3RlcmVkIHRvIExURSwgaXQg
aXMgYXR0YWNoZWQsIGJ1dCBvZm9ubyBkb2VzbiYjMzk7dCByZWNvZ25pemUgaXQgYXV0b21hdGlj
YWxseSBieSByYWRpbyB0ZWNobm9sb2d5LCBpdCBuZWVkcyBhIHNlcGFyYXRlIGluZGljYXRvci48
L2Rpdj48ZGl2PsKgPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxk
aXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48L2Rpdj48L2Rp
dj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRo
dSwgU2VwIDEzLCAyMDE4IGF0IDk6MTkgUE0gR2lhY2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmdjaW9mb25vQGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5IaSBGcmFuayw8ZGl2Pjxicj48L2Rpdj48
ZGl2PmJvdGjCoDxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPlRPQllMMl9DT01QQVRJ
QkxFX01PREUgYW5kwqA8L3NwYW4+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+wqA8
L3NwYW4+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+VE9CWUwyX0hJR0hfVEhST1VH
SFBVVF9NT0RFIGJlaGF2ZSB0aGUgc2FtZSBpbiB0aGUgY29kZS48L3NwYW4+PC9kaXY+PGRpdj48
c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj4oPC9zcGFuPjxzcGFuIHN0eWxlPSJjb2xv
cjpyZ2IoODAsMCw4MCkiPlRPQllMMl9NRURJVU1fVEhST1VHSFBVVF9NT0RFIGlzIHJlY29nbml6
ZWQgYnV0IGRpc2NhcmRlZCBsYXRlciBpbiB0aGUgY29kZSk8L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5QbGVhc2UgcmVwbGFjZSB0aGUgdHdvIGF0dGFj
aGVkIGZpbGVzIGluIHRoZSBwbHVnaW5zIGRpcmVjdG9yeS48L3NwYW4+PC9kaXY+PGRpdj48c3Bh
biBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5MZXQgbWUga25vdyBpZiBpdCB3b3JrcyAoaXQg
d291bGQgYmUgZ29vZCB0byBrbm93IHdoaWNoIGZ1bmN0aW9uYWxpdGllcyB5b3UgdHJ5IG91dCks
IGFuZCBpZiBzbyBJIGNhbiBzdWJtaXQgdGhlIGNoYW5nZXMgYXMgcGF0Y2hlcy48L3NwYW4+PC9k
aXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj48YnI+PC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+WW91IGRvbiYjMzk7dCBuZWVk
IHRoZSB1ZGV2IHJ1bGUgZm9yIHVzYiBtb2RlbXMsIGl0IGlzIHJlY29nbml6ZWQgYXV0b21hdGlj
YWxseS48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj48
YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+QmVz
dCBSZWdhcmRzLDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4
MCkiPkdpYWNpbnRvPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCww
LDgwKSI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4
MCkiPjxicj48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODAp
Ij48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+
PGJyPjwvc3Bhbj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYg
ZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDEwOjUxIFBNIEZyYW5rIFZhc3F1ZXog
Jmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZAaGVsaXVtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZy
YW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPkhpIEdpYW5jaXRvLDxkaXY+PGJyPjwvZGl2
PjxkaXY+SSBtb2RpZmllZCB1YmxveC5jIGFzIGZvbGxvd3MuPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48ZGl2PmVudW0gc3VwcG9ydGVkX21vZGVscyB7PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBT
QVJBX0cyNzDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoD0gMTEwMiw8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIFRPQllMMl9DT01QQVRJQkxFX01PREXCoCDCoCDCoCDCoCDCoCA9IDEx
NDEsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBUT0JZTDJfTUVESVVNX1RIUk9VR0hQVVRfTU9ERcKg
IMKgPSAxMTQzLDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgVE9CWUwyX0hJR0hfVEhST1VHSFBVVF9N
T0RFwqAgwqAgwqA9IDExMDcswqAgLyogd2FzIDExNDYgKi88L2Rpdj48ZGl2Pn07PC9kaXY+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbmQgc3RpbGwgbm8gbHVjay48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PjxkaXY+IyAuL2xpc3QtbW9kZW1zwqA8L2Rpdj48ZGl2PiM8L2Rpdj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2VlIG5vIGV2aWRlbmNlIHRoYXQgb0Zvbm8mIzM5O3MgdWJs
b3ggZHJpdmVyIGlzIGJlaW5nIGxvYWRlZCBldmVuIHRob3VnaCBJIGFkZGVkIHRoZSBmb2xsb3dp
bmcgbGluZSB0byA2MC1zZXJpYWwtcnVsZXMgaW4gL2V0Yy91ZGV2L3J1bGVzLmQvNjAtc2VyaWFs
LXJ1bGVzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+S0VSTkVMPT0mcXVvdDt0dHlBQ00wJnF1
b3Q7LCBFTlZ7T0ZPTk9fRFJJVkVSfT0mcXVvdDt1YmxveCZxdW90Ozxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pkkgd2FudCBUT0JZTDJfSElHSF9USFJPVUdIUFVUX01PREUgYmVjYXVzZSB0
aGF0JiMzOTtzIHRoZSBtb2RlIHRoYXQgdXNlcyBMVEUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2
PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+
T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTI6MTggUE0gRnJhbmsgVmFzcXVleiAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1
bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1
b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7
cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9
Imx0ciI+SGkgR2lhY2ludG8sPGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgVE9CWS1SMjAwIGlzIGFu
IExURSBtb2R1bGUuwqAgSSBzZWUgdGhhdCB0aGUgdWJsb3ggb0Zvbm8gcGx1Z2luIHN1cHBvcnRz
IExURSBvbiB0aGUgVE9CWS1MMiBzbyBtYXliZSBpdCB3aWxsIHdvcmsgb24gdGhlIFRPQlktUjIw
MCBhcyB3ZWxsLsKgIEkgdGhpbmsgbWFueSBvZiB0aGUgQVQgY29tbWFuZHMgYXJlIHRoZSBzYW1l
IGFjcm9zcyB1YmxveCBjZWxsdWxhciBtb2RlbXMgc28geWVzIGxldCYjMzk7cyBnaXZlIHRlc3Rp
bmcgYSBzaG90LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhbSB1c2luZyBCdWlsZHJvb3Qg
dG8gYnVpbGQgb0Zvbm8gZm9yIG15IExpbnV4IGRldmljZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PjxkaXY+IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyM8L2Rpdj48ZGl2PiM8L2Rpdj48ZGl2PiMg
b2Zvbm88L2Rpdj48ZGl2PiM8L2Rpdj48ZGl2PiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5PRk9OT19WRVJTSU9OID0gMS4yMTwvZGl2PjxkaXY+T0ZPTk9f
U09VUkNFID0gb2Zvbm8tJChPRk9OT19WRVJTSU9OKS50YXIueHo8L2Rpdj48ZGl2Pk9GT05PX1NJ
VEUgPSAkKEJSMl9LRVJORUxfTUlSUk9SKS9saW51eC9uZXR3b3JrL29mb25vPC9kaXY+PGRpdj5P
Rk9OT19MSUNFTlNFID0gR1BMLTIuMDwvZGl2PjxkaXY+T0ZPTk9fTElDRU5TRV9GSUxFUyA9IENP
UFlJTkc8L2Rpdj48ZGl2Pk9GT05PX0RFUEVOREVOQ0lFUyA9IFw8L2Rpdj48ZGl2PjxzcGFuIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5ob3N0LXBrZ2NvbmYgXDwvZGl2Pjxk
aXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmRidXMgXDwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmxpYmdsaWIy
IFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5s
aWJjYXAtbmcgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4J
PC9zcGFuPm1vYmlsZS1icm9hZGJhbmQtcHJvdmlkZXItaW5mbzwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+T0ZPTk9fQ09ORl9PUFRTID0gXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNw
YWNlOnByZS13cmFwIj4JPC9zcGFuPi0tZGlzYWJsZS10ZXN0IFw8L2Rpdj48ZGl2PjxzcGFuIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj4tLXdpdGgtZGJ1c2NvbmZkaXI9L2V0
YyBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+
JChpZiAkKEJSMl9JTklUX1NZU1RFTUQpLC0td2l0aC1zeXN0ZW1kdW5pdGRpcj0vdXNyL2xpYi9z
eXN0ZW1kL3N5c3RlbSk8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiMgTi5CLiBRdWFsY29tbSBR
TUkgbW9kZW0gc3VwcG9ydCByZXF1aXJlcyBPX0NMT0VYRUM7IHNvPC9kaXY+PGRpdj4jIG1ha2Ug
c3VyZSB0aGF0IGl0IGlzIGRlZmluZWQuPC9kaXY+PGRpdj5PRk9OT19DT05GX0VOViArPSBDRkxB
R1M9JnF1b3Q7JChUQVJHRVRfQ0ZMQUdTKSAtRF9HTlVfU09VUkNFJnF1b3Q7PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5kZWZpbmUgT0ZPTk9fSU5TVEFMTF9JTklUX1NZU1Y8L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj4kKElOU1RBTEwpIC1tIDA3
NTUgLUQgcGFja2FnZS9vZm9uby9TNDZvZm9ubyAkKFRBUkdFVF9ESVIpL2V0Yy9pbml0LmQvUzQ2
b2Zvbm88L2Rpdj48ZGl2PmVuZGVmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5kZWZpbmUgT0ZP
Tk9fSU5TVEFMTF9JTklUX1NZU1RFTUQ8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUtd3JhcCI+CTwvc3Bhbj5ta2RpciAtcCAkKFRBUkdFVF9ESVIpL2V0Yy9zeXN0ZW1kL3N5
c3RlbWQvbXVsdGktdXNlci50YXJnZXQud2FudHM8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5sbiAtZnMgLi4vLi4vLi4vLi4vdXNyL2xpYi9zeXN0
ZW1kL3N5c3RlbS9vZm9uby5zZXJ2aWNlIFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUtd3JhcCI+CQk8L3NwYW4+JChUQVJHRVRfRElSKS9ldGMvc3lzdGVtZC9zeXN0ZW0v
bXVsdGktdXNlci50YXJnZXQud2FudHM8L2Rpdj48ZGl2PmVuZGVmPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5pZmVxICgkKEJSMl9QQUNLQUdFX0hBU19VREVWKSx5KTwvZGl2PjxkaXY+T0ZPTk9f
Q09ORl9PUFRTICs9IC0tZW5hYmxlLXVkZXY8L2Rpdj48ZGl2Pk9GT05PX0RFUEVOREVOQ0lFUyAr
PSB1ZGV2PC9kaXY+PGRpdj5lbHNlPC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgKz0gLS1kaXNh
YmxlLXVkZXY8L2Rpdj48ZGl2PmVuZGlmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pZmVxICgk
KEJSMl9QQUNLQUdFX0JMVUVaX1VUSUxTKSx5KTwvZGl2PjxkaXY+T0ZPTk9fQ09ORl9PUFRTICs9
IC0tZW5hYmxlLWJsdWV0b290aDwvZGl2PjxkaXY+T0ZPTk9fREVQRU5ERU5DSUVTICs9IGJsdWV6
X3V0aWxzPC9kaXY+PGRpdj5lbHNlPC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgKz0gLS1kaXNh
YmxlLWJsdWV0b290aDwvZGl2PjxkaXY+ZW5kaWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiQo
ZXZhbCAkKGF1dG90b29scy1wYWNrYWdlKSk8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkkgY2FuIG1vZGlmeSB0aGUgZG93bmxvYWRlZCBvRm9ubyBzb3VyY2UgY29kZSAocGx1Z2lucyBh
bmQgZHJpdmVycyBkaXJlY3RvcmllcykgYW5kIHJlYnVpbGQgaXQgYXMgbmVlZGVkIHRvIHRlc3Qg
dGhlIFRPQlktUjIwMC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+JCBscyAtbCBvdXRw
dXQvYnVpbGQvb2Zvbm8tMS4yMTwvZGl2PjxkaXY+dG90YWwgMjUyODwvZGl2PjxkaXY+LXJ3LXIt
LXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoCA4MzUgT2N0wqAgNcKgIDIwMTcgYWNpbmNsdWRlLm00
PC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFuayAzNjA0OTEgT2N0wqAgNcKgIDIw
MTcgYWNsb2NhbC5tNDwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDCoDUz
NTYgT2N0wqAgNcKgIDIwMTcgQVVUSE9SUzwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsg
ZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgYnRpbzwvZGl2PjxkaXY+LXJ3LXItLXItLcKg
IDEgZnJhbmsgZnJhbmvCoCAzMDgxMSBPY3TCoCA1wqAgMjAxNyBDaGFuZ2VMb2c8L2Rpdj48ZGl2
Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgwqA3MzMzIE9jdMKgIDXCoCAyMDE3IGNvbXBp
bGU8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgNDM3NjUgU2VwIDEzIDEx
OjM5IGNvbmZpZy5ndWVzczwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCDC
oDI3NzUgU2VwIDEzIDExOjM5IGNvbmZpZy5oPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFu
ayBmcmFua8KgIMKgMjQ5MiBPY3TCoCA1wqAgMjAxNyA8YSBocmVmPSJodHRwOi8vY29uZmlnLmgu
aW4iIHRhcmdldD0iX2JsYW5rIj5jb25maWcuaC5pbjwvYT48L2Rpdj48ZGl2Pi1ydy1yLS1yLS3C
oCAxIGZyYW5rIGZyYW5rwqAgNDI4NzcgU2VwIDEzIDExOjM5IGNvbmZpZy5sb2c8L2Rpdj48ZGl2
Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgNjc1NzEgU2VwIDEzIDExOjM5IGNvbmZpZy5z
dGF0dXM8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rwqAgMzYxNzEgU2VwIDEz
IDExOjM5IGNvbmZpZy5zdWI8L2Rpdj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rIDQ2
NzY4OSBPY3TCoCA1wqAgMjAxNyBjb25maWd1cmU8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZy
YW5rIGZyYW5rwqAgwqA4MjIzIE9jdMKgIDXCoCAyMDE3IDxhIGhyZWY9Imh0dHA6Ly9jb25maWd1
cmUuYWMiIHRhcmdldD0iX2JsYW5rIj5jb25maWd1cmUuYWM8L2E+PC9kaXY+PGRpdj4tcnctci0t
ci0twqAgMSBmcmFuayBmcmFua8KgIDE4MDExIEp1bCAxMMKgIDIwMDkgQ09QWUlORzwvZGl2Pjxk
aXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCAyMzU2NiBPY3TCoCA1wqAgMjAxNyBkZXBj
b21wPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1
wqAgMjAxNyBkb2M8L2Rpdj48ZGl2PmRyd3hyLXhyLXggMjUgZnJhbmsgZnJhbmvCoCDCoDQwOTYg
T2N0wqAgNcKgIDIwMTcgZHJpdmVyczwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIgZnJhbmsgZnJh
bmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IGR1bmRlZTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDIg
ZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgZXhhbXBsZXM8L2Rpdj48ZGl2PmRy
d3hyLXhyLXjCoCA0IGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBnYXRjaGF0PC9k
aXY+PGRpdj5kcnd4ci14ci14wqAgNCBmcmFuayBmcmFua8KgIMKgNDA5NiBTZXAgMTMgMTE6Mzkg
Z2RidXM8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAx
MyAxMTozOSBnaXNpPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMyBmcmFuayBmcmFua8KgIMKgNDA5
NiBTZXAgMTMgMTE6MzkgZ3JpbDwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsgZnJhbmvC
oCDCoDQwOTYgU2VwIDEzIDExOjM5IGluY2x1ZGU8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZy
YW5rIGZyYW5rwqAgwqA5NDc4IEp1bCAxMMKgIDIwMDkgSU5TVEFMTDwvZGl2PjxkaXY+LXJ3eHIt
eHIteMKgIDEgZnJhbmsgZnJhbmvCoCAxNDQzMSBPY3TCoCA1wqAgMjAxNyBpbnN0YWxsLXNoPC9k
aXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFuayAyOTQyODIgU2VwIDEzIDExOjM5IGxp
YnRvb2w8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rIDI4Mzk0MCBTZXAgMTMg
MTE6MzkgbHRtYWluLnNoPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFuayAyODM2
NzIgT2N0wqAgNcKgIDIwMTcgbHRtYWluLnNoLm9yaWc8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAx
IGZyYW5rIGZyYW5rIDE4NTYwOCBTZXAgMTMgMTE6MzkgTWFrZWZpbGU8L2Rpdj48ZGl2Pi1ydy1y
LS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgMjg3NTUgT2N0wqAgNcKgIDIwMTcgTWFrZWZpbGUuYW08
L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rIDIwNDMxMSBPY3TCoCA1wqAgMjAx
NyBNYWtlZmlsZS5pbjwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCDCoDY4
NzIgT2N0wqAgNcKgIDIwMTcgbWlzc2luZzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsg
ZnJhbmvCoCDCoCDCoCAwIEp1bCAxMMKgIDIwMDkgTkVXUzwvZGl2PjxkaXY+LXJ3LXItLXItLcKg
IDEgZnJhbmsgZnJhbmvCoCDCoCAzMTAgU2VwIDEzIDExOjM5IG9mb25vLnBjPC9kaXY+PGRpdj4t
cnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDMyNSBGZWLCoCA2wqAgMjAxMSA8YSBocmVm
PSJodHRwOi8vb2Zvbm8ucGMuaW4iIHRhcmdldD0iX2JsYW5rIj5vZm9uby5wYy5pbjwvYT48L2Rp
dj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBw
bHVnaW5zPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDg4NiBKdWwg
MTnCoCAyMDEyIFJFQURNRTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDC
oDQwOTYgU2VwIDEzIDExOjM5IHNyYzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJh
bmvCoCDCoCDCoDIzIFNlcCAxMyAxMTozOSBzdGFtcC1oMTwvZGl2PjxkaXY+ZHJ3eHIteHIteMKg
IDIgZnJhbmsgZnJhbmvCoCDCoDQwOTYgT2N0wqAgNcKgIDIwMTcgdGVzdDwvZGl2PjxkaXY+LXJ3
eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCDCoDQyODcgU2VwIDEzwqAgMjAxNSB0ZXN0LWRyaXZl
cjwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmvCoCAxNzk5NiBNYXnCoCAzwqAg
MjAxNiBUT0RPPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMiBmcmFuayBmcmFua8KgIMKgNDA5NiBP
Y3TCoCA1wqAgMjAxNyB0b29sczwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDQgZnJhbmsgZnJhbmvC
oCDCoDQwOTYgU2VwIDEzIDExOjM5IHVuaXQ8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRp
cj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAxMTo0OCBBTSBHaWFjaW50byBDaWZlbGxp
ICZsdDs8YSBocmVmPSJtYWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFw
eCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJs
dHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGly
PSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPmhpIEZyYW5rLDxkaXY+PGJyPjwv
ZGl2PjxkaXY+eW91ciBtb2RlbSBkb2VzbiYjMzk7dCBzZWVtIHRvIGJlIHN1cHBvcnRlZC48L2Rp
dj48ZGl2PlRoZXJlIGFyZSB0aGVzZSBtb2RlbHM6PC9kaXY+PGRpdj48ZGl2PjxkaXY+PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPlNBUkFfRzI3MDxzcGFuIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CQkJPC9zcGFuPj0gMTEwMiw8L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj5UT0JZTDJfQ09NUEFUSUJMRV9N
T0RFPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCTwvc3Bhbj49IDExNDEsPGJy
PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPlRP
QllMMl9NRURJVU1fVEhST1VHSFBVVF9NT0RFPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13
cmFwIj4JPC9zcGFuPj0gMTE0Myw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUtd3JhcCI+CTwvc3Bhbj5UT0JZTDJfSElHSF9USFJPVUdIUFVUX01PREU8c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+PSAxMTQ2LDwvZGl2PjwvZGl2PjxkaXY+SWYg
eW91ciBtb2RlbCBpcyBjb21wYXRpYmxlIHdpdGggYW55IG9mIHRoZW0sIEkgY2FuIGFkZMKgIHRo
ZSAxMTA3IGZvciB5b3UgZm9yIGEgdGVzdC48YnI+PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5mcm9tIHRoZSBQSUQsIEkgd291bGQgc2F5IGl0IHNob3VsZCBiZSBpbnRlcm1lZGlhdGUg
YmV0d2VlbiB0aGUgU0FSQV9HMjYwIGFuZCB0aGUgVE9CWUwyX0NPTVBBVElCTEVfTU9ERS48L2Rp
dj48ZGl2Pk1vc3QgbGlrZWx5IGl0IHdpbGwgd29yayB0aGlzIGxhdHRlciwgYnV0IG1heWJlIG5v
dCBhbGwgZmVhdHVyZXMuLi48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFyZSB5b3Ugd2lsbGlu
ZyB0byB0ZXN0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDwvZGl2Pjxk
aXY+R2lhY2ludG88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rp
dj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDc6NDggUE0g
RnJhbmsgVmFzcXVleiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJn
ZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+
PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+SGkgR2lhY2ludG8sPC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2PjxkaXYgZGlyPSJs
dHIiPiZndDvCoDxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPmNhbiB5b3Ugc2VuZCB0
aGUgcmVzdWx0IG9mICZxdW90O2xzdXNiJnF1b3Q7IGFuZCAmcXVvdDtsc3VzYiAtdCZxdW90Oz88
L3NwYW4+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2PjxkaXYgZGlyPSJsdHIiPlRoZSB1
c2J1dGlscyB2ZXJzaW9uIG9mIGxzdXNiIGlzIHNvbWV3aGF0IGJldHRlci48L2Rpdj48ZGl2IGRp
cj0ibHRyIj48YnI+PGRpdj48ZGl2PiMgbHN1c2I8L2Rpdj48ZGl2PkJ1cyAwMDIgRGV2aWNlIDAw
MTogSUQgMWQ2YjowMDAzwqDCoDwvZGl2PjxkaXY+QnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAxNTQ2
OjExMDfCoMKgPC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDE6IElEIDFkNmI6MDAwMsKgwqA8
L2Rpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2Pi86wqAgQnVzIDAyLlBvcnQgMTogRGV2IDEs
IENsYXNzPXJvb3RfaHViLCBEcml2ZXI9eGhjaS1oY2QvMXAsIDUwMDBNPC9kaXY+PGRpdj4vOsKg
IEJ1cyAwMS5Qb3J0IDE6IERldiAxLCBDbGFzcz1yb290X2h1YiwgRHJpdmVyPXhoY2ktaGNkLzFw
LCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMCwgQ2xhc3M9LCBE
cml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElm
IDEsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0
IDE6IERldiAyLCBJZiAyLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7C
oCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgMywgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgw
TTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDQsIENsYXNzPSwgRHJpdmVy
PWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA1LCBD
bGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBE
ZXYgMiwgSWYgNiwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAg
fF9fIFBvcnQgMTogRGV2IDIsIElmIDcsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rp
dj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA4LCBDbGFzcz0sIERyaXZlcj1jZGNf
YWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgOSwgQ2xhc3M9
LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIs
IElmIDEwLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18g
UG9ydCAxOiBEZXYgMiwgSWYgMTEsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBoZXJlIGlzIGEgcmVsZXZhbnQgZXhjZXJwdCBm
cm9tIGxzdXNiIC12LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5CdXMgMDAxIERldmlj
ZSAwMDI6IElEIDE1NDY6MTEwNzwvZGl2PjxkaXY+RGV2aWNlIERlc2NyaXB0b3I6PC9kaXY+PGRp
dj7CoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTg8L2Rpdj48ZGl2PsKgIGJEZXNj
cmlwdG9yVHlwZcKgIMKgIMKgIMKgIMKgMTwvZGl2PjxkaXY+wqAgYmNkVVNCwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAyLjAwPC9kaXY+PGRpdj7CoCBiRGV2aWNlQ2xhc3PCoCDCoCDCoCDCoCDCoCAy
Mzk8L2Rpdj48ZGl2PsKgIGJEZXZpY2VTdWJDbGFzc8KgIMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+
wqAgYkRldmljZVByb3RvY29swqAgwqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCBiTWF4UGFja2V0
U2l6ZTDCoCDCoCDCoCDCoCA2NDwvZGl2PjxkaXY+wqAgaWRWZW5kb3LCoCDCoCDCoCDCoCDCoCDC
oDB4MTU0NjwvZGl2PjxkaXY+wqAgaWRQcm9kdWN0wqAgwqAgwqAgwqAgwqAgMHgxMTA3PC9kaXY+
PGRpdj7CoCBiY2REZXZpY2XCoCDCoCDCoCDCoCDCoCDCoDE3LjI5PC9kaXY+PGRpdj7CoCBpTWFu
dWZhY3R1cmVywqAgwqAgwqAgwqAgwqAgwqAxIHUtYmxveDwvZGl2PjxkaXY+wqAgaVByb2R1Y3TC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAyIHUtYmxveCBDZWxsdWxhciBNb2R1bGU8L2Rpdj48ZGl2
PsKgIGlTZXJpYWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDMgMzUyODQ4MDgwMzkyNjQ2PC9k
aXY+PGRpdj7CoCBiTnVtQ29uZmlndXJhdGlvbnPCoCDCoCDCoCAxPC9kaXY+PGRpdj7CoCBDb25m
aWd1cmF0aW9uIERlc2NyaXB0b3I6PC9kaXY+PGRpdj7CoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqA5PC9kaXY+PGRpdj7CoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDC
oCDCoDI8L2Rpdj48ZGl2PsKgIMKgIHdUb3RhbExlbmd0aMKgIMKgIMKgIMKgIMKgIDQwNTwvZGl2
PjxkaXY+wqAgwqAgYk51bUludGVyZmFjZXPCoCDCoCDCoCDCoCDCoDEyPC9kaXY+PGRpdj7CoCDC
oCBiQ29uZmlndXJhdGlvblZhbHVlwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCDCoCBpQ29uZmlndXJh
dGlvbsKgIMKgIMKgIMKgIMKgIDA8L2Rpdj48ZGl2PsKgIMKgIGJtQXR0cmlidXRlc8KgIMKgIMKg
IMKgIMKgMHhlMDwvZGl2PjxkaXY+wqAgwqAgwqAgU2VsZiBQb3dlcmVkPC9kaXY+PGRpdj7CoCDC
oCDCoCBSZW1vdGUgV2FrZXVwPC9kaXY+PGRpdj7CoCDCoCBNYXhQb3dlcsKgIMKgIMKgIMKgIMKg
IMKgIMKgIDEwMG1BPC9kaXY+PGRpdj7CoCDCoCBJbnRlcmZhY2UgQXNzb2NpYXRpb246PC9kaXY+
PGRpdj7CoCDCoCDCoCBiTGVuZ3RowqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA4PC9kaXY+PGRp
dj7CoCDCoCDCoCBiRGVzY3JpcHRvclR5cGXCoCDCoCDCoCDCoCAxMTwvZGl2PjxkaXY+wqAgwqAg
wqAgYkZpcnN0SW50ZXJmYWNlwqAgwqAgwqAgwqAgwqAwPC9kaXY+PGRpdj7CoCDCoCDCoCBiSW50
ZXJmYWNlQ291bnTCoCDCoCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIMKgIGJGdW5jdGlvbkNs
YXNzwqAgwqAgwqAgwqAgwqAgMjwvZGl2PjxkaXY+wqAgwqAgwqAgYkZ1bmN0aW9uU3ViQ2xhc3PC
oCDCoCDCoCDCoDI8L2Rpdj48ZGl2PsKgIMKgIMKgIGJGdW5jdGlvblByb3RvY29swqAgwqAgwqAg
wqAxPC9kaXY+PGRpdj7CoCDCoCDCoCBpRnVuY3Rpb27CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQg
Q0RDIEFDTTwvZGl2PjxkaXY+Li4uPC9kaXY+PC9kaXY+PGRpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIj5PbiBUaHUsIFNlcCAxMywgMjAxOCBhdCAxMDoyMSBBTSBGcmFuayBWYXNxdWV6
ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5m
cmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRy
Ij5IaSBHaWFjaW50byw8ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDsgY2FuIHlvdSBzZW5kIHRoZSBy
ZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZxdW90O2xzdXNiIC10JnF1b3Q7PzwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4jIGxzdXNiIC10PC9kaXY+PGRpdj5CdXMgMDAxIERl
dmljZSAwMDE6IElEIDFkNmI6MDAwMjwvZGl2PjxkaXY+QnVzIDAwMSBEZXZpY2UgMDAyOiBJRCAx
NTQ2OjExMDc8L2Rpdj48ZGl2PkJ1cyAwMDIgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAzPC9kaXY+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHJ1bm5pbmcgQnVzeUJveCYjMzk7cyBzdHJp
cHBlZCBkb3duIHZlcnNpb24gb2YgbHN1c2IgdGhhdCYjMzk7cyB3aHkgaW5mb3JtYXRpb24gaXMg
c28gbGFja2luZy48L2Rpdj48ZGl2PkkmIzM5O2xsIGluc3RhbGwgdXNidXRpbHMgb24gbXkgZGV2
aWNlJiMzOTtzIEJ1aWxkcm9vdCBpbWFnZSBhbmQgcmVydW4gdGhlIGNvbW1hbmRzLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48L2Rpdj48L2Rp
dj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgU2Vw
IDEzLCAyMDE4IGF0IDM6NDkgQU0gR2lhY2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmdjaW9mb25vQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmdjaW9mb25vQGdtYWlsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij48ZGl2IGRpcj0iYXV0byI+aGkgRnJhbmssPGRpdiBkaXI9ImF1dG8iPjxicj48
L2Rpdj48ZGl2IGRpcj0iYXV0byI+Y2FuIHlvdSBzZW5kIHRoZSByZXN1bHQgb2YgJnF1b3Q7bHN1
c2ImcXVvdDsgYW5kICZxdW90O2xzdXNiIC10JnF1b3Q7PzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48
YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPkdpYWNpbnRvPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBUaHUsIDEzIFNlcCAyMDE4LCAwMDo0
MSBGcmFuayBWYXNxdWV6LCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0
YXJnZXQ9Il9ibGFuayI+ZnJhbmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdzLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGFu
IGVtYmVkZGVkIGRldmljZSB3aXRoIGEgdWJsb3ggVE9CWS1SMjAwIG9uIGl0LsKgIEkgd2FudCB0
byB1c2UgY29ubm1hbiB0byBtYW5hZ2UgYW55IGNlbGx1bGFyIGNvbm5lY3Rpb24gb24gdGhhdCBt
b2RlbSBzaW5jZSBjb25ubWFuIGlzIGFscmVhZHkgbWFuYWdpbmcgZXRoZXJuZXQgYW5kIHdpZmkg
Y29ubmVjdGl2aXR5LsKgIG9Gb25vIHNlZW1zIGxpa2UgdGhlIGJlc3Qgb3B0aW9uLsKgIEkgc2Vl
IHRoYXQgdGhlcmUgaXMgYWxyZWFkeSBhIHVibG94IHBsdWdpbiBmb3Igb0Zvbm8gYnV0IEkgZG9u
JiMzOTt0IHRoaW5rIHRoZSBUT0JZLVIyMDAgaXMgc3VwcG9ydGVkLsKgIFRoZSBjZWxsIG1vZHVs
ZSBpcyBzb2xkZXJlZCBvbnRvIHRoZSBib2FyZCBhbmQgYXBwZWFycyBhcyBhIFVTQiBkZXZpY2Uu
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PlvCoCDCoCA2LjUxOTE5MF0gdXNiIDEtMTog
TmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTM8
L2Rpdj48ZGl2PlvCoCDCoCA2LjUxOTE5N10gdXNiIDEtMTogUHJvZHVjdDogdS1ibG94IENlbGx1
bGFyIE1vZHVsZTwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MjA0XSB1c2IgMS0xOiBNYW51ZmFjdHVy
ZXI6IHUtYmxveDwvZGl2PjxkaXY+W8KgIMKgIDYuNTE5MjExXSB1c2IgMS0xOiBTZXJpYWxOdW1i
ZXI6IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBjYW4g
c2VuZCBBVCBjb21tYW5kcyB0byB0aGUgbW9kZW0gb3ZlciAvZGV2L3R0eUFDTTAuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zv
bm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBo
cmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiByZWw9
Im5vcmVmZXJyZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMub2Zv
bm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm88L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+
CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9k
aXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+
PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2
Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============2897685241108312726==--

