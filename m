Content-Type: multipart/mixed; boundary="===============2257181898376666363=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] document getting of ell, point people at useful docs
Date: Sat, 02 Feb 2019 13:18:27 +0100
Message-ID: <EA0A1B7C-3B09-4258-B4AA-FA04F5A7911C@holtmann.org>
In-Reply-To: <20190201222554.GA22438@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2257181898376666363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>>> diff --git a/README b/README
>>> index 45bb2e9..04a50a5 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -16,11 +16,14 @@ To configure run:
>>> 	./configure --prefix=3D/usr --mandir=3D/usr/share/man \
>>> 				--sysconfdir=3D/etc --localstatedir=3D/var
>>> =

>>> -Configure automatically searches for all required components and packa=
ges.
>>> +Configure automatically searches for all required components and
>>> +packages, except ell, mentioned below.
>>> =

>> =

>> Nope. Since ELL is actually optional. It is clearly described just a few=
 lines below.
>> =

> =

> Is it optional? This is definitely unclear. Are we looking at same README?
> =

> commit 55e5a766f2833d6aaaf98d0f8cc250585717bc07
> Author: Nandini Rebello <nandini.rebello@intel.com>
> Date:   Wed Jan 16 12:15:31 2019 +0530
> =

> README says:
> =

> Embedded Linux library
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> In order to compile the daemon and utilities the development version
> of Embedded Linux library is required to be present. The development
> repositories can be found here:
> =

> which sounds like "required" to me. Then there is:
> =

> When using --enable-external-ell build option, it is not required that
> the Embedded Linux library source code is available in the top level
> directory.
> =

> But I read it as "can be present somewhere else".
> =

> Plus, build actually fails, with pretty cryptic error message:
> =

> ./bootstrap-configure
> ./configure
> pavel(a)duo:~/g/ofono$ make
> make --no-print-directory all-am
> make[1]: *** No rule to make target 'ell/util.c', needed by
> 'ell/util.lo'.  Stop.
> Makefile:2066: recipe for target 'all' failed
> make: *** [all] Error 2

we can improve the check for the built-in copy of ELL. That is something th=
at should be done for sure and I will look into that.

However for the actual released tarballs, ELL is present. So using the an e=
xternal ELL is optional. The difference is between building from the GIT tr=
ee and building from the tarballs.

Regards

Marcel


--===============2257181898376666363==--

