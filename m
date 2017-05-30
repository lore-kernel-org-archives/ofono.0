Content-Type: multipart/mixed; boundary="===============0196734890712999898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Crash in sim_query_fac_pinlock_cb
Date: Tue, 30 May 2017 18:12:09 -0500
Message-ID: <c60061de-4df4-fd9f-3af7-fd3a87ab828c@gmail.com>
In-Reply-To: <8b6a22c9-ceb2-46ba-dcb7-ad853de424bc@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0196734890712999898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/23/2017 11:39 AM, cantabile wrote:
> Hello.
>
> Ofono crashes as soon as I plug in my Nokia 5230 in "OVI Suite" mode.
> Ofono is the latest from git. Here is the backtrace:
>
> (gdb) bt full
> #0  0x0000000000526a5f in sim_query_fac_pinlock_cb
> (error=3D0x7fffffffdfd0, status=3D8799424, data=3D0x2) at src/sim.c:2476
>         sim =3D 0x2
> #1  0x000000000044faa0 in check_sec_response (msg=3D0x7fffffffe120,
> opaque=3D0x80c370, success=3D2 '\002', failure=3D3 '\003') at
> drivers/isimodem/sim.c:468
>         e =3D {type =3D OFONO_ERROR_TYPE_NO_ERROR, error =3D 0}
>         __ofono_debug_desc =3D {name =3D 0x0, file =3D 0x58f389
> "drivers/isimodem/sim.c", flags =3D 0}
>         __ofono_debug_desc =3D {name =3D 0x0, file =3D 0x58f389
> "drivers/isimodem/sim.c", flags =3D 0}
>         __ofono_debug_desc =3D {name =3D 0x0, file =3D 0x58f389
> "drivers/isimodem/sim.c", flags =3D 0}
>         __ofono_debug_desc =3D {name =3D 0x0, file =3D 0x58f389
> "drivers/isimodem/sim.c", flags =3D 0}
>         cbd =3D 0x80c370
>         cb =3D 0x526a40 <sim_query_fac_pinlock_cb>
>         sim =3D 0x8644c0
>         id =3D 2 '\002'
>         cause =3D 0 '\000'
> #2  0x000000000044fc57 in sec_code_state_resp_cb (msg=3D0x7fffffffe120,
> opaque=3D0x80c370) at drivers/isimodem/sim.c:649
> No locals.
> #3  0x0000000000436ae6 in pending_remove_and_dispatch (op=3D0x80c590,
> msg=3D0x7fffffffe120) at gisi/modem.c:171
>         modem =3D 0x8de2b0
> #4  0x0000000000437e04 in service_dispatch (mux=3D0x830a50,
> msg=3D0x7fffffffe120, is_indication=3D0) at gisi/modem.c:218
>         next =3D 0x0
>         pend =3D 0x80c590
>         msgid =3D 2 '\002'
>         utid =3D 3 '\003'
>         l =3D 0x8a8400 =3D {0x80baa0}
> #5  0x00000000004358e6 in isi_callback (channel=3D0x8df790, cond=3DG_IO_I=
N,
> data=3D0x8de2b0) at gisi/modem.c:334
>         msg =3D {addr =3D 0x7fffffffe160, version =3D 0x830a60, error =3D=
 0,
> data =3D 0x7fffffffe0f0, len =3D 4, private =3D 0x7ffff7b39670
> <g_thread_self+16>}
>         key =3D 8
>         buf =3D 0x7fffffffe0f0
>         addr =3D {spn_family =3D 35, spn_obj =3D 46 '.', spn_dev =3D 0 '\=
000',
> spn_resource =3D 8 '\b', __pad =3D "\000\000\000\000\000\000\000\000\000\=
000"}
>         mux =3D 0x830a50
>         modem =3D 0x8de2b0
>         len =3D 4
>         fd =3D 11
> #6  0x00007ffff7b1145a in g_main_context_dispatch () from
> /usr/lib/libglib-2.0.so.0
> No symbol table info available.
> #7  0x00007ffff7b11810 in ?? () from /usr/lib/libglib-2.0.so.0
> No symbol table info available.
> #8  0x00007ffff7b11b32 in g_main_loop_run () from /usr/lib/libglib-2.0.so=
.0
> No symbol table info available.
> #9  0x00000000004eebee in main (argc=3D1, argv=3D0x7fffffffe428) at
> src/main.c:256
>         context =3D 0x803df0
>         err =3D 0x0
>         conn =3D 0x80a440
>         error =3D {name =3D 0x0, message =3D 0x0, dummy1 =3D 1, dummy2 =
=3D 0,
> dummy3 =3D 1, dummy4 =3D 1, dummy5 =3D 0, padding1 =3D 0x720000007b}
>         signal =3D 1
> (gdb)
>
>
> You'll notice that the function pointer cb being called in
> check_sec_response (frame #1) is of type
>
> typedef void (*ofono_sim_lock_unlock_cb_t)(const struct ofono_error
> *error, void *data);
>
> It takes two parameters. The value of the function pointer is
> sim_query_fac_pinlock_cb, which takes three parameters.

It is quite obvious the driver implementation is wrong.  Someone was a =

bit too copy-paste happy.  When this driver was submitted, the query API =

was not being exercised, hence this path was never tested.

I do not know/have the ISI specs, nor do I have any functional ISI =

hardware.  In effect, the ISI driver code is not maintained.  If you =

want to fix this, then you will need to figure out what the callback =

implementation should look like.  Perhaps this RFC version of the =

current driver code might be of use, see sec_code_state_resp_cb() in =

particular:
https://lists.ofono.org/pipermail/ofono/2010-October/005154.html

Regards,
-Denis

--===============0196734890712999898==--

