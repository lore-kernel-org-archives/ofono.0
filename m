Content-Type: multipart/mixed; boundary="===============4664035500084079186=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Fri, 08 Sep 2017 20:09:33 -0700
Message-ID: <20170909030933.GA3@computer.craftyguy.net>
In-Reply-To: <aedf5713-9a9b-16b1-2a11-06da07ad5a11@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4664035500084079186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok so after applying the two patches submitted by Jonas, I can get a
little further, but it appears that init is still failing:

ofonod[12522]: plugins/udevng.c:create_modem() /sys/devices/platform/680000=
00.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[12522]: plugins/udevng.c:create_modem() driver=3Dn900
ofonod[12522]: src/modem.c:ofono_modem_create() name: (null), type: n900
ofonod[12522]: plugins/udevng.c:destroy_modem() /sys/devices/platform/68000=
000.ocp/48058000.ssi-controller/ssi0/port0/n900-modem
ofonod[12522]: src/modem.c:ofono_modem_remove() 0x622770
ofonod[12522]: src/private-network.c:ofono_private_network_driver_register(=
) driver: 0x60f334, name: Example Private Network Driver


After poking around in gdb, I've determined that this condition is failing:
from setup_isi_modem in plugins/udevng.c:
        if (g_strcmp0(udev_device_get_subsystem(info->dev), "net") !=3D 0)

It looks like the modem->serial object does not have any valid data. The
cstrings in that struct contain gibberish. info->dev is NULL, and other =

info members are not valid strings and definitely do not represent what the=
y =

