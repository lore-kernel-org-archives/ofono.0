Content-Type: multipart/mixed; boundary="===============0698345895523769839=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Wed, 02 Apr 2014 11:39:35 -0700
Message-ID: <7247E8A2-DA61-4DB6-9995-7B127B7780EA@holtmann.org>
In-Reply-To: <1396446981-19749-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0698345895523769839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

> In testing it is sometimes useful to be able to replace the system ofono =
daemon
> instance with our own. This patch makes this possible using dbus' name re=
placement
> feature. This patch has the plumbing changes to make it possible to set t=
he
> name replacement settings. The next patch allows you to set these paramet=
ers
> from the command line. The default behaviour does not change, i.e. the se=
rvice
> name is not replaceable and the daemon will not try to replace an existin=
g ofono
> instance.

what is this useful for. We have been running oFono for more than 4 years a=
nd BlueZ with D-Bus for over 10 years and never had the need for doing this=
. So I do not understand why we would support this.

> ---
> dundee/main.c        |  2 +-
> gdbus/gdbus.h        | 12 +++++++++---
> gdbus/mainloop.c     | 22 ++++++++++++++=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94

And gdbus/ changes must always be in a separate patch. This code is used by=
 ConnMan, oFono, BlueZ etc.

Regards

Marcel


--===============0698345895523769839==--

