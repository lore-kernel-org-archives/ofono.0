Content-Type: multipart/mixed; boundary="===============2789329485656325919=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Reliable SMS receive
Date: Fri, 01 Feb 2019 23:05:54 +0100
Message-ID: <20190201220554.GB13090@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2789329485656325919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I see that great care is taken not to lose outgoing message: "
Persisting of outgoing SMS messages.  Whenever oFono is asked to send
an SMS message, it adds it to an internal queue and persists it on
disk.  The queue is persistent across reboots of oFono and allows to
queue SMS messages even while the modem is offline."

Is there something similar possible for incoming messages? I really
hate losing those... Best think would be if

a) SMS comes from the modem

b) ofono sends the SMS over the dbus

c) application writes it to stable storage, and confirms that back on
dbus

d) ofono confirms reception of SMS to the modem.

e) modem confirms it to the network.

If something goes wrong, network will retransmit message and it will
be delivered on the next boot.

(Other schemes would work for me, too...)

Ideas?
								Pavel



--===============2789329485656325919==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseFV3c0lBQ2drUU1PZndhcFhiK3ZKMDJBQ2VJVlh6d2VWTGxBczdPbURUOW1TYVlwb3YK
b1ZjQW9KbnBmRHdFaStrcXhpeVAyWnlLY3pqZDdLWFIKPWVDNHcKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2789329485656325919==--

