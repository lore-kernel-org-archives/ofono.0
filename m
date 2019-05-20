Content-Type: multipart/mixed; boundary="===============1813704908307171695=="
MIME-Version: 1.0
From: Richard =?unknown-8bit?q?R=C3=B6jfors?= <richard.rojfors@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Mon, 20 May 2019 14:47:58 +0200
Message-ID: <CAHB-PjkktnfFgW02+PXne_Kg9eGOUmpv-SxCJ8WwxS3G=Ky1Mw@mail.gmail.com>
In-Reply-To: <9aabfacb-6de4-6b7f-8a8a-a946c99d21b0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1813704908307171695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Den tors 16 maj 2019 kl 18:01 skrev Denis Kenzior <denkenz@gmail.com>:
> >
> > I think I saw a patch for using c*reg in atmodem/gprs.c, can we wake th=
at up?
> > Otherwise I can put some energy into this, if we decide which
> > direction to go first.
> >
>
> Since 3GPP decided to go with EREG being separate from CGREG, I think it
> makes sense to support that natively in lte.c or gprs.c.  Our philosophy
> has always been to base the driver APIs off of 27.007.  So from that
> perspective, introducing ofono_lte_status_notify would make sense.
> Whether something like this makes things easier or not is a different
> question :)

...and we have the issue that the indications seems to be sent in random or=
der.

So what about when a c?reg indication is received from the modem.
Start a "poll" of all the supported c?reg and set a flag, so multiple
polls are not started in case of an additional indication is received.
When the poll of all the supported c?reg statuses returns -> update
the gprs "core" with the combined status?

.. and the attached_status callback should also poll all supported c?reg...

BR
Richard

--===============1813704908307171695==--

