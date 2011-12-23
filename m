Content-Type: multipart/mixed; boundary="===============7764543894693535595=="
MIME-Version: 1.0
From: Kukkonen, Jussi <jussi.kukkonen@intel.com>
Subject: crash after SimManager.ResetPin()
Date: Fri, 23 Dec 2011 20:48:32 +0200
Message-ID: <CAHiDW_FOzBG8vHfJ3M=wX8OxG1eMc6+-t+qdz2n9PyWr0C7f-A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7764543894693535595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I consistently get a crash when calling SimManager.ResetPin ("puk",
puk, new_pin). Before this I've called ChangePin()  with wrong pin
three times.to get "PinRequired=3Dpuk" property change.

This is a huawei E1550 USB modem.

log:

ofonod[31607]: drivers/atmodem/sms.c:at_csca_query_cb() csca_query_cb:
358508771010, 145
ofonod[31607]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[31607]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,=
 val=3D10
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,=
 val=3D2
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter
id=3D11, val=3D10
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,=
 val=3D3
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 4
ofonod[31607]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 4
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 8
ofonod[31607]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 8
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[31607]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[31607]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 1
ofonod[31607]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,=
 val=3D10
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,=
 val=3D1
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter
id=3D11, val=3D10
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,=
 val=3D3
ofonod[31607]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 244052260583237
ofonod[31607]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff:
39, toread: 4
ofonod[31607]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff:
39, toread: 8
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00=
, 30
ofonod[31607]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00=
, 1
ofonod[31607]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[31607]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 244052260583237
ofonod[31607]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: SIM PUK
ofonod[31607]: src/modem.c:modem_change_state() old state: 2, new state: 1
ofonod[31607]: src/modem.c:flush_atoms()
ofonod[31607]: Example Network Time Remove for modem: 0x87e29b0
ofonod[31607]: Example History Remove for modem: 0x87e29b0
ofonod[31607]: src/gprs.c:gprs_context_unregister() 0x87e9ea0, 0x87e9d50
ofonod[31607]: src/gprs.c:gprs_context_remove() atom: 0x87e9ec0
ofonod[31607]: drivers/atmodem/gprs-context.c:at_gprs_context_remove()
ofonod[31607]: Unregistered handle for channel 1: 0x10006
ofonod[31607]: src/gprs.c:gprs_unregister() 0x87e9d50
ofonod[31607]: src/gprs.c:gprs_remove() atom: 0x87e9db8
ofonod[31607]: plugins/push-notification.c:push_notification_cleanup() 0x87=
e5148
ofonod[31607]: plugins/smart-messaging.c:smart_messaging_cleanup() 0x87eb0d0
ofonod[31607]: src/sms.c:sms_remove() atom: 0x87e9ca8
ofonod[31607]: src/radio-settings.c:radio_settings_remove() atom: 0x87e7148
ofonod[31607]: src/phonebook.c:phonebook_remove() atom: 0x87e7058
ofonod[31607]: src/audio-settings.c:audio_settings_remove() atom: 0x87eaf10
ofonod[31607]: src/voicecall.c:voicecall_remove() atom: 0x87ea778
ofonod[31607]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D9,=
 val=3D10
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D1,=
 val=3D0
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter
id=3D11, val=3D10
ofonod[31607]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter id=3D4,=
 val=3D3
ofonod[31607]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[31607]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[31607]: Aborting (signal 11) [src/ofonod]
ofonod[31607]: ++++++++ backtrace ++++++++
ofonod[31607]: #0  0xb7823400 in
ofonod[31607]: #1  0x811306c in sim_fs_read() at src/simfs.c:895
ofonod[31607]: #2  0x80f101f in ofono_sim_read() at src/sim.c:2096
ofonod[31607]: #3  0x80f1600 in sim_initialize_after_pin() at src/sim.c:1739
ofonod[31607]: #4  0x80f1725 in sim_pin_query_cb() at src/sim.c:2427
ofonod[31607]: #5  0x8091657 in at_cpin_cb() at drivers/atmodem/sim.c:864
ofonod[31607]: #6  0x8079c15 in at_chat_finish_command() at
gatchat/gatchat.c:461
ofonod[31607]: #7  0x807aa3a in at_chat_handle_command_response() at
gatchat/gatchat.c:524
ofonod[31607]: #8  0x807ca46 in received_data() at gatchat/gatio.c:125
ofonod[31607]: #9  0xb77609ce in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[31607]: #10 0xb771aa3f in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[31607]: #11 0xb771b170 in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[31607]: #12 0xb771b77b in /lib/i386-linux-gnu/libglib-2.0.so.0
ofonod[31607]: #13 0x8054599 in main() at src/main.c:262
ofonod[31607]: #14 0xb751ae46 in /lib/i386-linux-gnu/i686/cmov/libc.so.6
ofonod[31607]: +++++++++++++++++++++++++++



I'd rather bring you nicer presents but ... merry christmas anyway,
  Jussi

--===============7764543894693535595==--

