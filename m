Content-Type: multipart/mixed; boundary="===============3513804773270977685=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Re: [PATCH 2/3] Drop checking whether +CMER is supported.
Date: Fri, 29 Mar 2013 16:40:37 +0100
Message-ID: <CAMtf1D8oMiptPOsacw6zRWUn6xGuYFxw5H1Y1a+DSA3mSd8D1g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3513804773270977685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

I am trying to setup the Telit HE910 with oFono-1.3, I adapted

a few files using the 1.12 version :

  drivers/atmodem/sim.c

  plugins/telit.c

  plugins/udevng.c

I still have this CMER problem though, and I was wondering what patch

you are refering to in the previous message, so that I can apply it to

my version of oFono.

Thank you in advance,

Etienne


Here is the end of the log from oFono just in case :

ofonod[1680]: plugins/telit.c:telit_post_online() 0x88e8290
ofonod[1680]: Aux: > AT+CGREG=3D?\r
ofonod[1680]: Aux: < \r\n
ofonod[1680]: Aux: < +CGREG: (0-2)\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CRSM=3D192,28489\r
ofonod[1680]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CREG=3D?\r
ofonod[1680]: Aux: < \r\n
ofonod[1680]: Aux: < +CREG: (0-2)\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CSCS?\r
ofonod[1680]: Aux: < \r\n+CSCS: "IRA"\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CUSD=3D1\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Aux: > AT+CAOC=3D2\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Aux: > AT+CCWE=3D1\r
ofonod[1680]: Aux: < \r\n+CME ERROR: 3\r\n
ofonod[1680]: Aux: > AT+CGREG=3D2\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Aux: > AT+CGAUTO=3D0\r
ofonod[1680]: Aux: < \r\nERROR\r\n
ofonod[1680]: Aux: > AT+CGEREP=3D2,1\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Aux: > AT+CRSM=3D192,20256\r
ofonod[1680]: Aux: < \r\n+CME ERROR: 4\r\n
ofonod[1680]: Aux: > AT+CREG=3D2\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Aux: > AT+CPSB=3D1\r
ofonod[1680]: Aux: < \r\nERROR\r\n
ofonod[1680]: Aux: > AT+CRSM=3D192,28618\r
ofonod[1680]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1680]: Unable to read waiting messages numbers from SIM
ofonod[1680]: Aux: > AT+CIND=3D?\r
ofonod[1680]: Aux: < \r\n+CIND:
(("battchg",(0-5,99)),("signal",(0-7,99)),("service",(0,1)),("sounder",(0,1=
)),("message",(0,1)),("call",(0,1)),("roam",(0,1)),("smsfull",(0,1)),("rssi=
",(0-5,99)))\r\n\r\nOK\r\n
ofonod[1680]: src/sim.c:ofono_sim_add_spn_watch() 0x88e7308
ofonod[1680]: src/network.c:__ofono_netreg_add_status_watch() 0x88eb670
ofonod[1680]: Aux: > AT+CRSM=3D192,28617\r
ofonod[1680]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1680]: Unable to read mailbox identifies from SIM
ofonod[1680]: Aux: > AT+CMER=3D3,0,0,1\r
ofonod[1680]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[1680]: Aux: > AT+CREG?\r
ofonod[1680]: Aux: < \r\n+CREG: 2,2\r\n\r\nOK\r\n
ofonod[1680]: src/network.c:current_operator_callback() 0x88eb670, (nil)
ofonod[1680]: src/gprs.c:netreg_status_changed() 2
ofonod[1680]: Aux: > AT+CRSM=3D192,28433\r
ofonod[1680]: Aux: < \r\n+CRSM:
144,0,000000016F11040011005501010000\r\n\r\nOK\r\n
ofonod[1680]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,=
 15
ofonod[1680]: Aux: > AT+CRSM=3D176,28433,0,0,1\r
ofonod[1680]: Aux: < \r\n+CRSM: 144,0,5A\r\n\r\nOK\r\n
ofonod[1680]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,=
 1
ofonod[1680]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[1680]: Aux: > AT+CRSM=3D192,28435\r
ofonod[1680]: Aux: < \r\n+CRSM:
144,0,000000016F13040011005501010000\r\n\r\nOK\r\n
ofonod[1680]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,=
 15
ofonod[1680]: Aux: > AT+CRSM=3D176,28435,0,0,1\r
ofonod[1680]: Aux: < \r\n+CRSM: 144,0,55\r\n\r\nOK\r\n
ofonod[1680]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,=
 1
ofonod[1680]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0,
dataoff: 0, tocopy: 1
ofonod[1680]: Aux: > AT+CRSM=3D192,28613\r
ofonod[1680]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1680]: src/simfs.c:sim_fs_op_read_block() bufoff: 0, seekoff:
39, toread: 17
ofonod[1680]: EFspn read successfully, but couldn't parse
ofonod[1680]: Aux: > AT+CRSM=3D192,28621\r
ofonod[1680]: Aux: < \r\n+CME ERROR: 4\r\n
ofonod[1680]: 3GPP MBDN not provided, parsing CPHS..
ofonod[1680]: Aux: > AT+CRSM=3D192,28437\r
ofonod[1680]: Aux: < \r\n+CRSM: 148,4\r\n\r\nOK\r\n
ofonod[1680]: Modem: < \r\n#MWI: 1,1\r\n
ofonod[1680]: Aux: < \r\n#MWI: 1,1\r\n
ofonod[1680]: Aux: < \r\n#QSS: 3\r\n
ofonod[1680]: plugins/telit.c:telit_qss_notify() 0x88e8290
ofonod[1680]: plugins/telit.c:switch_sim_state_status() 0x88e8290, SIM stat=
us: 3
ofonod[1680]: Aux: > AT+CSCS=3D?\r
ofonod[1680]: Aux: < \r\n
ofonod[1680]: Aux: < +CSCS:
("GSM","IRA","8859-1","PCCP437","UCS2")\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CSMS=3D?\r
ofonod[1680]: Aux: < \r\n+CSMS: (0,1)\r\n\r\nOK\r\n
ofonod[1680]: drivers/atmodem/sms.c:at_csms_query_cb() CSMS query
parsed successfully
ofonod[1680]: Aux: > AT+CPBS=3D?\r
ofonod[1680]: Aux: < \r\n+CPBS:
("SM","FD","LD","MC","RC","MB","DC","ME")\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CSMS=3D1\r
ofonod[1680]: Aux: < \r\n+CSMS: 1,1,1\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CSMS?\r
ofonod[1680]: Aux: < \r\n+CSMS: 1,1,1,1\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CMGF=3D?\r
ofonod[1680]: Aux: < \r\n
ofonod[1680]: Aux: < +CMGF: (0,1)\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CPMS=3D?\r
ofonod[1680]: Aux: < \r\n+CPMS: ("SM"),("SM"),("SM")\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CMGF=3D0\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Aux: > AT+CPMS=3D"SM","SM","SM"\r
ofonod[1680]: Aux: < \r\n
ofonod[1680]: Aux: < +CPMS: 0,100,0,100,0,100\r\n\r\nOK\r\n
ofonod[1680]: Aux: > AT+CNMI=3D?\r
ofonod[1680]: Aux: < \r\n
ofonod[1680]: Aux: < +CNMI: (0-3),(0-3),(0,2),(0-2),(0,1)\r\n\r\nOK\r\n
ofonod[1680]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[1680]: drivers/atmodem/sms.c:construct_ack_pdu()
ofonod[1680]: Aux: > AT+CNMI=3D2,2,2,1,0\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: src/network.c:__ofono_netreg_add_status_watch() 0x88eb670
ofonod[1680]: src/sms.c:sms_restore_tx_queue()
ofonod[1680]: plugins/push-notification.c:sms_watch() registered
ofonod[1680]: plugins/smart-messaging.c:sms_watch() registered
ofonod[1680]: Aux: > AT+CMGL=3D4\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: drivers/atmodem/sms.c:at_cmgl_done()
ofonod[1680]: Aux: > AT+CGSMS=3D3\r
ofonod[1680]: Aux: < \r\nOK\r\n
ofonod[1680]: Modem: < AT+CREG?\r\r\n+CREG: 0,2\r\n\r\nOK\r\n




