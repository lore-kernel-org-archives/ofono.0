Content-Type: multipart/mixed; boundary="===============7944862493035560327=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Testing asset for oFono
Date: Tue, 30 Mar 2010 17:22:19 +0300
Message-ID: <1269958939.2432.44.camel@phoenix.elisa-laajakaista.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7944862493035560327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

There are currently a bunch of helper scripts under /test for the D-Bus
API in addition to unit tests, and I'm wondering if there are any plans
to automate especially the former into a suite that could be run
semi-regularly, or even at 'make distcheck'?

I think it would be useful to have something like the current scripts,
but modified to be actual test cases as well as more easily
parametrized.

The tests could then be driven with a set of parameters (which cases to
run, what numbers to call, etc.) and a default test profile to work
with, for example, the default phonesim configuration.

Other profiles could then be made for other test environments, such as a
live modem and a test network or network simulator.

Any thoughts on this? =


Cheers,
Aki


--===============7944862493035560327==--

