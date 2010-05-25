Content-Type: multipart/mixed; boundary="===============3428703426582057869=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: Testing asset for oFono
Date: Tue, 25 May 2010 23:34:31 +0300
Message-ID: <1274819671.3755.401.camel@tucson.research.nokia.com>
In-Reply-To: <1269958939.2432.44.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3428703426582057869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-03-30 at 16:22 +0200, Niemi Aki (Nokia-D/Helsinki) wrote:
> There are currently a bunch of helper scripts under /test for the D-Bus
> API in addition to unit tests, and I'm wondering if there are any plans
> to automate especially the former into a suite that could be run
> semi-regularly, or even at 'make distcheck'?
> =

> I think it would be useful to have something like the current scripts,
> but modified to be actual test cases as well as more easily
> parametrized.

Returning to this old thread -- this was recently published:
http://meego.gitorious.org/meego-cellular/blts-ofono

It is a functional test suite for oFono. At least some parts of it might
actually make sense to have included in the oFono source tree.

Cheers,
Aki


--===============3428703426582057869==--

