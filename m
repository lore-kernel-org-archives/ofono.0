Content-Type: multipart/mixed; boundary="===============8687707573273918337=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 04 Jan 2011 15:37:45 +0200
Message-ID: <1294148265.3120.1644.camel@tucson>
In-Reply-To: <1294134077.5852.91.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8687707573273918337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, 2011-01-04 at 01:41 -0800, ext Marcel Holtmann wrote:
> > But then it is far simpler to have a D-Bus getter and a D-Bus signal by=
 any =

> > sane measure of complexity.
> =

> So you did consider the complexity on both sides, ofonod and timed? And
> not just looked at one side of picture?

Timed also needs to follow the registration status, namely the MNC/MCC
of the registered network.  This information it needs to be able to find
the correct timezone, as the UTC offset alone only indicates the
geographic longitude for the timezone.

Factor that in to the equation, and timed already needs to enumerate
available modems, call GetProperties, and listen to the
NetworkRegistration interface's PropertyChanged signals.

However, if we refactor the time plugin to also send the MNC/MCC pair --
or better yet, the ISO country code based on MCC or even the actual
timezone from matching zone.tab entry -- then following netreg is no
longer needed.

*Then* I agree a method call is actually a lot simpler from timed point
of view; all it needs to do is implement a single method on some
org.ofono.NetworkTimeConsumer interface and not worry about enumerating
modems via ModemManager or listening on any signals.

Cheers,
Aki


--===============8687707573273918337==--

