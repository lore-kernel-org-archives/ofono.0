Content-Type: multipart/mixed; boundary="===============4123199826399743397=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: ofono exits after DBUS error
Date: Tue, 18 Sep 2012 10:34:03 +0200
Message-ID: <CABvLYuDhE3Qeko2sffSt25yp1OOgdzJ2N0LSf_E6E_-vspY0Lw@mail.gmail.com>
In-Reply-To: <505767F9.9060909@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4123199826399743397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> What devices have you tried?  It may be the character is garbage, but it
> might also be it is not.  From the AT log the character you're getting is
> inverted exclamation point in Latin1 and it is a valid character in GSM
> character set...

Let me give you a background on the operators first. The operator i'm
using is is "Mobile Vikings", this is a virtual operator using the
network of an operator called "BASE".

I have three devices to test on:
- Huawei E1552:
  The first response to AT+COPS? to this device returns "Mobile
Vikings". After oFono changes to numeric format and back (AT+COPS=3D3,2
then back to AT+COPS=3D3,0), the device starts to return "BASEx". I've
already seen this return "BASE\241", "BASE0" or "BASEP". So the last
character seems pseudo-random.

- Huawei E352:
  For some reason this device doesn't register on the network, so i
don't know the output for AT+COPS?

- Option ICON 431:
  This always returns "Mobile Vikings" to AT+COPS?

regards,
Cedric

--===============4123199826399743397==--

