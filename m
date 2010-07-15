Content-Type: multipart/mixed; boundary="===============9114360490996435767=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] stkutil: display text attributes as html
Date: Thu, 15 Jul 2010 15:32:11 -0500
Message-ID: <4C3F704B.3010502@gmail.com>
In-Reply-To: <AANLkTikNE6jXa6Qhu33llLQGsUMnAGQPnchN_nBflHpB@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9114360490996435767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> One idea to handle this was for the text_to_html function to take a
> language parameter (for now it could just hardcode English) and decide
> the default alignment based on it.  Then default alignment (bits 0:3
> =3D=3D 3) would be treated same as left (or right).

Yes that is another approach, however I think that this might be moot
anyway.  At least on my Sony Ericsson T610 the EMS composer defaults to
alignment 'Auto' (No Alignment in the protocol) and only adds
Left/Right/Center alignment when the user tells it to.

> =

> This assumes the test is correct afterall, because it's not clear from 23=
 040.
> =


I'm fairly sure the current test case is synthetic, so might not reflect
how EMS messages are created in the real world.

I added another test case to test-sms with a test message composed by my
T610.  That is the better test case to focus on.

Regards,
-Denis


--===============9114360490996435767==--

