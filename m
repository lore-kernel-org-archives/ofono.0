Content-Type: multipart/mixed; boundary="===============5706526265912392276=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/modem.c/call_watches null pointer check
Date: Tue, 23 Oct 2018 11:50:35 -0500
Message-ID: <cc405107-2207-928a-2e48-1e472b7be45b@gmail.com>
In-Reply-To: <CAKSBH7FY_BApefBvEUPJmAkt_baigp8QdiKXuJE8iaZa_vgJSw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5706526265912392276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,
>     0  0x0000563b1842b735 in call_watches
> (atom=3Datom(a)entry=3D0x563b1a3f07d0,
> cond=3Dcond(a)entry=3DOFONO_ATOM_WATCH_CONDITION_UNREGISTERED) at
> src/modem.c:265
>     1  0x0000563b1842c32e in __ofono_atom_unregister
> (atom=3Datom(a)entry=3D0x563b1a3f07d0) at src/modem.c:299
>     2  0x0000563b1842c3ff in __ofono_atom_unregister
> (atom=3D0x563b1a3f07d0) at src/modem.c:296
>     3  flush_atoms (modem=3D0x563b1a3f1f50,
> new_state=3DMODEM_STATE_POWER_OFF) at src/modem.c:448
>     4  modem_change_state (modem=3D0x563b1a3f1f50,
> new_state=3DMODEM_STATE_POWER_OFF) at src/modem.c:529
>     5  0x0000563b1842c577 in set_powered
> (modem=3Dmodem(a)entry=3D0x563b1a3f1f50, powered=3Dpowered(a)entry=3D0) at
> src/modem.c:915
>     6  0x0000563b1842c863 in modem_unregister
> (modem=3Dmodem(a)entry=3D0x563b1a3f1f50) at src/modem.c:2111
>     7  0x0000563b1842e6a4 in ofono_modem_remove (modem=3D0x563b1a3f1f50)
> at src/modem.c:2177
>     8  0x0000563b183b05d3 in destroy_modem (data=3D0x563b1a3e50a0) at
> plugins/udevng.c:1408
>     9  0x00007f42b4bdd091 in ?? () from
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
>     10 0x0000563b183b561a in remove_device (device=3D0x563b1a401630) at
> plugins/udevng.c:1468
>     11 udev_event (channel=3D<optimized out>, cond=3D<optimized out>,
> user_data=3D<optimized out>) at plugins/udevng.c:1991
>     12 0x00007f42b4bef0f5 in g_main_context_dispatch () from
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
>     13 0x00007f42b4bef4c0 in ?? () from
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
>     14 0x00007f42b4bef7d2 in g_main_loop_run () from
> /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
>     15 0x0000563b183b0397 in main (argc=3D<optimized out>,
> argv=3D<optimized out>) at src/main.c:294
> =

> ?

Yes, much better.  So now you can explain to me how you're triggering this.

The only way modem->atom_watches is NULL is if ofono_modem_register =

failed.  So are you trying to use a modem object without registering it =

properly?

Regards,
-Denis


--===============5706526265912392276==--

