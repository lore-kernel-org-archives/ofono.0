Content-Type: multipart/mixed; boundary="===============2380438907703713233=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: ofono usage on embedded device
Date: Fri, 09 Dec 2011 14:41:16 +0100
Message-ID: <4EE20FFC.6070109@monom.org>
In-Reply-To: <CAGNC_aMO6AXGJkBSLPm+ZCCnSWa9wwvE=RJ6R3tK--eAV9qLgA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2380438907703713233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 09.12.2011 14:37, Renat Zaripov wrote:
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

Also 'udevadm monitor' would be helpful.

cheers,
daniel


--===============2380438907703713233==--

