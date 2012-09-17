Content-Type: multipart/mixed; boundary="===============9029706767344139013=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: ofono exits after DBUS error
Date: Mon, 17 Sep 2012 19:49:07 +0200
Message-ID: <CABvLYuCY1KE5btF59ioXesRg3o=BYJBbaZyt1bodHMLDoMf+2A@mail.gmail.com>
In-Reply-To: <50574530.3030709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9029706767344139013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> To me it sounds like the output should be BASE followed by the inverted '=
!'
> sign.  Unfortunately the modem is sending ISO-8859-1 characters instead of
> GSM like it is being told to do by the driver.  That particular character=
 is
> not valid utf8, hence we go kaboom.
>
> Having said that, I'm not familiar with 'BASE', does the above sound
> reasonable?

The operator's name is just "BASE", so i wouldn't see why there would
be an inverted '!' sign. In some AT logs i've also seen "BASE0" as a
response to AT+COPS?, so i'm thinking this last character is just
garbage.

regards,
Cedric

--===============9029706767344139013==--

