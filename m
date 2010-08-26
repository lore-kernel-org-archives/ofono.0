Content-Type: multipart/mixed; boundary="===============1907032438069099785=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-reset-pin PATCH 0/4] sim: better PIN reset
Date: Thu, 26 Aug 2010 15:49:13 +0300
Message-ID: <1282826957-8238-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1907032438069099785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

As I've said, I've toyed with PINs and PUKs.

The first two patches deal with resetting the PIN code with PUK.  In order
to reset the password, the modem must request for the PIN in first
place. Normally that is easy, driver gets +CPIN: SIM PUK response. However,
some (buggy?) SIM cards allow registering to network if the PIN was unlocked
before it got PUKed (and respond with +CPIN: READY).

Therefore, the pin reset now tries to trigger the appropriate +CPIN: SIM
PUK* state. Triggering is always needed for PIN2.

The two later patches add shell utilities for testing.

--Pekka


--===============1907032438069099785==--

