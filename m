Content-Type: multipart/mixed; boundary="===============5927177448360166119=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: failed to download source code!
Date: Fri, 22 May 2009 10:00:34 +0300
Message-ID: <200905221000.34635.remi.denis-courmont@nokia.com>
In-Reply-To: <a0b5f4b30905211808u31beacf7w7f2021e078370127@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5927177448360166119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


	Hello,

On Friday 22 May 2009 04:08:00 ext WuYongbo wrote:
> Initialized empty Git repository in /home/ubuntu/ofono/.git/
> git.kernel.org<http://git.kernel.org/>[0: 130.239.17.7]: errno=3DConnecti=
on
> timed out fatal: unable to connect a socket (Connection timed out)

It looks like a firewall on your end is blocking the git protocol.

I would recommend using HTTP instead, but it seems the HTTP repository is =

broken: git complains about missing infos/refs :(

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki


--===============5927177448360166119==--

