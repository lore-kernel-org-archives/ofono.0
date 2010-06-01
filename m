Content-Type: multipart/mixed; boundary="===============7736381091406908858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issue in concatenated message
Date: Tue, 01 Jun 2010 10:12:44 -0500
Message-ID: <201006011012.44695.denkenz@gmail.com>
In-Reply-To: <AANLkTimIbC2W3fPoLy0sfJEnv46cwBSGBNUwLGB1UFiD@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7736381091406908858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Satya,

> Hi all,
> =

> While receiving concatenated message more than 30 segments, then 31st
> segment  is concatenated at the beginning of the message. After that (i.e.
> 32nd segment) remaining segments are concatenated after 30th segment. It =
is
> observed in ofono-0.21 version of oFono source. It is identified while
> sending message with 5000 characters using phonesim-1.2 (source code).

Thanks for reporting this.  The issue was related to signed int usage when =

finding the insertion position for the fragment.  This has now been fixed =

upstream.

Regards,
-Denis

--===============7736381091406908858==--

