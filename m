Content-Type: multipart/mixed; boundary="===============1499197555778072328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] build: require glib >= 2.60
Date: Fri, 05 Mar 2021 08:49:13 -0600
Message-ID: <718f5a16-8605-c043-e95b-299eeab44476@gmail.com>
In-Reply-To: <20210226054117.2871.32381@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1499197555778072328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
> - AC_MSG_ERROR(GLib >=3D 2.32 is required))
> +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.60, dummy=3Dyes,
> + AC_MSG_ERROR(GLib >=3D 2.60 is required))

This patch doesn't apply:
denkenz(a)localhost ~/ofono-master $ git am ~/merge/\[PATCH\]\ build\:\ req=
uire\ =

glib\ \>\=3D\ 2.60.eml
Applying: build: require glib >=3D 2.60
error: corrupt patch at line 12
Patch failed at 0001 build: require glib >=3D 2.60
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Looks like it is whitespace-mangled or otherwise damaged for some reason.

Regards,
-Denis
--===============1499197555778072328==--

