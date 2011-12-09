Content-Type: multipart/mixed; boundary="===============7484116771148260305=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Fwd: ofono usage on embedded device
Date: Fri, 09 Dec 2011 17:11:26 +0300
Message-ID: <CAGNC_aM-y-2ZORdP1mHHNWSZQDn1SPhVrmjGBv-ak1QWtkLOiw@mail.gmail.com>
In-Reply-To: <CAGNC_aPHHWLaC2raKWDHNvMQpgkMxvR=NNE9qGK6gQTwubGwCQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7484116771148260305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2011/12/9 Daniel Wagner <wagi@monom.org>:
> Hi Renat,
>
> On 09.12.2011 14:37, Renat Zaripov wrote:
>>> On 09.12.2011 14:08, Sergey Lapin wrote:
>>>> I'm interested in c) because somehow we have troubles with udev in our
>>>> device, systemd detects ttys perfectly while ofono can't find anything
>>>> and it seems
>>>> to see no tty devices at all, so we'd like to use systemd to provide
>>>> ofono with information regarding devices (tty and driver).
>>>> It is unable to connect to udev monitor also. udev version is 175.
>>>
>>> Could you provide some logs?
>>
>> cat /etc/ydev/rules.d/ofono.rules
>>
>> KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"atmodem"
>
> Also 'udevadm monitor' would be helpful.

When we start ofonod nothing in udevadm monitor

#ofonod -n & udevadm monitor
[3] 26496
monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent

ofonod[26496]: oFono version 1.0

because our device is on fixed port which is not USB or anything.

root(a)crux:/mnt/ofono/ofono/src# systemctl list-units|grep ttyS
sys-devi...y-ttyS0.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/crux_serial/tty/ttyS0
sys-devi...y-ttyS1.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/crux_serial/tty/ttyS1
sys-devi...y-ttyS2.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/crux_serial/tty/ttyS2
sys-devi...y-ttyS3.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/crux_serial/tty/ttyS3
sys-devi...ttySAC0.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/s3c2440-uart.0/tty/ttySAC0
sys-devi...ttySAC1.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/s3c2440-uart.1/tty/ttySAC1
sys-devi...ttySAC2.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/s3c2440-uart.2/tty/ttySAC2
sys-devi...ttySAC3.device loaded active =C2=A0 =C2=A0 plugged
/sys/devices/platform/s3c2440-uart.3/tty/ttySAC3

root(a)crux:~# udevadm info --query=3Dall =C2=A0--path /sys/class/tty/ttySA=
C0
P: /devices/platform/s3c2440-uart.0/tty/ttySAC0
N: ttySAC0
E: DEVNAME=3D/dev/ttySAC0
E: DEVPATH=3D/devices/platform/s3c2440-uart.0/tty/ttySAC0
E: MAJOR=3D204
E: MINOR=3D64
E: SUBSYSTEM=3Dtty
E: TAGS=3D:systemd:
E: UDEV_LOG=3D3
E: USEC_INITIALIZED=3D10265578

--===============7484116771148260305==--

