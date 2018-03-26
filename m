Content-Type: multipart/mixed; boundary="===============0710682411524110164=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: SEGFAULT on sim_remove()
Date: Mon, 26 Mar 2018 16:41:25 +0200
Message-ID: <ec4f4945-fead-4181-3667-406d93c84113@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0710682411524110164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I'm getting a SEGFAULT when powering off a gemalto ALS3 modem with =

SetProperty("Powered", Variant(false)).

This method call is made right after the SimManager interface is on =

which could explain the error.

Log from oFono:

ofonod[6950]: src/sim.c:sim_remove() atom: 0x1604f0
(ofonod:6950): GLib-CRITICAL **: g_queue_is_empty: assertion 'queue !=3D =

NULL' failed

gdb backtrace:

Program received signal SIGSEGV, Segmentation fault.
__ofono_sim_remove_session_watch (session=3D0x74656e, id=3D16) at src/sim.c=
:3616
3616=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __ofono_watchlist_remove_item(ses=
sion->watches, id);
(gdb) bt
#0=C2=A0 __ofono_sim_remove_session_watch (session=3D0x74656e, id=3D16) at =

src/sim.c:3616
#1=C2=A0 0x000e368c in sim_fs_op_free (pointer=3D0x172498) at src/simfs.c:1=
02
#2=C2=A0 0x76f11304 in node_rotate (node=3D0x74656e) at =

/usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/gsequence.c:1840
#3=C2=A0 0x76f11384 in node_update_fields (node=3D<optimized out>) at =

/usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/gsequence.c:1827
#4=C2=A0 node_rotate (node=3D0x74656e) at =

/usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/gsequence.c:1891
#5=C2=A0 0x000c2d7c in sim_remove (atom=3D0xe3640 <sim_fs_op_free>) at =

src/sim.c:3175
#6=C2=A0 0x000a25c4 in flush_atoms (modem=3D0x160c00, =

new_state=3DMODEM_STATE_POWER_OFF) at src/modem.c:432
#7=C2=A0 modem_change_state (modem=3D0x160c00, new_state=3DMODEM_STATE_POWE=
R_OFF) =

at src/modem.c:510
#8=C2=A0 0x000a2874 in set_powered (modem=3Dmodem(a)entry=3D0x160c00, power=
ed=3D0) at =

src/modem.c:896
#9=C2=A0 0x000a2e5c in modem_set_property (conn=3D0x13e508, msg=3D0x140c28, =

data=3D0x160c00) at src/modem.c:1120
#10 0x000f657c in process_message (connection=3Dconnection(a)entry=3D0x13e5=
08, =

message=3Dmessage(a)entry=3D0x140c28, =

iface_user_data=3Diface_user_data(a)entry=3D0x160c00, method=3D0x11649c =

<modem_methods+24>, method=3D0x11649c <modem_methods+24>)
 =C2=A0=C2=A0=C2=A0 at gdbus/object.c:259
#11 0x000f6998 in generic_message (connection=3D0x13e508, =

message=3Dmessage(a)entry=3D0x140c28, user_data=3Duser_data(a)entry=3D0x15e=
ec0) at =

gdbus/object.c:1070
#12 0x76e9f240 in _dbus_object_tree_dispatch_and_unlock (tree=3D0x13e2f0, =

message=3Dmessage(a)entry=3D0x140c28, =

found_object=3Dfound_object(a)entry=3D0x7efffa64) at =

/usr/src/debug/dbus/1.6.18-r0/dbus-1.6.18/dbus/dbus-object-tree.c:862
#13 0x76e8fac4 in dbus_connection_dispatch =

(connection=3Dconnection(a)entry=3D0x13e508) at =

/usr/src/debug/dbus/1.6.18-r0/dbus-1.6.18/dbus/dbus-connection.c:4672
#14 0x000f3100 in message_dispatch (data=3D0x13e508) at gdbus/mainloop.c:72
#15 0x76efd9c4 in profile_print_locked (local_data=3D<optimized out>, =

success=3D<optimized out>) at =

/usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/gmem.c:637
#16 0x76f010b0 in g_node_first_sibling (node=3D0x13d600) at =

/usr/src/debug/glib-2.0/1_2.38.2-r0/glib-2.38.2/glib/gnode.c:1173
#17 0x00000000 in ?? ()

If you have any idea of the reason, let me know.

Best regards,

Gabriel


--===============0710682411524110164==--

