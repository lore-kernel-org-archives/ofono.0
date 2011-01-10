Content-Type: multipart/mixed; boundary="===============8868953016413726649=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Mon, 10 Jan 2011 10:01:57 +0200
Message-ID: <201101101001.57882.remi.denis-courmont@nokia.com>
In-Reply-To: <1294434331.2501.25.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8868953016413726649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 07 January 2011 23:05:31 ext Marcel Holtmann, you wrote:
> I don't even like the fact that we imported it in ConnMan. That might
> have been a mistake actually. I really prefer to have that on the
> filesystem and we just mmap() it. And it is up to the distribution to
> provide such a file.
> =

> We do a similar thing with OUI for BlueZ, so that is clearly the better
> approach here.

So I guess there are two different things here:
- whether oFono should parse that file,
- whether oFono should ship that file.

I guess you're arguing that oFono shouldn't ship the file, but it could sti=
ll =

parse it from a known location.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============8868953016413726649==--

