Content-Type: multipart/mixed; boundary="===============3242315637329250707=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC 0/1] use fsync in storage
Date: Tue, 08 Feb 2011 14:03:51 +0200
Message-ID: <201102081403.51243.remi.denis-courmont@nokia.com>
In-Reply-To: <1297165672-3217-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3242315637329250707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 February 2011 13:47:51 ext Kai Vehmanen, you wrote:
> 3) Is it ok, build-wise, for ofono to require availability fdatasync()
>    (which I think would be sufficient in this case and slightly
>    less expensive).

I would use fdatasync(). It would be trivial to alias it to fsync() from =

autoconf if needed. But currently, oFono core uses much less portable stuff=
, =

e.g. signalfd() anyhow.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============3242315637329250707==--

