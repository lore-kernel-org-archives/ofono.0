Content-Type: multipart/mixed; boundary="===============8545686169656739740=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Re: Segmentation fault
Date: Fri, 07 Aug 2009 08:15:35 +0300
Message-ID: <4A7BB877.8010709@gmail.com>
In-Reply-To: <200908061703.37562.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8545686169656739740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Something changed as the segfault is different. With adding and removing
the modem like previously showed it now results to one of the following
segmentation faults.

Program received signal SIGSEGV, Segmentation fault.
0x0000013c in ?? ()
(gdb) where
#0  0x0000013c in ?? ()
#1  0xb7e382b6 in ?? () from /usr/lib/libglib-2.0.so.0
#2  0xb7e37b88 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#3  0xb7e3b0eb in ?? () from /usr/lib/libglib-2.0.so.0
#4  0xb7e3b5ba in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
#5  0x0804d345 in main (argc=3D3, argv=3D0xabcdef) at main.c:148
(gdb)

Program received signal SIGSEGV, Segmentation fault.
update_network_operator_list_init (user_data=3D0x8e67500) at network.c:806
806             if (netreg->flags &
NETWORK_REGISTRATION_FLAG_REQUESTING_OPLIST)
(gdb) where
#0  update_network_operator_list_init (user_data=3D0x8e67500) at network.c:=
806
#1  0xb7f172b6 in ?? () from /usr/lib/libglib-2.0.so.0
#2  0xb7f16b88 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#3  0xb7f1a0eb in ?? () from /usr/lib/libglib-2.0.so.0
#4  0xb7f1a5ba in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
#5  0x0804d345 in main (argc=3D3, argv=3D0xabcdef) at main.c:148
(gdb)

Here is a small script which can be used to test this. With Nokia E51 it
always segfaults before the 100 is reached. Sometimes it is able to do
sequence multiple times and sometimes only create-destroy-create is enough.

#!/bin/sh

if [ ! $1 ]; then
  echo "Usage example: $0 dev:/dev/ttyACM0"
  return;
fi

for i in `seq 1 100`; do
  dbus-send --print-reply --system --dest=3Dorg.ofono /\
org.ofono.at.Manager.Create string:"$1" string:"at"
  dbus-send --print-reply --system --dest=3Dorg.ofono /\
org.ofono.at.Manager.Destroy objpath:"/modem$i"
done

Regards,
Marko

--===============8545686169656739740==--

