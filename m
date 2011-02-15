Content-Type: multipart/mixed; boundary="===============6148798910574982427=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 01/18] gisi: pipe and pep for wgmodem2.5
Date: Tue, 15 Feb 2011 15:23:28 +0200
Message-ID: <201102151523.28930.remi.denis-courmont@nokia.com>
In-Reply-To: <f492c9a7397b927f36e345450bd884bbb37a10fd.1297772944.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6148798910574982427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 15 February 2011 14:30:55 ext Andreas Westin, you wrote:
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>

I don't understand why you put a pipe controller in user-space. Why do we n=
eed =

a pipe controller at all? As far as I can tell, implementing connect() on P=
EP =

sockets would be much more elegant (and symmetric).

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6148798910574982427==--

