Content-Type: multipart/mixed; boundary="===============5474857243037735623=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] xmm7xxx: Fix non compiling file
Date: Tue, 08 Sep 2020 11:02:54 -0500
Message-ID: <43c63174-ad9c-345c-4887-45e17c73b353@gmail.com>
In-Reply-To: <20200903094321.3696246-1-poeschel@lemonage.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5474857243037735623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 9/3/20 4:43 AM, poeschel(a)lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> =

> I get a compilation error on plugins/xmm7xx.c:
> =

>    CC       plugins/xmm7xxx.o
> ../plugins/xmm7xxx.c:63:10: fatal error: dbus.h: No such file or directory
>     63 | #include "dbus.h"
>        |          ^~~~~~~~
> compilation terminated.
> =

> The commit that introduced this for me is: d2fd1721.
> I do out-of-tree builds.
> The fix is to simply delete the failing include. Since no other file in
> ofono uses such an include i consider this as a mistake.
> ---
>   plugins/xmm7xxx.c | 1 -
>   1 file changed, 1 deletion(-)
> =


Applied after tweaking the commit messagee, thanks.

Regards,
-Denis

--===============5474857243037735623==--

