Content-Type: multipart/mixed; boundary="===============7235716480101194621=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 0/1] use fsync in storage
Date: Tue, 08 Feb 2011 12:25:17 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157FC4A@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <201102081403.51243.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7235716480101194621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext R=C3=A9mi Denis-Courmont
> Sent: Tuesday, February 08, 2011 2:04 PM
> To: ofono(a)ofono.org
> Subject: Re: [RFC 0/1] use fsync in storage
> =

> On Tuesday 08 February 2011 13:47:51 ext Kai Vehmanen, you wrote:
> > 3) Is it ok, build-wise, for ofono to require availability
> fdatasync()
> >    (which I think would be sufficient in this case and slightly
> >    less expensive).
> =

> I would use fdatasync().

What about ensuring that file metadata are synced as well (e.g. the file it=
self cannot be lost on the filesystem)?

Best regards,
  Mikhail

--===============7235716480101194621==--

