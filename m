Content-Type: multipart/mixed; boundary="===============9015929481531340730=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: SEGFAULT on sim_remove()
Date: Thu, 29 Mar 2018 13:23:58 +0200
Message-ID: <8b36867e-e89c-c693-1f3c-6efca0d13933@smile.fr>
In-Reply-To: <92c03f6f-8ab7-d1a7-07d4-7c8aba94ef2f@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9015929481531340730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I've been investigating for the reason of the SIGSEGV signal.

Valgrind tells me that I'm reading an already-freed sector.

I've added some debug information in:

- src/sim.c:sim_remove: see below

- src/simfs.c:sim_fs_context_free: freed sim_context

- src/simfs.c:sim_fs_op_free: freed sim_fs_op and sim_fs_op::context pointer


Here is the sim_remove function called when disabling the gemalto's plugin

static void sim_remove(struct ofono_atom *atom)
{
 =C2=A0=C2=A0=C2=A0 struct ofono_sim *sim =3D __ofono_atom_get_data(atom);

 =C2=A0=C2=A0=C2=A0 DBG("atom: %p", atom);

 =C2=A0=C2=A0=C2=A0 if (sim =3D=3D NULL)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return;

 =C2=A0=C2=A0=C2=A0 if (sim->driver !=3D NULL && sim->driver->remove !=3D N=
ULL)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sim->driver->remove(sim);

 =C2=A0=C2=A0=C2=A0 sim_free_state(sim);

 =C2=A0=C2=A0=C2=A0 DBG("simfs"); // added
 =C2=A0=C2=A0=C2=A0 sim_fs_free(sim->simfs);
 =C2=A0=C2=A0=C2=A0 sim->simfs =3D NULL;
 =C2=A0=C2=A0=C2=A0 DBG("simfs_isim"); // added
 =C2=A0=C2=A0=C2=A0 sim_fs_free(sim->simfs_isim);
 =C2=A0=C2=A0=C2=A0 sim->simfs_isim =3D NULL;

 =C2=A0=C2=A0=C2=A0 g_free(sim);
}

I've launched Ofono with valgrind (I've added comments to the logs):
ofonod[30124]: src/sim.c:sim_remove() atom: 0x4e81d88
ofonod[30124]: src/simfs.c:sim_fs_context_free() 0x4e868f8
ofonod[30124]: src/simfs.c:sim_fs_context_free() 0x4ef6a08
ofonod[30124]: src/simfs.c:sim_fs_op_free() 0x4ef6a08, 0x3c, context: =

0x4eb7fb0
ofonod[30124]: src/simfs.c:sim_fs_context_free() 0x4ef6b38
ofonod[30124]: src/simfs.c:sim_fs_op_free() 0x4ef6b38, 0x3c, context: =

0x4eb7fb0
ofonod[30124]: src/simfs.c:sim_fs_context_free() **0x4eb7fb0** // -> =

This is freed in sim_free_state(sim);
ofonod[30124]: src/sim.c:sim_remove() simfs // -> Going in =

sim_fs_free(sim->simfs);
ofonod[30124]: src/simfs.c:sim_fs_free() 0x4e845a8
ofonod[30124]: src/simfs.c:sim_fs_op_free() 0x4ef67a8, 0x3c, context: =

**0x4eb7fb0** // Already freed
=3D=3D30124=3D=3D Invalid read of size 4
=3D=3D30124=3D=3D=C2=A0=C2=A0=C2=A0 at 0xE39A0: sim_fs_op_free (simfs.c:99)=
 // -> line: struct =

sim_fs *fs =3D node->context->fs;
=3D=3D30124=3D=3D=C2=A0=C2=A0=C2=A0 by 0x48B0303: g_queue_foreach (in =

/usr/lib/libglib-2.0.so.0.3800.2)
=3D=3D30124=3D=3D=C2=A0 Address **0x4eb7fb0** is 0 bytes inside a block of =
size 8 free'd
=3D=3D30124=3D=3D=C2=A0=C2=A0=C2=A0 at 0x4835760: free (in =

/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D30124=3D=3D
ofonod[30124]: src/sim.c:sim_remove() simfs_isim
ofonod[30124]: src/simfs.c:sim_fs_free() (nil)

What do you think about this?

Best regards,
Gabriel

--===============9015929481531340730==--

