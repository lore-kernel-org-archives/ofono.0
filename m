Content-Type: multipart/mixed; boundary="===============1233693626392524300=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Particular APN and Ofono+Connman+BBB+Buildroot
Date: Thu, 27 Mar 2014 14:48:22 -0500
Message-ID: <53348086.7000905@gmail.com>
In-Reply-To: <CAM5ihG_u9EwcnSP+PyCyLUCevd06C3HfP3b0t4k=x3zG6NYx3w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1233693626392524300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jer=C3=B4nimo,

> As fair as I understand, ofono gets the correct APN settings using
> Gnome Service Provider Database.

Not necessarily.  Mobile Broadband Provider Info can be used, but the
provisioning system is plugin based.  You can write your own if you
wish.  See examples/provision.c in oFono git.

> =

> My questions are:
>  - How can I 'tell' ofono to use a specific APN settings?

One can edit context settings via the D-Bus interface, if that is what
you mean.  See test/create-internet-context for an example.

>  - It seams that ofono only works if is started after usb-modeswitch
> detects the modem and create /dev/ttyUSBx devices. Is there anything to
> do to configure that to work properly? =

> =


As long as the modem is configured by usb-modeswitch properly and
detected by udev, the order of events doesn't matter.  oFono will detect
"hot-plugged" devices.

Regards,
-Denis


--===============1233693626392524300==--

