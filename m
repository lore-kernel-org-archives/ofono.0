Content-Type: multipart/mixed; boundary="===============2329076744529360366=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/3] Use %m instead of strerror() in syslog messages
Date: Thu, 25 Nov 2010 15:28:13 +0200
Message-ID: <201011251528.13093.remi.denis-courmont@nokia.com>
In-Reply-To: <1290687140.4795.2.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2329076744529360366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 25 November 2010 14:12:20 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> > strerror() is not thread-safe, nor in the glibc implementation,
> > nor in the POSIX specification. In my experience, it will infrequently
> > crash when another thread uses locale data in any way, including
> > string formatting and such...
> =

> I have no problem with this ...
> =

> > Since the Huawei driver uses thread, we might as well avoid strerror().
> =

> ..., but what are you talking about? Where is it using threads?

Hmm, yeah. I misread the code. That comment is wrong.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============2329076744529360366==--

