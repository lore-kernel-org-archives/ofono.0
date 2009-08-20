Content-Type: multipart/mixed; boundary="===============4208742980717927618=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Can't send second message in v0.3
Date: Thu, 20 Aug 2009 09:54:35 +0800
Message-ID: <B94C62E7C2870743865418621F040C130206BE7C94@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200908190947.54960.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4208742980717927618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
>This is strange.  Can you set the OFONO_AT_DEBUG environment variable and =
re-
>run ofonod?
>
>E.g. export OFONO_AT_DEBUG=3D1; ofonod -nd
>
>Report the AT trace so I can understand what is happening.  Sounds like the
>modem is not sending the first fragment.

ofonod[15312]: oFono version 0.3
ofonod[15312]: plugin.c:__ofono_plugin_init() =

ofonod[15312]: Seting up AT channel
ofonod[15312]: SIMManager interface for modem: /modem1 created
ofonod[15312]: Registered call forwarding interface
ofonod[15312]: Registered call settings interface
ofonod[15312]: Sending voice initialization commands
ofonod[15312]: > AT+CIMI\r
ofonod[15312]: < AT+CIMI\r
ofonod[15312]: < \r\n460028210210167\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_cimi_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: 460028210210167
ofonod[15312]: cimi_cb: 460028210210167
ofonod[15312]: > AT+CREG=3D2\r
ofonod[15312]: < AT+CREG=3D2\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: NetworkRegistration interface for modem: /modem1 created
ofonod[15312]: > AT+CRC=3D1\r
ofonod[15312]: < AT+CRC=3D1\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+CLIP=3D1\r
ofonod[15312]: < AT+CLIP=3D1\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+COLP=3D1\r
ofonod[15312]: < AT+COLP=3D1\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+CSSN=3D1,1\r
ofonod[15312]: < AT+CSSN=3D1,1\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+CCWA=3D1\r
ofonod[15312]: < AT+CCWA=3D1\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: voicecall_init: registering to notifications
ofonod[15312]: > AT+CAOC=3D2\r
ofonod[15312]: < AT+CAOC=3D2\r\r\nOK\r\n
ofonod[15312]: > AT+CCWE=3D1\r
ofonod[15312]: < AT+CCWE=3D1\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+CSMS=3D?\r
ofonod[15312]: < AT+CSMS=3D?\r
ofonod[15312]: < \r\n+CSMS: (0)\r\n\r\nOK\r\n
ofonod[15312]: csms_query_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CSMS: (0)
ofonod[15312]: CSMS query parsed successfully
ofonod[15312]: > AT+CSCS=3D?\r
ofonod[15312]: < AT+CSCS=3D?\r
ofonod[15312]: < \r\n+CSCS: ("GSM","IRA","8859-1","UTF-8","UCS2")\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_list_charsets_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CSCS: ("GSM","IRA","8859-1","UTF-8","UCS2")
ofonod[15312]: > AT+CGMI\r
ofonod[15312]: < AT+CGMI\r
ofonod[15312]: < \r\nSony Ericsson\r\n\r\nOK\r\n
ofonod[15312]: attr_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: Sony Ericsson
ofonod[15312]: > AT+CRSM=3D192,28480,0,0,15\r
ofonod[15312]: < AT+CRSM=3D192,28480,0,0,15\r
ofonod[15312]: < \r\n+CRSM: 148,4\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_crsm_info_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CRSM: 148,4
ofonod[15312]: > AT+CREG?\r
ofonod[15312]: < AT+CREG?\r
ofonod[15312]: < \r\n+CREG: 2,5,"188E","00006302"\r\n\r\nOK\r\n
ofonod[15312]: at_creg_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CREG: 2,5,"188E","00006302"
ofonod[15312]: creg_cb: 5, 6286, 25346, -1
ofonod[15312]: > AT+CSMS=3D0\r
ofonod[15312]: < AT+CSMS=3D0\r
ofonod[15312]: < \r\n+CSMS: 1,1,1\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+CPBS=3D?\r
ofonod[15312]: < AT+CPBS=3D?\r
ofonod[15312]: < \r\n+CPBS: ("ME","SM","FD","DC","LD","MC","RC")\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_list_storages_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CPBS: ("ME","SM","FD","DC","LD","MC","RC")
ofonod[15312]: > AT+CGMM\r
ofonod[15312]: < AT+CGMM\r
ofonod[15312]: < \r\nAAD-3352021-BV\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: attr_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: AAD-3352021-BV
ofonod[15312]: > AT+CRSM=3D192,28613,0,0,15\r
ofonod[15312]: < AT+CRSM=3D192,28613,0,0,15\r
ofonod[15312]: < \r\n+CRSM: 148,4\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_crsm_info_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CRSM: 148,4
ofonod[15312]: > AT+COPS=3D3,2\r
ofonod[15312]: < AT+COPS=3D3,2\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+COPS?\r
ofonod[15312]: < AT+COPS?\r
ofonod[15312]: < \r\n+COPS: 0,2,"46000",0 \r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: cops_numeric_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +COPS: 0,2,"46000",0 =

ofonod[15312]: Cops numeric got mcc: 460, mnc: 00
ofonod[15312]: > AT+COPS=3D3,0\r
ofonod[15312]: < AT+COPS=3D3,0\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: > AT+COPS?\r
ofonod[15312]: < AT+COPS?\r
ofonod[15312]: < \r\n+COPS: 0,0,"China Mobile",0 \r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: cops_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +COPS: 0,0,"China Mobile",0 =

