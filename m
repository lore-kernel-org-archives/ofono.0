Content-Type: multipart/mixed; boundary="===============5649381607538325013=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: plugins/udev.c: add_modem() problem
Date: Wed, 15 Dec 2010 00:42:59 -0300
Message-ID: <20101215034258.GA7118@rafazurita.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5649381607538325013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello, current ofono git version is showing me an odd behaviour on our
netbook today. Before, I have been working with ofonod without problems (the
netbook has a mbmmodem:  Dell Computer Corp. F3507g Mobile Broadband Module)

But now, ofonod does not detect properly the devices and their drivers, so =
I am
trying to debug further.

When it worked okey the output was (I just put here the interesting output =
parts) :

        export OFONO_AT_DEBUG=3D1
        ./src/ofonod -n -d

ofonod[3381]: src/nettime.c:ofono_nettime_driver_register() driver: 0x8104b=
38 name: Example Network Time
ofonod[3381]: src/history.c:ofono_history_driver_register() driver: 0x8104b=
00 name: Example Call History
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104a80, =
name: ste
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104a20, =
name: ifx
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x81049c0, =
name: palmpre
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x81048e0, =
name: hfp
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104880, =
name: nokia
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104820, =
name: novatel
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x81047c0, =
name: huawei
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104760, =
name: zte
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104700, =
name: hso
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x81046a0, =
name: mbm
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x8104640, =
name: calypso
ofonod[3381]: src/modem.c:ofono_modem_driver_register() driver: 0x81045e0, =
name: wavecom
...
ofonod[3381]: src/radio-settings.c:ofono_radio_settings_driver_register() d=
river: 0x81038e0, name: isimodem
ofonod[3381]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8103904, na=
me: isimodem
ofonod[3381]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x810=
3918, name: isimodem
ofonod[3381]: src/audio-settings.c:ofono_audio_settings_driver_register() d=
river: 0x810392c, name: isimodem
ofonod[3381]: src/modem.c:ofono_modem_create() name: 3558620212509920, type=
: mbm
ofonod[3381]: src/modem.c:set_modem_property() modem 0xa103178 property Path
ofonod[3381]: src/modem.c:set_modem_property() modem 0xa103178 property Reg=
istered
ofonod[3381]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/u=
sb1/1-5/1-5:1.1/tty/ttyACM0 (mbm)
ofonod[3381]: plugins/udev.c:add_mbm() desc: Dell Wireless 5530 HSPA Mobile=
 Broadband Minicard Modem
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Reg=
istered
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Mod=
emDevice
ofonod[3381]: src/modem.c:set_modem_property() modem 0xa103178 property Mod=
emDevice
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Mod=
emDevice
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Dat=
aDevice
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Net=
workInterface
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property GPS=
Device
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Path
ofonod[3381]: plugins/udev.c:add_modem() /devices/pci0000:00/0000:00:1d.7/u=
sb1/1-5/1-5:1.3/tty/ttyACM1 (mbm)
ofonod[3381]: plugins/udev.c:add_mbm() desc: Dell Wireless 5530 HSPA Mobile=
 Broadband Minicard Modem 2
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Reg=
istered
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Mod=
emDevice
ofonod[3381]: src/modem.c:set_modem_property() modem 0xa103178 property Dat=
aDevice
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Mod=
emDevice
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Dat=
aDevice
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property Net=
workInterface
ofonod[3381]: src/modem.c:get_modem_property() modem 0xa103178 property GPS=
Device
...