On 17/12/12 17:22, Mingli Wu wrote:
>* For Telit HE910,  ofono always got "\r\n+CME ERROR: 14\r\n"*>* after iss=
uing "AT+CMER=3D3,0,0,2\r" command. "CME ERROR: 14"*>* means that SIM is bu=
sy. Now we igonre the result of the*>* command "AT+CMER=3D3,0,0,2\r", and r=
egister network anyway.*>* ---*
I submitted some patches which will solve this problem.
You should not get CME ERROR: 14 anymore and hence
the netreg atom will not be removed.
There is not need to make changes in the network registration atom.
Telit supports +CMER but without waiting for the modem to be ready
the command will fail.

Regards,
Christopher

--===============3513804773270977685==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PHByZT5IaSBDaHJpc3RvcGhlciw8YnI+PGJyPjwvcHJlPjxwcmU+SSBh
bSB0cnlpbmcgdG8gc2V0dXAgdGhlIFRlbGl0IEhFOTEwIHdpdGggb0Zvbm8tMS4zLCBJIGFkYXB0
ZWQgPGJyPjxicj5hIGZldyBmaWxlcyB1c2luZyB0aGUgMS4xMiB2ZXJzaW9uIDo8YnI+PGJyPiAg
ZHJpdmVycy9hdG1vZGVtL3NpbS5jPGJyPjwvcHJlPjxwcmU+ICBwbHVnaW5zL3RlbGl0LmM8YnI+
CjwvcHJlPjxwcmU+ICBwbHVnaW5zL3VkZXZuZy5jPGJyPjwvcHJlPjxwcmU+SSBzdGlsbCBoYXZl
IHRoaXMgQ01FUiBwcm9ibGVtIHRob3VnaCwgYW5kIEkgd2FzIHdvbmRlcmluZyB3aGF0IHBhdGNo
IDxicj48L3ByZT48cHJlPnlvdSBhcmUgcmVmZXJpbmcgdG8gaW4gdGhlIHByZXZpb3VzIG1lc3Nh
Z2UsIHNvIHRoYXQgSSBjYW4gYXBwbHkgaXQgdG88YnI+PC9wcmU+PHByZT5teSB2ZXJzaW9uIG9m
IG9Gb25vLjxicj4KPC9wcmU+PHByZT5UaGFuayB5b3UgaW4gYWR2YW5jZSw8YnI+PGJyPjwvcHJl
PjxwcmU+RXRpZW5uZTxicj48YnI+PGJyPjwvcHJlPjxwcmU+SGVyZSBpcyB0aGUgZW5kIG9mIHRo
ZSBsb2cgZnJvbSBvRm9ubyBqdXN0IGluIGNhc2UgOjxicj48YnI+b2Zvbm9kWzE2ODBdOiBwbHVn
aW5zL3RlbGl0LmM6dGVsaXRfcG9zdF9vbmxpbmUoKSAweDg4ZTgyOTA8YnI+b2Zvbm9kWzE2ODBd
OiBBdXg6ICZndDsgQVQrQ0dSRUc9P1xyPGJyPgpvZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxu
PGJyPm9mb25vZFsxNjgwXTogQXV4OiAmbHQ7ICtDR1JFRzogKDAtMilcclxuXHJcbk9LXHJcbjxi
cj5vZm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQ4OVxyPGJyPm9mb25vZFsx
NjgwXTogQXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ4LDRcclxuXHJcbk9LXHJcbjxicj5vZm9ub2Rb
MTY4MF06IEF1eDogJmd0OyBBVCtDUkVHPT9ccjxicj4Kb2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsg
XHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyArQ1JFRzogKDAtMilcclxuXHJcbk9LXHJc
bjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtDU0NTP1xyPGJyPm9mb25vZFsxNjgwXTog
QXV4OiAmbHQ7IFxyXG4rQ1NDUzogJnF1b3Q7SVJBJnF1b3Q7XHJcblxyXG5PS1xyXG48YnI+b2Zv
bm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ1VTRD0xXHI8YnI+Cm9mb25vZFsxNjgwXTogQXV4OiAm
bHQ7IFxyXG5PS1xyXG48YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ0FPQz0yXHI8YnI+
b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDog
Jmd0OyBBVCtDQ1dFPTFccjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuK0NNRSBFUlJP
UjogM1xyXG48YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ0dSRUc9MlxyPGJyPgpvZm9u
b2RbMTY4MF06IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFsxNjgwXTogQXV4OiAmZ3Q7
IEFUK0NHQVVUTz0wXHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbkVSUk9SXHJcbjxi
cj5vZm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtDR0VSRVA9MiwxXHI8YnI+b2Zvbm9kWzE2ODBd
OiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtDUlNN
PTE5MiwyMDI1NlxyPGJyPgpvZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuK0NNRSBFUlJPUjog
NFxyXG48YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ1JFRz0yXHI8YnI+b2Zvbm9kWzE2
ODBdOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtD
UFNCPTFccjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuRVJST1JcclxuPGJyPm9mb25v
ZFsxNjgwXTogQXV4OiAmZ3Q7IEFUK0NSU009MTkyLDI4NjE4XHI8YnI+Cm9mb25vZFsxNjgwXTog
QXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ4LDRcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06
IFVuYWJsZSB0byByZWFkIHdhaXRpbmcgbWVzc2FnZXMgbnVtYmVycyBmcm9tIFNJTTxicj5vZm9u
b2RbMTY4MF06IEF1eDogJmd0OyBBVCtDSU5EPT9ccjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0
OyBcclxuK0NJTkQ6ICgoJnF1b3Q7YmF0dGNoZyZxdW90OywoMC01LDk5KSksKCZxdW90O3NpZ25h
bCZxdW90OywoMC03LDk5KSksKCZxdW90O3NlcnZpY2UmcXVvdDssKDAsMSkpLCgmcXVvdDtzb3Vu
ZGVyJnF1b3Q7LCgwLDEpKSwoJnF1b3Q7bWVzc2FnZSZxdW90OywoMCwxKSksKCZxdW90O2NhbGwm
cXVvdDssKDAsMSkpLCgmcXVvdDtyb2FtJnF1b3Q7LCgwLDEpKSwoJnF1b3Q7c21zZnVsbCZxdW90
OywoMCwxKSksKCZxdW90O3Jzc2kmcXVvdDssKDAtNSw5OSkpKVxyXG5cclxuT0tcclxuPGJyPgpv
Zm9ub2RbMTY4MF06IHNyYy9zaW0uYzpvZm9ub19zaW1fYWRkX3Nwbl93YXRjaCgpIDB4ODhlNzMw
ODxicj5vZm9ub2RbMTY4MF06IHNyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0YXR1
c193YXRjaCgpIDB4ODhlYjY3MDxicj5vZm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtDUlNNPTE5
MiwyODYxN1xyPGJyPm9mb25vZFsxNjgwXTogQXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ4LDRcclxu
XHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE2ODBdOiBVbmFibGUgdG8gcmVhZCBtYWlsYm94IGlkZW50
aWZpZXMgZnJvbSBTSU08YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ01FUj0zLDAsMCwx
XHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbitDTUUgRVJST1I6IDE0XHJcbjxicj5v
Zm9ub2RbMTY4MF06IEF1eDogJmd0OyBBVCtDUkVHP1xyPGJyPm9mb25vZFsxNjgwXTogQXV4OiAm
bHQ7IFxyXG4rQ1JFRzogMiwyXHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNjgwXTogc3JjL25l
dHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHg4OGViNjcwLCAobmlsKTxicj5v
Zm9ub2RbMTY4MF06IHNyYy9ncHJzLmM6bmV0cmVnX3N0YXR1c19jaGFuZ2VkKCkgMjxicj5vZm9u
b2RbMTY4MF06IEF1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQzM1xyPGJyPm9mb25vZFsxNjgwXTog
QXV4OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsMDAwMDAwMDE2RjExMDQwMDExMDA1NTAxMDEwMDAw
XHJcblxyXG5PS1xyXG48YnI+Cm9mb25vZFsxNjgwXTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAxNTxicj5vZm9ub2RbMTY4MF06
IEF1eDogJmd0OyBBVCtDUlNNPTE3NiwyODQzMywwLDAsMVxyPGJyPm9mb25vZFsxNjgwXTogQXV4
OiAmbHQ7IFxyXG4rQ1JTTTogMTQ0LDAsNUFcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06
IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkw
LCAwMCwgMTxicj4Kb2Zvbm9kWzE2ODBdOiBzcmMvc2ltZnMuYzpzaW1fZnNfb3BfcmVhZF9ibG9j
a19jYigpIGJ1Zm9mZjogMCwgZGF0YW9mZjogMCwgdG9jb3B5OiAxPGJyPm9mb25vZFsxNjgwXTog
QXV4OiAmZ3Q7IEFUK0NSU009MTkyLDI4NDM1XHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsg
XHJcbitDUlNNOiAxNDQsMCwwMDAwMDAwMTZGMTMwNDAwMTEwMDU1MDEwMTAwMDBcclxuXHJcbk9L
XHJcbjxicj4Kb2Zvbm9kWzE2ODBdOiBkcml2ZXJzL2F0bW9kZW0vc2ltLmM6YXRfY3JzbV9pbmZv
X2NiKCkgY3JzbV9pbmZvX2NiOiA5MCwgMDAsIDE1PGJyPm9mb25vZFsxNjgwXTogQXV4OiAmZ3Q7
IEFUK0NSU009MTc2LDI4NDM1LDAsMCwxXHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJc
bitDUlNNOiAxNDQsMCw1NVxyXG5cclxuT0tcclxuPGJyPm9mb25vZFsxNjgwXTogZHJpdmVycy9h
dG1vZGVtL3NpbS5jOmF0X2Nyc21fcmVhZF9jYigpIGNyc21fcmVhZF9jYjogOTAsIDAwLCAxPGJy
PgpvZm9ub2RbMTY4MF06IHNyYy9zaW1mcy5jOnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVm
b2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDE8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsg
QVQrQ1JTTT0xOTIsMjg2MTNccjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuK0NSU006
IDE0OCw0XHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzE2ODBdOiBzcmMvc2ltZnMuYzpzaW1fZnNf
b3BfcmVhZF9ibG9jaygpIGJ1Zm9mZjogMCwgc2Vla29mZjogMzksIHRvcmVhZDogMTc8YnI+Cm9m
b25vZFsxNjgwXTogRUZzcG4gcmVhZCBzdWNjZXNzZnVsbHksIGJ1dCBjb3VsZG4mIzM5O3QgcGFy
c2U8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ1JTTT0xOTIsMjg2MjFccjxicj5vZm9u
b2RbMTY4MF06IEF1eDogJmx0OyBcclxuK0NNRSBFUlJPUjogNFxyXG48YnI+b2Zvbm9kWzE2ODBd
OiAzR1BQIE1CRE4gbm90IHByb3ZpZGVkLCBwYXJzaW5nIENQSFMuLjxicj5vZm9ub2RbMTY4MF06
IEF1eDogJmd0OyBBVCtDUlNNPTE5MiwyODQzN1xyPGJyPgpvZm9ub2RbMTY4MF06IEF1eDogJmx0
OyBcclxuK0NSU006IDE0OCw0XHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzE2ODBdOiBNb2RlbTog
Jmx0OyBcclxuI01XSTogMSwxXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuI01X
STogMSwxXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuI1FTUzogM1xyXG48YnI+
b2Zvbm9kWzE2ODBdOiBwbHVnaW5zL3RlbGl0LmM6dGVsaXRfcXNzX25vdGlmeSgpIDB4ODhlODI5
MDxicj4Kb2Zvbm9kWzE2ODBdOiBwbHVnaW5zL3RlbGl0LmM6c3dpdGNoX3NpbV9zdGF0ZV9zdGF0
dXMoKSAweDg4ZTgyOTAsIFNJTSBzdGF0dXM6IDM8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsg
QVQrQ1NDUz0/XHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbjxicj5vZm9ub2RbMTY4
MF06IEF1eDogJmx0OyArQ1NDUzogKCZxdW90O0dTTSZxdW90OywmcXVvdDtJUkEmcXVvdDssJnF1
b3Q7ODg1OS0xJnF1b3Q7LCZxdW90O1BDQ1A0MzcmcXVvdDssJnF1b3Q7VUNTMiZxdW90Oylcclxu
XHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ1NNUz0/XHI8YnI+b2Zv
bm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbitDU01TOiAoMCwxKVxyXG5cclxuT0tcclxuPGJyPm9m
b25vZFsxNjgwXTogZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmF0X2NzbXNfcXVlcnlfY2IoKSBDU01T
IHF1ZXJ5IHBhcnNlZCBzdWNjZXNzZnVsbHk8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQr
Q1BCUz0/XHI8YnI+Cm9mb25vZFsxNjgwXTogQXV4OiAmbHQ7IFxyXG4rQ1BCUzogKCZxdW90O1NN
JnF1b3Q7LCZxdW90O0ZEJnF1b3Q7LCZxdW90O0xEJnF1b3Q7LCZxdW90O01DJnF1b3Q7LCZxdW90
O1JDJnF1b3Q7LCZxdW90O01CJnF1b3Q7LCZxdW90O0RDJnF1b3Q7LCZxdW90O01FJnF1b3Q7KVxy
XG5cclxuT0tcclxuPGJyPm9mb25vZFsxNjgwXTogQXV4OiAmZ3Q7IEFUK0NTTVM9MVxyPGJyPm9m
b25vZFsxNjgwXTogQXV4OiAmbHQ7IFxyXG4rQ1NNUzogMSwxLDFcclxuXHJcbk9LXHJcbjxicj4K
b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ1NNUz9ccjxicj5vZm9ub2RbMTY4MF06IEF1eDog
Jmx0OyBcclxuK0NTTVM6IDEsMSwxLDFcclxuXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1
eDogJmd0OyBBVCtDTUdGPT9ccjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuPGJyPm9m
b25vZFsxNjgwXTogQXV4OiAmbHQ7ICtDTUdGOiAoMCwxKVxyXG5cclxuT0tcclxuPGJyPgpvZm9u
b2RbMTY4MF06IEF1eDogJmd0OyBBVCtDUE1TPT9ccjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0
OyBcclxuK0NQTVM6ICgmcXVvdDtTTSZxdW90OyksKCZxdW90O1NNJnF1b3Q7KSwoJnF1b3Q7U00m
cXVvdDspXHJcblxyXG5PS1xyXG48YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ01HRj0w
XHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbk9LXHJcbjxicj5vZm9ub2RbMTY4MF06
IEF1eDogJmd0OyBBVCtDUE1TPSZxdW90O1NNJnF1b3Q7LCZxdW90O1NNJnF1b3Q7LCZxdW90O1NN
JnF1b3Q7XHI8YnI+Cm9mb25vZFsxNjgwXTogQXV4OiAmbHQ7IFxyXG48YnI+b2Zvbm9kWzE2ODBd
OiBBdXg6ICZsdDsgK0NQTVM6IDAsMTAwLDAsMTAwLDAsMTAwXHJcblxyXG5PS1xyXG48YnI+b2Zv
bm9kWzE2ODBdOiBBdXg6ICZndDsgQVQrQ05NST0/XHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZs
dDsgXHJcbjxicj5vZm9ub2RbMTY4MF06IEF1eDogJmx0OyArQ05NSTogKDAtMyksKDAtMyksKDAs
MiksKDAtMiksKDAsMSlcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE2ODBdOiBkcml2ZXJzL2F0
bW9kZW0vc21zLmM6YnVpbGRfY25taV9zdHJpbmcoKTxicj5vZm9ub2RbMTY4MF06IGRyaXZlcnMv
YXRtb2RlbS9zbXMuYzpjb25zdHJ1Y3RfYWNrX3BkdSgpPGJyPm9mb25vZFsxNjgwXTogQXV4OiAm
Z3Q7IEFUK0NOTUk9MiwyLDIsMSwwXHI8YnI+b2Zvbm9kWzE2ODBdOiBBdXg6ICZsdDsgXHJcbk9L
XHJcbjxicj5vZm9ub2RbMTY4MF06IHNyYy9uZXR3b3JrLmM6X19vZm9ub19uZXRyZWdfYWRkX3N0
YXR1c193YXRjaCgpIDB4ODhlYjY3MDxicj4Kb2Zvbm9kWzE2ODBdOiBzcmMvc21zLmM6c21zX3Jl
c3RvcmVfdHhfcXVldWUoKTxicj5vZm9ub2RbMTY4MF06IHBsdWdpbnMvcHVzaC1ub3RpZmljYXRp
b24uYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkPGJyPm9mb25vZFsxNjgwXTogcGx1Z2lucy9zbWFy
dC1tZXNzYWdpbmcuYzpzbXNfd2F0Y2goKSByZWdpc3RlcmVkPGJyPm9mb25vZFsxNjgwXTogQXV4
OiAmZ3Q7IEFUK0NNR0w9NFxyPGJyPgpvZm9ub2RbMTY4MF06IEF1eDogJmx0OyBcclxuT0tcclxu
PGJyPm9mb25vZFsxNjgwXTogZHJpdmVycy9hdG1vZGVtL3Ntcy5jOmF0X2NtZ2xfZG9uZSgpPGJy
Pm9mb25vZFsxNjgwXTogQXV4OiAmZ3Q7IEFUK0NHU01TPTNccjxicj5vZm9ub2RbMTY4MF06IEF1
eDogJmx0OyBcclxuT0tcclxuPGJyPm9mb25vZFsxNjgwXTogTW9kZW06ICZsdDsgQVQrQ1JFRz9c
clxyXG4rQ1JFRzogMCwyXHJcblxyXG5PS1xyXG48YnI+Cjxicj48L3ByZT48cHJlPjxicj48YnI+
PC9wcmU+PHByZT48YnI+T24gMTcvMTIvMTIgMTc6MjIsIE1pbmdsaSBXdSB3cm90ZToKJmd0Ozxp
PiBGb3IgVGVsaXQgSEU5MTAsICBvZm9ubyBhbHdheXMgZ290ICZxdW90O1xyXG4rQ01FIEVSUk9S
OiAxNFxyXG4mcXVvdDsKPC9pPiZndDs8aT4gYWZ0ZXIgaXNzdWluZyAmcXVvdDtBVCtDTUVSPTMs
MCwwLDJcciZxdW90OyBjb21tYW5kLiAmcXVvdDtDTUUgRVJST1I6IDE0JnF1b3Q7CjwvaT4mZ3Q7
PGk+IG1lYW5zIHRoYXQgU0lNIGlzIGJ1c3kuIE5vdyB3ZSBpZ29ucmUgdGhlIHJlc3VsdCBvZiB0
aGUKPC9pPiZndDs8aT4gY29tbWFuZCAmcXVvdDtBVCtDTUVSPTMsMCwwLDJcciZxdW90OywgYW5k
IHJlZ2lzdGVyIG5ldHdvcmsgYW55d2F5Lgo8L2k+Jmd0OzxpPiAtLS0KPC9pPgpJIHN1Ym1pdHRl
ZCBzb21lIHBhdGNoZXMgd2hpY2ggd2lsbCBzb2x2ZSB0aGlzIHByb2JsZW0uCllvdSBzaG91bGQg
bm90IGdldCBDTUUgRVJST1I6IDE0IGFueW1vcmUgYW5kIGhlbmNlCnRoZSBuZXRyZWcgYXRvbSB3
aWxsIG5vdCBiZSByZW1vdmVkLgpUaGVyZSBpcyBub3QgbmVlZCB0byBtYWtlIGNoYW5nZXMgaW4g
dGhlIG5ldHdvcmsgcmVnaXN0cmF0aW9uIGF0b20uClRlbGl0IHN1cHBvcnRzICtDTUVSIGJ1dCB3
aXRob3V0IHdhaXRpbmcgZm9yIHRoZSBtb2RlbSB0byBiZSByZWFkeQp0aGUgY29tbWFuZCB3aWxs
IGZhaWwuCgpSZWdhcmRzLApDaHJpc3RvcGhlcjxicj48YnI+PGJyPjxicj48L3ByZT48L2Rpdj4K

--===============3513804773270977685==--

