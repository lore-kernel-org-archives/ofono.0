Content-Type: multipart/mixed; boundary="===============9218261858036702975=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 22:02:24 +0300
Message-ID: <a661a52193386f37e83d540de4099e6a@localhost>
In-Reply-To: <1244743827.27363.53.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9218261858036702975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Jun 2009 20:10:27 +0200, Marcel Holtmann <marcel@holtmann.org>
wrote:
>> For geolocation help, sure, but there are other places where MNC/MCC are
>> used as keys to databases containing operator-specific information, like
>> default Internet APN names and such.
> =

> shouldn't we just integrate that database into oFono directly or as
> something like ofono-info.git that will be installed along with (for
> easier updates).

This particular database of default APN names, maybe, although I think it's
really oFono users like Connman that should integrate with that
information. =


However, this wouldn't be the only database ever, so we would still need a
way to reliably identify a specific operator.

Cheers,
Aki

--===============9218261858036702975==--

