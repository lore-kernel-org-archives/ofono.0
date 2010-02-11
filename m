Content-Type: multipart/mixed; boundary="===============8690553415012668155=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] Add support of Huawei EM770 modem
Date: Thu, 11 Feb 2010 13:54:05 +0800
Message-ID: <1EC975D79B8B1F4BBDC50EA54418A004125A3D3709@shzsmsx501.ccr.corp.intel.com>
In-Reply-To: <201002101637.32713.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8690553415012668155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Andrew and Denis,


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Denis Kenzior
>Sent: Thursday, February 11, 2010 6:38 AM
>To: ofono(a)ofono.org
>Subject: Re: [PATCH] Add support of Huawei EM770 modem
>
>Hi Yang,
>
>> There are two known parts of code that may have problem and need your
>>  comments. 1. Once connecting this modem to PC via USB, we can get 5 tty
>>  ports: ttyUSB0, ttyUSB1, ttyUSB2, ttyUSB3 and ttyUSB4. The correct way =
to
>>  talk to this modem is using ttyUSB2. I'm not sure if I handled this
>>  correctly in file udev.c. 2. When creating the modem, a global modem id
>
>So Andrew had it exactly correct, you can't just use ttyUSB2 here.  Most
>devices have other udev attributes you can examine for what type of port it
>is, to help you pick the right one.  Perhaps examination of 'udevadm info =
--
>attribute-walk --path=3D<device>' might be in order?

The check of "ttyUSB2" in my code is not the same as you see in /dev direct=
ory. =

Below is the output of this modem along its path (not a full path and I rem=
oved some unimportant attributes in each path):
  looking at device '/devices/pci0000:00/0000:00:1a.7/usb1/1-3/1-3:1.2/ttyU=
SB2/tty/ttyUSB2':  (device1)
    KERNEL=3D=3D"ttyUSB2"
    SUBSYSTEM=3D=3D"tty"
    DRIVER=3D=3D""

  looking at parent device '/devices/pci0000:00/0000:00:1a.7/usb1/1-3/1-3:1=
.2/ttyUSB2': (device2)
    KERNELS=3D=3D"ttyUSB2"
    SUBSYSTEMS=3D=3D"usb-serial"
    DRIVERS=3D=3D"option1"
    ATTRS{port_number}=3D=3D"0"

  looking at parent device '/devices/pci0000:00/0000:00:1a.7/usb1/1-3/1-3:1=
.2': (device3)
    KERNELS=3D=3D"1-3:1.2"
    SUBSYSTEMS=3D=3D"usb"
    DRIVERS=3D=3D"option"
    ATTRS{bInterfaceNumber}=3D=3D"02"
    ATTRS{modalias}=3D=3D"usb:v12D1p1404d0000dc00dsc00dp00icFFiscFFipFF"
    ATTRS{supports_autosuspend}=3D=3D"0"

  looking at parent device '/devices/pci0000:00/0000:00:1a.7/usb1/1-3':(dev=
ice4)
    KERNELS=3D=3D"1-3"
    ATTRS{configuration}=3D=3D"Huawei   Configuration"
    ATTRS{bNumInterfaces}=3D=3D" 5"
    ATTRS{idVendor}=3D=3D"12d1"
    ATTRS{idProduct}=3D=3D"1404"
    ATTRS{manufacturer}=3D=3D"HUAWEI Technology"
    ATTRS{product}=3D=3D"HUAWEI Mobile"

In oFono code, "device4" represents the modem, while "device1" is the udev_=
device when calling function add_huawei_em770(modem, udev_device). When I c=
heck if it's ttyUSB2 or not in my code, I think I'm checking the device1 an=
d its sysname (Showed as KERNEL in device1, but not the one showed in /dev =
directory), and in the context of this modem (device4). I do believe there =
may be some other ttyUSB2 in the system, for example, we have another em770=
 modem pluged in. But these two ttyUSB2 are in different context. I ever tr=
ied to change the name showed in /dev directory by writing some udev rules,=
 but this sysname (KERNEL) seems stable (It's still ttyUSB2). Is it possibl=
e this sysname gets changed under some circumstance expect the kernel or dr=
iver changes? If not, I still think it's safe and convenient to check this =
value here. =

Maybe we can use another attribute "bInterfaceNumber". But this attribute i=
s udev_device's parent's parent (device3), so the code could become more co=
mplicated. What's your opinion?

>
>>  will be appended to the name of it while constructing the path. This mo=
dem
>>  has name "huawei_em770", thus the path becomes things like
>>  "/huawei_em7700" or "/huawei_em7701". This looks strange. Need I change
>>  the name of this modem, or can we use some smarter way to append the mo=
dem
>>  id?
>
>We should be using the udev short serial from the device.  For some reason
>this seems to be failing on the EM770.  Can you check whether get_serial
>returns NULL for this device?

Yes. get_serial() will return NULL, and we just use its type as name. =


>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono


Regards,
-Yang

--===============8690553415012668155==--

