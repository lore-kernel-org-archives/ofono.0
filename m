Content-Type: multipart/mixed; boundary="===============4761838111537234433=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Segmentation fault
Date: Thu, 06 Aug 2009 17:03:37 -0500
Message-ID: <200908061703.37562.denkenz@gmail.com>
In-Reply-To: <4A7AC3BF.1090008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4761838111537234433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> [root(a)localhost ~]# dbus-send --print-reply --system --dest=3Dorg.ofono=
 /
> org.ofono.at.Manager.Create string:"dev:/dev/ttyACM0" string:"at"
> method return sender=3D:1.404 -> dest=3D:1.405 reply_serial=3D2
>    object path "/modem1"
> [root(a)localhost ~]# dbus-send --print-reply --system --dest=3Dorg.ofono=
 /
> org.ofono.at.Manager.Destroy objpath:"/modem1"
> method return sender=3D:1.404 -> dest=3D:1.406 reply_serial=3D2
> [root(a)localhost ~]# dbus-send --print-reply --system --dest=3Dorg.ofono=
 /
> org.ofono.at.Manager.Create string:"dev:/dev/ttyACM0" string:"at"
> method return sender=3D:1.404 -> dest=3D:1.407 reply_serial=3D2
>    object path "/modem2"
>
> gdb output:
>
> ofonod[2191]: SIMManager interface for modem: /modem2 created
> ofonod[2191]: Registered call forwarding interface
> ofonod[2191]: Registered call settings interface
> ofonod[2191]: Sending voice initialization commands
> ofonod[2191]: cops_list_cb got result: 1
> ofonod[2191]: Final response: OK
> ofonod[2191]: Got 0 elements
>
> Program received signal SIGSEGV, Segmentation fault.
> operator_list_callback (error=3D0xbfffe85c, total=3D0, list=3D0x0,
> data=3D0x80888f0) at network.c:981
> 981     network.c: No such file or directory.
>         in network.c

This should not be fixed upstream.  Can you check if this is still broken?

Regards,
-Denis


--===============4761838111537234433==--

