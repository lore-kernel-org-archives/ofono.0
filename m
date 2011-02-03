Content-Type: multipart/mixed; boundary="===============3598441602387495838=="
MIME-Version: 1.0
From: mikhail.zabaluev@nokia.com
Subject: RE: [RFC 2/2] doc: Add description for history agent interface
Date: Thu, 03 Feb 2011 12:42:56 +0000
Message-ID: <A459777776EB4841B844E1134E7928740157B5EB@008-AM1MPN1-016.mgdnok.nokia.com>
In-Reply-To: <4D4A557C.1070302@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3598441602387495838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of ext Denis Kenzior
> Sent: Thursday, February 03, 2011 9:13 AM
> To: ofono(a)ofono.org
> Cc: Vehmanen Kai (Nokia-MS/Tampere)
> Subject: Re: [RFC 2/2] doc: Add description for history agent interface
> =

> Of course, fsync is the best you can do.  I'm just pointing out that
> even with fsync you're not guaranteed to 'safely' receive the SMS.  You
> can still get astronomically unlucky: fsync, ack the message but still
> crash before it has a chance to appear on the physical media or corrupt
> the filesystem some other way.

No, that should be taken care of by fsync and filesystem journaling in non-=
broken systems.
If your filesystem storage has a writeback cache that you cannot flush, you=
 are screwed no matter what you do, of course.

Best regards,
  Mikhail


--===============3598441602387495838==--

