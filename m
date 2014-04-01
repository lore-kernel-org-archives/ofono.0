Content-Type: multipart/mixed; boundary="===============6484791937664613345=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Ofono not "recognizing" some USB dongles
Date: Tue, 01 Apr 2014 15:31:23 +0200
Message-ID: <533ABFAB.5000306@monom.org>
In-Reply-To: <CAM5ihG8n58RUnuyjfBiLegDTWyhNf_DSys1rwAtajK8gV3+VDQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6484791937664613345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/31/2014 11:25 PM, Jer=C3=B4nimo Lopes wrote:
> Long story, I'm trying to setup a system using Buildroot, Beaglebone
> Black, Connman, Ofono, and 3G USB dongles to connect to the internet.
> =

> I have 3 usb dongles (names showed at their plastic case):  =

>  - ZTE MF-190: not working
>  - Huawei E173: not working =

>  - Huawei E160: working
> =

> I'm attaching some log information of the dongles.
> =

> Both not working ones, are working at a PC with Ubuntu 13.10. Also they
> are recognized as the same device on Beaglebone and PC.
> =

> I'm aware that it's probably not a 'Ofono problem'. I'm using buildroot
> default kernel for the Beaglebone and set some options myself, like USB
> Serial Converter (not enabled by default), so there is a big probability
> that something is missing.

FWIW, didn't look at the logs, but one common problem I am aware of is
the missing support of CONFIG_TUN in the kernel.

HTH,
daniel

--===============6484791937664613345==--

