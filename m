Content-Type: multipart/mixed; boundary="===============8729873670738110627=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] hdlc: handle wrapped buffers
Date: Tue, 27 Apr 2010 05:02:10 +0200
Message-ID: <1272337330.22838.128.camel@localhost.localdomain>
In-Reply-To: <1271543998.22838.34.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8729873670738110627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> So I like to see the patch series this way:
> =

> 1) Handle ringbuffer wrapping in HDLC
> 2) Add recording support for HDLC
> 3) Add ACCM support to HDLC
> 4) Port PPP to use HDLC

so I have done 1) now in a way that it is efficient and doesn't become
the bottle-neck for PPP. What is the status of the other 3 tasks?

Regards

Marcel



--===============8729873670738110627==--

