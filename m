Content-Type: multipart/mixed; boundary="===============4401096485150048720=="
MIME-Version: 1.0
From: Naresh Mehta <nareshtechs@gmail.com>
Subject: Query on Ofono Architecture for multiple RATs
Date: Fri, 13 Aug 2010 08:46:24 +0200
Message-ID: <AANLkTi=koUsUv-Zdn0D3XrJtgSKzFscV9ejN93k-d1mn@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4401096485150048720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Ofono team,

Lets suppose that I have a modem which implements various radio access
technologies like CDMA, WCDMA,  GSM, LTE, etc. The questions I have
are:

- How should this modem look like inside Ofono and be exposed outside of Of=
ono?
- Do you expect to have separate modem drivers for CDMA, WCDMA/GSM and
LTE or a single driver covering these varied RATs would be accepted?
- Can there be multiple atoms to support the same functionality in
various RATs (like SMS or emergency calls) or we can modify one atom
to support all the RATs?
- I guess connman needs to know of the different connections such a
modem supports and trigger them accordingly? How might this
functionality look like?
- Can the Ofono DBus API differentiate between various RATs based on
parameters or some new messages needs to be defined if we use a single
modem driver for multiple RATs?

Please advise. Any pointers/suggestions would be of great help.

-- =


BR; Naresh

visit me at:
http://www.naresh.se/

--===============4401096485150048720==--

