Content-Type: multipart/mixed; boundary="===============2542367007407828592=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Demo client
Date: Wed, 23 Jun 2010 00:41:38 +0200
Message-ID: <AANLkTimtL5yGP1Q65UzrOVXUQzmbd2eABfYeX5WI1oI_@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2542367007407828592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have a minimal GUI client that I recently started using for testing
some new ofono features, and thought that others might want to use
something like that too.  It currently only supports Voicecall atom
(two-party calls only), voicemail, PIN entry and Sim Toolkit menus.
Adding new atoms is fairly easy, for example adding the menus only
took about an hour.  It's a little rough as it's a quick development
(for example error handling is poor).

git clone http://openstreetmap.pl/balrog/webfono.git

The program is browser based (in javascript) and needs a tiny http
server running, the server is a 10kb python script excuted with
./gateway.py (depends on python3, glib and dbus bindings installed).
The javascript part is only tested in Firefox.  It can run remotely
but probably makes most sense on localhost or on ethernet.  If
anything goes wrong, you can always hit Refresh (F5) and it should go
back to a sane state.

The sim toolkit support needs the patches I just sent, I tested it
with the mbmmodem plugin, and three different SIMs (not only a certain
AU vodafone card, also a local Polish one) and navigating the menu
seems very stable, I can even go into "My Vodafone" and hit "STK
version" and the sim gives some info about itself.
(http://openstreetmap.pl/balrog/ofono-screen-stk0.png
http://openstreetmap.pl/balrog/ofono-screen-stk1.png)

Regards

--===============2542367007407828592==--

