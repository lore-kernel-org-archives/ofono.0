Content-Type: multipart/mixed; boundary="===============2324346071666855379=="
MIME-Version: 1.0
From: claudio Degioanni <claudio.degioanni@zirak.it>
Subject: ConnectionContext on Nokia 6760s-1
Date: Tue, 22 Mar 2011 15:34:30 +0100
Message-ID: <1300804470.2673.14.camel@claudio-ThinkPad-R61>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2324346071666855379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

We have tried to attach an Nokia 6760s-1, for using it like 3G modem.
Ofono manages correctly the mobile phone creating /isiusb0/
and /isiusb0/context1 and i think it uses the isi modem driver.

Next we have activated the pdp context, but it returns the following
dbus exception =


	org.ofono.Error.NotAttached GPRS is not attached

The log of ofono are: =


ofonod[2441]: drivers/isimodem/ussd.c:ussd_ind_cb() type: 5
SS_GSM_USSD_END, dcs: 0x0f, len: 125
ofonod[2441]: src/ussd.c:ofono_ussd_notify() status: 2 TERMINATED,
state: 0 IDLE
ofonod[2441]: drivers/isimodem/ussd.c:ussd_ind_cb() type: 5
SS_GSM_USSD_END, dcs: 0x00, len: 0
ofonod[2441]: src/ussd.c:ofono_ussd_notify() status: 2 TERMINATED,
state: 0 IDLE

is it possible to use the nokia phone as 3G modem?

Note:
We attached the phone through usb cable, indicating PC Suite as
interaction mode.

regs
-- =

claudio Degioanni <claudio.degioanni@zirak.it>


--===============2324346071666855379==--

