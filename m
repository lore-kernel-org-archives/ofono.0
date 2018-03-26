Content-Type: multipart/mixed; boundary="===============5074376318326342424=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SEGFAULT on sim_remove()
Date: Mon, 26 Mar 2018 10:25:41 -0500
Message-ID: <577d9298-f71c-aa5b-ddc3-11a2cdad07f9@gmail.com>
In-Reply-To: <ec4f4945-fead-4181-3667-406d93c84113@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5074376318326342424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

> gdb backtrace:
> =

> Program received signal SIGSEGV, Segmentation fault.
> __ofono_sim_remove_session_watch (session=3D0x74656e, id=3D16) at =

> src/sim.c:3616
> 3616=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __ofono_watchlist_remove_item(s=
ession->watches, id);
> (gdb) bt
> #0=C2=A0 __ofono_sim_remove_session_watch (session=3D0x74656e, id=3D16) a=
t =

> src/sim.c:3616
> #1=C2=A0 0x000e368c in sim_fs_op_free (pointer=3D0x172498) at src/simfs.c=
:102

Are you running upstream?  There's nothing relevant at that line now.

This should have been fixed in commit =

a99c0be535410a92773ffdfbebb766bec66b66fe by the way.

Regards,
-Denis

--===============5074376318326342424==--

