Content-Type: multipart/mixed; boundary="===============7412143300378893297=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/3] EF-SPN API to sim-atom
Date: Mon, 31 Jan 2011 10:57:26 +0100
Message-ID: <1296467846.1520.197.camel@aeonflux>
In-Reply-To: <1296454409.2204.6.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7412143300378893297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> > Here is an asynchronous implementation of SIM Service Provider Name (EF=
-SPN) getter API.
> > The trick is to delay setting sim ready until spn reading is finished.
> =

> Any comments about this? =

> So, yes, it slightly delays SIM initialisation (usually SPN value should
> come from disk cache), but then netreg can use it immediately when it
> registers. =


I am actually fine with this. Denis had a concern about it. Check with
him.

Regards

Marcel



--===============7412143300378893297==--

