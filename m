Content-Type: multipart/mixed; boundary="===============1199266419511111397=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: failed to download source code!
Date: Fri, 22 May 2009 09:43:41 -0700
Message-ID: <1243010621.3147.101.camel@localhost.localdomain>
In-Reply-To: <200905221000.34635.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1199266419511111397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi

> > Initialized empty Git repository in /home/ubuntu/ofono/.git/
> > git.kernel.org<http://git.kernel.org/>[0: 130.239.17.7]: errno=3DConnec=
tion
> > timed out fatal: unable to connect a socket (Connection timed out)
> =

> It looks like a firewall on your end is blocking the git protocol.
> =

> I would recommend using HTTP instead, but it seems the HTTP repository is =

> broken: git complains about missing infos/refs :(

forgot the update-server-info hook. Should be fixed now.

Regards

Marcel



--===============1199266419511111397==--

