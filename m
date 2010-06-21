Content-Type: multipart/mixed; boundary="===============2048050659013044226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-common: Avoid accessing an unitialised variable.
Date: Mon, 21 Jun 2010 16:11:29 -0500
Message-ID: <201006211611.29462.denkenz@gmail.com>
In-Reply-To: <1277109671-7452-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2048050659013044226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Fixes a segfault, reported by valrgind as:
> [...]
> =3D=3D6300=3D=3D Use of uninitialised value of size 4
> =3D=3D6300=3D=3D    at 0x8048B4D: test_invalid (test-common.c:81)
> ---
>  unit/test-common.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Good catch.  Patch has been applied.

Regards,
-Denis

--===============2048050659013044226==--

