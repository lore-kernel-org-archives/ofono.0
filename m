Content-Type: multipart/mixed; boundary="===============9206871371896688560=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: oFono release plan?
Date: Tue, 21 Dec 2010 18:28:25 +0200
Message-ID: <AANLkTikwzoy9NN0g0DrDP84GmePfKxH36s2Y74Lhq2xK@mail.gmail.com>
In-Reply-To: <1292948319.2658.53.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9206871371896688560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/12/21 Marcel Holtmann <marcel@holtmann.org>:
> we don't know that yet for sure. They might be all internal, but there
> might be also D-Bus visible changes. We will see once LTE support lands
> in oFono.

Well, from my point of view there are some key APIs we know for sure
are missing. Off the top of my head:

- LCS, neighbor cell info
- CDMA support
- the SMS (history) agent API
- SIM authentication API (EAP-SIM, EAP-AKA, IMS and GBA)

Then again, I don't really see the point in a 1.0 beyond marketing.
It's not like the current D-Bus API is allowed to change a lot as it
stands currently.

Cheers,
Aki

--===============9206871371896688560==--

