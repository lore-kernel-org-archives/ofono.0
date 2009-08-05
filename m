Content-Type: multipart/mixed; boundary="===============5223836630386307832=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Wed, 05 Aug 2009 21:18:25 +0200
Message-ID: <fb249edb0908051218l3315aa74v4aaf82ee372bdb3b@mail.gmail.com>
In-Reply-To: <200908051247.46922.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5223836630386307832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/8/5 Denis Kenzior <denkenz@gmail.com>:
> Sorry I don't quite follow. =C2=A0The mw_set_indicator function sets the =
value and
> emits the signals regardless of whether the MWIS file could be written. =
=C2=A0Can
> you explain some more?
>
> For setting mailbox numbers, a working EF-MBDN is required since the only
> alternative would be to store them on the filesystem.

mw_set_indicator does the right thing, I missed this fact.  But when a
mailbox number is set or received from network all clients get a
PropertyChanged and the new number can be retrieved from the interface
but only when the store succeeded, previously it would be available
regardless of MBDN on the card and the writing to card was secondary.
The number is kind of important if you want to hear the messages.

Regards

--===============5223836630386307832==--

