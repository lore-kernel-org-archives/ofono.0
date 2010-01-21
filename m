Content-Type: multipart/mixed; boundary="===============3238967865143791238=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [RFC] HFP support into oFono and BlueZ
Date: Thu, 21 Jan 2010 14:28:08 +0800
Message-ID: <8B81FACE836F9248894A7844CC0BA8141C9C543163@shzsmsx501.ccr.corp.intel.com>
In-Reply-To: <fbf08281001201158q23d13d9bj930a66271c527b43@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3238967865143791238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Padovan,

Gustavo F. Padovan wrote:
>> New version of the patches. Known issues:
>> "'org.bluez.HandsfreeAgent.Release' part not implemented" and it's
>> not working with more than one bluetooth devices in some cases.
>> Comments are welcome. =

>> =

> =

> Another new version of the patches. Now ofono query all bluetooth
> devices and searches for the ones with Gateway interface. Bluez has
> some fixes and now supports connection coming from the AG. =

> The patches are using a per-device agent as described by the last
> version of Handsfree API. =

> =

> I did not implemented yet 'org.bluez.HandsfreeAgent.Release'.
> =

> Comments are welcome. :)

Two small comments.

1. Remove unused variables.

make --no-print-directory all-am
  CC     plugins/hfp.o
cc1: warnings being treated as errors
plugins/hfp.c: In function =E2=80=98get_properties_cb=E2=80=99:
plugins/hfp.c:500: error: unused variable =E2=80=98err=E2=80=99
plugins/hfp.c: In function =E2=80=98list_devices_cb=E2=80=99:
plugins/hfp.c:529: error: unused variable =E2=80=98modem=E2=80=99
plugins/hfp.c: In function =E2=80=98hfp_probe=E2=80=99:
plugins/hfp.c:656: error: unused variable =E2=80=98data=E2=80=99
make[1]: *** [plugins/hfp.o] Error 1
make: *** [all] Error 2

2. You may use Linux kernel /scripts/checkpatch.pl to check your patch.
E.g, there're trailing space in 0002.patch line 832.

Regards,
Zhenhua

--===============3238967865143791238==--

