Content-Type: multipart/mixed; boundary="===============7084376522655710862=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Thu, 07 Sep 2017 18:38:40 -0700
Message-ID: <20170908013840.GD3@computer.craftyguy.net>
In-Reply-To: <0b611248-8735-aaf4-4f6a-6d4209014840@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7084376522655710862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's the info you requested, please let me know if I can gather
anything else to help!

localhost:/home/user# udevadm info --query all --path /sys/bus/hsi/devices/=
n900-modem
P: /devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/n900-m=
odem
E: DEVPATH=3D/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/po=
rt0/n900-modem
E: DRIVER=3Dnokia-modem
E: MODALIAS=3Dhsi:n900-modem
E: OFONO_DRIVER=3Dn900
E: OFONO_ISI_ADDRESS=3D108
E: OF_COMPATIBLE_0=3Dnokia,n900-modem
E: OF_COMPATIBLE_N=3D1
E: OF_FULLNAME=3D/ocp(a)68000000/ssi-controller(a)48058000/ssi-port(a)4805a=
000/hsi-client
E: OF_NAME=3Dhsi-client
E: SUBSYSTEM=3Dhsi
E: USEC_INITIALIZED=3D337086386

localhost:/home/user# udevadm info --attribute-walk --path /sys/bus/hsi/dev=
ices/n900-modem

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/platform/68000000.ocp/48058000.ssi-controller=
/ssi0/port0/n900-modem':
    KERNEL=3D=3D"n900-modem"
    SUBSYSTEM=3D=3D"hsi"
    DRIVER=3D=3D"nokia-modem"

  looking at parent device '/devices/platform/68000000.ocp/48058000.ssi-con=
troller/ssi0/port0':
    KERNELS=3D=3D"port0"
    SUBSYSTEMS=3D=3D""
    DRIVERS=3D=3D""

  looking at parent device '/devices/platform/68000000.ocp/48058000.ssi-con=
troller/ssi0':
    KERNELS=3D=3D"ssi0"
    SUBSYSTEMS=3D=3D""
    DRIVERS=3D=3D""

  looking at parent device '/devices/platform/68000000.ocp/48058000.ssi-con=
troller':
    KERNELS=3D=3D"48058000.ssi-controller"
    SUBSYSTEMS=3D=3D"platform"
    DRIVERS=3D=3D"omap_ssi"
    ATTRS{driver_override}=3D=3D"(null)"

  looking at parent device '/devices/platform/68000000.ocp':
    KERNELS=3D=3D"68000000.ocp"
    SUBSYSTEMS=3D=3D"platform"
    DRIVERS=3D=3D"omap_l3_smx"
    ATTRS{driver_override}=3D=3D"(null)"

  looking at parent device '/devices/platform':
    KERNELS=3D=3D"platform"
    SUBSYSTEMS=3D=3D""
    DRIVERS=3D=3D""

-Clayton
On Fri, Sep 08, 2017 at 03:29:27AM +0200, Jonas Bonn wrote:
>On 09/08/2017 03:17 AM, Clayton Craft wrote:
>>This is on HSI bus. I am running ofono on the N900 (not tethering).
>
>OK, from what I understand, you should be able to find this device =

>under /sys/class/net/....
>
>See if you can find the device there and run:
>
>udevadm info --query all --path /sys/class/net/....
>and
>udevadm info --attribute-walk --path /sys/class/net.....
>
>Post that output here if it's sane so that we can see what info udev =

>is giving you for the device.
>
>/Jonas
>
>>
>>From what I understand, I am loading all of the necessary drivers for
>>this to work (nokia-modem, which pulls in its dependencies
>>automaticall). As I stated in my original note, before moving 'legacy
>>device' initialization to udevng, ofono would at least 'see' the
>>modem. The test script 'list-modems' would list it, now it does not
>>list anything.
>>
>>-Clayton
>>On Fri, Sep 08, 2017 at 03:13:03AM +0200, Jonas Bonn wrote:
>>>On 09/08/2017 02:51 AM, Clayton Craft wrote:
>>>>Hi,
>>>>I've been debugging why the n900 modem is not recognized by ofono
>>>>for a few days now, and have determined that the cause is because the
>>>>calls in udevng to udev_device_get_devnode return NULL. It seems that
>>>>the nokia-modem driver does not create any device nodes under /dev.
>>>
>>>What bus does this modem sit on?  Are you running ofono _on_ the =

>>>N900 or are you trying to tether the N900 to some system with =

>>>ofono?
>>>
>>>If you are tethering, what udev events do you get when you plug in =

>>>the modem?  Try running "udevadm monitor" and watch what happens =

>>>when you plug the modem in.
>>>
>>>Not getting a device node sounds mostly like there's a driver =

>>>missing, though...
>>>
>>>/Jonas
>>>
>>>>
>>>>This seems to be a regression in functionality since the move to
>>>>udevng as previous versions of ofono seem to detect the n900 modem
>>>>correctly (right before this commit =

>>>>3ac449e25fc8cb9880c48b8f309189c6a644f200)
>>>>This issue occurs from this commit onwards, including the latest commit
>>>>as of this mail.
>>>>
>>>>https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/ude=
vng.c#n1316
>>>>
>>>>
>>>>
>>>>-Clayton
>>>>
>>>>_______________________________________________
>>>>ofono mailing list
>>>>ofono(a)ofono.org
>>>>https://lists.ofono.org/mailman/listinfo/ofono
>>>
>>>
>>>_______________________________________________
>>>ofono mailing list
>>>ofono(a)ofono.org
>>>https://lists.ofono.org/mailman/listinfo/ofono
>>
>>_______________________________________________
>>ofono mailing list
>>ofono(a)ofono.org
>>https://lists.ofono.org/mailman/listinfo/ofono
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>https://lists.ofono.org/mailman/listinfo/ofono


--===============7084376522655710862==--

