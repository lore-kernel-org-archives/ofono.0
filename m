Content-Type: multipart/mixed; boundary="===============1597443357954400577=="
MIME-Version: 1.0
From: Georg Chini <georg@chini.tk>
Subject: Problem with hangup of multiple calls
Date: Sat, 16 Aug 2014 22:07:51 +0200
Message-ID: <53EFBA17.2020705@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1597443357954400577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am using ofono (compiled from git) and bluez 5.21 to access
my old Nokia 6230i. I have a problem, when I call two parties.
When one call is ended, I do not receive a dbus signal. As soon
as I hangup the second call, I get "CallRemoved" messages for
both calls, so the first signal is delayed until the second call is
finished.
Any idea why this happens or how to debug it further?

Regards
               Georg

--===============1597443357954400577==--

