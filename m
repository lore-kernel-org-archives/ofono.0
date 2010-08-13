Content-Type: multipart/mixed; boundary="===============7653635696926179633=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Removal of modemconf plugin
Date: Fri, 13 Aug 2010 21:22:03 +0300
Message-ID: <AANLkTin0iWv1n-TCw5MiVGoVzyZTmKDUJxKifZgBhcjo@mail.gmail.com>
In-Reply-To: <1281704204.23399.6.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7653635696926179633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/8/13 Marcel Holtmann <marcel@holtmann.org>:
>> > The open here is the ISI modem detection, but this should be clearly
>> > done via a Phonet plugin. And also the N900 specific case inside
>> > modemconf is just wrong. This needs to be fixed and just auto-detected
>> > via Phonet or maybe just via RTNL directly.
>>
>> Once we get proper n900modem driver tested and integrated, the
>> isimodem stuff can be removed, too.
>
> so how close are you with that. I am going to remove modemconf sooner
> than later actually.

I'll try to test it against meego kernel, but I have some problems
(like, usb ethernet does not get up so I could see what is happening
there.)

However, I can post the almost completely untested version once I've
split it into digestable pieces.

-- =

Pekka.Pessi mail at nokia.com

--===============7653635696926179633==--

