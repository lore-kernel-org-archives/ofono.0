Content-Type: multipart/mixed; boundary="===============1828545418602088910=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: GPRS - SIGABRT after context down - (SIMCOM 7600E)
Date: Wed, 22 Jan 2020 11:02:04 +0100
Message-ID: <20200121160413.26551a58@s-rd-8.syscom.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1828545418602088910==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have found a problem with ofono and the modem SIMCOM7600E. In a context w=
ith
a weak signal, sometimes ofono stops on signal 6 (SIGNAL ABORT).

I use the last version from git (commit
d90cfdd71cb9eb2b533a20e4aea6bbf79e79fd2e). I have some custom patches but it
should not play a role in the problem.

I have a little program that listen dbus signals from ofono and
controls it. The problem always occurs in the same way. A GPRS detach is de=
tected by ofono
and it sends a PropertyChanged signal on org.ofono.ConnectionManager interf=
ace with
"Attached" set to false. Right after, the Attached property change to true =
and a DBUS signal is sent
by ofono. Therefore, my program sends SetProperty DBUS message on org.ofono=
.ConnectionContext interface with Active set to
true to enable the data connection again. But there, a signal SIGABRT is ra=
ised
in ofono. It is the layer DBUS that call abort() because an argument is NUL=
L as you
can see below (in the stack #5, message is 0x0).

---
(gdb) bt
#0  0xb6c7d2e0 in raise () from ./output/staging/lib/libc.so.0
#1  0xb6c776c0 in abort () from ./output/staging/lib/libc.so.0
#2  0xb6c1fa88 in _dbus_abort () at dbus-sysdeps.c:91
#3  0xb6c17964 in _dbus_warn_check_failed (
    format=3D0xb6c266fc "arguments to %s() were incorrect, assertion \"%s\"=
 failed in file %s line %d.\nThis is normally a bug in some application usi=
ng the D-Bus library.\n") at dbus-internals.c:275
#4  0xb6c0c550 in dbus_message_new_error (reply_to=3Dreply_to(a)entry=3D0x0=
, =

    error_name=3Derror_name(a)entry=3D0x121086 "org.ofono.Error.Failed", er=
ror_message=3D0xb6c6148c <vsnprintf+132> "", =

    error_message(a)entry=3D0xbedf2688 "Operation failed") at dbus-message.=
c:1478
#5  0x000fc44c in g_dbus_create_error_valist (message=3D0x0, name=3Dname(a)=
entry=3D0x121086 "org.ofono.Error.Failed", =

    format=3Dformat(a)entry=3D0x149bb8 <__ofono_debug_desc.22176> "", args=
=3D..., args(a)entry=3D...) at gdbus/object.c:1420
#6  0x000fc46c in g_dbus_create_error (message=3D<optimized out>, name=3Dna=
me(a)entry=3D0x121086 "org.ofono.Error.Failed", =

    format=3D0x12109d "Operation failed") at gdbus/object.c:1431
#7  0x000b3438 in __ofono_error_failed (msg=3D<optimized out>) at src/dbus.=
c:312
#8  0x000dcd98 in pri_activate_callback (error=3D0xbedf2b60, data=3D0x16104=
8) at src/gprs.c:838
#9  0x0007149c in at_cgdcont_cb (ok=3D0, result=3D0xbedf2bb8, user_data=3D0=
x1602c8) at drivers/atmodem/gprs-context.c:229
#10 0x000a39d4 in at_chat_finish_command (p=3Dp(a)entry=3D0x153b90, ok=3D0,=
 final=3Dfinal(a)entry=3D0x15e1a0 "NO CARRIER")
    at gatchat/gatchat.c:459
#11 0x000a4368 in at_chat_handle_command_response (line=3D<optimized out>, =
cmd=3D<optimized out>, p=3D<optimized out>)
    at gatchat/gatchat.c:529
#12 have_line (str=3D0x15e1a0 "NO CARRIER", p=3D0x153b90) at gatchat/gatcha=
t.c:600
#13 new_bytes (rbuf=3D0x14fe18, user_data=3Duser_data(a)entry=3D0x153b90) a=
t gatchat/gatchat.c:759
#14 0x000a62e8 in g_at_io_set_read_handler (io=3D0x153c08, read_handler=3Dr=
ead_handler(a)entry=3D0xa41c8 <new_bytes>, =

---Type <return> to continue, or q <return> to quit---
    user_data=3Duser_data(a)entry=3D0x153b90) at gatchat/gatio.c:260
#15 0x000a4874 in at_chat_resume (chat=3D0x153b90) at gatchat/gatchat.c:955
#16 g_at_chat_resume (chat=3D<optimized out>) at gatchat/gatchat.c:1449
#17 0x00071704 in ppp_disconnect (reason=3DG_AT_PPP_REASON_PEER_CLOSED, use=
r_data=3D0x1602c8)
    at drivers/atmodem/gprs-context.c:134
