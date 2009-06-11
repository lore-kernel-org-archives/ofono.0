Content-Type: multipart/mixed; boundary="===============4286796349652915931=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 21:10:31 +0300
Message-ID: <ed18d858e2e6705f94676a5798fb0d2c@localhost>
In-Reply-To: <1244720815.27363.10.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4286796349652915931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Jun 2009 13:46:55 +0200, Marcel Holtmann <marcel@holtmann.org>
wrote:
> That said, we do want some exposure of these values since it is an easy
> way to determine geo location help and switch timezones etc. =


For geolocation, cell ID and LAC are more useful, especially coupled with
information on neighboring cells, RTT measurements, etc. We will probably
need to expose this information some way.

Also, typically networks provide date-time, timezone and DST information
via NITZ [1].

Cheers,
Aki

[1] http://en.wikipedia.org/wiki/NITZ

--===============4286796349652915931==--

