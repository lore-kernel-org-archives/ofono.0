Content-Type: multipart/mixed; boundary="===============1770840868707472282=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Huawei E3372
Date: Tue, 14 Feb 2017 10:53:44 +0100
Message-ID: <088d60e2-4e2c-c7d0-47ab-0022de446b14@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1770840868707472282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I try to connect using a USB dongle. It is a Huawei E3372h-153. I will =

try to give information on this modem because looking at Internet, it =

seems that E3372 is a generic name for different hardwares (or firmwares?).

Before usb_modeswitch my USB dongle present itself as a CDROM and a mass =

storage media with these vendor and product ids:

usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D15cf

After usb_modeswitch, product id changes:

usb 1-1: New USB device found, idVendor=3D12d1, idProduct=3D15b7

And devices are:

  - 2 serial ports:

[   16.010158] option 1-1:1.0: GSM modem (1-port) converter detected
[   16.065118] usb 1-1: GSM modem (1-port) converter now attached to ttyUSB0
[   16.141589] option 1-1:1.1: GSM modem (1-port) converter detected
[   16.208587] usb 1-1: GSM modem (1-port) converter now attached to ttyUSB1

  - a CDC NCM net device (/dev/cdc-wdm0):

[   16.358721] huawei_cdc_ncm 1-1:1.2: MAC-Address: 00:1e:10:1f:00:00
[   16.417550] huawei_cdc_ncm 1-1:1.2: NDP will be placed at end of =

frame for this device.
[   16.455455] huawei_cdc_ncm 1-1:1.2: cdc-wdm0: USB WDM device
[   16.520626] huawei_cdc_ncm 1-1:1.2 wwan0: register 'huawei_cdc_ncm' =

at usb-ci_hdrc.0-1, Huawei CDC NCM device, 00:1e:10:1f:00:00

  - a mass storage device


Using ATI, modem present itself like that:

Manufacturer: huawei
Model: E3372H
Revision: 21.315.01.00.314
IMEI: XXXX
+GCAP: +CGSM,+DS,+ES


Using an unmodified Ofono, I fail to activate gprs context:

Feb 14 08:43:55 klk-lpbs-040070 daemon.debug ofonod[1238]: =

../git/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Feb 14 08:43:55 klk-lpbs-040070 daemon.info ofonod[1238]: Modem: > =

AT+CGDCONT=3D1,"IP","orange.m2m.spec"\r
Feb 14 08:43:55 klk-lpbs-040070 daemon.info ofonod[1238]: Modem: < =

\r\nOK\r\n
Feb 14 08:43:55 klk-lpbs-040070 daemon.debug ofonod[1238]: =

../git/drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
Feb 14 08:43:55 klk-lpbs-040070 daemon.info ofonod[1238]: Modem: > =

AT+CGDATA=3D"PPP",1\r
Feb 14 08:43:55 klk-lpbs-040070 daemon.info ofonod[1238]: Modem: < =

\r\n+CME ERROR: 50\r\n
Feb 14 08:43:55 klk-lpbs-040070 daemon.debug ofonod[1238]: =

../git/drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
Feb 14 08:43:55 klk-lpbs-040070 daemon.info ofonod[1238]: Unable to =

enter data state
Feb 14 08:43:55 klk-lpbs-040070 daemon.debug ofonod[1238]: =

../git/src/gprs.c:pri_activate_callback() 0x41f4f8
Feb 14 08:43:55 klk-lpbs-040070 daemon.debug ofonod[1238]: =

../git/src/gprs.c:pri_activate_callback() Activating context failed with =

error: Incorrect parameters


So activation fails because AT+CGDATA=3D"PPP",1 fails. Here is what this =

modem claims to support:

AT+CGDATA=3D?
+CGDATA: ("NULL")

OK

I didn't try to send AT+CGDATA=3D"NULL",1 before PPP setup. Instead I used =

ATD*99***1#. So I modified function at_cgdcont_cb in =

drivers/atmodem/gprs-context.c to send this command instead of =

AT+CGDATA=3D"PPP",1 and I managed to connect. Here are the traces:

Feb 14 08:57:30 klk-lpbs-040070 daemon.debug ofonod[1252]: =

../git/drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
Feb 14 08:57:30 klk-lpbs-040070 daemon.info ofonod[1252]: Modem: > =

AT+CGDCONT=3D1,"IP","orange.m2m.spec"\r
Feb 14 08:57:30 klk-lpbs-040070 daemon.info ofonod[1252]: Modem: < =

\r\nOK\r\n
Feb 14 08:57:30 klk-lpbs-040070 daemon.debug ofonod[1252]: =

../git/drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
Feb 14 08:57:30 klk-lpbs-040070 daemon.info ofonod[1252]: Modem: > =

ATD*99***1#\r
Feb 14 08:57:30 klk-lpbs-040070 daemon.info ofonod[1252]: Modem: < =

\r\nCONNECT\r\n
Feb 14 08:57:30 klk-lpbs-040070 daemon.debug ofonod[1252]: =

../git/drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 1
Feb 14 08:57:30 klk-lpbs-040070 daemon.debug ofonod[1252]: =

../git/drivers/atmodem/gprs-context.c:setup_ppp()
Feb 14 08:57:30 klk-lpbs-040070 daemon.info ofonod[1252]: PPP: lcp: =

pppcp_generate_event: current state 0:INITIAL

... (PPP debug)

Feb 14 08:57:33 klk-lpbs-040070 daemon.info ofonod[1252]: PPP: =

../git/gatchat/gatppp.c:ppp_enter_phase() 4
Feb 14 08:57:33 klk-lpbs-040070 daemon.debug ofonod[1252]: =

../git/drivers/atmodem/gprs-context.c:ppp_connect()
Feb 14 08:57:33 klk-lpbs-040070 daemon.info ofonod[1252]: IP: 10.47.149.108
Feb 14 08:57:33 klk-lpbs-040070 daemon.info ofonod[1252]: DNS: =

192.168.10.110, 194.51.3.56
Feb 14 08:57:33 klk-lpbs-040070 daemon.debug ofonod[1252]: =

../git/src/gprs.c:pri_activate_callback() 0x3654e8


My problem now is how to know if I should send AT+CGDATA=3D"PPP",1 or =

ATD*99***1# when activating context in@modem driver. I see in this =

driver and others that a VENDOR information can be sent from plugin but =

I imagine that other Huawei devices support AT+CGDATA=3D"PPP",1.

Do you have any idea of what I should do to support this modem without =

disturbing other devices?

Christophe


PS: I am aware that using PPP to connect this modem might not be the =

best solution. I spent days to try to get interface wwan0 up. I managed =

to get IP address, gateway and DNS servers for this interface using =

something similar to what is done in telitmodem/gprs-context-ncm.c (I =

might send traces if someone is interested) but I never managed to send =

or receive a packet on wwan0 interface. Problem might come from my =

kernel (4.1) even if I applied all patches from Vanilla linked to =

drivers/net/usb/cdc_ncm.c, drivers/net/usb/huawei_cdc_ncm.c or =

drivers/usb/class/cdc-wdm.c.




--===============1770840868707472282==--

