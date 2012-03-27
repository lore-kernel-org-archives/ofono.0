Content-Type: multipart/mixed; boundary="===============1026654443251516680=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Configuring a TCP-connected Modem
Date: Tue, 27 Mar 2012 21:41:18 +0200
Message-ID: <1332877278.1870.116.camel@aeonflux>
In-Reply-To: <CAE_x+2CWUv15tqji+zYhOB4Qym=Qb7ibkx+q81PqCgnALeoqqg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1026654443251516680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

> I have a sort of strange question. I'd like to be able to configure an
> Inmarsat BGAN modem with ofono using a TCP connection to a port on the
> modem. The modem is connected via Ethernet.
> =

> Has this sort of thing been done? Any ideas on what it would take to get
> this working?

we have been doing this for Phonesim testing. And this is talking AT
commands over a TCP connections. See plugins/phonesim.c for an example.

If you are talking about a real product, then this has not been done
yet, but it is also not a problem to do so. oFono can support multiple
different transport types easily.

Regards

Marcel



--===============1026654443251516680==--

