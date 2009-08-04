Content-Type: multipart/mixed; boundary="===============3158492616937251421=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: segment fault in latest version
Date: Tue, 04 Aug 2009 11:31:49 +0800
Message-ID: <B94C62E7C2870743865418621F040C1302055CD715@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3158492616937251421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
Does its known issue of segment fault in latest version?
I think the version of yesterday is ok
[root(a)zgli src]# ./ofonod -dn
ofonod[3314]: oFono version 0.2
ofonod[3314]: plugin.c:__ofono_plugin_init() =

ofonod[3314]: history.c:ofono_history_driver_register() driver: 0x8082280 n=
ame: Example Call History
ofonod[3314]: Seting up AT channel
ofonod[3314]: Example History Probe for modem: 0x9e02ce0
ofonod[3314]: SIMManager interface for modem: /modem1 created
ofonod[3314]: Registered call forwarding interface
ofonod[3314]: Registered call settings interface
ofonod[3314]: Sending voice initialization commands
ofonod[3314]: NetworkRegistration interface for modem: /modem1 created
ofonod[3314]: voicecall_init: registering to notifications
ofonod[3314]: csms_query_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CSMS: (0)
ofonod[3314]: CSMS query parsed successfully
ofonod[3314]: at_list_charsets_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CSCS: ("GSM","IRA","8859-1","UTF-8","UCS2")
ofonod[3314]: attr_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: Sony Ericsson
ofonod[3314]: at_cimi_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: 460028210210167
ofonod[3314]: cimi_cb: 460028210210167
ofonod[3314]: at_creg_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CREG: 2,5,"188E","00006302"
ofonod[3314]: creg_cb: 5, 6286, 25346, -1
ofonod[3314]: at_list_storages_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CPBS: ("ME","SM","FD","DC","LD","MC","RC")
ofonod[3314]: attr_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: AAD-3352021-BV
ofonod[3314]: at_crsm_info_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CRSM: 148,4
ofonod[3314]: cops_numeric_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +COPS: 1,2,"46000",0 =

ofonod[3314]: Cops numeric got mcc: 460, mnc: 00
ofonod[3314]: cops_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +COPS: 1,0,"China Mobile",0 =

ofonod[3314]: cops_cb: China Mobile, 460 00 0
ofonod[3314]: csq_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CSQ: 13,99
ofonod[3314]: csq_cb: 13
ofonod[3314]: csms_status_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CSMS: 0,1,1,1
ofonod[3314]: attr_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: R1BA038 081016 1346 1208-0527_CHINA_SI
ofonod[3314]: at_crsm_info_cb got result: 1
ofonod[3314]: Final response: OK
ofonod[3314]: Response line: +CRSM: 148,4
Segmentation fault

Thanks
zgli

--===============3158492616937251421==--

