Content-Type: multipart/mixed; boundary="===============8912367915795360270=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: Can't send second message in v0.3
Date: Thu, 20 Aug 2009 11:32:10 +0800
Message-ID: <B94C62E7C2870743865418621F040C130206BE7D14@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200908192210.11656.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8912367915795360270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

>Are you sure this worked before on this modem?

Yes, this is the log of v0.2 and no at debug trace
ofonod[18711]: oFono version 0.2
ofonod[18711]: plugin.c:__ofono_plugin_init() =

ofonod[18711]: Seting up AT channel
ofonod[18711]: SIMManager interface for modem: /modem1 created
ofonod[18711]: Registered call forwarding interface
ofonod[18711]: Registered call settings interface
ofonod[18711]: Sending voice initialization commands
ofonod[18711]: NetworkRegistration interface for modem: /modem1 created
ofonod[18711]: voicecall_init: registering to notifications
ofonod[18711]: csms_query_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CSMS: (0)
ofonod[18711]: CSMS query parsed successfully
ofonod[18711]: at_list_charsets_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CSCS: ("GSM","IRA","8859-1","UTF-8","UCS2")
ofonod[18711]: Phonebook not supported by this modem.  If this is in error =
please submit patches to support this hardware
ofonod[18711]: attr_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: Sony Ericsson
ofonod[18711]: at_cimi_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: 460028210210167
ofonod[18711]: cimi_cb: 460028210210167
ofonod[18711]: at_creg_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CREG: 2,5,"188E","00006302"
ofonod[18711]: creg_cb: 5, 6286, 25346, -1
ofonod[18711]: attr_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: AAD-3352021-BV
ofonod[18711]: at_crsm_info_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CRSM: 148,4
ofonod[18711]: cops_numeric_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +COPS: 0,2,"46000",0 =

ofonod[18711]: Cops numeric got mcc: 460, mnc: 00
ofonod[18711]: cops_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +COPS: 0,0,"China Mobile",0 =

ofonod[18711]: cops_cb: China Mobile, 460 00 0
ofonod[18711]: csq_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CSQ: 20,99
ofonod[18711]: csq_cb: 20
ofonod[18711]: csms_status_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CSMS: 0,1,1,1
ofonod[18711]: attr_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: R1BA038 081016 1346 1208-0527_CHINA_SI
ofonod[18711]: at_crsm_info_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CRSM: 148,4
ofonod[18711]: cmgf_query_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CMGF: (0)
ofonod[18711]: attr_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: 352022031549734
ofonod[18711]: at_crsm_info_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CRSM: 148,4
ofonod[18711]: cpms_query_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CPMS: ("ME","SM"),("ME","SM"),("ME","SM")
ofonod[18711]: at_cmgf_set_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: at_cpms_set_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CPMS: 13,39031,13,39031,13,39031
ofonod[18711]: at_cnmi_query_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CNMI: (2),(0,1,3),(0,2),(0,1),(0)
ofonod[18711]: SmsManager interface for modem: /modem1 created
ofonod[18711]: cops_list_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +COPS: (1,"China Mobile","CHN CMCC","46000",0=
),(3,"China Unicom","CHN CU-GSM","46001",2)
ofonod[18711]: Got 2 elements
ofonod[18711]: Got 2 operators
ofonod[18711]: Operator: China Mobile, 460, 00, status: 1, 0
ofonod[18711]: Operator: China Unicom, 460, 01, status: 3, 2
ofonod[18711]: at_csca_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CSCA: "+8613800210500",145
ofonod[18711]: csca_query_cb: 8613800210500, 145
ofonod[18711]: Got 1 recipients
ofonod[18711]: ref: 1, offset: 0
ofonod[18711]: pdu_len: 22, tpdu_len: 21
ofonod[18711]: tx_next: 0x84ff248
ofonod[18711]: at_cmgs_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CMGS: 127
ofonod[18711]: Got MR: 127
ofonod[18711]: tx_finished
ofonod[18711]: Peeking in the queue
ofonod[18711]: Got 1 recipients
ofonod[18711]: ref: 2, offset: 0
ofonod[18711]: pdu_len: 22, tpdu_len: 21
ofonod[18711]: tx_next: 0x84ff248
ofonod[18711]: at_cmgs_cb got result: 1
ofonod[18711]: Final response: OK
ofonod[18711]: Response line: +CMGS: 128
ofonod[18711]: Got MR: 128
ofonod[18711]: tx_finished
ofonod[18711]: Peeking in the queue

>
>> ofonod[15312]: < \r\n+CMGS: 124
>> ofonod[15312]: < \r\nOK\r\n
>
>This line tells me the modem is not a compliant 27.007 modem as there's no
>terminating \r\n on the CMGS.  The default parser is extremely strict and
>ignores this input.  A slightly tweaked parser is required for this device.


I guess that's the point, v0.3 follow the spec strictly now.

>
>Regards,
>-Denis
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============8912367915795360270==--

