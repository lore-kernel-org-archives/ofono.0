Content-Type: multipart/mixed; boundary="===============3841592931125720562=="
MIME-Version: 1.0
From: Sanjay Mehta <sanjay@haskell.in>
Subject: Re: Which desktop linux distribution uses ofono natively?
Date: Tue, 17 Feb 2015 10:15:50 +0530
Message-ID: <3DD39C20E4854DDFA57C04F00A24EC5D@haskell.in>
In-Reply-To: <mailman.5.1424116801.14952.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3841592931125720562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> From: Christian Gagneraud

> I use to use Ubuntu 13.04 and 13.10 with custom built ofono.
> The problem when you experiment with ofono on your dev machine is that  =

> you will loose your internet connection in case ofono goes nuts. So I  =


I=E2=80=99ve brought up ofono and econnman on Ubuntu 14.04.01 LTS
using the packages available via apt-get on a generic Intel laptop.

Haven=E2=80=99t tested Bluetooth, but it=E2=80=99s working with wifi and wi=
red ethernet. I=E2=80=99m now
trying to figure out how to add =E2=80=9Ccellular=E2=80=9D to the technolog=
ies supported by ofono.

After upgrading the linux kernel to 3.19, I can see wwan0 showing up
in /sys/class/net so the device (a Huawei E3272 LTE dongle) is being
detected by the kernel properly (and it works if I use sakis3g).

I think there was a Huawei specific bug in the shipped version of the
kernel that blocked me earlier.  =


Short of reading the ofono code - which I can do later this week - any poin=
ters
on connecting cellular with ofono?

> would say it's better to run ofono experiment on the embedded board.
> Set up your dev computer with the cross toolchain, and mount (part of)  =

> the board rootfs on your dev computer and build (or install) ofono there.


My target board isn=E2=80=99t ready yet. I could try an experiment with an =
old
Raspberry Pi B.  =


thanks!

Sanjay=20

--===============3841592931125720562==--

