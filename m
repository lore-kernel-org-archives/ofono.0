Content-Type: multipart/mixed; boundary="===============0884088290606974606=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH 01/18] gisi: pipe and pep for wgmodem2.5
Date: Wed, 16 Feb 2011 10:27:00 +0100
Message-ID: <4D5B9864.3010100@stericsson.com>
In-Reply-To: <201102151523.28930.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0884088290606974606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 2011-02-15 14:23, R=C3=A9mi Denis-Courmont wrote:
> On Tuesday 15 February 2011 14:30:55 ext Andreas Westin, you wrote:
>> From: Jessica Nilsson<jessica.j.nilsson@stericsson.com>
>
> I don't understand why you put a pipe controller in user-space. Why do we=
 need
> a pipe controller at all? As far as I can tell, implementing connect() on=
 PEP
> sockets would be much more elegant (and symmetric).
>
Previously there was no pipe controller in the kernel so we needed one =

in ofono.

We are looking into changing it.

Regards
Andreas

--===============0884088290606974606==--

