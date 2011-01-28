Content-Type: multipart/mixed; boundary="===============0062475370761904480=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 16:41:05 +0200
Message-ID: <201101281641.05376.remi.denis-courmont@nokia.com>
In-Reply-To: <AANLkTi=wAzXyb7uqCCY-7sqhgoi_bSQeQAR1Kt6WoyVt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0062475370761904480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 28 January 2011 14:49:16 ext Sjur Br=C3=A6ndeland, you wrote:
> I think it would be nice if we could keep only one interface here.
> It's a bit messy that the difference between R7 and R8
> networks will be visible to the users like this.
> =

> So when in a R7 network the uplink traffic should be filtered into the
> right ipv4 and ipv6 pdp-connection automagically.
> I know STE will support this in the modem firmware.
> =

> If firmware doesn't support this perhaps this could also be handled
> in the kernel drivers. This should be doable for phonet (and Caif),

Not really no. The API to create a Phonet gprs interface is tightly coupled =

with the underlying pipe. There are no easy ways to patch the driver to use =

two pipes, nor the corresponding userspace code.

It would actually be much easier to write a bonding driver to rule both IPv=
4 =

and IPv6 instances of the existing driver. It would also be more generic, n=
ot =

Phonet/CAIF/PPP-specific, although it would probably not work for fake Ethe=
rnet =

devices.

However it is questionable why we would optimize this when the only custome=
r =

is ConnMan, and the only use case is 3GPP Rel7. Applications don't need to =

care whether IPv4 and IPv6 are through a single or two separate interfaces. =

They just use the socket API.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0062475370761904480==--