should. I added a DBG() print of them here to demonstrate:
ofonod[12905]: plugins/udevng.c:setup_isi_serial() **devpath: `aX, devnode:=
 (null), subsystem: X

Patches applied so far:
https://lists.ofono.org/pipermail/ofono/2017-September/017463.html
https://lists.ofono.org/pipermail/ofono/2017-September/017465.html

-Clayton


On Fri, Sep 08, 2017 at 04:12:25AM +0200, Jonas Bonn wrote:
>On 09/08/2017 03:38 AM, Clayton Craft wrote:
>>Here's the info you requested, please let me know if I can gather
>>anything else to help!
>
>OK, good.  It's not a driver issue in any case.  Now we need to figure =

>out why ofono is rejecting the device.  The debug output from ofonod =

>would be useful.  Try running ofono as:
>
>ofonod -d -n
>
>and paste the output here.
>
>/Jonas
>
>>
>>localhost:/home/user# udevadm info --query all --path =

>>/sys/bus/hsi/devices/n900-modem
>>P: /devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/n900=
-modem
>>E: DEVPATH=3D/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/=
port0/n900-modem
>>E: DRIVER=3Dnokia-modem
>>E: MODALIAS=3Dhsi:n900-modem
>>E: OFONO_DRIVER=3Dn900
>>E: OFONO_ISI_ADDRESS=3D108
>>E: OF_COMPATIBLE_0=3Dnokia,n900-modem
>>E: OF_COMPATIBLE_N=3D1
>>E: OF_FULLNAME=3D/ocp(a)68000000/ssi-controller(a)48058000/ssi-port(a)480=
5a000/hsi-client
>>E: OF_NAME=3Dhsi-client
>>E: SUBSYSTEM=3Dhsi
>>E: USEC_INITIALIZED=3D337086386
>>
>>localhost:/home/user# udevadm info --attribute-walk --path =

>>/sys/bus/hsi/devices/n900-modem
>>
>>Udevadm info starts with the device specified by the devpath and then
>>walks up the chain of parent devices. It prints for every device
>>found, all possible attributes in the udev rules key format.
>>A rule to match, can be composed by the attributes of the device
>>and the attributes from one single parent device.
>>
>> looking at device '/devices/platform/68000000.ocp/48058000.ssi-controlle=
r/ssi0/port0/n900-modem':
>>   KERNEL=3D=3D"n900-modem"
>>   SUBSYSTEM=3D=3D"hsi"
>>   DRIVER=3D=3D"nokia-modem"
>>
>> looking at parent device =

>>'/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0':
>>   KERNELS=3D=3D"port0"
>>   SUBSYSTEMS=3D=3D""
>>   DRIVERS=3D=3D""
>>
>> looking at parent device =

>>'/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0':
>>   KERNELS=3D=3D"ssi0"
>>   SUBSYSTEMS=3D=3D""
>>   DRIVERS=3D=3D""
>>
>> looking at parent device =

>>'/devices/platform/68000000.ocp/48058000.ssi-controller':
>>   KERNELS=3D=3D"48058000.ssi-controller"
>>   SUBSYSTEMS=3D=3D"platform"
>>   DRIVERS=3D=3D"omap_ssi"
>>   ATTRS{driver_override}=3D=3D"(null)"
>>
>> looking at parent device '/devices/platform/68000000.ocp':
>>   KERNELS=3D=3D"68000000.ocp"
>>   SUBSYSTEMS=3D=3D"platform"
>>   DRIVERS=3D=3D"omap_l3_smx"
>>   ATTRS{driver_override}=3D=3D"(null)"
>>
>> looking at parent device '/devices/platform':
>>   KERNELS=3D=3D"platform"
>>   SUBSYSTEMS=3D=3D""
>>   DRIVERS=3D=3D""
>>
>>-Clayton
>>On Fri, Sep 08, 2017 at 03:29:27AM +0200, Jonas Bonn wrote:
>>>On 09/08/2017 03:17 AM, Clayton Craft wrote:
>>>>This is on HSI bus. I am running ofono on the N900 (not tethering).
>>>
>>>OK, from what I understand, you should be able to find this device =

>>>under /sys/class/net/....
>>>
>>>See if you can find the device there and run:
>>>
>>>udevadm info --query all --path /sys/class/net/....
>>>and
>>>udevadm info --attribute-walk --path /sys/class/net.....
>>>
>>>Post that output here if it's sane so that we can see what info =

>>>udev is giving you for the device.
>>>
>>>/Jonas
>>>
>>>>
>>>>From what I understand, I am loading all of the necessary drivers for
>>>>this to work (nokia-modem, which pulls in its dependencies
>>>>automaticall). As I stated in my original note, before moving 'legacy
>>>>device' initialization to udevng, ofono would at least 'see' the
>>>>modem. The test script 'list-modems' would list it, now it does not
>>>>list anything.
>>>>
>>>>-Clayton
>>>>On Fri, Sep 08, 2017 at 03:13:03AM +0200, Jonas Bonn wrote:
>>>>>On 09/08/2017 02:51 AM, Clayton Craft wrote:
>>>>>>Hi,
>>>>>>I've been debugging why the n900 modem is not recognized by ofono
>>>>>>for a few days now, and have determined that the cause is because the
>>>>>>calls in udevng to udev_device_get_devnode return NULL. It seems that
>>>>>>the nokia-modem driver does not create any device nodes under /dev.
>>>>>
>>>>>What bus does this modem sit on?  Are you running ofono _on_ =

>>>>>the N900 or are you trying to tether the N900 to some system =

>>>>>with ofono?
>>>>>
>>>>>If you are tethering, what udev events do you get when you =

>>>>>plug in the modem?  Try running "udevadm monitor" and watch =

>>>>>what happens when you plug the modem in.
>>>>>
>>>>>Not getting a device node sounds mostly like there's a driver =

>>>>>missing, though...
>>>>>
>>>>>/Jonas
>>>>>
>>>>>>
>>>>>>This seems to be a regression in functionality since the move to
>>>>>>udevng as previous versions of ofono seem to detect the n900 modem
>>>>>>correctly (right before this commit =

>>>>>>3ac449e25fc8cb9880c48b8f309189c6a644f200)
>>>>>>This issue occurs from this commit onwards, including the =

>>>>>>latest commit
>>>>>>as of this mail.
>>>>>>
>>>>>>https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/u=
devng.c#n1316
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>-Clayton
>>>>>>
>>>>>>_______________________________________________
>>>>>>ofono mailing list
>>>>>>ofono(a)ofono.org
>>>>>>https://lists.ofono.org/mailman/listinfo/ofono
>>>>>
>>>>>
>>>>>_______________________________________________
>>>>>ofono mailing list
>>>>>ofono(a)ofono.org
>>>>>https://lists.ofono.org/mailman/listinfo/ofono
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


--===============4664035500084079186==--

