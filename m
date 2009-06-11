Content-Type: multipart/mixed; boundary="===============5927642105597520589=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 21:00:48 +0300
Message-ID: <a26fd138dc308308288592371b2202e2@localhost>
In-Reply-To: <200906110932.39143.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5927642105597520589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Jun 2009 09:32:38 -0500, Denis Kenzior <denkenz@gmail.com>
wrote:
> About the only thing that MCC/MNC is useful for is to display it during
> manual =

> operator selection.  =


That's not true. In fact, I'd say manual operator selection is just about
the last
place where the codes should be displayed.

> MCC/MNC is not helpful at all for countries like U.S. =

> with 4+ timezones and the same carrier id across all of them.  A country =

> property would work just as well for this.  =


For geolocation help, sure, but there are other places where MNC/MCC are
used as keys to databases containing operator-specific information, like
default Internet APN names and such.

> What standard do we want to use
> =

> here? ITU 212? ISO 3166? or E164?
> =

> Any objections from actually removing the MCC/MNC Properties?

We need them.

Cheers,
Aki

--===============5927642105597520589==--