#18 0x000ab850 in ppp_dead (userdata=3D0x166cf8) at gatchat/gatppp.c:108
#19 0xb6e3db84 in g_main_dispatch (context=3D0x14f038) at gmain.c:3111
#20 g_main_context_dispatch (context=3Dcontext(a)entry=3D0x14f038) at gmain=
.c:3710
#21 0xb6e3de28 in g_main_context_iterate (context=3D0x14f038, block=3Dblock=
(a)entry=3D1, dispatch=3Ddispatch(a)entry=3D1, =

    self=3D<optimized out>) at gmain.c:3781
#22 0xb6e3e1f8 in g_main_loop_run (loop=3D0x150fb8) at gmain.c:3975
#23 0x0001de5c in main (argc=3D0, argv=3D0x0) at src/main.c:293
---

With DBG enabled, we can see this in the log:

---
Jan 15 11:01:42 box ofonod[5828]: AT< \r\n+CREG: 2\r\n\r\n+CGREG: 2\r\n
Jan 15 11:01:42 box ofonod[5828]: AT< \r\n+CREG: 5,FFFE,13D6204\r\n\r\n+CGR=
EG: 5,FFFE,9C40\r\n
Jan 15 11:01:42 box ofonod[5828]: src/network.c:ofono_netreg_status_notify(=
) /sim7x00_0 status 2 tech -1 lac -1 ci -1
Jan 15 11:01:42 box ofonod[5828]: src/network.c:current_operator_callback()=
 0x160c00, 0x153e70
