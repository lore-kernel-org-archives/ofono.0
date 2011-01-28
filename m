Content-Type: multipart/mixed; boundary="===============5597800163456116776=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC 1/5] gprs: Update documentation for IPv6
Date: Fri, 28 Jan 2011 16:43:28 +0200
Message-ID: <201101281643.29136.remi.denis-courmont@nokia.com>
In-Reply-To: <1296224224.1520.175.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5597800163456116776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 28 January 2011 16:17:04 ext Marcel Holtmann, you wrote:
> I am not sure it is a good idea to make ConnMan do that. For IFX, I was
> actually considering just piping the two RawIP streams into one network
> interface. That seems easy enough.
> =

> And to be honest for PPP, just doing IPv4 seems acceptable since PPP is
> bad idea in the first place. It is a limitation I am willing to accept.
> =

> My concern is also on how we handle the Tethering cases properly. I have
> not yet spent enough time to think about it, but I have concerns here.
> =

> So right now I would prefer to sit ipv6 out until we have proper ipv4v6
> context support in the network and the modems.

I would want to do that too. But my current guesstimate is that we will hav=
e =

to support dual-stack before we can assume dual-stack support in both the =

networks and the modems.

This limitation might be acceptable for tethering though, which is the main =

customer for PPP.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============5597800163456116776==--

