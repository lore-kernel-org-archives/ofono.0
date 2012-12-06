Content-Type: multipart/mixed; boundary="===============5513810544416191576=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: tun interface name conflicts with ppp driver
Date: Thu, 06 Dec 2012 12:13:04 +0100
Message-ID: <CABvLYuBUFN+YtPd9=vd4akWfEYZR84xp6TaFrBYY=EUvd7istg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5513810544416191576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

when a context is active, the interface name is typically ppp0. If you try
to run pppd for some other device/interface, the kernel ppp driver prints
an error because it can't register ppp0. It looks like it's assumed that
ppp* interface names are reserved for the ppp_driver.
Can the tun interface name be changed to eg. ofono0?

thanks,
Cedric

--===============5513810544416191576==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGRpdj48YnI+PC9kaXY+PGRpdj53aGVuIGEgY29udGV4dCBpcyBhY3RpdmUsIHRoZSBpbnRl
cmZhY2UgbmFtZSBpcyB0eXBpY2FsbHkgcHBwMC6gSWYgeW91IHRyeSB0byBydW4gcHBwZCBmb3Ig
c29tZSBvdGhlciBkZXZpY2UvaW50ZXJmYWNlLCB0aGUga2VybmVsIHBwcCBkcml2ZXIgcHJpbnRz
IGFuIGVycm9yIGJlY2F1c2UgaXQgY2FuJiMzOTt0IHJlZ2lzdGVyIHBwcDAuIEl0IGxvb2tzIGxp
a2UgaXQmIzM5O3MgYXNzdW1lZCB0aGF0IHBwcCogaW50ZXJmYWNlIG5hbWVzIGFyZSByZXNlcnZl
ZCBmb3IgdGhlIHBwcF9kcml2ZXIuPC9kaXY+CjxkaXY+Q2FuIHRoZSB0dW4gaW50ZXJmYWNlIG5h
bWUgYmUgY2hhbmdlZCB0byBlZy4gb2Zvbm8wPzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+dGhh
bmtzLDwvZGl2PjxkaXY+Q2VkcmljPC9kaXY+Cg==

--===============5513810544416191576==--

