Content-Type: multipart/mixed; boundary="===============3950073209136248620=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC sim-authenticate PATCH 2/3] Added
 doc/sim-authentication-api.txt.
Date: Tue, 04 Jan 2011 13:16:01 +0200
Message-ID: <AANLkTi=Ka_VmgYd-QSH4rPLBHM25iteXD7RPD2qr1D8S@mail.gmail.com>
In-Reply-To: <1294088081.5852.26.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3950073209136248620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/3 Marcel Holtmann <marcel@holtmann.org>:
> yep, that is similar to what I was thinking about.

I'll update the proposal.

> Andrew is currently
> looking on how to do SIM application discovery. So I like to get his
> input on this as well.

The AT+CUAD looks straightforward enough. Unfortunately I've yet to
see a modem implementing AT+CUAD.

> On AT command modems, we are pretty much tight into SIM application
> discover and execution of authentication methods. At least when reading
> the specification. I have not yet tested this since right now we are not
> even bothering with SIM application details inside oFono at all.
>
> For WISPr 2.0 and 802.1x we will need to make this work as well.
>
>> > The EAP SIM is a subset of any proper AKA mechanism, but that should be
>> > fine as well. Just having an empty AUTN array seems fine to me.
>>
>> I'll see how GBA will fit to the architecture. According to the ISI
>> modem spec it might be straightforward.
>
> Is there a public specification for GBA by any chance?

33.220 is specifies the algorithm and 24.109 contains the protocol.
I'd recommend starting from the examples in 24.109, they are most
easiest to digest.

-- =

Pekka.Pessi mail at nokia.com

--===============3950073209136248620==--