(it shows the add_modem(), add_mbm(), etc). And the test/* scripts worked w=
ell
(list-modems, enable-modem, online-modem).

Then, I guess that something changed (but I am trying to find what) and ofo=
nod
does not find the modem anymore. The new ofonod output (check how it does n=
ot
find the ttyACM* mbm modem anymore) is :

root(a)profusion-Inspiron-1010:/home/profusion/rafa/latest/ofono# ./src/ofo=
nod -n -d
ofonod[11030]: oFono version 0.36
ofonod[11030]: src/plugin.c:__ofono_plugin_init() =

ofonod[11030]: plugins/push-notification.c:push_notification_init() =

ofonod[11030]: plugins/smart-messaging.c:smart_messaging_init() =

ofonod[11030]: src/nettime.c:ofono_nettime_driver_register() driver: 0x8103=
b18 name: Example Network Time
ofonod[11030]: src/history.c:ofono_history_driver_register() driver: 0x8103=
ae0 name: Example Call History
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103a60,=
 name: ste
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103a00,=
 name: ifx
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x81039a0,=
 name: palmpre
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x81038c0,=
 name: hfp
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103860,=
 name: nokia
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103800,=
 name: novatel
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x81037a0,=
 name: huawei
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103740,=
 name: zte
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x81036e0,=
 name: hso
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103680,=
 name: mbm
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103620,=
 name: calypso
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x81035c0,=
 name: wavecom
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103560,=
 name: g1
ofonod[11030]: src/modem.c:ofono_modem_driver_register() driver: 0x8103500,=
 name: phonesim
...
ofonod[11030]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x81028e0, name: isimodem
ofonod[11030]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8102904, n=
ame: isimodem
ofonod[11030]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
02918, name: isimodem
ofonod[11030]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x810292c, name: isimodem
ofonod[11030]: plugins/bluetooth.c:manager_properties_cb() =

ofonod[11030]: plugins/bluetooth.c:parse_adapters() =

ofonod[11030]: plugins/bluetooth.c:parse_adapters() Calling GetProperties o=
n /org/bluez/1056/hci0
ofonod[11030]: plugins/bluetooth.c:parse_devices() =

ofonod[11030]: plugins/bluetooth.c:adapter_properties_cb() Adapter Address:=
 00:22:69:C7:85:89, Path: /org/bluez/1056/hci0
^Cofonod[11030]: src/plugin.c:__ofono_plugin_cleanup() =

ofonod[11030]: plugins/push-notification.c:push_notification_exit() =

ofonod[11030]: plugins/smart-messaging.c:smart_messaging_exit() =



list-modes, enable-modem, etc did not work either. (And then I did CTRL+C to
finish.)

With a bit of debug it shows something weird. I found that
plugins/udev.c:add_modem() is called, but for some reason it does not have =
the same
behaviour than before.

The patch below is a little of debug added to add_modem()

diff --git a/plugins/udev.c b/plugins/udev.c
index 255755e..a877b59 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -453,9 +453,12 @@ static void add_modem(struct udev_device *udev_device)
 {
        struct ofono_modem *modem;
        struct udev_device *parent;
-       const char *devpath, *curpath, *driver;
+       const char *devpath, *curpath, *driver, *subsystem;
 =

+       devpath =3D udev_device_get_devpath(udev_device);
+       subsystem =3D udev_device_get_subsystem(udev_device);
        driver =3D get_driver(udev_device);
+       DBG("devpath : %s - driver : %s - subsystem : %s", devpath, driver,=
 subsystem);
        if (driver !=3D NULL) {
                devpath =3D udev_device_get_devpath(udev_device);
                if (devpath =3D=3D NULL)
@@ -476,13 +479,22 @@ static void add_modem(struct udev_device *udev_device)
        if (parent =3D=3D NULL)
                return;
 =

+       devpath =3D udev_device_get_devpath(parent);
+       subsystem =3D udev_device_get_subsystem(parent);
        driver =3D get_driver(parent);
+       DBG("devpath : %s - driver : %s - subsystem : %s", devpath, driver,=
 subsystem);
        if (driver =3D=3D NULL) {
                parent =3D udev_device_get_parent(parent);
+               devpath =3D udev_device_get_devpath(parent);
+               subsystem =3D udev_device_get_subsystem(parent);
                driver =3D get_driver(parent);
+               DBG("devpath : %s - driver : %s - subsystem : %s", devpath,=
 driver, subsystem);
                if (driver =3D=3D NULL) {
                        parent =3D udev_device_get_parent(parent);
                        driver =3D get_driver(parent);
+                       devpath =3D udev_device_get_devpath(parent);
+                       subsystem =3D udev_device_get_subsystem(parent);
+                       DBG("devpath : %s - driver : %s - subsystem : %s", =
devpath, driver, subsystem);
                        if (driver =3D=3D NULL)
                                return;
                }


And this is the ofonod output with that patch applied :

root(a)profusion-Inspiron-1010:/home/profusion/rafa/latest/ofono# ./src/ofo=
nod -n -d
ofonod[11388]: oFono version 0.36
ofonod[11388]: src/plugin.c:__ofono_plugin_init() =

ofonod[11388]: plugins/push-notification.c:push_notification_init() =

ofonod[11388]: plugins/smart-messaging.c:smart_messaging_init() =

ofonod[11388]: src/nettime.c:ofono_nettime_driver_register() driver: 0x8103=
b18 name: Example Network Time
ofonod[11388]: src/history.c:ofono_history_driver_register() driver: 0x8103=
ae0 name: Example Call History
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103a60,=
 name: ste
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103a00,=
 name: ifx
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x81039a0,=
 name: palmpre
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x81038c0,=
 name: hfp
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103860,=
 name: nokia
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103800,=
 name: novatel
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x81037a0,=
 name: huawei
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103740,=
 name: zte
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x81036e0,=
 name: hso
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103680,=
 name: mbm
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103620,=
 name: calypso
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x81035c0,=
 name: wavecom
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103560,=
 name: g1
ofonod[11388]: src/modem.c:ofono_modem_driver_register() driver: 0x8103500,=
 name: phonesim
ofonod[11388]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
034ec, name: phonesim
...
ofonod[11388]: src/radio-settings.c:ofono_radio_settings_driver_register() =
driver: 0x81028e0, name: isimodem
ofonod[11388]: src/gprs.c:ofono_gprs_driver_register() driver: 0x8102904, n=
ame: isimodem
ofonod[11388]: src/gprs.c:ofono_gprs_context_driver_register() driver: 0x81=
02918, name: isimodem
ofonod[11388]: src/audio-settings.c:ofono_audio_settings_driver_register() =
driver: 0x810292c, name: isimodem
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.1/tty/ttyACM0 - driver : (null) - subsystem : tty
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.1 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.3/tty/ttyACM1 - driver : (null) - subsystem : tty
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.3 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.7/net/wwan0 - driver : (null) - subsystem : net
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.7 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.9/tty/ttyACM2 - driver : (null) - subsystem : tty
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5/1-5:1.9 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1/1-5 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/pci0000:00/000=
0:00:1d.7/usb1 - driver : (null) - subsystem : usb
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/platform/seria=
l8250/tty/ttyS0 - driver : (null) - subsystem : tty
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/platform/seria=
l8250 - driver : (null) - subsystem : platform
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/platform - dri=
ver : (null) - subsystem : (null)
ofonod[11388]: plugins/udev.c:add_modem() devpath : (null) - driver : (null=
) - subsystem : (null)
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/platform/seria=
l8250/tty/ttyS1 - driver : (null) - subsystem : tty
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/platform/seria=
l8250 - driver : (null) - subsystem : platform
ofonod[11388]: plugins/udev.c:add_modem() devpath : /devices/platform - dri=
ver : (null) - subsystem : (null)


Then I checked a bit the system.. =

The system reports this information about the mbmmodem :

# lsusb
Bus 001 Device 003: ID 413c:8147 Dell Computer Corp. F3507g Mobile Broadban=
d Module
 =

root(a)profusion-Inspiron-1010:/home/profusion/rafa/latest/ofono# dmesg | g=
rep -i cdc
[   11.079706] usbcore: registered new interface driver cdc_acm
[   11.079716] cdc_acm: v0.26:USB Abstract Control Model driver for USB mod=
ems and ISDN adapters
[ 3137.190284] cdc_acm 1-5:1.1: ttyACM0: USB ACM device
[ 3137.192278] cdc_acm 1-5:1.3: ttyACM1: USB ACM device
[ 3137.194623] cdc_acm 1-5:1.9: ttyACM2: USB ACM device

root(a)profusion-Inspiron-1010:/home/profusion/rafa/latest/ofono# lsusb -v =
| grep -i mobile
Bus 001 Device 003: ID 413c:8147 Dell Computer Corp. F3507g Mobile Broadban=
d Module
  idProduct          0x8147 F3507g Mobile Broadband Module
  iProduct                2 Dell Wireless 5530 HSPA Mobile Broadband Minica=
rd Device
      iInterface              6 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem
      iInterface              7 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem
      iInterface              8 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem 2
      iInterface              9 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem 2
      iInterface             10 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard
      iInterface             11 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard PC SC Port
      bInterfaceSubClass     10 Mobile Direct Line
      iInterface             17 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard GPS Port
      iInterface             18 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard GPS Port
      iInterface              6 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem
      iInterface              7 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem
      iInterface              8 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem 2
      iInterface              9 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard Modem 2
      iInterface             10 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard
      iInterface             11 Dell Wireless 5530 HSPA Mobile Broadband Mi=
nicard PC SC Port
      bInterfaceSubClass     10 Mobile Direct Line

root(a)profusion-Inspiron-1010:/home/profusion/rafa/latest/ofono# udevadm i=
nfo --name=3D/dev/ttyACM0 --attribute-walk

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1.1/tty/=
ttyACM0':
    KERNEL=3D=3D"ttyACM0"
    SUBSYSTEM=3D=3D"tty"
    DRIVER=3D=3D""

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1/1-5/1-5:1=
.1':
    KERNELS=3D=3D"1-5:1.1"
    SUBSYSTEMS=3D=3D"usb"
    DRIVERS=3D=3D"cdc_acm"
    ATTRS{bInterfaceNumber}=3D=3D"01"
    ATTRS{bAlternateSetting}=3D=3D" 0"
    ATTRS{bNumEndpoints}=3D=3D"01"
    ATTRS{bInterfaceClass}=3D=3D"02"
    ATTRS{bInterfaceSubClass}=3D=3D"02"
    ATTRS{bInterfaceProtocol}=3D=3D"01"
    ATTRS{modalias}=3D=3D"usb:v413Cp8147d0000dc02dsc00dp00ic02isc02ip01"
    ATTRS{supports_autosuspend}=3D=3D"1"
    ATTRS{interface}=3D=3D"Dell Wireless 5530 HSPA Mobile Broadband Minicar=
d Modem"
    ATTRS{bmCapabilities}=3D=3D"7"

  looking at parent device '/devices/pci0000:00/0000:00:1d.7/usb1/1-5':
    KERNELS=3D=3D"1-5"
    SUBSYSTEMS=3D=3D"usb"
    DRIVERS=3D=3D"usb"
    ATTRS{configuration}=3D=3D"WMC Device"
...


I see that, for example, udevadm info --name=3D/dev/ttyACM0 --attribute-walk
shows the proper parents and drivers for ttyACM0, but from the log of ofono=
d with
the debug patch added it does not get the proper "driver" for every
parent of every device.

Maybe I am missing something, but the system has not changed, so I guess
that I did something wrong. If you have suggestions let me know, I would li=
ke
to debug further.

Thanks in advance.

Rafael Zurita

--===============5649381607538325013==--

