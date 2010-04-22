Content-Type: multipart/mixed; boundary="===============2161966461701560920=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] usbpnmodem: configure usbpn interfaces automatically
Date: Thu, 22 Apr 2010 17:51:24 -0500
Message-ID: <201004221751.25146.denkenz@gmail.com>
In-Reply-To: <1271935632-8567-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2161966461701560920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  drivers/isimodem/isimodem.c |    2 +-
>  gisi/netlink.c              |  242
>  ++++++++++++++++++++++++++++++++++++++++--- gisi/netlink.h              =
| =

>   11 ++-
>  plugins/usbpnmodem.c        |   10 ++-
>  4 files changed, 244 insertions(+), 21 deletions(-)
> =

> =


We're quite serious about coding style here:

WARNING: line over 80 characters
#156: FILE: gisi/netlink.c:239:
+				g_critical("Netlink error: %s", strerror(-err->error));

ERROR: code indent should use tabs where possible
#204: FILE: gisi/netlink.c:367:
+        for (; NLMSG_OK(nlh, (size_t)ret); nlh =3D NLMSG_NEXT(nlh, ret)) {$

WARNING: line over 80 characters
#210: FILE: gisi/netlink.c:373:
+			struct nlmsgerr *err =3D (struct nlmsgerr *)NLMSG_DATA(nlh);

ERROR: need consistent spacing around '|' (ctx:VxW)
#306: FILE: gisi/netlink.c:469:
+					| NLM_F_CREATE| NLM_F_APPEND,

Regards,
-Denis

--===============2161966461701560920==--

