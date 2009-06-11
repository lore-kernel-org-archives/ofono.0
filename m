Content-Type: multipart/mixed; boundary="===============4700550994276046627=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 22:38:49 +0300
Message-ID: <cb0e8d6f9acaa0c755e042ab8dda6dbd@localhost>
In-Reply-To: <1244747882.27363.65.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4700550994276046627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Jun 2009 21:18:02 +0200, Marcel Holtmann <marcel@holtmann.org>
wrote:
>> However, this wouldn't be the only database ever, so we would still need
>> a
>> way to reliably identify a specific operator.
> =

> if we are unclear about the format and the users at this moment,

The format should be 's' in D-Bus and in struct ofono_network_operator:

   char mnc[4];
   char mcc[4];

And as for users, we need access to both MNC and MCC.

What part of this is unclear?

Cheers,
Aki

--===============4700550994276046627==--

