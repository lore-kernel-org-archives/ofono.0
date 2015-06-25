Content-Type: multipart/mixed; boundary="===============5900659859788306160=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: HE910 + ofono: "Activating context failed with error: Unknown error
 type"
Date: Thu, 25 Jun 2015 11:15:52 +0200
Message-ID: <558BC6C8.9080600@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5900659859788306160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I need your help in using a Telit HE910 with ofono (and eventually connman).
(I am using ofono 1.16 with HE910 firmware version 12.00.006; connman =

version is 1.29).

My problem is the following ...
on startup everything works fine and the ppp0 connection is established,
but problems occur in the following case:

connmanctl> disconnect cellular_*_context15
Disconnected cellular_*_context15

connmanctl> connect cellular_*_context15
Error /net/connman/service/cellular_*_context15: Input/output error


ofonod[5355]: gprs-context.c(244):at_gprs_activate_primary() cid 1
ofonod[5355]: gprs.c(889):pri_activate_callback() 0x1a18c50
ofonod[5355]: gprs.c(893):pri_activate_callback() Activating context =

failed with error: Unknown error type
connmand[3815]: Failed to change property: /he910_0/context15 =

org.ofono.ConnectionContext.Active: org.ofono.Error.Failed Operation failed


The same error happens if I am manually sending connect/disconnect via =

dbus-send.

Only a hard ofono restart can establish the connection again.
This behavior happens all the time once a ppp0 disconnect happened
(e.g. by removing the SIM; manual disconnect via dbus or connmanctl).

A subquestion regarding connman:
Can connmand be configured in such a way that on every connection
loss, ofono is triggered to reconnect to the Internet?

Thank you very muchin advance,
Marko

--===============5900659859788306160==--

