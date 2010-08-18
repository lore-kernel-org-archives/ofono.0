Content-Type: multipart/mixed; boundary="===============6172270410975740377=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC_PATCH 4/4] smsutil: added function for data handling of
 status report
Date: Wed, 18 Aug 2010 13:11:02 -0500
Message-ID: <4C6C2236.2050007@gmail.com>
In-Reply-To: <201008182053.08551.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6172270410975740377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

>> If we can write / read the node structure directly, then I'm actually
>> thinking we won't be needing this patch at all.
> =

> OK. We'll get nicer code-solution with packed node-structure, and get rid=
 of =

> memcopies etc.  So, could it be that I'll just send you updated [PATCH 2/=
4], =

> and that's only needed patch with status report backup-files?
> =


Sounds like it should be sufficient.  Lets go in this direction and mop
up any further issues afterwards.

Regards,
-Denis

--===============6172270410975740377==--

