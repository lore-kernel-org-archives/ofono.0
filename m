Content-Type: multipart/mixed; boundary="===============6361141237542544906=="
MIME-Version: 1.0
From: Frank Vasquez <frankv@helium.com>
Subject: Re: ublox TOBY-R200
Date: Wed, 19 Sep 2018 13:35:52 -0700
Message-ID: <CAFJydPWS6sVv0+0pYTRjy6Ne5r1+Z8A8r2QUOqWFGNZrGGE+og@mail.gmail.com>
In-Reply-To: <CAKSBH7F5T1ziRrwY72e-LFkr7Kn2q3cx_5wPQPn_9G5iVUUQKQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6361141237542544906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

I attached a better antenna to our custom board but I'm still getting the
same results.

AT+CSQ
+CSQ: 24,4

OK

# ./enable-modem
Connecting modem /ublox_0...
# ./create-internet-context hologram
Found context /ublox_0/context1
Setting APN to hologram
# ./online-modem
Setting modem /ublox_0 online...
#
Sep 19 20:17:41 gateway daemon.warn ofonod[152]: Context activated for
driver that doesn't support automatic context activation.
Sep 19 20:17:41 gateway daemon.err connmand[148]: Failed to set regulatory
domain
# ./activate-context
Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS is
not attached

Reception appears to be good and I waited more than 2 minutes before
./activate-context.

I'm new to oFono and connman so I'm going to try to get cellular
connectivity working on a BeagleBone Black with u-blox TOBY-L201 (oFono
supported modem) plugged into USB first.  I can activate a context
successfully but cellular still says Connected =3D False in connmanctl on t=
he
BeagleBone Black.  Any pointers or links on how to do get connman working
with oFono are appreciated.

Cheers,
Frank

On Tue, Sep 18, 2018 at 8:02 PM Giacinto Cifelli <gciofono@gmail.com> wro=
te:

