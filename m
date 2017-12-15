Content-Type: multipart/mixed; boundary="===============8311275427717855531=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmimodem: fix roaming status report
Date: Fri, 15 Dec 2017 11:28:04 +0100
Message-ID: <1513333685-12008-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8311275427717855531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

With a MC7304 modem and a roaming SIM card, Status in org.ofono.NetworkRegi=
stration
properties ends up in "registered" instead of roaming.
Both AT command and qmicli indicates we are roaming.

What's happening is the following:

1) first QMI_NAS_SS_INFO_IND indicating we are registered contains a QMI_NA=
S_RESULT_ROAMING_STATUS parameter.
Parameter inside says we are roaming and qmimidem driver correctly reports =
status NETWORK_REGISTRATION_STATUS_ROAMING.
2) other QMI_NAS_SS_INFO_IND arrive, saying we are registered without QMI_N=
AS_RESULT_ROAMING_STATUS parameter.
Driver reports NETWORK_REGISTRATION_STATUS_REGISTERED.

Extract of traces with QMI binary debug interpreted (as far as I can...):
a) first "searching" indication
Dec 13 13:19:40 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: < 01 3b 00 80=
 03 01 04 00 00 24 00 2f 00
29 05 00 d0 00 14 00 00 MCC:208 MNC:20
22 05 00 01 02 00 01 00 Detailed Service Status: QMI_NAS_SERVICE_STATUS_LIM=
ITED, QMI_NAS_NETWORK_SERVICE_DOMAIN_PS, ...
15 03 00 01 08 01 LTE, no roaming
12 05 00 d0 00 14 00 00 Current PLMN: MCC:208 MNC:20, no desc
11 01 00 00
10 01 00 01 No roaming
01 06 00 02 02 02 02 01 08 QMI_NAS_REGISTRATION_STATE_NOT_REGISTERED_SEARCH=
ING, CS detached, PS detached, NETWORK_TYPE_3GPP, QMI_NAS_RADIO_INTERFACE_L=
TE
Dec 13 13:19:40 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: NAS_ind msg=
=3D36 len=3D47 [client=3D1,type=3D4,tid=3D0,len=3D59]
Dec 13 13:19:40 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D41,le=
n=3D5} {type=3D34,len=3D5} {type=3D21,len=3D3} {type=3D18,len=3D5}
Dec 13 13:19:40 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D17,le=
n=3D1} {type=3D16,len=3D1} {type=3D1,len=3D6}
Dec 13 13:19:40 klk-lpbs-0504B4 daemon.debug ofonod[855]: ofono_netreg_stat=
us_notify modem /sierra_0 status 2 lac -1 cellid -1 tech 7

b) second "searching" indication
Dec 13 13:19:41 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: < 01 21 00 80=
 03 01 04 00 00 24 00 15 00
22 05 00 03 03 00 01 00 Detailed Service Status: QMI_NAS_SERVICE_STATUS_LIM=
ITED_REGIONAL, CS_PS, ...
11 01 00 00
01 06 00 02 02 02 02 01 08 QMI_NAS_REGISTRATION_STATE_NOT_REGISTERED_SEARCH=
ING, CS detached, PS detached, NETWORK_TYPE_3GPP, QMI_NAS_RADIO_INTERFACE_L=
TE

Dec 13 13:19:41 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: NAS_ind msg=
=3D36 len=3D21 [client=3D1,type=3D4,tid=3D0,len=3D33]
Dec 13 13:19:41 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D34,le=
n=3D5} {type=3D17,len=3D1} {type=3D1,len=3D6}

c) First indication while "registered"
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: < 01 5e 00 80=
 03 01 04 00 00 24 00 52 00
2a 01 00 00
29 05 00 d0 00 14 00 00 MCC:208 MNC:20
28 02 00 15 01 UMTS Primary Scrambling Code
26 08 00 03 00 00 00 03 00 00 00 CS: all calls allowed, PS: all calls allow=
ed
22 05 00 02 03 00 01 00 Detailed Service Status: QMI_NAS_SERVICE_STATUS_AVA=
ILABLE, CS_PS, ...
1e 04 00 f7 00 95 04 CID 3GPP
1d 02 00 fb 50 LAC 3GPP
15 03 00 01 05 00 UMTS: roaming
12 05 00 d0 00 14 00 00 Current PLMN: MCC:208 MNC:20, no desc
11 04 00 03 03 04 05
10 01 00 00 ROAMING ON
01 06 00 01 01 01 02 01 05 QMI_NAS_REGISTRATION_STATE_REGISTERED, CS attach=
ed, PS attached, NETWORK_TYPE_3GPP, QMI_NAS_RADIO_INTERFACE_UMTS
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: NAS_ind msg=
=3D36 len=3D82 [client=3D1,type=3D4,tid=3D0,len=3D94]
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D42,le=
n=3D1} {type=3D41,len=3D5} {type=3D40,len=3D2} {type=3D38,len=3D8}
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D34,le=
n=3D5} {type=3D30,len=3D4} {type=3D29,len=3D2} {type=3D21,len=3D3}
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D18,le=
n=3D5} {type=3D17,len=3D4} {type=3D16,len=3D1} {type=3D1,len=3D6}

Dec 13 13:19:56 klk-lpbs-0504B4 daemon.debug ofonod[855]: ofono_gprs_status=
_notify modem /sierra_0 status 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> ROAMING status repo=
rted <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.debug ofonod[855]: ofono_netreg_stat=
us_notify modem /sierra_0 status 5 lac 20731 cellid 76873975 tech 2

d) second indication while "registered"
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: < 01 31 00 80=
 03 01 04 00 00 24 00 25 00
29 05 00 d0 00 14 00 00 MCC:208 MNC:20
28 02 00 15 01 UMTS Primary Scrambling Code
12 05 00 d0 00 14 00 00 Current PLMN: MCC:208 MNC:20, no desc
11 04 00 03 03 04 05
01 06 00 01 01 01 02 01 05 QMI_NAS_REGISTRATION_STATE_REGISTERED, CS attach=
ed, PS attached, NETWORK_TYPE_3GPP, QMI_NAS_RADIO_INTERFACE_UMTS
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: NAS_ind msg=
=3D36 len=3D37 [client=3D1,type=3D4,tid=3D0,len=3D49]
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D41,le=
n=3D5} {type=3D40,len=3D2} {type=3D18,len=3D5} {type=3D17,len=3D4}
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.info ofonod[855]: QMI: {type=3D1,len=
=3D6}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> ROAMING information=
 lost <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Dec 13 13:19:56 klk-lpbs-0504B4 daemon.debug ofonod[855]: ofono_netreg_stat=
us_notify modem /sierra_0 status 1 lac -1 cellid -1 tech 2


I don't know if this is a problem specific to MC7304 or even to my firmware=
 version or if this is a normal behavior to have ROAMING_STATUS parameter o=
nly when status change from anything to registered.

Best Regards,

Christophe

Christophe Ronco (1):
  qmimodem: fix roaming status report

 drivers/qmimodem/network-registration.c | 50 ++++++++++++++++++++++++++++-=
----
 1 file changed, 43 insertions(+), 7 deletions(-)

-- =

2.7.4


--===============8311275427717855531==--

