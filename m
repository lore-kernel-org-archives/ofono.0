Content-Type: multipart/mixed; boundary="===============5539909188020902373=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 10:50:03 +0200
Message-ID: <201101071050.03794.remi.denis-courmont@nokia.com>
In-Reply-To: <1294272721.2521.34.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5539909188020902373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 06 January 2011 02:12:01 ext Marcel Holtmann, you wrote:
> > If such context is not found create a new one with "Internet" type.
> =

> I don't really agree that we should create a context if no match is
> found. I think the better sensible strategy is to hold this information
> internally and only map it to a context once the user or provisioning
> creates it.

Indeed. Alternatively, we could have a dedicated type, e.g. "Unknown". Usin=
g =

the Internet type is only likely to confuse the connection manager.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5539909188020902373==--

