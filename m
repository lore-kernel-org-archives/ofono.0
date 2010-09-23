Content-Type: multipart/mixed; boundary="===============6294640496764885800=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: support of "emergency call when SIM not inserted" ?
Date: Thu, 23 Sep 2010 22:54:02 +0900
Message-ID: <1285250042.20811.76.camel@localhost.localdomain>
In-Reply-To: <A9AC1023FCA4654D92AC24C2A8F6A09201B01496@renesas4bis.renesas-rdf.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6294640496764885800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

new rule for everybody, no more HTML emails on this mailing list.
Actually not really a new rule, but I forgot to enforce it. So please
fix your mail clients.

> I am new to oFono.
> It seems an important challenge to design a telephony system that will
> support =

> several 3GPP modems. I would like to participate.
>  =

> I have read documentation (ofono-paper, coding-style, api for oFono
> Interfaces).
> I have started to cover source code: modem part, sim part...
>  =

> I need a clarification about SIM:
> Most GSM mobile phones can dial emergency calls even when the phone is
> without a SIM card.
> But it seems that oFono does not support an emergency call if the sim
> driver is present but no SIM is inserted:

I have never tested it by myself, but this should actually work just
fine. The voice call driver is registered in the pre-SIM state and has
some special handling when no SIM is present.

If it does not work, then this is a bug.

Regards

Marcel



--===============6294640496764885800==--

