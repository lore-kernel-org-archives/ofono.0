Content-Type: multipart/mixed; boundary="===============2480350292731077860=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 1/4] Add: Online property to modem
Date: Thu, 27 May 2010 16:05:09 +0300
Message-ID: <AANLkTikQJ6AooO-z3IUNthX_d9IlXffpaZKI1XXT18xZ@mail.gmail.com>
In-Reply-To: <201005262105.11721.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2480350292731077860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/5/27 Denis Kenzior <denkenz@gmail.com>:
> Patch has been applied, however I did some refactoring afterward. =C2=A0P=
lease test
> that I didn't break something.

There is now a race condition in online/offline and sim hotswap. With
imperfect hw a missing sim gets detected only when modem attempts to
register to network and actually tries to read something from sim
card. I have no idea if the missing sim can be reported before +cops
command response is returned.

However, at least isimodem needs explicitly told to go offline when
sim gets removed.

-- =

Pekka.Pessi mail at nokia.com

--===============2480350292731077860==--