Jan 15 11:01:42 box ofonod[5828]: src/gprs.c:netreg_status_changed() 2 (sea=
rching)
Jan 15 11:01:42 box ofonod[5828]: src/gprs.c:gprs_netreg_update() attach: 0=
, driver_attached: 1
Jan 15 11:01:42 box ofonod[5828]: src/gprs.c:netreg_status_changed() 2 (sea=
rching)
Jan 15 11:01:42 box ofonod[5828]: src/gprs.c:gprs_netreg_update() attach: 0=
, driver_attached: 0
Jan 15 11:01:42 box ofonod[5828]: src/gprs.c:ofono_gprs_status_notify() /si=
m7x00_0 status searching (2)
Jan 15 11:01:42 box ofonod[5828]: src/network.c:ofono_netreg_status_notify(=
) /sim7x00_0 status 5 tech 7 lac -1 ci -1
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:netreg_status_changed() 5 (roa=
ming)
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:gprs_netreg_update() attach: 1=
, driver_attached: 0
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:ofono_gprs_status_notify() /si=
m7x00_0 status roaming (5)
Jan 15 11:01:43 box ofonod[5828]: AT> AT+CGATT=3D0\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+CME ERROR: 30\r\n\r\n+CGEV: NW D=
ETACH\r\n
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:gprs_attach_callback() /sim7x0=
0_0 error =3D 1
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:ofono_gprs_detached_notify() /=
sim7x00_0
Jan 15 11:01:43 box ofonod[5828]: AT> AT+COPS=3D3,2\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\nOK\r\n\r\nNO CARRIER\r\n\r\n+PPPD=
: DISCONNECTED\r\n
Jan 15 11:01:43 box ofonod[5828]: AT> AT+COPS?\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+COPS: 0,2,"22802",7\r\n\r\nOK\r\n
Jan 15 11:01:43 box ofonod[5828]: drivers/atmodem/network-registration.c:co=
ps_numeric_cb() Cops numeric got mcc: 228, mnc: 02
Jan 15 11:01:43 box ofonod[5828]: AT> AT+CSQ\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+CSQ: 20,7\r\n\r\nOK\r\n
Jan 15 11:01:43 box ofonod[5828]: drivers/atmodem/network-registration.c:cs=
q_cb() csq_cb: 20
Jan 15 11:01:43 box ofonod[5828]: src/network.c:ofono_netreg_strength_notif=
y() strength 64
Jan 15 11:01:43 box ofonod[5828]: AT> AT+CGREG?\r
Jan 15 11:01:43 box ofonod[5828]: plugins/udevng.c:remove_device() /sys/dev=
ices/virtual/net/ppp0
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+CGREG: 2,5,9C40,13D6204\r\n\r\nO=
K\r\n
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:registration_status_cb() /sim7=
x00_0 error 0 status 5
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:ofono_gprs_status_notify() /si=
m7x00_0 status roaming (5)
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:gprs_netreg_update() attach: 1=
, driver_attached: 1
Jan 15 11:01:43 box ofonod[5828]: AT> AT+CLCC\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+CGEV: ME DETACH\r\n
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+CGREG: 2\r\n\r\nOK\r\n
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:ofono_gprs_detached_notify() /=
sim7x00_0
Jan 15 11:01:43 box ofonod[5828]: drivers/atmodem/gprs-context.c:at_gprs_de=
tach_shutdown() cid 1
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:ofono_gprs_status_notify() /si=
m7x00_0 status searching (2)
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:ofono_gprs_detached_notify() /=
sim7x00_0
Jan 15 11:01:43 box ofonod[5828]: AT> AT+COPS=3D3,0\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\nOK\r\n
Jan 15 11:01:43 box ofonod[5828]: AT> AT+COPS?\r
Jan 15 11:01:43 box ofonod[5828]: AT< \r\n+COPS: 0,0,"Sunrise Tele2 IoT",7\=
r\n\r\nOK\r\n
Jan 15 11:01:43 box ofonod[5828]: drivers/atmodem/network-registration.c:co=
ps_cb() cops_cb: Sunrise Tele2 IoT, 228 02 7
Jan 15 11:01:43 box ofonod[5828]: src/network.c:current_operator_callback()=
 0x160c00, (nil)
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:netreg_status_changed() 5 (roa=
ming)
Jan 15 11:01:43 box ofonod[5828]: src/gprs.c:gprs_netreg_update() attach: 1=
, driver_attached: 0
Jan 15 11:01:43 box ofonod[5828]: AT> AT+CGATT=3D1\r
Jan 15 11:01:44 box ofonod[5828]: AT< \r\n+CGREG: 5,FFFE,9C40\r\n\r\nOK\r\n
Jan 15 11:01:44 box ofonod[5828]: src/gprs.c:ofono_gprs_status_notify() /si=
m7x00_0 status roaming (5)
Jan 15 11:01:44 box ofonod[5828]: src/gprs.c:gprs_attach_callback() /sim7x0=
0_0 error =3D 0
Jan 15 11:01:44 box ofonod[5828]: AT> AT+CGREG?\r
Jan 15 11:01:44 box ofonod[5828]: AT< \r\n+CGREG: 2,5,9C40,13D6204\r\n\r\nO=
K\r\n
Jan 15 11:01:44 box ofonod[5828]: src/gprs.c:registration_status_cb() /sim7=
x00_0 error 0 status 5
Jan 15 11:01:44 box ofonod[5828]: src/gprs.c:ofono_gprs_status_notify() /si=
m7x00_0 status roaming (5)
Jan 15 11:01:44 box ofonod[5828]: drivers/atmodem/gprs-context.c:at_gprs_ac=
tivate_primary() cid 1
Jan 15 11:01:46 box ofonod[5828]: drivers/atmodem/gprs-context.c:ppp_discon=
nect() Reason: 4
Jan 15 11:01:46 box ofonod[5828]: src/gprs.c:pri_activate_callback() 0x15e7=
60
Jan 15 11:01:46 box ofonod[5828]: src/gprs.c:pri_activate_callback() Activa=
ting context failed with error: Unknown error type
Jan 15 11:01:46 box ofonod[5828]: drivers/atmodem/gprs-context.c:at_cgdcont=
_cb() ok 0
Jan 15 11:01:46 box ofonod[5828]: src/gprs.c:pri_activate_callback() 0x15e7=
60
Jan 15 11:01:46 box ofonod[5828]: src/gprs.c:pri_activate_callback() Activa=
ting context failed with error: Unknown error type
---

The line above is the last before ofono gets killed.

I can guess with the log and the code that there is a double hit of pri_act=
ivate_callback() whereas there is
only one DBUS request coming from my program (modemd):

---
Jan 15 10:57:06 box modemd[1131]: /sim7x00_0/context1: PPP is up (ipaddr=3D=
100.77.207.2)
Jan 15 11:01:42 box modemd[1131]: Network status changed: searching
Jan 15 11:01:43 box modemd[1131]: Network status changed: roaming
Jan 15 11:01:43 box modemd[1131]: packet domain is non-attached
Jan 15 11:01:43 box modemd[1131]: /sim7x00_0/context1: PPP is down (lost pa=
cket domain)
Jan 15 11:01:44 box modemd[1131]: packet domain is attached
Jan 15 11:01:44 box modemd[1131]: /sim7x00_0/context1: enabling context...
Jan 15 11:01:46 box modemd[1131]: gprs.c:307 gprs_enable_context() Set 'Act=
ive' to '1' failed
Jan 15 11:01:46 box modemd[1131]: gprs.c:636 gprs_sm_conduct() /sim7x00_0/c=
ontext1: enabling context failed
---

Is there anyone have an idea to explain why this problem occur and how to f=
ix it ?

Best regards,
Anthony V.
--=20
--===============1828545418602088910==--

