Content-Type: multipart/mixed; boundary="===============5521766742674649113=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 4/4] Dummy example GPRS context provisioning driver
Date: Thu, 13 Jan 2011 08:36:12 +0200
Message-ID: <1294900572.18783.21.camel@jsaunama-desktop>
In-Reply-To: <4D2DDAF6.5050600@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5521766742674649113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

On Wed, 2011-01-12 at 10:46 -0600, Denis Kenzior wrote:
> > ...SIM EF-SPN... =

> =

> You're correct that netreg is the only consumer.  There was no need for
> anyone else to see this information.  However, this begs the question,
> why do you need the SPN data?

Some virtual operators are using the same MCC/MNC as their host, or some
operators have several different trade names, and these can have
different access settings (at least different UI visible name). =

SPN in SIM typically tells these cases apart. This is why I included
reading SPN to that example provisioning.

All provisioning plugins might not care about SPN (e.g. the previously
discussed one using mobile-broadband-provider-info?), so I would suggest
not creating specific SIM API yet. Of cause it can be added later, if so
wished.

--Jukka



--===============5521766742674649113==--

