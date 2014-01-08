Content-Type: multipart/mixed; boundary="===============3012384110346240220=="
MIME-Version: 1.0
From: Dennis Lan (dlan) <dennis.yxun@gmail.com>
Subject: How to set 3G card into data mode?
Date: Wed, 08 Jan 2014 17:27:52 +0800
Message-ID: <CAF1ZMEeUCkEFCH+MNh0caPbymZ5iX+BOF58bwgO1gtd7U9+rDw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3012384110346240220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all:
  I'm using Huawei E173 3G card,  and have problem to set current operator.
seems it set to GSM mode by default, COPS query command return "
CHN-CUGSM, 460 01 2"
  the commands I'm using here 1) list-modems 2) enable-modem
3)online-modem 4) create-internet-context 5=EF=BC=89activate-context
  reading the code, it seems possible to manually change operator,
from drivers/atmodem/network-registration.c : at_register_manual()?
  any idea? what should I do?

detail log:

ofonod[14119]: PCUI: > AT+CSQ\r
ofonod[14119]: PCUI: < \r\n+CSQ: 23,99\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 23
ofonod[14119]: PCUI: > AT+COPS=3D3,0\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,0,"CHN-CUGSM",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_cb()
cops_cb: CHN-CUGSM, 460 01 2
ofonod[14119]: src/network.c:current_operator_callback() 0x772a80, 0x769f50
ofonod[14119]: PCUI: < \r\n+CREG: 1,"A80A","51AF"\r\n\r\n+CGREG:
1,"A80A","51AF"\r\n
ofonod[14119]: src/network.c:ofono_netreg_status_notify() /huawei_0
status 1 tech 2
ofonod[14119]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, 46001
ofonod[14119]: src/gprs.c:netreg_status_changed() 1
ofonod[14119]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 1
ofonod[14119]: PCUI: > AT+COPS=3D3,2\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,2,"46001",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 460, mnc: 01
ofonod[14119]: PCUI: > AT+CSQ\r
ofonod[14119]: PCUI: < \r\n+CSQ: 23,99\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 23
ofonod[14119]: PCUI: > AT+COPS=3D3,0\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,0,"CHN-CUGSM",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_cb()
cops_cb: CHN-CUGSM, 460 01 2
ofonod[14119]: src/network.c:current_operator_callback() 0x772a80, 0x769f50

ofonod[14119]: PCUI: < \r\n+CREG: 1,"A80A","517E"\r\n\r\n+CGREG:
1,"A80A","517E"\r\n
ofonod[14119]: src/network.c:ofono_netreg_status_notify() /huawei_0
status 1 tech 2
ofonod[14119]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, 46001
ofonod[14119]: src/gprs.c:netreg_status_changed() 1
ofonod[14119]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 1
ofonod[14119]: PCUI: > AT+COPS=3D3,2\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,2,"46001",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 460, mnc: 01
ofonod[14119]: PCUI: > AT+CSQ\r
ofonod[14119]: PCUI: < \r\n+CSQ: 23,99\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 23
ofonod[14119]: PCUI: > AT+COPS=3D3,0\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,0,"CHN-CUGSM",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_cb()
cops_cb: CHN-CUGSM, 460 01 2
ofonod[14119]: src/network.c:current_operator_callback() 0x772a80, 0x769f50
ofonod[14119]: PCUI: < \r\n+CREG: 1,"A80A","51AF"\r\n\r\n+CGREG:
1,"A80A","51AF"\r\n
ofonod[14119]: src/network.c:ofono_netreg_status_notify() /huawei_0
status 1 tech 2
ofonod[14119]: src/cbs.c:cbs_location_changed() 1, -1, -1, 2, 46001
ofonod[14119]: src/gprs.c:netreg_status_changed() 1
ofonod[14119]: src/gprs.c:ofono_gprs_status_notify() /huawei_0 status 1
ofonod[14119]: PCUI: > AT+COPS=3D3,2\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,2,"46001",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_numeric_cb()
Cops numeric got mcc: 460, mnc: 01
ofonod[14119]: PCUI: > AT+CSQ\r
ofonod[14119]: PCUI: < \r\n+CSQ: 23,99\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:csq_cb() csq_cb: 23
ofonod[14119]: PCUI: > AT+COPS=3D3,0\r
ofonod[14119]: PCUI: < \r\nOK\r\n
ofonod[14119]: PCUI: > AT+COPS?\r
ofonod[14119]: PCUI: < \r\n+COPS: 1,0,"CHN-CUGSM",2\r\n\r\nOK\r\n
ofonod[14119]: drivers/atmodem/network-registration.c:cops_cb()
cops_cb: CHN-CUGSM, 460 01 2
ofonod[14119]: src/network.c:current_operator_callback() 0x772a80, 0x769f50
ofonod[14119]: PCUI: < \r\n^RSSI: 26\r\n
ofonod[14119]: src/network.c:ofono_netreg_strength_notify() strength 83



ofonod[14119]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() ci=
d 1
ofonod[14119]: Modem: > AT+CGDCONT=3D1,"IP","3gnet"\r
ofonod[14119]: Modem: < \r\nOK\r\n
ofonod[14119]: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod[14119]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[14119]: Modem: < \r\n+CME ERROR: 50\r\n
ofonod[14119]: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
ofonod[14119]: Unable to enter data state
ofonod[14119]: src/gprs.c:pri_activate_callback() 0x782e30
ofonod[14119]: src/gprs.c:pri_activate_callback() Activating context
failed with error: Incorrect parameters

--===============3012384110346240220==--

