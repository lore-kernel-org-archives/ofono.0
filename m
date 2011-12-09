Content-Type: multipart/mixed; boundary="===============4834493762799034966=="
MIME-Version: 1.0
From: Sergey Lapin <slapinid@gmail.com>
Subject: ofono usage on embedded device
Date: Fri, 09 Dec 2011 16:08:17 +0300
Message-ID: <CAFZPMoaC9LRW-=ApSY207eowO4BhkLZ+xBgpefNjRBBc5tdbpw@mail.gmail.com>
In-Reply-To: <CAFZPMoZGOBOPGtKR578UB3+YRcOvYaR=8f7MM-DgpZQqnUq8Zg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4834493762799034966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, all!

Is it possible to achieve the following with ofono: a) have pppd do
its job re ppp b) use N_GSM in-kernel gsm0710 mux c) use ofono to
start modem with
GPIO, handle SMS and modem setup d) use fixed configuration without
udev support?

I'm interested in c) because somehow we have troubles with udev in our
device, systemd detects ttys perfectly while ofono can't find anything
and it seems
to see no tty devices at all, so we'd like to use systemd to provide
ofono with information regarding devices (tty and driver).
It is unable to connect to udev monitor also. udev version is 175.

This is on generic fixed serial port AT-modem (sim900 actually).

S.

--===============4834493762799034966==--

