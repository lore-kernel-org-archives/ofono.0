Content-Type: multipart/mixed; boundary="===============2289330022570871792=="
MIME-Version: 1.0
From: Ming Li Wu <mingli@southpole.se>
Subject: Telit he910 ---- modem port got stuck
Date: Tue, 12 Mar 2013 14:26:15 +0100
Message-ID: <513F2CF7.7040704@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2289330022570871792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am using Telit HE910 modem, the version of firmware is 12.00.03.

Sometimes, the modem port got stuck after sending AT+CGDCONT=3D1.
(Such as AT+CGDCONT=3D1,"IP","internet.tele2.se").

When this problem happened, I could not get any information from the =

modem port
after this command..


The following was the situation when this problem happened
  Aux: > AT+CRSM=3D192,28621\r
  Modem: > AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
  Modem: < AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
  Aux: < \r\n+CME ERROR: 4\r\n

According to Telit AT Commands Reference Guide:
/3.2.5. Command Issuing Timing/

/The chain Command -> Response shall always be respected and a new =

command must not be//
//issued before the module has terminated all the sending of its =

response result code (whatever it//
//may be)./

It seems that this problem is caused by "Command Issuing TIming"

Since there were alway some pending responses on the AUX port when this =

problem happened.
and there was no pending response on the AUX port when it worked.

when it worked:
  Aux: > AT+CRSM=3D192,28621\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CRSM=3D192,28437\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
  Modem: > AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
  Modem: < AT+CGDCONT=3D1,"IP","internet.tele2.se"\r\r\nOK\r\n

I added sleep(1) just before sending out =

AT+CGDCONT=3D1,"IP","internet.tele2.se command.
It worked well. I know this is a bad idea.

If this problem is really caused by "Command Issuing TIming",  How =

should we solve or work around this problem?


Thanks.

Mingli

The following is trace log.


  Aux: > ATE0 +CMEE=3D1\r
  Aux: < ATE0 +CMEE=3D1\r\r\nOK\r\n
  Aux: > AT#QSS=3D0\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CFUN=3D1\r
  Aux: < \r\nOK\r\n
  plugins/telit.c:cfun_enable_cb() 0x9b6af8
  src/modem.c:modem_change_state() old state: 0, new state: 1
  plugins/telit.c:telit_pre_sim() 0x9b6af8
  Aux: > AT&C0\r
  src/sim.c:ofono_sim_add_state_watch() 0x9afc98
  src/sim.c:ofono_sim_add_state_watch() 0x9afc98
  src/sim.c:ofono_sim_add_state_watch() 0x9afc98
  Aux: < \r\nOK\r\n
  Aux: > AT+GCAP\r
  Aux: < \r\n+GCAP: +CGSM,+DS,+FCLASS,+MS,+ES\r\n\r\nOK\r\n
  Aux: > AT+CRC=3D1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CLIP=3D1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CDIP=3D1\r
  Aux: < \r\nERROR\r\n
  Aux: > AT+CNAP=3D1\r
  Aux: < \r\nERROR\r\n
  Aux: > AT+COLP=3D1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CSSN=3D1,1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+VTD?\r
  Aux: < \r\n0\r\n\r\nOK\r\n
  Aux: > AT+CCWA=3D1\r
  Aux: < \r\nOK\r\n
  drivers/atmodem/voicecall.c:at_voicecall_initialized() voicecall_init: =

registering to notifications
  src/sim.c:ofono_sim_add_state_watch() 0x9afc98
  Aux: > AT#AUTOATT=3D0\r
  Aux: < \r\nOK\r\n
  Aux: > AT#QSS=3D2\r
  Aux: < \r\nOK\r\n
  Aux: > AT#QSS?\r
  Aux: < \r\n#QSS: 2,1\r\n\r\nOK\r\n
  plugins/telit.c:telit_qss_notify() 0x9b6af8
plugins/telit.c:switch_sim_state_status() 0x9b6af8, SIM status: 1
  Aux: > AT+CGMI\r
  Aux: < \r\nTelit\r\n\r\nOK\r\n
  Aux: > AT+CLCC\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CPIN?\r
  Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
  Aux: > AT+CGMM\r
  Aux: < \r\nHE910\r\n\r\nOK\r\n
  Aux: > AT+CPMS?\r
  Aux: < \r\n+CPMS: "SM",0,25,"SM",0,25,"SM",0,25\r\n\r\nOK\r\n
  Aux: > AT+CGMR\r
  Aux: < \r\n12.00.002\r\n\r\nOK\r\n
  Aux: > AT+CSCS=3D?\r
  Aux: < \r\n+CSCS: ("GSM","IRA","8859-1","PCCP437","UCS2")\r\n\r\nOK\r\n
  Aux: > AT+CSMS=3D?\r
  Aux: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
  drivers/atmodem/sms.c:at_csms_query_cb() CSMS query parsed successfully
  Aux: > AT+CRSM=3D192,28599\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  src/voicecall.c:ecc_g2_read_cb() 0
  Aux: > AT+CGSN\r
  Aux: < \r\n357164045019588\r\n\r\nOK\r\n
  Aux: > AT+CPBS=3D?\r
  Aux: < \r\n+CPBS: ("SM","FD","LD","MC","RC","DC","ME","ON")\r\n\r\nOK\r\n
  Aux: > AT+CSMS=3D1\r
  Aux: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D192,28599\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  src/voicecall.c:ecc_g3_read_cb() 0
  Aux: > AT+CSMS?\r
  Aux: < \r\n
  Aux: < +CSMS: 1,1,1,1\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D192,12258\r
  Aux: < \r\n+CRSM: 144,0,0000000A2FE204000EFFEE01020000\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 15
  Aux: > AT+CMGF=3D?\r
  Aux: < \r\n+CMGF: (0,1)\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D176,12258,0,0,10\r
  Aux: < \r\n+CRSM: 144,0,98640244020000105139\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 10
  src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 10
  Aux: > AT+CPMS=3D?\r
  Aux: < \r\n+CPMS: ("SM"),("SM"),("SM")\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D192,28421\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CMGF=3D0\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CRSM=3D192,12037\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CPMS=3D"SM","SM","SM"\r
  Aux: < \r\n+CPMS: 0,25,0,25,0,25\r\n\r\nOK\r\n
  Aux: > AT+CPIN?\r
  Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
  drivers/atmodem/sim.c:at_pin_retries_query()
  Aux: > AT+CNMI=3D?\r
  Aux: < \r\n+CNMI: (0-3),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
  drivers/atmodem/sms.c:build_cnmi_string()
  drivers/atmodem/sms.c:construct_ack_pdu()
  Aux: > AT#PCT\r
  Aux: < \r\n#PCT: 3\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_pct_cb() Note: No password required, =

returning maximum retries:
  drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D1, val=3D3
  drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D4, val=3D3
  drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D9, val=3D10
  drivers/atmodem/sim.c:at_pct_cb() retry counter id=3D11, val=3D10
  Aux: > AT+CRSM=3D192,28590\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CNMI=3D2,2,2,1,0\r
  Aux: < \r\nOK\r\n
  src/sms.c:sms_restore_tx_queue()
  plugins/push-notification.c:sms_watch() registered
  plugins/smart-messaging.c:sms_watch() registered
  Aux: > AT+CRSM=3D192,28589\r
  Aux: < \r\n+CRSM: 144,0,000000036FAD04000EFFEE01020000\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 15
  Aux: > AT+CMGL=3D4\r
  Aux: < \r\nOK\r\n
  drivers/atmodem/sms.c:at_cmgl_done()
  Aux: > AT+CGSMS=3D3\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CRSM=3D176,28589,0,0,3\r
  Aux: < \r\n
  Aux: < +CRSM: 144,0,00FFFF\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 3
  src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 3
  EFad does not specify (optional) MNC length, defaulting to 2
  Aux: > AT+CRSM=3D192,28438\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D192,28472\r
  Aux: < \r\n+CRSM: 144,0,0000000E6F3804001EFFEE01020000\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 15
  Aux: > AT+CRSM=3D176,28472,0,0,14\r
  Aux: < \r\n+CRSM: 144,0,FF3FFF0F0300FC03000CC300F0C0\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 14
  src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0, tocopy: 14
  Aux: > AT+CRSM=3D192,28502\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CIMI\r
  Aux: < \r\n240075990001159\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_cimi_cb() cimi_cb: 240075990001159
  src/modem.c:modem_change_state() old state: 1, new state: 2
  plugins/telit.c:telit_post_sim() 0x9b6af8
  drivers/atmodem/gprs-context.c:at_gprs_context_probe()
  Aux: > AT+CGDCONT=3D?\r
  plugins/telit.c:telit_set_online() modem 0x9b6af8 online
  Aux: < \r\n+CGDCONT: (1-5),"IP",,,(0,1),(0,1)\r\n\r\nOK\r\n
  Aux: > AT+CFUN=3D1,0\r
  Aux: < \r\nOK\r\n
  src/modem.c:modem_change_state() old state: 2, new state: 3
  plugins/telit.c:telit_post_online() 0x9b6af8
  Aux: > AT#QSS?\r
  Aux: < \r\n#QSS: 2,1\r\n\r\nOK\r\n
  plucins/telit.c:telit_qss_notify() 0x9b6af8
  plugins/telit.c:switch_sim_state_status() 0x9b6af8, SIM status: 1
  Aux: > AT+CRSM=3D192,28480\r
  Aux: < \r\n+CRSM: 144,0,000000386F40040011FFEE0102011C\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00, 15
  Aux: > AT+CGREG=3D?\r
  Aux: < \r\n+CGREG: (0-2)\r\n\r\nOK\r\n
  Aux: > AT+CREG=3D?\r
  Aux: < \r\n
  Aux: < +CREG: (0-2)\r\n\r\nOK\r\n
  Aux: > AT+CSCS?\r
  Aux: < \r\n+CSCS: "IRA"\r\n\r\nOK\r\n
  Aux: > AT+CUSD=3D1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CAOC=3D2\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CCWE=3D1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CPIN?\r
  Aux: < \r\n+CPIN: READY\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D178,28480,1,4,28\r
  Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 28
  Aux: > AT+CGREG=3D2\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CGAUTO=3D0\r
  Aux: < \r\nERROR\r\n
  Aux: > AT+CGEREP=3D2,1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CREG=3D2\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CPMS?\r
  Aux: < \r\n+CPMS: "SM",0,25,"SM",0,25,"SM",0,25\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D178,28480,2,4,28\r
  Aux: < \r\n+CRSM: =

144,0,FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF\r\n\r\nOK\r\n
  drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00, 28
  Aux: > AT#PSNT=3D1\r
  Aux: < \r\nOK\r\n
  Aux: > AT+CPSB=3D1\r
  Aux: < \r\nERROR\r\n
  Aux: > AT+CIND=3D?\r
  Aux: < \r\n+CIND: =

(("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",(0,1=
)),("messn
  Aux: > AT+CRSM=3D192,28489\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  Aux: > AT+CMER=3D?\r
  Aux: < \r\n+CMER: (0-3),(0),(0),(0,2),(0,1)\r\n\r\nOK\r\n
  drivers/atmodem/network-registration.c:build_cmer_string()
  Aux: > AT+CRSM=3D192,20256\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CMER=3D3,0,0,2\r
  Aux: < \r\nOK\r\n
  Aux: < \r\n+CIEV: battchg,0\r\n\r\n+CIEV: signal,7\r\n\r\n+CIEV: =

service,1\r\n\r\n+CIEV: sounder,0\r\nn
  src/sim.c:ofono_sim_add_spn_watch() 0x9afc98
  src/network.c:__ofono_netreg_add_status_watch() 0x9b9ff0
  src/network.c:__ofono_netreg_add_status_watch() 0x9b9ff0
  Aux: > AT+CRSM=3D192,28618\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  Unable to read waiting messages numbers from SIM
  Aux: > AT+CREG?\r
  Aux: < \r\n+CREG: 2,1,"00D4","0D45D96",2\r\n\r\nOK\r\n
  src/network.c:ofono_netreg_status_notify() /telit_0 status 1 tech 2
  src/gprs.c:netreg_status_changed() 1
  Aux: > AT+CRSM=3D192,28617\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  Unable to read mailbox identifies from SIM
  Aux: > AT+COPS=3D3,2\r
  Aux: < \r\nOK\r\n
  Aux: > AT+COPS?\r
  Aux: < \r\n+COPS: 0,2,"24005",2\r\n\r\nOK\r\n
  drivers/atmodem/network-registration.c:cops_numeric_cb() Cops numeric =

got mcc: 240, mnc: 05
  Aux: > AT+CIND?\r
  Aux: < \r\n+CIND: 0,7,1,0,0,0,0,0,5\r\n\r\nOK\r\n
  src/network.c:ofono_netreg_strength_notify() strength 100
  Aux: > AT+CGATT=3D1\r
  Aux: < \r\nOK\r\n
  Aux: < \r\n+CGREG: 1,"00D4","0D45D96",2,"01"\r\n
  src/gprs.c:gprs_attach_callback() /telit_0 error =3D 0
  src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
  Aux: > AT+CIND?\r
  Aux: < \r\n+CIND: 0,7,1,0,0,0,0,0,5\r\n\r\nOK\r\n
  Aux: > AT+CRSM=3D192,28433\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  src/message-waiting.c:mw_cphs_mwis_read_cb() No CPHS MWIS on SIM
  Aux: > AT+COPS=3D3,0\r
  Aux: < \r\nOK\r\n
  Aux: > AT+COPS?\r
  Aux: < \r\n+COPS: 0,0,"S 05",2\r\n\r\nOK\r\n
  drivers/atmodem/network-registration.c:cops_cb() cops_cb: S 05, 240 05 2
  src/network.c:current_operator_callback() 0x9b9ff0, (nil)
  src/gprs.c:netreg_status_changed() 1
  Aux: > AT+CGREG?\r
  Aux: < \r\n
  Aux: < +CGREG: 2,1,"00D4","0D45D96",2,"01"\r\n\r\nOK\r\n
  src/gprs.c:registration_status_cb() /telit_0 error 0 status 1
  src/gprs.c:ofono_gprs_status_notify() /telit_0 status 1
  Aux: > AT+CRSM=3D192,28435\r
  Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
  src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff: 39, toread: 17
  Aux: > AT+CRSM=3D192,28621\r
  drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
  Modem: > AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
  Modem: < AT+CGDCONT=3D1,"IP","internet.tele2.se"\r
  Aux: < \r\n+CME ERROR: 4\r\n
  Aux: > AT+CRSM=3D192,28437\r







--===============2289330022570871792==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CgogICAgPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250
ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9SVNPLTg4NTktMSI+CiAgPC9oZWFkPgogIDxib2R5IHRl
eHQ9IiMwMDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgSGVsbG8sPGJyPgogICAgPGJyPgog
ICAgSSBhbSB1c2luZyBUZWxpdCBIRTkxMCBtb2RlbSwgdGhlIHZlcnNpb24gb2YgZmlybXdhcmUg
aXMgMTIuMDAuMDMuPGJyPgogICAgPGJyPgogICAgU29tZXRpbWVzLCB0aGUgbW9kZW0gcG9ydCBn
b3Qgc3R1Y2sgYWZ0ZXIgc2VuZGluZyBBVCtDR0RDT05UPTEuPGJyPgogICAgKFN1Y2ggYXMgQVQr
Q0dEQ09OVD0xLCJJUCIsImludGVybmV0LnRlbGUyLnNlIikuPGJyPgogICAgPGJyPgogICAgV2hl
biB0aGlzIHByb2JsZW0gaGFwcGVuZWQsIEkgY291bGQgbm90IGdldCBhbnkgaW5mb3JtYXRpb24g
ZnJvbSB0aGUKICAgIG1vZGVtIHBvcnQ8YnI+CiAgICBhZnRlciB0aGlzIGNvbW1hbmQuLjxicj4K
ICAgIDxicj4KICAgIDxicj4KICAgIFRoZSBmb2xsb3dpbmcgd2FzIHRoZSBzaXR1YXRpb24gd2hl
biB0aGlzIHByb2JsZW0gaGFwcGVuZWQ8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ1JTTT0x
OTIsMjg2MjFccjxicj4KICAgICZuYnNwO01vZGVtOiAmZ3Q7IEFUK0NHRENPTlQ9MSwiSVAiLCJp
bnRlcm5ldC50ZWxlMi5zZSJccjxicj4KICAgICZuYnNwO01vZGVtOiAmbHQ7IEFUK0NHRENPTlQ9
MSwiSVAiLCJpbnRlcm5ldC50ZWxlMi5zZSJccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxu
K0NNRSBFUlJPUjogNFxyXG48YnI+CiAgICA8YnI+CiAgICBBY2NvcmRpbmcgdG8gVGVsaXQgQVQg
Q29tbWFuZHMgUmVmZXJlbmNlIEd1aWRlOiZuYnNwOyA8YnI+CiAgICA8aT4zLjIuNS4gQ29tbWFu
ZCBJc3N1aW5nIFRpbWluZzwvaT48YnI+CiAgICA8YnI+CiAgICA8aT5UaGUgY2hhaW4gQ29tbWFu
ZCAtJmd0OyBSZXNwb25zZSBzaGFsbCBhbHdheXMgYmUgcmVzcGVjdGVkIGFuZCBhCiAgICAgIG5l
dyBjb21tYW5kIG11c3Qgbm90IGJlPC9pPjxpPjxicj4KICAgIDwvaT48aT5pc3N1ZWQgYmVmb3Jl
IHRoZSBtb2R1bGUgaGFzIHRlcm1pbmF0ZWQgYWxsIHRoZSBzZW5kaW5nIG9mCiAgICAgIGl0cyBy
ZXNwb25zZSByZXN1bHQgY29kZSAod2hhdGV2ZXIgaXQ8L2k+PGk+PGJyPgogICAgPC9pPjxpPm1h
eSBiZSkuPC9pPjxicj4KICAgIDxicj4KICAgIEl0IHNlZW1zIHRoYXQgdGhpcyBwcm9ibGVtIGlz
IGNhdXNlZCBieSAiQ29tbWFuZCBJc3N1aW5nIFRJbWluZyI8YnI+CiAgICA8YnI+CiAgICBTaW5j
ZSB0aGVyZSB3ZXJlIGFsd2F5IHNvbWUgcGVuZGluZyByZXNwb25zZXMgb24gdGhlIEFVWCBwb3J0
IHdoZW4KICAgIHRoaXMgcHJvYmxlbSBoYXBwZW5lZC48YnI+CiAgICBhbmQgdGhlcmUgd2FzIG5v
IHBlbmRpbmcgcmVzcG9uc2Ugb24gdGhlIEFVWCBwb3J0IHdoZW4gaXQgd29ya2VkLjxicj4KICAg
IDxicj4KICAgIHdoZW4gaXQgd29ya2VkOjxicj4KICAgICZuYnNwO0F1eDogJmd0OwogICAgQVQr
Q1JTTT0xOTIsMjg2MjFcciZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOwogICAgPGJy
PgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ01FIEVSUk9SOgogICAgNFxyXG4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7CiAgICBBVCtDUlNNPTE5MiwyODQz
N1xyJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7CiAgICA8YnI+CiAgICAmbmJzcDtB
dXg6ICZsdDsgXHJcbitDUlNNOgogICAgMTQ4LDRcclxuXHJcbk9LXHJcbiZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyA8YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6
YXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5KCkgY2lkCiAgICAxJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxicj4KICAgICZuYnNwO01vZGVtOiAmZ3Q7CiAgICBBVCtDR0RD
T05UPTEsIklQIiwiaW50ZXJuZXQudGVsZTIuc2UiXHImbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsKICAgIDxicj4K
ICAgICZuYnNwO01vZGVtOiAmbHQ7IEFUK0NHRENPTlQ9MSwiSVAiLCJpbnRlcm5ldC50ZWxlMi5z
ZSJcclxyXG5PS1xyXG4gPGJyPgogICAgPGJyPgogICAgSSBhZGRlZCBzbGVlcCgxKSBqdXN0IGJl
Zm9yZSBzZW5kaW5nIG91dAogICAgQVQrQ0dEQ09OVD0xLCJJUCIsImludGVybmV0LnRlbGUyLnNl
IGNvbW1hbmQuPGJyPgogICAgSXQgd29ya2VkIHdlbGwuIEkga25vdyB0aGlzIGlzIGEgYmFkIGlk
ZWEuIDxicj4KICAgIDxicj4KICAgIElmIHRoaXMgcHJvYmxlbSBpcyByZWFsbHkgY2F1c2VkIGJ5
ICJDb21tYW5kIElzc3VpbmcgVEltaW5nIiwmbmJzcDsgSG93CiAgICBzaG91bGQgd2Ugc29sdmUg
b3Igd29yayBhcm91bmQgdGhpcyBwcm9ibGVtPzxicj4KICAgIDxicj4KICAgIDxicj4KICAgIFRo
YW5rcy48YnI+CiAgICA8YnI+CiAgICBNaW5nbGk8YnI+CiAgICA8YnI+CiAgICBUaGUgZm9sbG93
aW5nIGlzIHRyYWNlIGxvZy48YnI+CiAgICA8YnI+CiAgICA8YnI+CiAgICAmbmJzcDtBdXg6ICZn
dDsgQVRFMCArQ01FRT0xXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgQVRFMCArQ01FRT0xXHJc
clxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUI1FTUz0wXHI8YnI+CiAgICAmbmJz
cDtBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDRlVOPTFc
cjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7cGx1Z2lu
cy90ZWxpdC5jOmNmdW5fZW5hYmxlX2NiKCkgMHg5YjZhZjg8YnI+CiAgICAmbmJzcDtzcmMvbW9k
ZW0uYzptb2RlbV9jaGFuZ2Vfc3RhdGUoKSBvbGQgc3RhdGU6IDAsIG5ldyBzdGF0ZTogMTxicj4K
ICAgICZuYnNwO3BsdWdpbnMvdGVsaXQuYzp0ZWxpdF9wcmVfc2ltKCkgMHg5YjZhZjg8YnI+CiAg
ICAmbmJzcDtBdXg6ICZndDsgQVQmYW1wO0MwXHI8YnI+CiAgICAmbmJzcDtzcmMvc2ltLmM6b2Zv
bm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4OWFmYzk4PGJyPgogICAgJm5ic3A7c3JjL3NpbS5j
Om9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDlhZmM5ODxicj4KICAgICZuYnNwO3NyYy9z
aW0uYzpvZm9ub19zaW1fYWRkX3N0YXRlX3dhdGNoKCkgMHg5YWZjOTg8YnI+CiAgICAmbmJzcDtB
dXg6ICZsdDsgXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtHQ0FQXHI8YnI+
CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitHQ0FQOiArQ0dTTSwrRFMsK0ZDTEFTUywrTVMsK0VT
XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ1JDPTFccjxicj4KICAg
ICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NM
SVA9MVxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtB
dXg6ICZndDsgQVQrQ0RJUD0xXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbkVSUk9SXHJc
bjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDTkFQPTFccjxicj4KICAgICZuYnNwO0F1eDog
Jmx0OyBcclxuRVJST1JcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NPTFA9MVxyPGJy
PgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZndDsg
QVQrQ1NTTj0xLDFccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAg
Jm5ic3A7QXV4OiAmZ3Q7IEFUK1ZURD9ccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuMFxy
XG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NDV0E9MVxyPGJyPgogICAg
Jm5ic3A7QXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0v
dm9pY2VjYWxsLmM6YXRfdm9pY2VjYWxsX2luaXRpYWxpemVkKCkKICAgIHZvaWNlY2FsbF9pbml0
OiByZWdpc3RlcmluZyB0byBub3RpZmljYXRpb25zPGJyPgogICAgJm5ic3A7c3JjL3NpbS5jOm9m
b25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDlhZmM5ODxicj4KICAgICZuYnNwO0F1eDogJmd0
OyBBVCNBVVRPQVRUPTBccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgog
ICAgJm5ic3A7QXV4OiAmZ3Q7IEFUI1FTUz0yXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJc
bk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCNRU1M/XHI8YnI+CiAgICAmbmJzcDtB
dXg6ICZsdDsgXHJcbiNRU1M6IDIsMVxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7cGx1Z2lu
cy90ZWxpdC5jOnRlbGl0X3Fzc19ub3RpZnkoKSAweDliNmFmODxicj4KICAgIHBsdWdpbnMvdGVs
aXQuYzpzd2l0Y2hfc2ltX3N0YXRlX3N0YXR1cygpIDB4OWI2YWY4LCBTSU0gc3RhdHVzOiAxPGJy
PgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NHTUlccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBc
clxuVGVsaXRcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDTENDXHI8
YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0
OyBBVCtDUElOP1xyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ1BJTjogUkVBRFlcclxu
XHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDR01NXHI8YnI+CiAgICAmbmJz
cDtBdXg6ICZsdDsgXHJcbkhFOTEwXHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZn
dDsgQVQrQ1BNUz9ccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NQTVM6ICJTTSIsMCwy
NSwiU00iLDAsMjUsIlNNIiwwLDI1XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZn
dDsgQVQrQ0dNUlxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4xMi4wMC4wMDJcclxuXHJc
bk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDU0NTPT9ccjxicj4KICAgICZuYnNw
O0F1eDogJmx0OyBcclxuK0NTQ1M6CiAgICAoIkdTTSIsIklSQSIsIjg4NTktMSIsIlBDQ1A0Mzci
LCJVQ1MyIilcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDU01TPT9c
cjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NTTVM6ICgwLDEpXHJcblxyXG5PS1xyXG48
YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vc21zLmM6YXRfY3Ntc19xdWVyeV9jYigpIENT
TVMgcXVlcnkgcGFyc2VkCiAgICBzdWNjZXNzZnVsbHk8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsg
QVQrQ1JTTT0xOTIsMjg1OTlccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NSU006IDE0
OCw0XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtzcmMvdm9pY2VjYWxsLmM6ZWNjX2cyX3Jl
YWRfY2IoKSAwPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NHU05ccjxicj4KICAgICZuYnNw
O0F1eDogJmx0OyBcclxuMzU3MTY0MDQ1MDE5NTg4XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJz
cDtBdXg6ICZndDsgQVQrQ1BCUz0/XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDUEJT
OgogICAgKCJTTSIsIkZEIiwiTEQiLCJNQyIsIlJDIiwiREMiLCJNRSIsIk9OIilcclxuXHJcbk9L
XHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDU01TPTFccjxicj4KICAgICZuYnNwO0F1
eDogJmx0OyBcclxuK0NTTVM6IDEsMSwxXHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6
ICZndDsgQVQrQ1JTTT0xOTIsMjg1OTlccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NS
U006IDE0OCw0XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtzcmMvdm9pY2VjYWxsLmM6ZWNj
X2czX3JlYWRfY2IoKSAwPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NTTVM/XHI8YnI+CiAg
ICAmbmJzcDtBdXg6ICZsdDsgXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmx0OyArQ1NNUzogMSwx
LDEsMVxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NSU009MTkyLDEy
MjU4XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDUlNNOgogICAgMTQ0LDAsMDAwMDAw
MEEyRkUyMDQwMDBFRkZFRTAxMDIwMDAwXHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtkcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZvX2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAs
IDE1PGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NNR0Y9P1xyPGJyPgogICAgJm5ic3A7QXV4
OiAmbHQ7IFxyXG4rQ01HRjogKDAsMSlcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDog
Jmd0OyBBVCtDUlNNPTE3NiwxMjI1OCwwLDAsMTBccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBc
clxuK0NSU006IDE0NCwwLDk4NjQwMjQ0MDIwMDAwMTA1MTM5XHJcblxyXG5PS1xyXG48YnI+CiAg
ICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkgY3JzbV9yZWFk
X2NiOiA5MCwgMDAsIDEwPGJyPgogICAgJm5ic3A7c3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRf
YmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsCiAgICB0b2NvcHk6IDEwPGJyPgogICAg
Jm5ic3A7QXV4OiAmZ3Q7IEFUK0NQTVM9P1xyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4r
Q1BNUzogKCJTTSIpLCgiU00iKSwoIlNNIilcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1
eDogJmd0OyBBVCtDUlNNPTE5MiwyODQyMVxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4r
Q01FIEVSUk9SOiA0XHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDTUdGPTBccjxicj4K
ICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFU
K0NSU009MTkyLDEyMDM3XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDTUUgRVJST1I6
IDRcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NQTVM9IlNNIiwiU00iLCJTTSJccjxi
cj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NQTVM6IDAsMjUsMCwyNSwwLDI1XHJcblxyXG5P
S1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ1BJTj9ccjxicj4KICAgICZuYnNwO0F1
eDogJmx0OyBcclxuK0NQSU46IFJFQURZXHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtkcml2
ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3Bpbl9jYigpIGNyc21fcGluX2NiOiBSRUFEWTxicj4KICAg
ICZuYnNwO2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9waW5fcmV0cmllc19xdWVyeSgpPGJyPgog
ICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NOTUk9P1xyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxy
XG4rQ05NSTogKDAtMyksKDAtMyksKDAsMiksKDAtMiksKDAsMSlcclxuXHJcbk9LXHJcbjxicj4K
ICAgICZuYnNwO2RyaXZlcnMvYXRtb2RlbS9zbXMuYzpidWlsZF9jbm1pX3N0cmluZygpPGJyPgog
ICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmNvbnN0cnVjdF9hY2tfcGR1KCk8YnI+CiAg
ICAmbmJzcDtBdXg6ICZndDsgQVQjUENUXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbiNQ
Q1Q6IDNcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO2RyaXZlcnMvYXRtb2RlbS9zaW0uYzph
dF9wY3RfY2IoKSBOb3RlOiBObyBwYXNzd29yZCByZXF1aXJlZCwKICAgIHJldHVybmluZyBtYXhp
bXVtIHJldHJpZXM6PGJyPgogICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X3BjdF9j
YigpIHJldHJ5IGNvdW50ZXIgaWQ9MSwgdmFsPTM8YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9k
ZW0vc2ltLmM6YXRfcGN0X2NiKCkgcmV0cnkgY291bnRlciBpZD00LCB2YWw9Mzxicj4KICAgICZu
YnNwO2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9wY3RfY2IoKSByZXRyeSBjb3VudGVyIGlkPTks
IHZhbD0xMDxicj4KICAgICZuYnNwO2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9wY3RfY2IoKSBy
ZXRyeSBjb3VudGVyIGlkPTExLCB2YWw9MTA8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ1JT
TT0xOTIsMjg1OTBccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NNRSBFUlJPUjogNFxy
XG48YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ05NST0yLDIsMiwxLDBccjxicj4KICAgICZu
YnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7c3JjL3Ntcy5jOnNtc19yZXN0
b3JlX3R4X3F1ZXVlKCk8YnI+CiAgICAmbmJzcDtwbHVnaW5zL3B1c2gtbm90aWZpY2F0aW9uLmM6
c21zX3dhdGNoKCkgcmVnaXN0ZXJlZDxicj4KICAgICZuYnNwO3BsdWdpbnMvc21hcnQtbWVzc2Fn
aW5nLmM6c21zX3dhdGNoKCkgcmVnaXN0ZXJlZDxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtD
UlNNPTE5MiwyODU4OVxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ1JTTToKICAgIDE0
NCwwLDAwMDAwMDAzNkZBRDA0MDAwRUZGRUUwMTAyMDAwMFxyXG5cclxuT0tcclxuPGJyPgogICAg
Jm5ic3A7ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19j
YjogOTAsIDAwLCAxNTxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDTUdMPTRccjxicj4KICAg
ICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVt
L3Ntcy5jOmF0X2NtZ2xfZG9uZSgpPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NHU01TPTNc
cjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAm
Z3Q7IEFUK0NSU009MTc2LDI4NTg5LDAsMCwzXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJc
bjxicj4KICAgICZuYnNwO0F1eDogJmx0OyArQ1JTTTogMTQ0LDAsMDBGRkZGXHJcblxyXG5PS1xy
XG48YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9yZWFkX2NiKCkg
Y3JzbV9yZWFkX2NiOiA5MCwgMDAsIDM8YnI+CiAgICAmbmJzcDtzcmMvc2ltZnMuYzpzaW1fZnNf
b3BfcmVhZF9ibG9ja19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwKICAgIHRvY29weTogMzxi
cj4KICAgICZuYnNwO0VGYWQgZG9lcyBub3Qgc3BlY2lmeSAob3B0aW9uYWwpIE1OQyBsZW5ndGgs
IGRlZmF1bHRpbmcgdG8gMjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQz
OFxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ4LDRcclxuXHJcbk9LXHJc
bjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQ3MlxyPGJyPgogICAgJm5i
c3A7QXV4OiAmbHQ7IFxyXG4rQ1JTTToKICAgIDE0NCwwLDAwMDAwMDBFNkYzODA0MDAxRUZGRUUw
MTAyMDAwMFxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVtL3NpbS5j
OmF0X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAxNTxicj4KICAgICZuYnNw
O0F1eDogJmd0OyBBVCtDUlNNPTE3NiwyODQ3MiwwLDAsMTRccjxicj4KICAgICZuYnNwO0F1eDog
Jmx0OyBcclxuK0NSU006CiAgICAxNDQsMCxGRjNGRkYwRjAzMDBGQzAzMDAwQ0MzMDBGMEMwXHJc
blxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9y
ZWFkX2NiKCkgY3JzbV9yZWFkX2NiOiA5MCwgMDAsIDE0PGJyPgogICAgJm5ic3A7c3JjL3NpbWZz
LmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZvZmY6IDAsIGRhdGFvZmY6IDAsCiAgICB0
b2NvcHk6IDE0PGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NSU009MTkyLDI4NTAyXHI8YnI+
CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDTUUgRVJST1I6IDRcclxuPGJyPgogICAgJm5ic3A7
QXV4OiAmZ3Q7IEFUK0NJTUlccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuMjQwMDc1OTkw
MDAxMTU5XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vc2ltLmM6
YXRfY2ltaV9jYigpIGNpbWlfY2I6IDI0MDA3NTk5MDAwMTE1OTxicj4KICAgICZuYnNwO3NyYy9t
b2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMSwgbmV3IHN0YXRlOiAyPGJy
PgogICAgJm5ic3A7cGx1Z2lucy90ZWxpdC5jOnRlbGl0X3Bvc3Rfc2ltKCkgMHg5YjZhZjg8YnI+
CiAgICAmbmJzcDtkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRfZ3Byc19jb250ZXh0
X3Byb2JlKCk8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ0dEQ09OVD0/XHI8YnI+CiAgICAm
bmJzcDtwbHVnaW5zL3RlbGl0LmM6dGVsaXRfc2V0X29ubGluZSgpIG1vZGVtIDB4OWI2YWY4IG9u
bGluZTxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NHRENPTlQ6ICgxLTUpLCJJUCIsLCwo
MCwxKSwoMCwxKVxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NGVU49
MSwwXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO3Ny
Yy9tb2RlbS5jOm1vZGVtX2NoYW5nZV9zdGF0ZSgpIG9sZCBzdGF0ZTogMiwgbmV3IHN0YXRlOiAz
PGJyPgogICAgJm5ic3A7cGx1Z2lucy90ZWxpdC5jOnRlbGl0X3Bvc3Rfb25saW5lKCkgMHg5YjZh
Zjg8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQjUVNTP1xyPGJyPgogICAgJm5ic3A7QXV4OiAm
bHQ7IFxyXG4jUVNTOiAyLDFcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO3BsdWNpbnMvdGVs
aXQuYzp0ZWxpdF9xc3Nfbm90aWZ5KCkgMHg5YjZhZjg8YnI+CiAgICAmbmJzcDtwbHVnaW5zL3Rl
bGl0LmM6c3dpdGNoX3NpbV9zdGF0ZV9zdGF0dXMoKSAweDliNmFmOCwgU0lNIHN0YXR1czogMTxi
cj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQ4MFxyPGJyPgogICAgJm5ic3A7
QXV4OiAmbHQ7IFxyXG4rQ1JTTToKICAgIDE0NCwwLDAwMDAwMDM4NkY0MDA0MDAxMUZGRUUwMTAy
MDExQ1xyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAxNTxicj4KICAgICZuYnNwO0F1
eDogJmd0OyBBVCtDR1JFRz0/XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDR1JFRzog
KDAtMilcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDUkVHPT9ccjxi
cj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7ICtDUkVH
OiAoMC0yKVxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NTQ1M/XHI8
YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDU0NTOiAiSVJBIlxyXG5cclxuT0tcclxuPGJy
PgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NVU0Q9MVxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7
IFxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ0FPQz0yXHI8YnI+CiAgICAm
bmJzcDtBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDQ1dF
PTFccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4
OiAmZ3Q7IEFUK0NQSU4/XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDUElOOiBSRUFE
WVxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NSU009MTc4LDI4NDgw
LDEsNCwyOFxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ1JTTToKMTQ0LDAsRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZcclxuXHJc
bk9LXHJcbjxicj4KICAgICZuYnNwO2RyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRf
Y2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMjg8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQr
Q0dSRUc9MlxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+CiAgICAmbmJz
cDtBdXg6ICZndDsgQVQrQ0dBVVRPPTBccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuRVJS
T1JcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NHRVJFUD0yLDFccjxicj4KICAgICZu
YnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NSRUc9
MlxyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6
ICZndDsgQVQrQ1BNUz9ccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NQTVM6ICJTTSIs
MCwyNSwiU00iLDAsMjUsIlNNIiwwLDI1XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6
ICZndDsgQVQrQ1JTTT0xNzgsMjg0ODAsMiw0LDI4XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsg
XHJcbitDUlNNOgoxNDQsMCxGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZG
RkZGRkZGRkZGRkZGRkZGRlxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7ZHJpdmVycy9hdG1v
ZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAyODxicj4K
ICAgICZuYnNwO0F1eDogJmd0OyBBVCNQU05UPTFccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBc
clxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NQU0I9MVxyPGJyPgogICAgJm5i
c3A7QXV4OiAmbHQ7IFxyXG5FUlJPUlxyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ0lO
RD0/XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDSU5EOgooKCJiYXR0Y2hnIiwoMC01
LDk5KSksKCJzaWduYWwiLCgwLTcsOTkpKSwoInNlcnZpY2UiLCgwLDEpKSwoInNvdW5kZXIiLCgw
LDEpKSwoIm1lc3NuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NSU009MTkyLDI4NDg5XHI8
YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDUlNNOiAxNDgsNFxyXG5cclxuT0tcclxuPGJy
PgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NNRVI9P1xyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7
IFxyXG4rQ01FUjogKDAtMyksKDApLCgwKSwoMCwyKSwoMCwxKVxyXG5cclxuT0tcclxuPGJyPgog
ICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6YnVpbGRfY21l
cl9zdHJpbmcoKTxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDUlNNPTE5MiwyMDI1NlxyPGJy
PgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ01FIEVSUk9SOiA0XHJcbjxicj4KICAgICZuYnNw
O0F1eDogJmd0OyBBVCtDTUVSPTMsMCwwLDJccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxu
T0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ0lFVjogYmF0dGNoZywwXHJcblxy
XG4rQ0lFVjogc2lnbmFsLDdcclxuXHJcbitDSUVWOgogICAgc2VydmljZSwxXHJcblxyXG4rQ0lF
Vjogc291bmRlciwwXHJcbm48YnI+CiAgICAmbmJzcDtzcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9z
cG5fd2F0Y2goKSAweDlhZmM5ODxicj4KICAgICZuYnNwO3NyYy9uZXR3b3JrLmM6X19vZm9ub19u
ZXRyZWdfYWRkX3N0YXR1c193YXRjaCgpIDB4OWI5ZmYwPGJyPgogICAgJm5ic3A7c3JjL25ldHdv
cmsuYzpfX29mb25vX25ldHJlZ19hZGRfc3RhdHVzX3dhdGNoKCkgMHg5YjlmZjA8YnI+CiAgICAm
bmJzcDtBdXg6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MThccjxicj4KICAgICZuYnNwO0F1eDogJmx0
OyBcclxuK0NSU006IDE0OCw0XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtVbmFibGUgdG8g
cmVhZCB3YWl0aW5nIG1lc3NhZ2VzIG51bWJlcnMgZnJvbSBTSU08YnI+CiAgICAmbmJzcDtBdXg6
ICZndDsgQVQrQ1JFRz9ccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NSRUc6IDIsMSwi
MDBENCIsIjBENDVEOTYiLDJcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO3NyYy9uZXR3b3Jr
LmM6b2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkoKSAvdGVsaXRfMCBzdGF0dXMgMSB0ZWNoIDI8
YnI+CiAgICAmbmJzcDtzcmMvZ3Bycy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8YnI+CiAg
ICAmbmJzcDtBdXg6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MTdccjxicj4KICAgICZuYnNwO0F1eDog
Jmx0OyBcclxuK0NSU006IDE0OCw0XHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtVbmFibGUg
dG8gcmVhZCBtYWlsYm94IGlkZW50aWZpZXMgZnJvbSBTSU08YnI+CiAgICAmbmJzcDtBdXg6ICZn
dDsgQVQrQ09QUz0zLDJccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuT0tcclxuPGJyPgog
ICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NPUFM/XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJc
bitDT1BTOiAwLDIsIjI0MDA1IiwyXHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtkcml2ZXJz
L2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX251bWVyaWNfY2IoKSBDb3BzCiAg
ICBudW1lcmljIGdvdCBtY2M6IDI0MCwgbW5jOiAwNTxicj4KICAgICZuYnNwO0F1eDogJmd0OyBB
VCtDSU5EP1xyPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ0lORDogMCw3LDEsMCwwLDAs
MCwwLDVcclxuXHJcbk9LXHJcbjxicj4KICAgICZuYnNwO3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0
cmVnX3N0cmVuZ3RoX25vdGlmeSgpIHN0cmVuZ3RoIDEwMDxicj4KICAgICZuYnNwO0F1eDogJmd0
OyBBVCtDR0FUVD0xXHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj4KICAg
ICZuYnNwO0F1eDogJmx0OyBcclxuK0NHUkVHOiAxLCIwMEQ0IiwiMEQ0NUQ5NiIsMiwiMDEiXHJc
bjxicj4KICAgICZuYnNwO3NyYy9ncHJzLmM6Z3Byc19hdHRhY2hfY2FsbGJhY2soKSAvdGVsaXRf
MCBlcnJvciA9IDA8YnI+CiAgICAmbmJzcDtzcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25v
dGlmeSgpIC90ZWxpdF8wIHN0YXR1cyAxPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NJTkQ/
XHI8YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDSU5EOiAwLDcsMSwwLDAsMCwwLDAsNVxy
XG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmZ3Q7IEFUK0NSU009MTkyLDI4NDMzXHI8
YnI+CiAgICAmbmJzcDtBdXg6ICZsdDsgXHJcbitDUlNNOiAxNDgsNFxyXG5cclxuT0tcclxuPGJy
PgogICAgJm5ic3A7c3JjL21lc3NhZ2Utd2FpdGluZy5jOm13X2NwaHNfbXdpc19yZWFkX2NiKCkg
Tm8gQ1BIUyBNV0lTIG9uIFNJTTxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDT1BTPTMsMFxy
PGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZn
dDsgQVQrQ09QUz9ccjxicj4KICAgICZuYnNwO0F1eDogJmx0OyBcclxuK0NPUFM6IDAsMCwiUyAw
NSIsMlxyXG5cclxuT0tcclxuPGJyPgogICAgJm5ic3A7ZHJpdmVycy9hdG1vZGVtL25ldHdvcmst
cmVnaXN0cmF0aW9uLmM6Y29wc19jYigpIGNvcHNfY2I6IFMgMDUsIDI0MAogICAgMDUgMjxicj4K
ICAgICZuYnNwO3NyYy9uZXR3b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4OWI5
ZmYwLCAobmlsKTxicj4KICAgICZuYnNwO3NyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2Vk
KCkgMTxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDR1JFRz9ccjxicj4KICAgICZuYnNwO0F1
eDogJmx0OyBcclxuPGJyPgogICAgJm5ic3A7QXV4OiAmbHQ7ICtDR1JFRzogMiwxLCIwMEQ0Iiwi
MEQ0NUQ5NiIsMiwiMDEiXHJcblxyXG5PS1xyXG48YnI+CiAgICAmbmJzcDtzcmMvZ3Bycy5jOnJl
Z2lzdHJhdGlvbl9zdGF0dXNfY2IoKSAvdGVsaXRfMCBlcnJvciAwIHN0YXR1cyAxPGJyPgogICAg
Jm5ic3A7c3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvdGVsaXRfMCBzdGF0
dXMgMTxicj4KICAgICZuYnNwO0F1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQzNVxyPGJyPgogICAg
Jm5ic3A7QXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ4LDRcclxuXHJcbk9LXHJcbjxicj4KICAgICZu
YnNwO3NyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrKCkgYnVmb2ZmOiAwLCBzZWVrb2Zm
OiAzOSwgdG9yZWFkOgogICAgMTc8YnI+CiAgICAmbmJzcDtBdXg6ICZndDsgQVQrQ1JTTT0xOTIs
Mjg2MjFccjxicj4KICAgICZuYnNwO2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9n
cHJzX2FjdGl2YXRlX3ByaW1hcnkoKSBjaWQgMTxicj4KICAgICZuYnNwO01vZGVtOiAmZ3Q7IEFU
K0NHRENPTlQ9MSwiSVAiLCJpbnRlcm5ldC50ZWxlMi5zZSJccjxicj4KICAgICZuYnNwO01vZGVt
OiAmbHQ7IEFUK0NHRENPTlQ9MSwiSVAiLCJpbnRlcm5ldC50ZWxlMi5zZSJccjxicj4KICAgICZu
YnNwO0F1eDogJmx0OyBcclxuK0NNRSBFUlJPUjogNFxyXG48YnI+CiAgICAmbmJzcDtBdXg6ICZn
dDsgQVQrQ1JTTT0xOTIsMjg0Mzdccjxicj4KICAgIDxicj4KICAgIDxicj4KICAgIDxicj4KICAg
IDxicj4KICAgIDxicj4KICAgIDxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============2289330022570871792==--

