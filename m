Content-Type: multipart/mixed; boundary="===============1274070895877898976=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC online/offline atoms PATCH 2/4] sms: watch modem state
Date: Wed, 06 Oct 2010 10:54:40 +0200
Message-ID: <1286355280.6145.20.camel@aeonflux>
In-Reply-To: <4CABC509.2080502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1274070895877898976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> Allow use of SMS atom in online and offline states.  The messages are
> >> queued but not sent in offline mode. Errors occurring when an SMS is
> >> being sent while transition from online to offline are handled
> >> gracefully.
> > =

> > do we really want this? How is this suppose to work from the user
> > experience. I think just failing SendMessage with a proper error is a
> > more clear indication.
> =

> That is a valid point, the code should be able to handle this use case,
> but from a UI stand point I don't know what is better.
> =

> The main reason for moving sms atom from online to offline is the
> ability to switch the settings.  In particular the SMSC address which is
> stored on the SIM.

good enough reason for me. Just blindly spooling SMS is not what I want
right now. We should just fail with a proper error for now. Being able
to send SMS when offline needs a bit more thinking about on how the user
exceptions are and should be handled.

Regards

Marcel



--===============1274070895877898976==--

