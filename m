Content-Type: multipart/mixed; boundary="===============6574506953094715454=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Test clients for ofono: rfone, Unicsy Demo 
Date: Thu, 14 Feb 2019 11:11:18 +0100
Message-ID: <20190214101117.GA6132@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6574506953094715454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

What ofono client are you using for development.. and for real usage
on a cellphone?

There are scripts in test/ which are suitable for early development,
but not really for real use or 'does everything work?' testing.

Anyway, I created some.

RFone -- https://gitlab.com/tui/tui/tree/master/rfone -- command line
tool written in Rust, by default monitors interesting events
(incomming call, sms, signal changes, registration changes), and has
command-line options for making/answering calls and sending sms. I'm
starting gtk support.

Unicsy Demo -- https://github.com/pavelmachek/unicsy_demo -- gtk phone
application meant for a phone, written in Python so a bit slow on
Nokia N900. But it has integrated phonebook, log of sms messages, is
fully graphical so possible to control from touchscreen, and actually
plays melody on incoming call. [Few GPL compatible melodies would
be good.] Quite basic, but should be useable.

Is there any other software I should look at?

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6574506953094715454==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseGxQc1VBQ2drUU1PZndhcFhiK3ZMS1N3Q2VLWk9hUlhKUmVmM1B0dlpzUjJjMmdTWUUK
RW1FQW4zSXN6NDlFMHh0YXA3OEJyYkdZUDloeFUwWUMKPWtXbUgKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6574506953094715454==--

