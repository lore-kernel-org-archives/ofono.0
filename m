Content-Type: multipart/mixed; boundary="===============3188769868950359257=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofono usage on embedded device
Date: Fri, 09 Dec 2011 04:47:08 -0600
Message-ID: <4EE1E72C.1020904@gmail.com>
In-Reply-To: <CAGNC_aMO6AXGJkBSLPm+ZCCnSWa9wwvE=RJ6R3tK--eAV9qLgA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3188769868950359257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 12/09/2011 07:37 AM, Renat Zaripov wrote:
> 2011/12/9 Daniel Wagner <wagi@monom.org>
>>
>> Hi Sergey,
>>
>> On 09.12.2011 14:08, Sergey Lapin wrote:
>>> I'm interested in c) because somehow we have troubles with udev in our
>>> device, systemd detects ttys perfectly while ofono can't find anything
>>> and it seems
>>> to see no tty devices at all, so we'd like to use systemd to provide
>>> ofono with information regarding devices (tty and driver).
>>> It is unable to connect to udev monitor also. udev version is 175.
>>
>> Could you provide some logs?
> =

> cat /etc/ydev/rules.d/ofono.rules
> =

> KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"atmodem"
> =


'atmodem' is not a modem driver.  You need to specify a modem driver
here, e.g. calypso, huawei, ifx, etc.  If your hardware is not covered
by an existing driver, then you will have to write your own.  By
convention all modem drivers are found in plugins/, e.g.
plugins/calypso.c, plugins/huawei.c, plugins/ifx.c, etc.

Regards,
-Denis

--===============3188769868950359257==--

