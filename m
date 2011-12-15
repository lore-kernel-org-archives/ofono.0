Content-Type: multipart/mixed; boundary="===============9129873461759428529=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v3 12/16] elect: Add skeleton dial implementation
Date: Wed, 14 Dec 2011 19:15:29 -0600
Message-ID: <4EE94A31.50201@gmail.com>
In-Reply-To: <1323788410-9988-13-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9129873461759428529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 12/13/2011 09:00 AM, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> =

> ---
>  Makefile.am   |    3 +-
>  elect/dial.c  |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  elect/elect.h |   16 +++++++++++
>  3 files changed, 101 insertions(+), 1 deletions(-)
>  create mode 100644 elect/dial.c
> =


Personally I'm having trouble seeing what this abstraction is really
buying you.  There's really only one way to establish a PPP connection,
so much of this file is just overhead and can easily live inside
device.c.  But maybe I am missing something here...

Regards,
-Denis

--===============9129873461759428529==--

