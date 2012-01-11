Content-Type: multipart/mixed; boundary="===============1494466177829561521=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: How to tweak sim atom
Date: Wed, 11 Jan 2012 16:50:33 +0100
Message-ID: <4F0DAFC9.3010403@linux.intel.com>
In-Reply-To: <4F0D76DC.3050605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1494466177829561521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> 4) Having 2 drivers can be a solution to make difference between CSIM
>> and (U)SIM:
>>          - "atmodem/sim.c" drivers
>>          - "cdmamodem/sim.c" drivers
>> There can be a lib simutil for PIN management and IMSI retrieval whose
>> APIs would be called by "atmodem" and "cdmamodem" drivers to avoid
>> duplicated code.
>>
> Why don't you try adding a 'atmodem-noef' driver to
> drivers/atmodem/sim.c and see how far you get?  You only need ~13 lines
> of code and a register / unregister driver call

It seems working according to what I get from pre_sim() state:

ofonod[12224]: plugins/huawei.c:huawei_pre_sim() 0x81d86d0
ofonod[12224]: PCUI: > AT^CVOICE?\r
ofonod[12224]: src/sim.c:ofono_sim_add_state_watch() 0x81d0740
ofonod[12224]: src/sim.c:ofono_sim_add_state_watch() 0x81d0740
ofonod[12224]: src/sim.c:ofono_sim_add_state_watch() 0x81d0740
ofonod[12224]: PCUI: < \r\n^CVOICE:1\r\n\r\nOK\r\n
ofonod[12224]: PCUI: > AT+GCAP\r
ofonod[12224]: PCUI: < \r\n+GCAP: +CIS707-A,CIS-856-A,+MS, +ES, +DS, =

+FCLASS\r\n\r\nOK\r\n
ofonod[12224]: PCUI: > AT+CPIN?\r
ofonod[12224]: PCUI: < \r\n+CPIN:READY\r\n\r\nOK\r\n
ofonod[12224]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[12224]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[12224]: PCUI: > AT+GMI\r
ofonod[12224]: PCUI: < \r\n+GMI: HUAWEI TECHNOLOGIES CO., LTD\r\n\r\nOK\r\n
ofonod[12224]: PCUI: > AT^CPIN?\r
ofonod[12224]: PCUI: < \r\n^CPIN:READY,2,10,2,10,3\r\n\r\nOK\r\n
ofonod[12224]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter =

id=3D9, val=3D10
ofonod[12224]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter =

id=3D1, val=3D2
ofonod[12224]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter =

id=3D11, val=3D10
ofonod[12224]: drivers/atmodem/sim.c:huawei_cpin_cb() retry counter =

id=3D4, val=3D3
ofonod[12224]: PCUI: > AT+CIMI\r
ofonod[12224]: PCUI: < \r\n510992151460620\r\n\r\r\n\r\nOK\r\n
ofonod[12224]: drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 510992151460620
ofonod[12224]: src/modem.c:modem_change_state() old state: 1, new state: 2
ofonod[12224]: plugins/huawei.c:huawei_post_sim() 0x81d86d0
ofonod[12224]: PCUI: > AT+GMM\r
ofonod[12224]: PCUI: < \r\nEC1261\r\n\r\nOK\r\n
ofonod[12224]: PCUI: > AT+GMR\r
ofonod[12224]: PCUI: < \r\n+CGMR:11.102.11.00.45\r\n\r\nOK\r\n
ofonod[12224]: PCUI: > AT+GSN\r
ofonod[12224]: PCUI: < \r\n+GSN:80363dac\r\n\r\nOK\r\n

./online-modem

ofonod[12224]: plugins/huawei.c:huawei_set_online() modem 0x81d86d0 online
ofonod[12224]: PCUI: > AT+CFUN=3D1\r
ofonod[12224]: PCUI: < \r\nOK\r\n
ofonod[12224]: PCUI: > AT^SYSINFO\r
ofonod[12224]: PCUI: < \r\n^SYSINFO:0,255,0,0,1\r\n\r\nOK\r\n
ofonod[12224]: plugins/huawei.c:sysinfo_online_cb() 1 -> 1
ofonod[12224]: src/modem.c:modem_change_state() old state: 2, new state: 3
ofonod[12224]: plugins/huawei.c:huawei_post_online() 0x81d86d0
ofonod[12224]: src/cdma-connman.c:ofono_cdma_connman_create()
ofonod[12224]: drivers/cdmamodem/connman.c:cdma_connman_probe()
ofonod[12224]: PCUI: > AT^SYSINFO\r
ofonod[12224]: Modem: > AT+CTA=3D0\r
ofonod[12224]: PCUI: < \r\n^SYSINFO:0,255,0,0,1\r\n\r\nOK\r\n
ofonod[12224]: Modem: < \r\nOK\r\n
ofonod[12224]: Modem: > AT&C0\r
ofonod[12224]: Modem: < \r\nOK\r\n
ofonod[12224]: drivers/cdmamodem/connman.c:at_c0_cb() ok 1
ofonod[12224]: src/cdma-connman.c:ofono_cdma_connman_register()


Kind regards,
Guillaume

--===============1494466177829561521==--