ofonod[15312]: cops_cb: China Mobile, 460 00 0
ofonod[15312]: > AT+CSQ\r
ofonod[15312]: < AT+CSQ\r
ofonod[15312]: < \r\n+CSQ: 19,99\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: csq_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CSQ: 19,99
ofonod[15312]: csq_cb: 19
ofonod[15312]: > AT+CSMS?\r
ofonod[15312]: < AT+CSMS?\r
ofonod[15312]: < \r\n+CSMS: 0,1,1,1\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: csms_status_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CSMS: 0,1,1,1
ofonod[15312]: > AT+CGMR\r
ofonod[15312]: < AT+CGMR\r
ofonod[15312]: < \r\nR1BA038 081016 1346 1208-0527_CHINA_SI\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: attr_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: R1BA038 081016 1346 1208-0527_CHINA_SI
ofonod[15312]: > AT+CRSM=3D192,28486,0,0,15\r
ofonod[15312]: < AT+CRSM=3D192,28486,0,0,15\r
ofonod[15312]: < \r\n+CRSM: 148,4\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_crsm_info_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CRSM: 148,4
ofonod[15312]: > AT+CMGF=3D?\r
ofonod[15312]: < AT+CMGF=3D?\r
ofonod[15312]: < \r\n+CMGF: (0)\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: cmgf_query_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CMGF: (0)
ofonod[15312]: > AT+CGSN\r
ofonod[15312]: < AT+CGSN\r
ofonod[15312]: < \r\n352022031549734\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: attr_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: 352022031549734
ofonod[15312]: > AT+CPMS=3D?\r
ofonod[15312]: < AT+CPMS=3D?\r
ofonod[15312]: < \r\n+CPMS: ("ME","SM"),("ME","SM"),("ME","SM")\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: cpms_query_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CPMS: ("ME","SM"),("ME","SM"),("ME","SM")
ofonod[15312]: > AT+CMGF=3D0\r
ofonod[15312]: < AT+CMGF=3D0\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_cmgf_set_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: > AT+CPMS=3D"ME","ME","ME"\r
ofonod[15312]: < AT+CPMS=3D"ME","ME","ME"\r
ofonod[15312]: < \r\n+CPMS: 13,39031,13,39031,13,39031\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_cpms_set_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CPMS: 13,39031,13,39031,13,39031
ofonod[15312]: > AT+CNMI=3D?\r
ofonod[15312]: < AT+CNMI=3D?\r
ofonod[15312]: < \r\n+CNMI: (2),(0,1,3),(0,2),(0,1),(0)\r\n\r\nOK\r\n
ofonod[15312]: at_cnmi_query_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CNMI: (2),(0,1,3),(0,2),(0,1),(0)
ofonod[15312]: > AT+CNMI=3D2,1,2,1,0\r
ofonod[15312]: < AT+CNMI=3D2,1,2,1,0\r
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: MessageWaiting interface for modem: /modem1 created
ofonod[15312]: SmsManager interface for modem: /modem1 created
ofonod[15312]: > AT+CRSM=3D192,28618,0,0,15\r
ofonod[15312]: < AT+CRSM=3D192,28618,0,0,15\r
ofonod[15312]: < \r\n+CRSM: 148,4\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_crsm_info_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CRSM: 148,4
ofonod[15312]: Unable to read waiting messages numbers from SIM
ofonod[15312]: > AT+CRSM=3D192,28617,0,0,15\r
ofonod[15312]: < AT+CRSM=3D192,28617,0,0,15\r
ofonod[15312]: < \r\n+CRSM: 148,4\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_crsm_info_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CRSM: 148,4
ofonod[15312]: Unable to read mailbox identifies from SIM
ofonod[15312]: > AT+COPS=3D?\r
ofonod[15312]: < AT+COPS=3D?\r
ofonod[15312]: < \r\n+COPS: (1,"China Mobile","CHN CMCC","46000",0),(3,"Chi=
na Unicom","CHN CU-GSM","46001",2)\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: cops_list_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +COPS: (1,"China Mobile","CHN CMCC","46000",0=
),(3,"China Unicom","CHN CU-GSM","46001",2)
ofonod[15312]: Got 2 elements
ofonod[15312]: Got 2 operators
ofonod[15312]: Operator: China Mobile, 460, 00, status: 1, 0
ofonod[15312]: Operator: China Unicom, 460, 01, status: 3, 2
ofonod[15312]: > AT+CSCA?\r
ofonod[15312]: < AT+CSCA?\r
ofonod[15312]: < \r\n+CSCA: "+8613800210500",145\r\n
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: at_csca_cb got result: 1
ofonod[15312]: Final response: OK
ofonod[15312]: Response line: +CSCA: "+8613800210500",145
ofonod[15312]: csca_query_cb: 8613800210500, 145
ofonod[15312]: Got 1 recipients
ofonod[15312]: ref: 1, offset: 0
ofonod[15312]: pdu_len: 22, tpdu_len: 21
ofonod[15312]: tx_next: 0x8b8a248
ofonod[15312]: > AT+CMGS=3D21\r
ofonod[15312]: < AT+CMGS=3D21\r
ofonod[15312]: < \r\n> =

ofonod[15312]: > 0011000B813118567873F20000A707EDF27C1E3E9701<CtrlZ>
ofonod[15312]: < 0011000B813118567873F20000A707EDF27C1E3E9701<CtrlZ>
ofonod[15312]: < \r\n+CMGS: 124
ofonod[15312]: < \r\nOK\r\n
ofonod[15312]: Got 1 recipients
ofonod[15312]: ref: 2, offset: 0
ofonod[15312]: pdu_len: 22, tpdu_len: 21

Thanks


--===============4208742980717927618==--

