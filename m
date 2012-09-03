Content-Type: multipart/mixed; boundary="===============5515816789586729454=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: context activation quickly after context deactivation fails
Date: Mon, 03 Sep 2012 14:50:20 +0200
Message-ID: <CABvLYuD17J3urLnbzDuzM95BPbRDs1Y6Mgi9=6yX3wPunxz6LA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5515816789586729454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

When i want to change a Property (eg. APN) of an Active
ConnectionContext. I first deactivate the context, wait for a reply
then set the property and re-activate the context.
The problem is i'm already trying to re-activate the context, before
oFono gets a "NO CARRIER" from the modem. oFono tries to send
AT+CGDCONT, but get's a "NO CARRIER" response and fails to activate
the context.
Is there a way to tell if it's ready to re-activate? Should oFono wait
for the "NO CARRIER" before it sends a reply to the deactivation?

Here's a log of the problem
Jan  4 22:14:38 ofonod[3022]:
drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_generate_event: current
state 9:OPENED
Jan  4 22:14:38 ofonod[3022]: PPP: event: 3 (Close), action: 8224,
new_state: 4 (CLOSING)
Jan  4 22:14:38 ofonod[3022]: PPP: lcp:
pppcp_initialize_restart_count: current state 9:OPENED
Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_send_terminate_request:
current state 9:OPENED
Jan  4 22:14:38 ofonod[3022]: PPP: ipcp: pppcp_generate_event: current
state 9:OPENED
Jan  4 22:14:38 ofonod[3022]: PPP: event: 1 (Down), action: 201,
new_state: 1 (STARTING)
Jan  4 22:14:38 ofonod[3022]: PPP: gatchat/gatppp.c:ppp_enter_phase() 5
Jan  4 22:14:38 ofonod[3022]: plugins/udevng.c:remove_device()
/sys/devices/virtual/net/ppp0
Jan  4 22:14:38 ofonod[3022]: plugins/udev.c:udev_event() subsystem net rem=
ove
Jan  4 22:14:38 ofonod[3022]: plugins/udev.c:remove_modem()
/devices/virtual/net/ppp0
Jan  4 22:14:38 ofonod[3022]: plugins/udev.c:udev_event() subsystem net fin=
ished
Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_process_terminate_ack:
current state 4:CLOSING
Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_generate_event: current
state 4:CLOSING
Jan  4 22:14:38 ofonod[3022]: PPP: event: 11 (RTA), action: 802,
new_state: 2 (CLOSED)
Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_this_layer_finished:
current state 2:CLOSED
Jan  4 22:14:38 ofonod[3022]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
Jan  4 22:14:38 ofonod[3022]: PPP: gatchat/gatppp.c:ppp_dead()
Jan  4 22:14:38 ofonod[3022]: src/gprs.c:assign_context()
Jan  4 22:14:38 ofonod[3022]: src/gprs.c:assign_context()
gprs[0x557f80] context_driver[0x556a40]
Jan  4 22:14:38 ofonod[3022]:
drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Jan  4 22:14:38 ofonod[3022]: Modem: > AT+CGDCONT=3D1,"IP","test"\r
Jan  4 22:14:39 ofonod[3022]: PCUI: < \r\n^RSSI:17\r\n
Jan  4 22:14:40 ofonod[3022]: PCUI: < \r\n^MODE:5,4\r\n
Jan  4 22:14:40 ofonod[3022]: Modem: < \r\nNO CARRIER\r\n
Jan  4 22:14:40 ofonod[3022]:
drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 0
Jan  4 22:14:40 ofonod[3022]: src/gprs.c:pri_activate_callback() 0x55dc88
Jan  4 22:14:40 ofonod[3022]: src/gprs.c:pri_activate_callback()
Activating context failed with error: Unknown error type

Thanks,
Cedric

--===============5515816789586729454==--

