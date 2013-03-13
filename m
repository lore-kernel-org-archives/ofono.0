Content-Type: multipart/mixed; boundary="===============3426585182732486127=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: QMI and MBIM: Do you want a "Max Command Size" ioctl?
Date: Wed, 13 Mar 2013 10:52:25 +0100
Message-ID: <878v5r8w4m.fsf@nemi.mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3426585182732486127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

this question is relevant for both QMI and MBIM support. You do need to
know the exact message size used by the device (and driver) when using
/dev/cdc-wdmX devices.  This is particularily important for MBIM, where
the size differs from device to device, and MBIM management will fail if
you use the wrong value.  Currently you have to parse the MBIM
descriptors to retrieve it.  But the question is also relevant for QMI,
where you should use whatever the driver uses, and have no other way to
find out than reading the driver source and copy the value from there.

The obvious simpler alternative is to make the driver export the value
to userspace.

We're currently discussing if and how such an userspace API should be
added to cdc-wdm.c, effectively implementing it for all the three
drivers qmi_wwan, cdc_mbim and cdc-wdm.

The current proposal [1] is adding a new ioctl.

As an userspace API is carved in diamond when it is added, we need to be
absolutely sure this is the right thing to do before going forward.
Greg KH has requested [2] acks from the userspace authors:

 " Oh, also get the
   userspace authors to agree and sign-off on this, I want their agreement
   that this is something they can support.
 "

As for the discussion of sysfs vs ioctl, I believe Oliver summarized [3]
the advantages of the ioctl quite nicely.

There are more details in the rest of the thread if anyone is
interested, including an alternative sysfs implementation.

Sample usage will of course be quite simple from any C application:

#include <linux/usb/cdc-wdm.h>
        __u16 msgsize;
        int fd =3D open("/dev/cdc-wdm0", O_RDWR);
	if (ioctl(fd, IOCTL_WDM_MAX_COMMAND, &msgsize) < 0) {
           /* then fall back to whatever you do today, using
            * a fixed value or parsing USB descriptors
            */
        }

The questions for you as userspace authors are:
 a) Should these drivers export "max message size" to userspace?
 b) Is an ioctl the best solution?
 c) Will you use the ioctl in your userspace implementation?

I really appreciate any feedback, including "We do not want this at
all".  Thanks.


Bj=C3=B8rn

[1] http://www.spinics.net/lists/linux-usb/msg81650.html
[2] http://www.spinics.net/lists/linux-usb/msg81811.html
[3] http://www.spinics.net/lists/linux-usb/msg81679.html

--===============3426585182732486127==--