> Hi Frank,
>
> is it working? I had a look at ublox specification, and I think you need
> some more support in ofono for establishing the LTE default bearer.
> I will take this back once I have submitted some patches for this support
> (and have been accepted).
>
> Best regards,
> Giacinto
>
>
> On Sat, Sep 15, 2018 at 8:31 AM Giacinto Cifelli <gciofono@gmail.com>
> wrote:
>
>> Hi Frank,
>>
>> I am happy that it started working.
>> Reviewing your email, I doubted that it was more a configure parameters
>> issue.
>> The rest below, I shall not top-post in this distribution list.
>>
>> On Sat, Sep 15, 2018 at 2:54 AM Frank Vasquez <frankv@helium.com> wrot=
e:
>>
>>> Hi Giacinto,
>>>
>>> I applied your patch for the TOBY-R200 and the results look very
>>> promising.
>>>
>>> # ./list-modems
>>> [ /ublox_0 ]
>>>     Online =3D 1
>>>     Powered =3D 1
>>>     Lockdown =3D 0
>>>     Emergency =3D 0
>>>     Manufacturer =3D u-blox
>>>     Model =3D TOBY-R200
>>>     Revision =3D 30.31
>>>     Serial =3D 352848080392646
>>>     Interfaces =3D org.ofono.NetworkRegistration org.ofono.NetworkMonit=
or
>>> org.ofono.ConnectionManager org.ofono.LongTermEvolution
>>> org.ofono.AllowedAccessPoints org.ofono.VoiceCallManager
>>> org.ofono.SimManager
>>>     Features =3D net gprs sim
>>>     Type =3D hardware
>>>     [ org.ofono.NetworkRegistration ]
>>>         Status =3D searching
>>>         Mode =3D auto
>>>         Name =3D
>>>     [ org.ofono.NetworkMonitor ]
>>>     [ org.ofono.ConnectionManager ]
>>>         Attached =3D 0
>>>         Bearer =3D none
>>>         RoamingAllowed =3D 0
>>>         Powered =3D 1
>>>     [ org.ofono.LongTermEvolution ]
>>>         DefaultAccessPointName =3D
>>>     [ org.ofono.AllowedAccessPoints ]
>>>     [ org.ofono.VoiceCallManager ]
>>>         EmergencyNumbers =3D 112 911
>>>     [ org.ofono.SimManager ]
>>>         Present =3D 1
>>>         CardIdentifier =3D 8944501011176099176
>>>         SubscriberIdentity =3D 234507098609917
>>>         ServiceProviderName =3D Hologram
>>>         FixedDialing =3D 0
>>>         BarredDialing =3D 0
>>>         MobileCountryCode =3D 234
>>>         MobileNetworkCode =3D 50
>>>         SubscriberNumbers =3D
>>>         LockedPins =3D
>>>         PreferredLanguages =3D en
>>>         PinRequired =3D none
>>>         Retries =3D [pin =3D 3] [pin2 =3D 3] [puk =3D 10] [puk2 =3D 10]
>>>
>>> # ./enable-modem
>>> Connecting modem /ublox_0...
>>> # ./create-internet-context hologram
>>> Found context /ublox_0/context1
>>> Setting APN to hologram
>>> # ./online-modem
>>> Setting modem /ublox_0 online...
>>> # ./activate-context
>>> Error activating /ublox_0/context1: org.ofono.Error.NotAttached: GPRS is
>>> not attached
>>>
>>>
>> Have you connected your antennas properly? Have you waited some 2 minutes
>> before trying the ./activate-context ?
>> If yes, then this module reports its attach status with some indicator
>> not recognized by ofono today (blind shot: +CEREG).
>>
>>
>>
>>> As you can see I was unable to activate-context but I got pretty close.
>>> I'm willing to apply more code changes if it means I can get cellular
>>> integration with connman.
>>>
>>
>> In general I test on Ubuntu with d-feed, so I don't know all the test
>> scripts, but there should be some to check whether the modem is reported
>> registered, to which technology, what the signal strength is, and if it =
is
>> reported attached.
>> If it is registered to LTE, it is attached, but ofono doesn't recognize
>> it automatically by radio technology, it needs a separate indicator.
>>
>>
>>>
>>> Cheers,
>>> Frank
>>>
>>> On Thu, Sep 13, 2018 at 9:19 PM Giacinto Cifelli <gciofono@gmail.com>
>>> wrote:
>>>
>>>> Hi Frank,
>>>>
>>>> both TOBYL2_COMPATIBLE_MODE and  TOBYL2_HIGH_THROUGHPUT_MODE behave
>>>> the same in the code.
>>>> (TOBYL2_MEDIUM_THROUGHPUT_MODE is recognized but discarded later in
>>>> the code)
>>>> Please replace the two attached files in the plugins directory.
>>>> Let me know if it works (it would be good to know which functionalities
>>>> you try out), and if so I can submit the changes as patches.
>>>>
>>>> You don't need the udev rule for usb modems, it is recognized
>>>> automatically.
>>>>
>>>> Best Regards,
>>>> Giacinto
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On Thu, Sep 13, 2018 at 10:51 PM Frank Vasquez <frankv@helium.com>
>>>> wrote:
>>>>
>>>>> Hi Giancito,
>>>>>
>>>>> I modified ublox.c as follows.
>>>>>
>>>>> enum supported_models {
>>>>>         SARA_G270                       =3D 1102,
>>>>>         TOBYL2_COMPATIBLE_MODE          =3D 1141,
>>>>>         TOBYL2_MEDIUM_THROUGHPUT_MODE   =3D 1143,
>>>>>         TOBYL2_HIGH_THROUGHPUT_MODE     =3D 1107,  /* was 1146 */
>>>>> };
>>>>>
>>>>> And still no luck.
>>>>>
>>>>> # ./list-modems
>>>>> #
>>>>>
>>>>> I see no evidence that oFono's ublox driver is being loaded even
>>>>> though I added the following line to 60-serial-rules in
>>>>> /etc/udev/rules.d/60-serial-rules.
>>>>>
>>>>> KERNEL=3D=3D"ttyACM0", ENV{OFONO_DRIVER}=3D"ublox"
>>>>>
>>>>> I want TOBYL2_HIGH_THROUGHPUT_MODE because that's the mode that uses
>>>>> LTE.
>>>>>
>>>>> Cheers,
>>>>> Frank
>>>>>
>>>>>
>>>>> On Thu, Sep 13, 2018 at 12:18 PM Frank Vasquez <frankv@helium.com>
>>>>> wrote:
>>>>>
>>>>>> Hi Giacinto,
>>>>>>
>>>>>> The TOBY-R200 is an LTE module.  I see that the ublox oFono plugin
>>>>>> supports LTE on the TOBY-L2 so maybe it will work on the TOBY-R200 as
>>>>>> well.  I think many of the AT commands are the same across ublox cel=
lular
>>>>>> modems so yes let's give testing a shot.
>>>>>>
>>>>>> I am using Buildroot to build oFono for my Linux device.
>>>>>>
>>>>>>
>>>>>> ####################################################################=
############
>>>>>> #
>>>>>> # ofono
>>>>>> #
>>>>>>
>>>>>> ####################################################################=
############
>>>>>>
>>>>>> OFONO_VERSION =3D 1.21
>>>>>> OFONO_SOURCE =3D ofono-$(OFONO_VERSION).tar.xz
>>>>>> OFONO_SITE =3D $(BR2_KERNEL_MIRROR)/linux/network/ofono
>>>>>> OFONO_LICENSE =3D GPL-2.0
>>>>>> OFONO_LICENSE_FILES =3D COPYING
>>>>>> OFONO_DEPENDENCIES =3D \
>>>>>> host-pkgconf \
>>>>>> dbus \
>>>>>> libglib2 \
>>>>>> libcap-ng \
>>>>>> mobile-broadband-provider-info
>>>>>>
>>>>>> OFONO_CONF_OPTS =3D \
>>>>>> --disable-test \
>>>>>> --with-dbusconfdir=3D/etc \
>>>>>> $(if
>>>>>> $(BR2_INIT_SYSTEMD),--with-systemdunitdir=3D/usr/lib/systemd/system)
>>>>>>
>>>>>> # N.B. Qualcomm QMI modem support requires O_CLOEXEC; so
>>>>>> # make sure that it is defined.
>>>>>> OFONO_CONF_ENV +=3D CFLAGS=3D"$(TARGET_CFLAGS) -D_GNU_SOURCE"
>>>>>>
>>>>>> define OFONO_INSTALL_INIT_SYSV
>>>>>> $(INSTALL) -m 0755 -D package/ofono/S46ofono
>>>>>> $(TARGET_DIR)/etc/init.d/S46ofono
>>>>>> endef
>>>>>>
>>>>>> define OFONO_INSTALL_INIT_SYSTEMD
>>>>>> mkdir -p $(TARGET_DIR)/etc/systemd/systemd/multi-user.target.wants
>>>>>> ln -fs ../../../../usr/lib/systemd/system/ofono.service \
>>>>>> $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
>>>>>> endef
>>>>>>
>>>>>> ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
>>>>>> OFONO_CONF_OPTS +=3D --enable-udev
>>>>>> OFONO_DEPENDENCIES +=3D udev
>>>>>> else
>>>>>> OFONO_CONF_OPTS +=3D --disable-udev
>>>>>> endif
>>>>>>
>>>>>> ifeq ($(BR2_PACKAGE_BLUEZ_UTILS),y)
>>>>>> OFONO_CONF_OPTS +=3D --enable-bluetooth
>>>>>> OFONO_DEPENDENCIES +=3D bluez_utils
>>>>>> else
>>>>>> OFONO_CONF_OPTS +=3D --disable-bluetooth
>>>>>> endif
>>>>>>
>>>>>> $(eval $(autotools-package))
>>>>>>
>>>>>> I can modify the downloaded oFono source code (plugins and drivers
>>>>>> directories) and rebuild it as needed to test the TOBY-R200.
>>>>>>
>>>>>> $ ls -l output/build/ofono-1.21
>>>>>> total 2528
>>>>>> -rw-r--r--  1 frank frank    835 Oct  5  2017 acinclude.m4
>>>>>> -rw-r--r--  1 frank frank 360491 Oct  5  2017 aclocal.m4
>>>>>> -rw-r--r--  1 frank frank   5356 Oct  5  2017 AUTHORS
>>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 btio
>>>>>> -rw-r--r--  1 frank frank  30811 Oct  5  2017 ChangeLog
>>>>>> -rwxr-xr-x  1 frank frank   7333 Oct  5  2017 compile
>>>>>> -rwxr-xr-x  1 frank frank  43765 Sep 13 11:39 config.guess
>>>>>> -rw-r--r--  1 frank frank   2775 Sep 13 11:39 config.h
>>>>>> -rw-r--r--  1 frank frank   2492 Oct  5  2017 config.h.in
>>>>>> -rw-r--r--  1 frank frank  42877 Sep 13 11:39 config.log
>>>>>> -rwxr-xr-x  1 frank frank  67571 Sep 13 11:39 config.status
>>>>>> -rwxr-xr-x  1 frank frank  36171 Sep 13 11:39 config.sub
>>>>>> -rwxr-xr-x  1 frank frank 467689 Oct  5  2017 configure
>>>>>> -rw-r--r--  1 frank frank   8223 Oct  5  2017 configure.ac
>>>>>> -rw-r--r--  1 frank frank  18011 Jul 10  2009 COPYING
>>>>>> -rwxr-xr-x  1 frank frank  23566 Oct  5  2017 depcomp
>>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 doc
>>>>>> drwxr-xr-x 25 frank frank   4096 Oct  5  2017 drivers
>>>>>> drwxr-xr-x  2 frank frank   4096 Sep 13 11:39 dundee
>>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 examples
>>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gatchat
>>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 gdbus
>>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gisi
>>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 gril
>>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 include
>>>>>> -rw-r--r--  1 frank frank   9478 Jul 10  2009 INSTALL
>>>>>> -rwxr-xr-x  1 frank frank  14431 Oct  5  2017 install-sh
>>>>>> -rwxr-xr-x  1 frank frank 294282 Sep 13 11:39 libtool
>>>>>> -rw-r--r--  1 frank frank 283940 Sep 13 11:39 ltmain.sh
>>>>>> -rw-r--r--  1 frank frank 283672 Oct  5  2017 ltmain.sh.orig
>>>>>> -rw-r--r--  1 frank frank 185608 Sep 13 11:39 Makefile
>>>>>> -rw-r--r--  1 frank frank  28755 Oct  5  2017 Makefile.am
>>>>>> -rw-r--r--  1 frank frank 204311 Oct  5  2017 Makefile.in
>>>>>> -rwxr-xr-x  1 frank frank   6872 Oct  5  2017 missing
>>>>>> -rw-r--r--  1 frank frank      0 Jul 10  2009 NEWS
>>>>>> -rw-r--r--  1 frank frank    310 Sep 13 11:39 ofono.pc
>>>>>> -rw-r--r--  1 frank frank    325 Feb  6  2011 ofono.pc.in
>>>>>> drwxr-xr-x  3 frank frank   4096 Sep 13 11:39 plugins
>>>>>> -rw-r--r--  1 frank frank    886 Jul 19  2012 README
>>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 src
>>>>>> -rw-r--r--  1 frank frank     23 Sep 13 11:39 stamp-h1
>>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 test
>>>>>> -rwxr-xr-x  1 frank frank   4287 Sep 13  2015 test-driver
>>>>>> -rw-r--r--  1 frank frank  17996 May  3  2016 TODO
>>>>>> drwxr-xr-x  2 frank frank   4096 Oct  5  2017 tools
>>>>>> drwxr-xr-x  4 frank frank   4096 Sep 13 11:39 unit
>>>>>>
>>>>>> Cheers,
>>>>>> Frank
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Thu, Sep 13, 2018 at 11:48 AM Giacinto Cifelli <gciofono@gmail.=
com>
>>>>>> wrote:
>>>>>>
>>>>>>> hi Frank,
>>>>>>>
>>>>>>> your modem doesn't seem to be supported.
>>>>>>> There are these models:
>>>>>>> SARA_G270 =3D 1102,
>>>>>>> TOBYL2_COMPATIBLE_MODE =3D 1141,
>>>>>>> TOBYL2_MEDIUM_THROUGHPUT_MODE =3D 1143,
>>>>>>> TOBYL2_HIGH_THROUGHPUT_MODE =3D 1146,
>>>>>>> If your model is compatible with any of them, I can add  the 1107
>>>>>>> for you for a test.
>>>>>>>
>>>>>>> from the PID, I would say it should be intermediate between the
>>>>>>> SARA_G260 and the TOBYL2_COMPATIBLE_MODE.
>>>>>>> Most likely it will work this latter, but maybe not all features...
>>>>>>>
>>>>>>> Are you willing to test?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Giacinto
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Thu, Sep 13, 2018 at 7:48 PM Frank Vasquez <frankv@helium.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Hi Giacinto,
>>>>>>>>
>>>>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>>
>>>>>>>> The usbutils version of lsusb is somewhat better.
>>>>>>>>
>>>>>>>> # lsusb
>>>>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>>>>> # lsusb -t
>>>>>>>> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, =
5000M
>>>>>>>> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, =
480M
>>>>>>>>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 1, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 2, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 3, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 4, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 5, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 6, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 7, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 8, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 9, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 10, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>     |__ Port 1: Dev 2, If 11, Class=3D, Driver=3Dcdc_acm, 480M
>>>>>>>>
>>>>>>>> And here is a relevant excerpt from lsusb -v.
>>>>>>>>
>>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>>> Device Descriptor:
>>>>>>>>   bLength                18
>>>>>>>>   bDescriptorType         1
>>>>>>>>   bcdUSB               2.00
>>>>>>>>   bDeviceClass          239
>>>>>>>>   bDeviceSubClass         2
>>>>>>>>   bDeviceProtocol         1
>>>>>>>>   bMaxPacketSize0        64
>>>>>>>>   idVendor           0x1546
>>>>>>>>   idProduct          0x1107
>>>>>>>>   bcdDevice           17.29
>>>>>>>>   iManufacturer           1 u-blox
>>>>>>>>   iProduct                2 u-blox Cellular Module
>>>>>>>>   iSerial                 3 352848080392646
>>>>>>>>   bNumConfigurations      1
>>>>>>>>   Configuration Descriptor:
>>>>>>>>     bLength                 9
>>>>>>>>     bDescriptorType         2
>>>>>>>>     wTotalLength          405
>>>>>>>>     bNumInterfaces         12
>>>>>>>>     bConfigurationValue     1
>>>>>>>>     iConfiguration          0
>>>>>>>>     bmAttributes         0xe0
>>>>>>>>       Self Powered
>>>>>>>>       Remote Wakeup
>>>>>>>>     MaxPower              100mA
>>>>>>>>     Interface Association:
>>>>>>>>       bLength                 8
>>>>>>>>       bDescriptorType        11
>>>>>>>>       bFirstInterface         0
>>>>>>>>       bInterfaceCount         2
>>>>>>>>       bFunctionClass          2
>>>>>>>>       bFunctionSubClass       2
>>>>>>>>       bFunctionProtocol       1
>>>>>>>>       iFunction               4 CDC ACM
>>>>>>>> ...
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Frank
>>>>>>>>
>>>>>>>>
>>>>>>>> On Thu, Sep 13, 2018 at 10:21 AM Frank Vasquez <frankv@helium.co=
m>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> Hi Giacinto,
>>>>>>>>>
>>>>>>>>> > can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>>>
>>>>>>>>> # lsusb -t
>>>>>>>>> Bus 001 Device 001: ID 1d6b:0002
>>>>>>>>> Bus 001 Device 002: ID 1546:1107
>>>>>>>>> Bus 002 Device 001: ID 1d6b:0003
>>>>>>>>>
>>>>>>>>> I am running BusyBox's stripped down version of lsusb that's why
>>>>>>>>> information is so lacking.
>>>>>>>>> I'll install usbutils on my device's Buildroot image and rerun the
>>>>>>>>> commands.
>>>>>>>>>
>>>>>>>>> Cheers,
>>>>>>>>> Frank
>>>>>>>>>
>>>>>>>>> On Thu, Sep 13, 2018 at 3:49 AM Giacinto Cifelli <
>>>>>>>>> gciofono(a)gmail.com> wrote:
>>>>>>>>>
>>>>>>>>>> hi Frank,
>>>>>>>>>>
>>>>>>>>>> can you send the result of "lsusb" and "lsusb -t"?
>>>>>>>>>>
>>>>>>>>>> Giacinto
>>>>>>>>>>
>>>>>>>>>> On Thu, 13 Sep 2018, 00:41 Frank Vasquez, <frankv@helium.com>
>>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>>> Greetings,
>>>>>>>>>>>
>>>>>>>>>>> I have an embedded device with a ublox TOBY-R200 on it.  I want
>>>>>>>>>>> to use connman to manage any cellular connection on that modem =
since
>>>>>>>>>>> connman is already managing ethernet and wifi connectivity.  oF=
ono seems
>>>>>>>>>>> like the best option.  I see that there is already a ublox plug=
in for oFono
>>>>>>>>>>> but I don't think the TOBY-R200 is supported.  The cell module =
is soldered
>>>>>>>>>>> onto the board and appears as a USB device.
>>>>>>>>>>>
>>>>>>>>>>> [    6.519190] usb 1-1: New USB device strings: Mfr=3D1,
>>>>>>>>>>> Product=3D2, SerialNumber=3D3
>>>>>>>>>>> [    6.519197] usb 1-1: Product: u-blox Cellular Module
>>>>>>>>>>> [    6.519204] usb 1-1: Manufacturer: u-blox
>>>>>>>>>>> [    6.519211] usb 1-1: SerialNumber: 352848080392646
>>>>>>>>>>>
>>>>>>>>>>> I can send AT commands to the modem over /dev/ttyACM0.
>>>>>>>>>>>
>>>>>>>>>>> Cheers,
>>>>>>>>>>> Frank
>>>>>>>>>>> _______________________________________________
>>>>>>>>>>> ofono mailing list
>>>>>>>>>>> ofono(a)ofono.org
>>>>>>>>>>> https://lists.ofono.org/mailman/listinfo/ofono
>>>>>>>>>>>
>>>>>>>>>>

