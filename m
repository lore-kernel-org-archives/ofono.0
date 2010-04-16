Content-Type: multipart/mixed; boundary="===============6071899773027410832=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] Add skeleton of src/emulator.c
Date: Fri, 16 Apr 2010 15:17:17 -0500
Message-ID: <201004161517.17861.denkenz@gmail.com>
In-Reply-To: <1271168299-4862-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6071899773027410832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> ---
>  Makefile.am        |    7 +-
>  include/dbus.h     |    1 +
>  include/emulator.h |   75 +++++++++++++++++++
>  src/emulator.c     |  203
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++ src/ofono.h        =

| =

>    4 +
>  5 files changed, 287 insertions(+), 3 deletions(-)
>  create mode 100644 include/emulator.h
>  create mode 100644 src/emulator.c
> =


I suggest we handle this one a bit differently.  Let us create an Emulator =
atom =

that has no driver (similar to how MessageWaiting atom works).  Then have e=
ach =

interested atom declare an atom watch on the Emulator atom.  When one is =

created, let the atom get notified and register any AT command handlers it =

wishes.  If the atom itself goes away, it needs to de-register at commands =

from all relevant emulators.

Potentially there might be several emulators at once in the system (e.g. on=
e =

for DUN, one for HFP, one for SPP, etc)

Regards,
-Denis

--===============6071899773027410832==--

