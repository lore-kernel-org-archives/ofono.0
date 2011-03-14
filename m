Content-Type: multipart/mixed; boundary="===============5655175316734333220=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: Setting PDP mode
Date: Mon, 14 Mar 2011 10:13:40 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC2D0C3D@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D7A4BC6.7030203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5655175316734333220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> The protocol selection (IP, IPv6 or dual stack IPv4 & IPv6 =

> combined) is
> currently work in progress, but we support IP contexts already. =


If by "work in progress" you're referring to my IPv6 patches, the progress =
is pretty much stalled due to lack of response from you or Marcel for a cou=
ple of months now. Are you planning to review and/or push the patches or no=
t? The next time I will send a patch, it will be to remove the work item fr=
om the TODO list due to lack of interest from maintainers.

> oFono does not allow you to select the actual protocol used to talk to
> the modem (e.g. PPP, high-speed, or some vendor specific) for gprs
> contexts.  In fact it does not even care itself.  It is up to =

> the modem
> driver to figure out the best protocol for that particular modem.

Just FYI, PPP is a valid PDP context type, where the PPP protocol terminate=
s on the network side instead of in the modem. AFAIK, this configuration is=
 not widely supported by cellular operators, though.

	MikaL

--===============5655175316734333220==--

