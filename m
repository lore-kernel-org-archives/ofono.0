Content-Type: multipart/mixed; boundary="===============3179127453743593930=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: SEGFAULT on sim_remove()
Date: Mon, 26 Mar 2018 17:32:26 +0200
Message-ID: <92c03f6f-8ab7-d1a7-07d4-7c8aba94ef2f@smile.fr>
In-Reply-To: <577d9298-f71c-aa5b-ddc3-11a2cdad07f9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3179127453743593930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

On 26/03/2018 17:25, Denis Kenzior wrote:
> Hi Gabriel,
>
>> gdb backtrace:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> __ofono_sim_remove_session_watch (session=3D0x74656e, id=3D16) at =

>> src/sim.c:3616
>> 3616=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __ofono_watchlist_remove_item(=
session->watches, id);
>> (gdb) bt
>> #0=C2=A0 __ofono_sim_remove_session_watch (session=3D0x74656e, id=3D16) =
at =

>> src/sim.c:3616
>> #1=C2=A0 0x000e368c in sim_fs_op_free (pointer=3D0x172498) at src/simfs.=
c:102
>
> Are you running upstream?=C2=A0 There's nothing relevant at that line now.
>
> This should have been fixed in commit =

> a99c0be535410a92773ffdfbebb766bec66b66fe by the way.
It is not exactly the upstream version but I've already applied this =

patch and my changes compared to
the upstream version doesn't concern the SIM neither the driver's =

disable function.

Looks like a double-free. I'll investigate deeper tomorrow.

Regards,
Gabriel

--===============3179127453743593930==--