--===============6361141237542544906==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhY2ludG8s
PGRpdj48YnI+PC9kaXY+PGRpdj5JIGF0dGFjaGVkIGEgYmV0dGVyIGFudGVubmEgdG8gb3VyIGN1
c3RvbSBib2FyZCBidXQgSSYjMzk7bSBzdGlsbCBnZXR0aW5nIHRoZSBzYW1lIHJlc3VsdHMuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PkFUK0NTUTwvZGl2PjxkaXY+K0NTUTogMjQsNDwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T0s8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PjxkaXY+IyAuL2VuYWJsZS1tb2RlbcKgPC9kaXY+PGRpdj5Db25uZWN0aW5nIG1vZGVtIC91Ymxv
eF8wLi4uPC9kaXY+PGRpdj4jIC4vY3JlYXRlLWludGVybmV0LWNvbnRleHQgaG9sb2dyYW08L2Rp
dj48ZGl2PkZvdW5kIGNvbnRleHQgL3VibG94XzAvY29udGV4dDE8L2Rpdj48ZGl2PlNldHRpbmcg
QVBOIHRvIGhvbG9ncmFtPC9kaXY+PGRpdj4jIC4vb25saW5lLW1vZGVtwqA8L2Rpdj48ZGl2PlNl
dHRpbmcgbW9kZW0gL3VibG94XzAgb25saW5lLi4uPC9kaXY+PGRpdj4jPC9kaXY+PGRpdj5TZXAg
MTkgMjA6MTc6NDEgZ2F0ZXdheSBkYWVtb24ud2FybiBvZm9ub2RbMTUyXTogQ29udGV4dCBhY3Rp
dmF0ZWQgZm9yIGRyaXZlciB0aGF0IGRvZXNuJiMzOTt0IHN1cHBvcnQgYXV0b21hdGljIGNvbnRl
eHQgYWN0aXZhdGlvbi48L2Rpdj48ZGl2PlNlcCAxOSAyMDoxNzo0MSBnYXRld2F5IGRhZW1vbi5l
cnIgY29ubm1hbmRbMTQ4XTogRmFpbGVkIHRvIHNldCByZWd1bGF0b3J5IGRvbWFpbjwvZGl2Pjxk
aXY+IyAuL2FjdGl2YXRlLWNvbnRleHTCoDwvZGl2PjxkaXY+RXJyb3IgYWN0aXZhdGluZyAvdWJs
b3hfMC9jb250ZXh0MTogb3JnLm9mb25vLkVycm9yLk5vdEF0dGFjaGVkOiBHUFJTIGlzIG5vdCBh
dHRhY2hlZDwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVjZXB0aW9uIGFwcGVhcnMg
dG8gYmUgZ29vZCBhbmQgSSB3YWl0ZWQgbW9yZSB0aGFuIDIgbWludXRlcyBiZWZvcmUgLi9hY3Rp
dmF0ZS1jb250ZXh0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSBuZXcgdG8gb0Zv
bm8gYW5kIGNvbm5tYW4gc28gSSYjMzk7bSBnb2luZyB0byB0cnkgdG8gZ2V0IGNlbGx1bGFyIGNv
bm5lY3Rpdml0eSB3b3JraW5nIG9uIGEgQmVhZ2xlQm9uZSBCbGFjayB3aXRoIHUtYmxveCBUT0JZ
LUwyMDEgKG9Gb25vIHN1cHBvcnRlZCBtb2RlbSkgcGx1Z2dlZCBpbnRvIFVTQiBmaXJzdC7CoCBJ
IGNhbiBhY3RpdmF0ZSBhIGNvbnRleHQgc3VjY2Vzc2Z1bGx5IGJ1dCBjZWxsdWxhciBzdGlsbCBz
YXlzIENvbm5lY3RlZCA9IEZhbHNlIGluIGNvbm5tYW5jdGwgb24gdGhlIEJlYWdsZUJvbmUgQmxh
Y2suwqAgQW55IHBvaW50ZXJzIG9yIGxpbmtzIG9uIGhvdyB0byBkbyBnZXQgY29ubm1hbiB3b3Jr
aW5nIHdpdGggb0Zvbm8gYXJlIGFwcHJlY2lhdGVkLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFR1ZSwgU2VwIDE4LCAyMDE4IGF0
IDg6MDIgUE0gR2lhY2ludG8gQ2lmZWxsaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdt
YWlsLmNvbSI+Z2Npb2Zvbm9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPkhp
IEZyYW5rLDxkaXY+PGJyPjwvZGl2PjxkaXY+aXMgaXQgd29ya2luZz8gSSBoYWQgYSBsb29rIGF0
IHVibG94IHNwZWNpZmljYXRpb24sIGFuZCBJIHRoaW5rIHlvdSBuZWVkIHNvbWUgbW9yZSBzdXBw
b3J0IGluIG9mb25vIGZvciBlc3RhYmxpc2hpbmcgdGhlIExURSBkZWZhdWx0IGJlYXJlci48L2Rp
dj48ZGl2Pkkgd2lsbCB0YWtlIHRoaXMgYmFjayBvbmNlIEkgaGF2ZSBzdWJtaXR0ZWQgc29tZSBw
YXRjaGVzIGZvciB0aGlzIHN1cHBvcnQgKGFuZCBoYXZlIGJlZW4gYWNjZXB0ZWQpLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXY+R2lhY2ludG88L2Rpdj48
ZGl2Pjxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGly
PSJsdHIiPk9uIFNhdCwgU2VwIDE1LCAyMDE4IGF0IDg6MzEgQU0gR2lhY2ludG8gQ2lmZWxsaSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmdjaW9mb25vQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmdj
aW9mb25vQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5IaSBGcmFuayw8ZGl2
Pjxicj48L2Rpdj48ZGl2PkkgYW0gaGFwcHkgdGhhdCBpdCBzdGFydGVkIHdvcmtpbmcuPC9kaXY+
PGRpdj5SZXZpZXdpbmcgeW91ciBlbWFpbCwgSSBkb3VidGVkIHRoYXQgaXQgd2FzIG1vcmUgYSBj
b25maWd1cmUgcGFyYW1ldGVycyBpc3N1ZS48L2Rpdj48ZGl2PlRoZSByZXN0IGJlbG93LCBJIHNo
YWxsIG5vdCB0b3AtcG9zdCBpbiB0aGlzIGRpc3RyaWJ1dGlvbiBsaXN0LjwvZGl2PjxkaXY+PGJy
PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5PbiBTYXQsIFNlcCAxNSwg
MjAxOCBhdCAyOjU0IEFNIEZyYW5rIFZhc3F1ZXogJmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZA
aGVsaXVtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZyYW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3Jv
dGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPkhpIEdpYWNpbnRv
LDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhcHBsaWVkIHlvdXIgcGF0Y2ggZm9yIHRoZSBUT0JZLVIy
MDAgYW5kIHRoZSByZXN1bHRzIGxvb2sgdmVyeSBwcm9taXNpbmcuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48ZGl2PiMgLi9saXN0LW1vZGVtc8KgPC9kaXY+PGRpdj5bIC91YmxveF8wIF08L2Rp
dj48ZGl2PsKgIMKgIE9ubGluZSA9IDE8L2Rpdj48ZGl2PsKgIMKgIFBvd2VyZWQgPSAxPC9kaXY+
PGRpdj7CoCDCoCBMb2NrZG93biA9IDA8L2Rpdj48ZGl2PsKgIMKgIEVtZXJnZW5jeSA9IDA8L2Rp
dj48ZGl2PsKgIMKgIE1hbnVmYWN0dXJlciA9IHUtYmxveDwvZGl2PjxkaXY+wqAgwqAgTW9kZWwg
PSBUT0JZLVIyMDA8L2Rpdj48ZGl2PsKgIMKgIFJldmlzaW9uID0gMzAuMzE8L2Rpdj48ZGl2PsKg
IMKgIFNlcmlhbCA9IDM1Mjg0ODA4MDM5MjY0NjwvZGl2PjxkaXY+wqAgwqAgSW50ZXJmYWNlcyA9
IG9yZy5vZm9uby5OZXR3b3JrUmVnaXN0cmF0aW9uIG9yZy5vZm9uby5OZXR3b3JrTW9uaXRvciBv
cmcub2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIgb3JnLm9mb25vLkxvbmdUZXJtRXZvbHV0aW9uIG9y
Zy5vZm9uby5BbGxvd2VkQWNjZXNzUG9pbnRzIG9yZy5vZm9uby5Wb2ljZUNhbGxNYW5hZ2VyIG9y
Zy5vZm9uby5TaW1NYW5hZ2VywqA8L2Rpdj48ZGl2PsKgIMKgIEZlYXR1cmVzID0gbmV0IGdwcnMg
c2ltwqA8L2Rpdj48ZGl2PsKgIMKgIFR5cGUgPSBoYXJkd2FyZTwvZGl2PjxkaXY+wqAgwqAgWyBv
cmcub2Zvbm8uTmV0d29ya1JlZ2lzdHJhdGlvbiBdPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTdGF0
dXMgPSBzZWFyY2hpbmc8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIE1vZGUgPSBhdXRvPC9kaXY+PGRp
dj7CoCDCoCDCoCDCoCBOYW1lID3CoDwvZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8uTmV0d29y
a01vbml0b3IgXTwvZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIg
XTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgQXR0YWNoZWQgPSAwPC9kaXY+PGRpdj7CoCDCoCDCoCDC
oCBCZWFyZXIgPSBub25lPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBSb2FtaW5nQWxsb3dlZCA9IDA8
L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFBvd2VyZWQgPSAxPC9kaXY+PGRpdj7CoCDCoCBbIG9yZy5v
Zm9uby5Mb25nVGVybUV2b2x1dGlvbiBdPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBEZWZhdWx0QWNj
ZXNzUG9pbnROYW1lID3CoDwvZGl2PjxkaXY+wqAgwqAgWyBvcmcub2Zvbm8uQWxsb3dlZEFjY2Vz
c1BvaW50cyBdPC9kaXY+PGRpdj7CoCDCoCBbIG9yZy5vZm9uby5Wb2ljZUNhbGxNYW5hZ2VyIF08
L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEVtZXJnZW5jeU51bWJlcnMgPSAxMTIgOTExwqA8L2Rpdj48
ZGl2PsKgIMKgIFsgb3JnLm9mb25vLlNpbU1hbmFnZXIgXTwvZGl2PjxkaXY+wqAgwqAgwqAgwqAg
UHJlc2VudCA9IDE8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIENhcmRJZGVudGlmaWVyID0gODk0NDUw
MTAxMTE3NjA5OTE3NjwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Vic2NyaWJlcklkZW50aXR5ID0g
MjM0NTA3MDk4NjA5OTE3PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBTZXJ2aWNlUHJvdmlkZXJOYW1l
ID0gSG9sb2dyYW08L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIEZpeGVkRGlhbGluZyA9IDA8L2Rpdj48
ZGl2PsKgIMKgIMKgIMKgIEJhcnJlZERpYWxpbmcgPSAwPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBN
b2JpbGVDb3VudHJ5Q29kZSA9IDIzNDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgTW9iaWxlTmV0d29y
a0NvZGUgPSA1MDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgU3Vic2NyaWJlck51bWJlcnMgPcKgPC9k
aXY+PGRpdj7CoCDCoCDCoCDCoCBMb2NrZWRQaW5zID3CoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAg
UHJlZmVycmVkTGFuZ3VhZ2VzID0gZW7CoDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgUGluUmVxdWly
ZWQgPSBub25lPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBSZXRyaWVzID0gW3BpbiA9IDNdIFtwaW4y
ID0gM10gW3B1ayA9IDEwXSBbcHVrMiA9IDEwXTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PGRpdj4jIC4vZW5hYmxlLW1vZGVtwqA8L2Rpdj48ZGl2PkNvbm5lY3RpbmcgbW9kZW0gL3Vi
bG94XzAuLi48L2Rpdj48ZGl2PiMgLi9jcmVhdGUtaW50ZXJuZXQtY29udGV4dCBob2xvZ3JhbTwv
ZGl2PjxkaXY+Rm91bmQgY29udGV4dCAvdWJsb3hfMC9jb250ZXh0MTwvZGl2PjxkaXY+U2V0dGlu
ZyBBUE4gdG8gaG9sb2dyYW08L2Rpdj48ZGl2PiMgLi9vbmxpbmUtbW9kZW08L2Rpdj48ZGl2PlNl
dHRpbmcgbW9kZW0gL3VibG94XzAgb25saW5lLi4uPC9kaXY+PGRpdj4jIC4vYWN0aXZhdGUtY29u
dGV4dMKgPC9kaXY+PGRpdj5FcnJvciBhY3RpdmF0aW5nIC91YmxveF8wL2NvbnRleHQxOiBvcmcu
b2Zvbm8uRXJyb3IuTm90QXR0YWNoZWQ6IEdQUlMgaXMgbm90IGF0dGFjaGVkPC9kaXY+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+SGF2ZSB5b3UgY29ubmVjdGVkIHlvdXIgYW50ZW5uYXMgcHJvcGVybHk/IEhhdmUg
eW91IHdhaXRlZCBzb21lIDIgbWludXRlcyBiZWZvcmUgdHJ5aW5nIHRoZSAuL2FjdGl2YXRlLWNv
bnRleHQgPzwvZGl2PjxkaXY+SWYgeWVzLCB0aGVuIHRoaXMgbW9kdWxlIHJlcG9ydHMgaXRzIGF0
dGFjaCBzdGF0dXMgd2l0aCBzb21lIGluZGljYXRvciBub3QgcmVjb2duaXplZCBieSBvZm9ubyB0
b2RheSAoYmxpbmQgc2hvdDrCoCtDRVJFRykuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2
IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2PjwvZGl2PjxkaXY+
QXMgeW91IGNhbiBzZWUgSSB3YXMgdW5hYmxlIHRvIGFjdGl2YXRlLWNvbnRleHQgYnV0IEkgZ290
IHByZXR0eSBjbG9zZS7CoCBJJiMzOTttIHdpbGxpbmcgdG8gYXBwbHkgbW9yZSBjb2RlIGNoYW5n
ZXMgaWYgaXQgbWVhbnMgSSBjYW4gZ2V0IGNlbGx1bGFyIGludGVncmF0aW9uIHdpdGggY29ubm1h
bi48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRp
dj5JbiBnZW5lcmFsIEkgdGVzdCBvbiBVYnVudHUgd2l0aCBkLWZlZWQsIHNvIEkgZG9uJiMzOTt0
IGtub3cgYWxsIHRoZSB0ZXN0IHNjcmlwdHMsIGJ1dCB0aGVyZSBzaG91bGQgYmUgc29tZSB0byBj
aGVjayB3aGV0aGVyIHRoZSBtb2RlbSBpcyByZXBvcnRlZCByZWdpc3RlcmVkLCB0byB3aGljaCB0
ZWNobm9sb2d5LCB3aGF0IHRoZSBzaWduYWwgc3RyZW5ndGggaXMsIGFuZCBpZiBpdCBpcyByZXBv
cnRlZCBhdHRhY2hlZC48L2Rpdj48ZGl2PklmIGl0IGlzIHJlZ2lzdGVyZWQgdG8gTFRFLCBpdCBp
cyBhdHRhY2hlZCwgYnV0IG9mb25vIGRvZXNuJiMzOTt0IHJlY29nbml6ZSBpdCBhdXRvbWF0aWNh
bGx5IGJ5IHJhZGlvIHRlY2hub2xvZ3ksIGl0IG5lZWRzIGEgc2VwYXJhdGUgaW5kaWNhdG9yLjwv
ZGl2PjxkaXY+wqA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRp
dj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2
PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1
LCBTZXAgMTMsIDIwMTggYXQgOToxOSBQTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJt
YWlsdG86Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Z2Npb2Zvbm9AZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPkhpIEZyYW5rLDxkaXY+PGJyPjwvZGl2Pjxk
aXY+Ym90aMKgPHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+VE9CWUwyX0NPTVBBVElC
TEVfTU9ERSBhbmTCoDwvc3Bhbj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj7CoDwv
c3Bhbj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5UT0JZTDJfSElHSF9USFJPVUdI
UFVUX01PREUgYmVoYXZlIHRoZSBzYW1lIGluIHRoZSBjb2RlLjwvc3Bhbj48L2Rpdj48ZGl2Pjxz
cGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPig8L3NwYW4+PHNwYW4gc3R5bGU9ImNvbG9y
OnJnYig4MCwwLDgwKSI+VE9CWUwyX01FRElVTV9USFJPVUdIUFVUX01PREUgaXMgcmVjb2duaXpl
ZCBidXQgZGlzY2FyZGVkIGxhdGVyIGluIHRoZSBjb2RlKTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPlBsZWFzZSByZXBsYWNlIHRoZSB0d28gYXR0YWNo
ZWQgZmlsZXMgaW4gdGhlIHBsdWdpbnMgZGlyZWN0b3J5Ljwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
IHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPkxldCBtZSBrbm93IGlmIGl0IHdvcmtzIChpdCB3
b3VsZCBiZSBnb29kIHRvIGtub3cgd2hpY2ggZnVuY3Rpb25hbGl0aWVzIHlvdSB0cnkgb3V0KSwg
YW5kIGlmIHNvIEkgY2FuIHN1Ym1pdCB0aGUgY2hhbmdlcyBhcyBwYXRjaGVzLjwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPjxicj48L3NwYW4+PC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5Zb3UgZG9uJiMzOTt0IG5lZWQg
dGhlIHVkZXYgcnVsZSBmb3IgdXNiIG1vZGVtcywgaXQgaXMgcmVjb2duaXplZCBhdXRvbWF0aWNh
bGx5Ljwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCkiPjxi
cj48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj5CZXN0
IFJlZ2FyZHMsPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgw
KSI+R2lhY2ludG88L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAs
ODApIj48YnI+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgw
KSI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoODAsMCw4MCki
Pjxicj48L3NwYW4+PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0iY29sb3I6cmdiKDgwLDAsODApIj48
YnI+PC9zcGFuPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBk
aXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgMTA6NTEgUE0gRnJhbmsgVmFzcXVleiAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmZyYW5rdkBoZWxpdW0uY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJh
bmt2QGhlbGl1bS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNj
Y2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+
PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgR2lhbmNpdG8sPGRpdj48YnI+PC9kaXY+
PGRpdj5JIG1vZGlmaWVkIHVibG94LmMgYXMgZm9sbG93cy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PjxkaXY+ZW51bSBzdXBwb3J0ZWRfbW9kZWxzIHs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFNB
UkFfRzI3MMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPSAxMTAyLDwvZGl2Pjxk
aXY+wqAgwqAgwqAgwqAgVE9CWUwyX0NPTVBBVElCTEVfTU9ERcKgIMKgIMKgIMKgIMKgID0gMTE0
MSw8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIFRPQllMMl9NRURJVU1fVEhST1VHSFBVVF9NT0RFwqAg
wqA9IDExNDMsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCBUT0JZTDJfSElHSF9USFJPVUdIUFVUX01P
REXCoCDCoCDCoD0gMTEwNyzCoCAvKiB3YXMgMTE0NiAqLzwvZGl2PjxkaXY+fTs8L2Rpdj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkFuZCBzdGlsbCBubyBsdWNrLjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PGRpdj4jIC4vbGlzdC1tb2RlbXPCoDwvZGl2PjxkaXY+IzwvZGl2PjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBzZWUgbm8gZXZpZGVuY2UgdGhhdCBvRm9ubyYjMzk7cyB1Ymxv
eCBkcml2ZXIgaXMgYmVpbmcgbG9hZGVkIGV2ZW4gdGhvdWdoIEkgYWRkZWQgdGhlIGZvbGxvd2lu
ZyBsaW5lIHRvIDYwLXNlcmlhbC1ydWxlcyBpbiAvZXRjL3VkZXYvcnVsZXMuZC82MC1zZXJpYWwt
cnVsZXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5LRVJORUw9PSZxdW90O3R0eUFDTTAmcXVv
dDssIEVOVntPRk9OT19EUklWRVJ9PSZxdW90O3VibG94JnF1b3Q7PGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+SSB3YW50IFRPQllMMl9ISUdIX1RIUk9VR0hQVVRfTU9ERSBiZWNhdXNlIHRo
YXQmIzM5O3MgdGhlIG1vZGUgdGhhdCB1c2VzIExURS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIj5P
biBUaHUsIFNlcCAxMywgMjAxOCBhdCAxMjoxOCBQTSBGcmFuayBWYXNxdWV6ICZsdDs8YSBocmVm
PSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRhcmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVt
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0i
bHRyIj5IaSBHaWFjaW50byw8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBUT0JZLVIyMDAgaXMgYW4g
TFRFIG1vZHVsZS7CoCBJIHNlZSB0aGF0IHRoZSB1YmxveCBvRm9ubyBwbHVnaW4gc3VwcG9ydHMg
TFRFIG9uIHRoZSBUT0JZLUwyIHNvIG1heWJlIGl0IHdpbGwgd29yayBvbiB0aGUgVE9CWS1SMjAw
IGFzIHdlbGwuwqAgSSB0aGluayBtYW55IG9mIHRoZSBBVCBjb21tYW5kcyBhcmUgdGhlIHNhbWUg
YWNyb3NzIHVibG94IGNlbGx1bGFyIG1vZGVtcyBzbyB5ZXMgbGV0JiMzOTtzIGdpdmUgdGVzdGlu
ZyBhIHNob3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHVzaW5nIEJ1aWxkcm9vdCB0
byBidWlsZCBvRm9ubyBmb3IgbXkgTGludXggZGV2aWNlLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+PGRpdj4jIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIzwvZGl2PjxkaXY+IzwvZGl2PjxkaXY+IyBv
Zm9ubzwvZGl2PjxkaXY+IzwvZGl2PjxkaXY+IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyM8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pk9GT05PX1ZFUlNJT04gPSAxLjIxPC9kaXY+PGRpdj5PRk9OT19T
T1VSQ0UgPSBvZm9uby0kKE9GT05PX1ZFUlNJT04pLnRhci54ejwvZGl2PjxkaXY+T0ZPTk9fU0lU
RSA9ICQoQlIyX0tFUk5FTF9NSVJST1IpL2xpbnV4L25ldHdvcmsvb2Zvbm88L2Rpdj48ZGl2Pk9G
T05PX0xJQ0VOU0UgPSBHUEwtMi4wPC9kaXY+PGRpdj5PRk9OT19MSUNFTlNFX0ZJTEVTID0gQ09Q
WUlORzwvZGl2PjxkaXY+T0ZPTk9fREVQRU5ERU5DSUVTID0gXDwvZGl2PjxkaXY+PHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmhvc3QtcGtnY29uZiBcPC9kaXY+PGRp
dj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+ZGJ1cyBcPC9kaXY+
PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+bGliZ2xpYjIg
XDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmxp
YmNhcC1uZyBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8
L3NwYW4+bW9iaWxlLWJyb2FkYmFuZC1wcm92aWRlci1pbmZvPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5PRk9OT19DT05GX09QVFMgPSBcPC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlLXdyYXAiPgk8L3NwYW4+LS1kaXNhYmxlLXRlc3QgXDwvZGl2PjxkaXY+PHNwYW4gc3R5
bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPi0td2l0aC1kYnVzY29uZmRpcj0vZXRj
IFw8L2Rpdj48ZGl2PjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj4k
KGlmICQoQlIyX0lOSVRfU1lTVEVNRCksLS13aXRoLXN5c3RlbWR1bml0ZGlyPS91c3IvbGliL3N5
c3RlbWQvc3lzdGVtKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+IyBOLkIuIFF1YWxjb21tIFFN
SSBtb2RlbSBzdXBwb3J0IHJlcXVpcmVzIE9fQ0xPRVhFQzsgc288L2Rpdj48ZGl2PiMgbWFrZSBz
dXJlIHRoYXQgaXQgaXMgZGVmaW5lZC48L2Rpdj48ZGl2Pk9GT05PX0NPTkZfRU5WICs9IENGTEFH
Uz0mcXVvdDskKFRBUkdFVF9DRkxBR1MpIC1EX0dOVV9TT1VSQ0UmcXVvdDs8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PmRlZmluZSBPRk9OT19JTlNUQUxMX0lOSVRfU1lTVjwvZGl2PjxkaXY+PHNw
YW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPiQoSU5TVEFMTCkgLW0gMDc1
NSAtRCBwYWNrYWdlL29mb25vL1M0Nm9mb25vICQoVEFSR0VUX0RJUikvZXRjL2luaXQuZC9TNDZv
Zm9ubzwvZGl2PjxkaXY+ZW5kZWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmRlZmluZSBPRk9O
T19JTlNUQUxMX0lOSVRfU1lTVEVNRDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNl
OnByZS13cmFwIj4JPC9zcGFuPm1rZGlyIC1wICQoVEFSR0VUX0RJUikvZXRjL3N5c3RlbWQvc3lz
dGVtZC9tdWx0aS11c2VyLnRhcmdldC53YW50czwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRl
LXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPmxuIC1mcyAuLi8uLi8uLi8uLi91c3IvbGliL3N5c3Rl
bWQvc3lzdGVtL29mb25vLnNlcnZpY2UgXDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNw
YWNlOnByZS13cmFwIj4JCTwvc3Bhbj4kKFRBUkdFVF9ESVIpL2V0Yy9zeXN0ZW1kL3N5c3RlbS9t
dWx0aS11c2VyLnRhcmdldC53YW50czwvZGl2PjxkaXY+ZW5kZWY8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PmlmZXEgKCQoQlIyX1BBQ0tBR0VfSEFTX1VERVYpLHkpPC9kaXY+PGRpdj5PRk9OT19D
T05GX09QVFMgKz0gLS1lbmFibGUtdWRldjwvZGl2PjxkaXY+T0ZPTk9fREVQRU5ERU5DSUVTICs9
IHVkZXY8L2Rpdj48ZGl2PmVsc2U8L2Rpdj48ZGl2Pk9GT05PX0NPTkZfT1BUUyArPSAtLWRpc2Fi
bGUtdWRldjwvZGl2PjxkaXY+ZW5kaWY8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmlmZXEgKCQo
QlIyX1BBQ0tBR0VfQkxVRVpfVVRJTFMpLHkpPC9kaXY+PGRpdj5PRk9OT19DT05GX09QVFMgKz0g
LS1lbmFibGUtYmx1ZXRvb3RoPC9kaXY+PGRpdj5PRk9OT19ERVBFTkRFTkNJRVMgKz0gYmx1ZXpf
dXRpbHM8L2Rpdj48ZGl2PmVsc2U8L2Rpdj48ZGl2Pk9GT05PX0NPTkZfT1BUUyArPSAtLWRpc2Fi
bGUtYmx1ZXRvb3RoPC9kaXY+PGRpdj5lbmRpZjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+JChl
dmFsICQoYXV0b3Rvb2xzLXBhY2thZ2UpKTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SSBjYW4gbW9kaWZ5IHRoZSBkb3dubG9hZGVkIG9Gb25vIHNvdXJjZSBjb2RlIChwbHVnaW5zIGFu
ZCBkcml2ZXJzIGRpcmVjdG9yaWVzKSBhbmQgcmVidWlsZCBpdCBhcyBuZWVkZWQgdG8gdGVzdCB0
aGUgVE9CWS1SMjAwLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj4kIGxzIC1sIG91dHB1
dC9idWlsZC9vZm9uby0xLjIxPC9kaXY+PGRpdj50b3RhbCAyNTI4PC9kaXY+PGRpdj4tcnctci0t
ci0twqAgMSBmcmFuayBmcmFua8KgIMKgIDgzNSBPY3TCoCA1wqAgMjAxNyBhY2luY2x1ZGUubTQ8
L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rIDM2MDQ5MSBPY3TCoCA1wqAgMjAx
NyBhY2xvY2FsLm00PC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKgNTM1
NiBPY3TCoCA1wqAgMjAxNyBBVVRIT1JTPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMiBmcmFuayBm
cmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyBidGlvPC9kaXY+PGRpdj4tcnctci0tci0twqAg
MSBmcmFuayBmcmFua8KgIDMwODExIE9jdMKgIDXCoCAyMDE3IENoYW5nZUxvZzwvZGl2PjxkaXY+
LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCDCoDczMzMgT2N0wqAgNcKgIDIwMTcgY29tcGls
ZTwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCA0Mzc2NSBTZXAgMTMgMTE6
MzkgY29uZmlnLmd1ZXNzPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIMKg
Mjc3NSBTZXAgMTMgMTE6MzkgY29uZmlnLmg8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5r
IGZyYW5rwqAgwqAyNDkyIE9jdMKgIDXCoCAyMDE3IDxhIGhyZWY9Imh0dHA6Ly9jb25maWcuaC5p
biIgdGFyZ2V0PSJfYmxhbmsiPmNvbmZpZy5oLmluPC9hPjwvZGl2PjxkaXY+LXJ3LXItLXItLcKg
IDEgZnJhbmsgZnJhbmvCoCA0Mjg3NyBTZXAgMTMgMTE6MzkgY29uZmlnLmxvZzwvZGl2PjxkaXY+
LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCA2NzU3MSBTZXAgMTMgMTE6MzkgY29uZmlnLnN0
YXR1czwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmvCoCAzNjE3MSBTZXAgMTMg
MTE6MzkgY29uZmlnLnN1YjwvZGl2PjxkaXY+LXJ3eHIteHIteMKgIDEgZnJhbmsgZnJhbmsgNDY3
Njg5IE9jdMKgIDXCoCAyMDE3IGNvbmZpZ3VyZTwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJh
bmsgZnJhbmvCoCDCoDgyMjMgT2N0wqAgNcKgIDIwMTcgPGEgaHJlZj0iaHR0cDovL2NvbmZpZ3Vy
ZS5hYyIgdGFyZ2V0PSJfYmxhbmsiPmNvbmZpZ3VyZS5hYzwvYT48L2Rpdj48ZGl2Pi1ydy1yLS1y
LS3CoCAxIGZyYW5rIGZyYW5rwqAgMTgwMTEgSnVsIDEwwqAgMjAwOSBDT1BZSU5HPC9kaXY+PGRp
dj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIDIzNTY2IE9jdMKgIDXCoCAyMDE3IGRlcGNv
bXA8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IE9jdMKgIDXC
oCAyMDE3IGRvYzwvZGl2PjxkaXY+ZHJ3eHIteHIteCAyNSBmcmFuayBmcmFua8KgIMKgNDA5NiBP
Y3TCoCA1wqAgMjAxNyBkcml2ZXJzPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMiBmcmFuayBmcmFu
a8KgIMKgNDA5NiBTZXAgMTMgMTE6MzkgZHVuZGVlPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMiBm
cmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyBleGFtcGxlczwvZGl2PjxkaXY+ZHJ3
eHIteHIteMKgIDQgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IGdhdGNoYXQ8L2Rp
dj48ZGl2PmRyd3hyLXhyLXjCoCA0IGZyYW5rIGZyYW5rwqAgwqA0MDk2IFNlcCAxMyAxMTozOSBn
ZGJ1czwvZGl2PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEz
IDExOjM5IGdpc2k8L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAzIGZyYW5rIGZyYW5rwqAgwqA0MDk2
IFNlcCAxMyAxMTozOSBncmlsPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgMyBmcmFuayBmcmFua8Kg
IMKgNDA5NiBTZXAgMTMgMTE6MzkgaW5jbHVkZTwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJh
bmsgZnJhbmvCoCDCoDk0NzggSnVsIDEwwqAgMjAwOSBJTlNUQUxMPC9kaXY+PGRpdj4tcnd4ci14
ci14wqAgMSBmcmFuayBmcmFua8KgIDE0NDMxIE9jdMKgIDXCoCAyMDE3IGluc3RhbGwtc2g8L2Rp
dj48ZGl2Pi1yd3hyLXhyLXjCoCAxIGZyYW5rIGZyYW5rIDI5NDI4MiBTZXAgMTMgMTE6MzkgbGli
dG9vbDwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmsgMjgzOTQwIFNlcCAxMyAx
MTozOSBsdG1haW4uc2g8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rIDI4MzY3
MiBPY3TCoCA1wqAgMjAxNyBsdG1haW4uc2gub3JpZzwvZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEg
ZnJhbmsgZnJhbmsgMTg1NjA4IFNlcCAxMyAxMTozOSBNYWtlZmlsZTwvZGl2PjxkaXY+LXJ3LXIt
LXItLcKgIDEgZnJhbmsgZnJhbmvCoCAyODc1NSBPY3TCoCA1wqAgMjAxNyBNYWtlZmlsZS5hbTwv
ZGl2PjxkaXY+LXJ3LXItLXItLcKgIDEgZnJhbmsgZnJhbmsgMjA0MzExIE9jdMKgIDXCoCAyMDE3
IE1ha2VmaWxlLmluPC9kaXY+PGRpdj4tcnd4ci14ci14wqAgMSBmcmFuayBmcmFua8KgIMKgNjg3
MiBPY3TCoCA1wqAgMjAxNyBtaXNzaW5nPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBm
cmFua8KgIMKgIMKgIDAgSnVsIDEwwqAgMjAwOSBORVdTPC9kaXY+PGRpdj4tcnctci0tci0twqAg
MSBmcmFuayBmcmFua8KgIMKgIDMxMCBTZXAgMTMgMTE6Mzkgb2Zvbm8ucGM8L2Rpdj48ZGl2Pi1y
dy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgMzI1IEZlYsKgIDbCoCAyMDExIDxhIGhyZWY9
Imh0dHA6Ly9vZm9uby5wYy5pbiIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vLnBjLmluPC9hPjwvZGl2
PjxkaXY+ZHJ3eHIteHIteMKgIDMgZnJhbmsgZnJhbmvCoCDCoDQwOTYgU2VwIDEzIDExOjM5IHBs
dWdpbnM8L2Rpdj48ZGl2Pi1ydy1yLS1yLS3CoCAxIGZyYW5rIGZyYW5rwqAgwqAgODg2IEp1bCAx
OcKgIDIwMTIgUkVBRE1FPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgNCBmcmFuayBmcmFua8KgIMKg
NDA5NiBTZXAgMTMgMTE6Mzkgc3JjPC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFu
a8KgIMKgIMKgMjMgU2VwIDEzIDExOjM5IHN0YW1wLWgxPC9kaXY+PGRpdj5kcnd4ci14ci14wqAg
MiBmcmFuayBmcmFua8KgIMKgNDA5NiBPY3TCoCA1wqAgMjAxNyB0ZXN0PC9kaXY+PGRpdj4tcnd4
ci14ci14wqAgMSBmcmFuayBmcmFua8KgIMKgNDI4NyBTZXAgMTPCoCAyMDE1IHRlc3QtZHJpdmVy
PC9kaXY+PGRpdj4tcnctci0tci0twqAgMSBmcmFuayBmcmFua8KgIDE3OTk2IE1hecKgIDPCoCAy
MDE2IFRPRE88L2Rpdj48ZGl2PmRyd3hyLXhyLXjCoCAyIGZyYW5rIGZyYW5rwqAgwqA0MDk2IE9j
dMKgIDXCoCAyMDE3IHRvb2xzPC9kaXY+PGRpdj5kcnd4ci14ci14wqAgNCBmcmFuayBmcmFua8Kg
IMKgNDA5NiBTZXAgMTMgMTE6MzkgdW5pdDwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGly
PSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDExOjQ4IEFNIEdpYWNpbnRvIENpZmVsbGkg
Jmx0OzxhIGhyZWY9Im1haWx0bzpnY2lvZm9ub0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5n
Y2lvZm9ub0BnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9
Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+aGkgRnJhbmssPGRpdj48YnI+PC9k
aXY+PGRpdj55b3VyIG1vZGVtIGRvZXNuJiMzOTt0IHNlZW0gdG8gYmUgc3VwcG9ydGVkLjwvZGl2
PjxkaXY+VGhlcmUgYXJlIHRoZXNlIG1vZGVsczo8L2Rpdj48ZGl2PjxkaXY+PGRpdj48c3BhbiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+U0FSQV9HMjcwPHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCQk8L3NwYW4+PSAxMTAyLDwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JPC9zcGFuPlRPQllMMl9DT01QQVRJQkxFX01P
REU8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgkJPC9zcGFuPj0gMTE0MSw8YnI+
PC9kaXY+PGRpdj48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPgk8L3NwYW4+VE9C
WUwyX01FRElVTV9USFJPVUdIUFVUX01PREU8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdy
YXAiPgk8L3NwYW4+PSAxMTQzLDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZS13cmFwIj4JPC9zcGFuPlRPQllMMl9ISUdIX1RIUk9VR0hQVVRfTU9ERTxzcGFuIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUtd3JhcCI+CTwvc3Bhbj49IDExNDYsPC9kaXY+PC9kaXY+PGRpdj5JZiB5
b3VyIG1vZGVsIGlzIGNvbXBhdGlibGUgd2l0aCBhbnkgb2YgdGhlbSwgSSBjYW4gYWRkwqAgdGhl
IDExMDcgZm9yIHlvdSBmb3IgYSB0ZXN0Ljxicj48L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PmZyb20gdGhlIFBJRCwgSSB3b3VsZCBzYXkgaXQgc2hvdWxkIGJlIGludGVybWVkaWF0ZSBi
ZXR3ZWVuIHRoZSBTQVJBX0cyNjAgYW5kIHRoZSBUT0JZTDJfQ09NUEFUSUJMRV9NT0RFLjwvZGl2
PjxkaXY+TW9zdCBsaWtlbHkgaXQgd2lsbCB3b3JrIHRoaXMgbGF0dGVyLCBidXQgbWF5YmUgbm90
IGFsbCBmZWF0dXJlcy4uLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QXJlIHlvdSB3aWxsaW5n
IHRvIHRlc3Q/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMsPC9kaXY+PGRp
dj5HaWFjaW50bzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2
PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAgMTMsIDIwMTggYXQgNzo0OCBQTSBG
cmFuayBWYXNxdWV6ICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRhcmdl
dD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48
ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRy
Ij5IaSBHaWFjaW50byw8L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0
ciI+Jmd0O8KgPHNwYW4gc3R5bGU9ImNvbG9yOnJnYig4MCwwLDgwKSI+Y2FuIHlvdSBzZW5kIHRo
ZSByZXN1bHQgb2YgJnF1b3Q7bHN1c2ImcXVvdDsgYW5kICZxdW90O2xzdXNiIC10JnF1b3Q7Pzwv
c3Bhbj48L2Rpdj48ZGl2IGRpcj0ibHRyIj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+VGhlIHVz
YnV0aWxzIHZlcnNpb24gb2YgbHN1c2IgaXMgc29tZXdoYXQgYmV0dGVyLjwvZGl2PjxkaXYgZGly
PSJsdHIiPjxicj48ZGl2PjxkaXY+IyBsc3VzYjwvZGl2PjxkaXY+QnVzIDAwMiBEZXZpY2UgMDAx
OiBJRCAxZDZiOjAwMDPCoMKgPC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1NDY6
MTEwN8KgwqA8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2aWNlIDAwMTogSUQgMWQ2YjowMDAywqDCoDwv
ZGl2PjxkaXY+IyBsc3VzYiAtdDwvZGl2PjxkaXY+LzrCoCBCdXMgMDIuUG9ydCAxOiBEZXYgMSwg
Q2xhc3M9cm9vdF9odWIsIERyaXZlcj14aGNpLWhjZC8xcCwgNTAwME08L2Rpdj48ZGl2Pi86wqAg
QnVzIDAxLlBvcnQgMTogRGV2IDEsIENsYXNzPXJvb3RfaHViLCBEcml2ZXI9eGhjaS1oY2QvMXAs
IDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAwLCBDbGFzcz0sIERy
aXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYg
MSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQg
MTogRGV2IDIsIElmIDIsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKg
IMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiAzLCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBN
PC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwgSWYgNCwgQ2xhc3M9LCBEcml2ZXI9
Y2RjX2FjbSwgNDgwTTwvZGl2PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDUsIENs
YXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERl
diAyLCBJZiA2LCBDbGFzcz0sIERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8
X18gUG9ydCAxOiBEZXYgMiwgSWYgNywgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2
PjxkaXY+wqAgwqAgfF9fIFBvcnQgMTogRGV2IDIsIElmIDgsIENsYXNzPSwgRHJpdmVyPWNkY19h
Y20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQb3J0IDE6IERldiAyLCBJZiA5LCBDbGFzcz0s
IERyaXZlcj1jZGNfYWNtLCA0ODBNPC9kaXY+PGRpdj7CoCDCoCB8X18gUG9ydCAxOiBEZXYgMiwg
SWYgMTAsIENsYXNzPSwgRHJpdmVyPWNkY19hY20sIDQ4ME08L2Rpdj48ZGl2PsKgIMKgIHxfXyBQ
b3J0IDE6IERldiAyLCBJZiAxMSwgQ2xhc3M9LCBEcml2ZXI9Y2RjX2FjbSwgNDgwTTwvZGl2Pjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QW5kIGhlcmUgaXMgYSByZWxldmFudCBleGNlcnB0IGZy
b20gbHN1c2IgLXYuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PkJ1cyAwMDEgRGV2aWNl
IDAwMjogSUQgMTU0NjoxMTA3PC9kaXY+PGRpdj5EZXZpY2UgRGVzY3JpcHRvcjo8L2Rpdj48ZGl2
PsKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxODwvZGl2PjxkaXY+wqAgYkRlc2Ny
aXB0b3JUeXBlwqAgwqAgwqAgwqAgwqAxPC9kaXY+PGRpdj7CoCBiY2RVU0LCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoDIuMDA8L2Rpdj48ZGl2PsKgIGJEZXZpY2VDbGFzc8KgIMKgIMKgIMKgIMKgIDIz
OTwvZGl2PjxkaXY+wqAgYkRldmljZVN1YkNsYXNzwqAgwqAgwqAgwqAgwqAyPC9kaXY+PGRpdj7C
oCBiRGV2aWNlUHJvdG9jb2zCoCDCoCDCoCDCoCDCoDE8L2Rpdj48ZGl2PsKgIGJNYXhQYWNrZXRT
aXplMMKgIMKgIMKgIMKgIDY0PC9kaXY+PGRpdj7CoCBpZFZlbmRvcsKgIMKgIMKgIMKgIMKgIMKg
MHgxNTQ2PC9kaXY+PGRpdj7CoCBpZFByb2R1Y3TCoCDCoCDCoCDCoCDCoCAweDExMDc8L2Rpdj48
ZGl2PsKgIGJjZERldmljZcKgIMKgIMKgIMKgIMKgIMKgMTcuMjk8L2Rpdj48ZGl2PsKgIGlNYW51
ZmFjdHVyZXLCoCDCoCDCoCDCoCDCoCDCoDEgdS1ibG94PC9kaXY+PGRpdj7CoCBpUHJvZHVjdMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDIgdS1ibG94IENlbGx1bGFyIE1vZHVsZTwvZGl2PjxkaXY+
wqAgaVNlcmlhbMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMyAzNTI4NDgwODAzOTI2NDY8L2Rp
dj48ZGl2PsKgIGJOdW1Db25maWd1cmF0aW9uc8KgIMKgIMKgIDE8L2Rpdj48ZGl2PsKgIENvbmZp
Z3VyYXRpb24gRGVzY3JpcHRvcjo8L2Rpdj48ZGl2PsKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDk8L2Rpdj48ZGl2PsKgIMKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKg
IMKgMjwvZGl2PjxkaXY+wqAgwqAgd1RvdGFsTGVuZ3RowqAgwqAgwqAgwqAgwqAgNDA1PC9kaXY+
PGRpdj7CoCDCoCBiTnVtSW50ZXJmYWNlc8KgIMKgIMKgIMKgIMKgMTI8L2Rpdj48ZGl2PsKgIMKg
IGJDb25maWd1cmF0aW9uVmFsdWXCoCDCoCDCoDE8L2Rpdj48ZGl2PsKgIMKgIGlDb25maWd1cmF0
aW9uwqAgwqAgwqAgwqAgwqAgMDwvZGl2PjxkaXY+wqAgwqAgYm1BdHRyaWJ1dGVzwqAgwqAgwqAg
wqAgwqAweGUwPC9kaXY+PGRpdj7CoCDCoCDCoCBTZWxmIFBvd2VyZWQ8L2Rpdj48ZGl2PsKgIMKg
IMKgIFJlbW90ZSBXYWtldXA8L2Rpdj48ZGl2PsKgIMKgIE1heFBvd2VywqAgwqAgwqAgwqAgwqAg
wqAgwqAgMTAwbUE8L2Rpdj48ZGl2PsKgIMKgIEludGVyZmFjZSBBc3NvY2lhdGlvbjo8L2Rpdj48
ZGl2PsKgIMKgIMKgIGJMZW5ndGjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDg8L2Rpdj48ZGl2
PsKgIMKgIMKgIGJEZXNjcmlwdG9yVHlwZcKgIMKgIMKgIMKgIDExPC9kaXY+PGRpdj7CoCDCoCDC
oCBiRmlyc3RJbnRlcmZhY2XCoCDCoCDCoCDCoCDCoDA8L2Rpdj48ZGl2PsKgIMKgIMKgIGJJbnRl
cmZhY2VDb3VudMKgIMKgIMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAgwqAgYkZ1bmN0aW9uQ2xh
c3PCoCDCoCDCoCDCoCDCoCAyPC9kaXY+PGRpdj7CoCDCoCDCoCBiRnVuY3Rpb25TdWJDbGFzc8Kg
IMKgIMKgIMKgMjwvZGl2PjxkaXY+wqAgwqAgwqAgYkZ1bmN0aW9uUHJvdG9jb2zCoCDCoCDCoCDC
oDE8L2Rpdj48ZGl2PsKgIMKgIMKgIGlGdW5jdGlvbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNCBD
REMgQUNNPC9kaXY+PGRpdj4uLi48L2Rpdj48L2Rpdj48ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Q2hlZXJzLDwvZGl2PjxkaXY+RnJhbms8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYg
ZGlyPSJsdHIiPk9uIFRodSwgU2VwIDEzLCAyMDE4IGF0IDEwOjIxIEFNIEZyYW5rIFZhc3F1ZXog
Jmx0OzxhIGhyZWY9Im1haWx0bzpmcmFua3ZAaGVsaXVtLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZy
YW5rdkBoZWxpdW0uY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIi
PkhpIEdpYWNpbnRvLDxkaXY+PGJyPjwvZGl2PjxkaXY+Jmd0OyBjYW4geW91IHNlbmQgdGhlIHJl
c3VsdCBvZiAmcXVvdDtsc3VzYiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQmcXVvdDs/PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2PiMgbHN1c2IgLXQ8L2Rpdj48ZGl2PkJ1cyAwMDEgRGV2
aWNlIDAwMTogSUQgMWQ2YjowMDAyPC9kaXY+PGRpdj5CdXMgMDAxIERldmljZSAwMDI6IElEIDE1
NDY6MTEwNzwvZGl2PjxkaXY+QnVzIDAwMiBEZXZpY2UgMDAxOiBJRCAxZDZiOjAwMDM8L2Rpdj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gcnVubmluZyBCdXN5Qm94JiMzOTtzIHN0cmlw
cGVkIGRvd24gdmVyc2lvbiBvZiBsc3VzYiB0aGF0JiMzOTtzIHdoeSBpbmZvcm1hdGlvbiBpcyBz
byBsYWNraW5nLjwvZGl2PjxkaXY+SSYjMzk7bGwgaW5zdGFsbCB1c2J1dGlscyBvbiBteSBkZXZp
Y2UmIzM5O3MgQnVpbGRyb290IGltYWdlIGFuZCByZXJ1biB0aGUgY29tbWFuZHMuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5DaGVlcnMsPC9kaXY+PGRpdj5GcmFuazwvZGl2PjwvZGl2PjwvZGl2
Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciI+T24gVGh1LCBTZXAg
MTMsIDIwMTggYXQgMzo0OSBBTSBHaWFjaW50byBDaWZlbGxpICZsdDs8YSBocmVmPSJtYWlsdG86
Z2Npb2Zvbm9AZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+Z2Npb2Zvbm9AZ21haWwuY29tPC9h
PiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPjxkaXYgZGlyPSJhdXRvIj5oaSBGcmFuayw8ZGl2IGRpcj0iYXV0byI+PGJyPjwv
ZGl2PjxkaXYgZGlyPSJhdXRvIj5jYW4geW91IHNlbmQgdGhlIHJlc3VsdCBvZiAmcXVvdDtsc3Vz
YiZxdW90OyBhbmQgJnF1b3Q7bHN1c2IgLXQmcXVvdDs/PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxi
cj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+R2lhY2ludG88L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiPk9uIFRodSwgMTMgU2VwIDIwMTgsIDAwOjQx
IEZyYW5rIFZhc3F1ZXosICZsdDs8YSBocmVmPSJtYWlsdG86ZnJhbmt2QGhlbGl1bS5jb20iIHRh
cmdldD0iX2JsYW5rIj5mcmFua3ZAaGVsaXVtLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDti
b3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRy
Ij48ZGl2IGRpcj0ibHRyIj5HcmVldGluZ3MsPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgYW4g
ZW1iZWRkZWQgZGV2aWNlIHdpdGggYSB1YmxveCBUT0JZLVIyMDAgb24gaXQuwqAgSSB3YW50IHRv
IHVzZSBjb25ubWFuIHRvIG1hbmFnZSBhbnkgY2VsbHVsYXIgY29ubmVjdGlvbiBvbiB0aGF0IG1v
ZGVtIHNpbmNlIGNvbm5tYW4gaXMgYWxyZWFkeSBtYW5hZ2luZyBldGhlcm5ldCBhbmQgd2lmaSBj
b25uZWN0aXZpdHkuwqAgb0Zvbm8gc2VlbXMgbGlrZSB0aGUgYmVzdCBvcHRpb24uwqAgSSBzZWUg
dGhhdCB0aGVyZSBpcyBhbHJlYWR5IGEgdWJsb3ggcGx1Z2luIGZvciBvRm9ubyBidXQgSSBkb24m
IzM5O3QgdGhpbmsgdGhlIFRPQlktUjIwMCBpcyBzdXBwb3J0ZWQuwqAgVGhlIGNlbGwgbW9kdWxl
IGlzIHNvbGRlcmVkIG9udG8gdGhlIGJvYXJkIGFuZCBhcHBlYXJzIGFzIGEgVVNCIGRldmljZS48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTkwXSB1c2IgMS0xOiBO
ZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLCBTZXJpYWxOdW1iZXI9Mzwv
ZGl2PjxkaXY+W8KgIMKgIDYuNTE5MTk3XSB1c2IgMS0xOiBQcm9kdWN0OiB1LWJsb3ggQ2VsbHVs
YXIgTW9kdWxlPC9kaXY+PGRpdj5bwqAgwqAgNi41MTkyMDRdIHVzYiAxLTE6IE1hbnVmYWN0dXJl
cjogdS1ibG94PC9kaXY+PGRpdj5bwqAgwqAgNi41MTkyMTFdIHVzYiAxLTE6IFNlcmlhbE51bWJl
cjogMzUyODQ4MDgwMzkyNjQ2PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGNhbiBz
ZW5kIEFUIGNvbW1hbmRzIHRvIHRoZSBtb2RlbSBvdmVyIC9kZXYvdHR5QUNNMC48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkNoZWVycyw8L2Rpdj48ZGl2PkZyYW5rPC9kaXY+PC9kaXY+PC9kaXY+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9u
byBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHJlbD0i
bm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhy
ZWY9Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHJlbD0i
bm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9u
by5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4K
PC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48L2Rp
dj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+CjwvYmxvY2txdW90ZT48
L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+
CjwvYmxvY2txdW90ZT48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============6361141237542544906==--

