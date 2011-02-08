Content-Type: multipart/mixed; boundary="===============0915266582469802524=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFC 0/1] use fsync in storage
Date: Tue, 08 Feb 2011 14:45:36 +0200
Message-ID: <201102081445.36710.remi.denis-courmont@nokia.com>
In-Reply-To: <A459777776EB4841B844E1134E7928740157FC4A@008-AM1MPN1-016.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0915266582469802524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 February 2011 14:25:17 ext mikhail.zabaluev(a)nokia.com, you =

wrote:
> Hi,
> =

> > -----Original Message-----
> > From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> > Behalf Of ext R=C3=A9mi Denis-Courmont
> > Sent: Tuesday, February 08, 2011 2:04 PM
> > To: ofono(a)ofono.org
> > Subject: Re: [RFC 0/1] use fsync in storage
> > =

> > On Tuesday 08 February 2011 13:47:51 ext Kai Vehmanen, you wrote:
> > > 3) Is it ok, build-wise, for ofono to require availability
> > =

> > fdatasync()
> > =

> > >    (which I think would be sufficient in this case and slightly
> > >    less expensive).
> > =

> > I would use fdatasync().
> =

> What about ensuring that file metadata are synced as well (e.g. the file
> itself cannot be lost on the filesystem)?

fdatasync() syncs the data and the metadata NEEDED TO READ the data afterwa=
rd, =

which includes the file directory entry and file size (in practice, I guess=
 most =

filesystems implement both the same).

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============0915266582469802524==--

