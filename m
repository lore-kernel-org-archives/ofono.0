Content-Type: multipart/mixed; boundary="===============6555071963390571688=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] Use %m instead of strerror() in syslog messages
Date: Thu, 25 Nov 2010 13:12:20 +0100
Message-ID: <1290687140.4795.2.camel@aeonflux>
In-Reply-To: <1290682265-11373-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6555071963390571688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> strerror() is not thread-safe, nor in the glibc implementation,
> nor in the POSIX specification. In my experience, it will infrequently
> crash when another thread uses locale data in any way, including
> string formatting and such...

I have no problem with this ...

> Since the Huawei driver uses thread, we might as well avoid strerror().

..., but what are you talking about? Where is it using threads?

Regards

Marcel



--===============6555071963390571688==--

