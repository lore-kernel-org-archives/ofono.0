Content-Type: multipart/mixed; boundary="===============7942858434829789935=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] src/modem.c/call_watches null pointer check
Date: Tue, 23 Oct 2018 18:39:25 +0200
Message-ID: <CAKSBH7FY_BApefBvEUPJmAkt_baigp8QdiKXuJE8iaZa_vgJSw@mail.gmail.com>
In-Reply-To: <25c17be1-239f-ce47-5a89-76b9b64ee641@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7942858434829789935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, Oct 23, 2018 at 4:47 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
> >
> > you mean something like the following or more?
> >
>
> Yes, but something that is actually useful and not a bunch of memory
> locations.  e.g.
>
> git show a99c0be535410a92773ffdfbebb766bec66b66fe
>
> Regards,
> -Denis

   0  0x0000563b1842b735 in call_watches
(atom=3Datom(a)entry=3D0x563b1a3f07d0,
cond=3Dcond(a)entry=3DOFONO_ATOM_WATCH_CONDITION_UNREGISTERED) at
src/modem.c:265
   1  0x0000563b1842c32e in __ofono_atom_unregister
(atom=3Datom(a)entry=3D0x563b1a3f07d0) at src/modem.c:299
   2  0x0000563b1842c3ff in __ofono_atom_unregister
(atom=3D0x563b1a3f07d0) at src/modem.c:296
   3  flush_atoms (modem=3D0x563b1a3f1f50,
new_state=3DMODEM_STATE_POWER_OFF) at src/modem.c:448
   4  modem_change_state (modem=3D0x563b1a3f1f50,
new_state=3DMODEM_STATE_POWER_OFF) at src/modem.c:529
   5  0x0000563b1842c577 in set_powered
(modem=3Dmodem(a)entry=3D0x563b1a3f1f50, powered=3Dpowered(a)entry=3D0) at
src/modem.c:915
   6  0x0000563b1842c863 in modem_unregister
(modem=3Dmodem(a)entry=3D0x563b1a3f1f50) at src/modem.c:2111
   7  0x0000563b1842e6a4 in ofono_modem_remove (modem=3D0x563b1a3f1f50)
at src/modem.c:2177
   8  0x0000563b183b05d3 in destroy_modem (data=3D0x563b1a3e50a0) at
plugins/udevng.c:1408
   9  0x00007f42b4bdd091 in ?? () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
   10 0x0000563b183b561a in remove_device (device=3D0x563b1a401630) at
plugins/udevng.c:1468
   11 udev_event (channel=3D<optimized out>, cond=3D<optimized out>,
user_data=3D<optimized out>) at plugins/udevng.c:1991
   12 0x00007f42b4bef0f5 in g_main_context_dispatch () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
   13 0x00007f42b4bef4c0 in ?? () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
   14 0x00007f42b4bef7d2 in g_main_loop_run () from
/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
   15 0x0000563b183b0397 in main (argc=3D<optimized out>,
argv=3D<optimized out>) at src/main.c:294

?
Regards,
Giacinto

--===============7942858434829789935==--

