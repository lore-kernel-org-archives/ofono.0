Content-Type: multipart/mixed; boundary="===============3803119820625761824=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] atmodem: sim-auth atom driver.
Date: Fri, 21 Jan 2011 11:25:19 -0600
Message-ID: <4D39C17F.9050409@gmail.com>
In-Reply-To: <AANLkTi=J+3mGKBz3RrveP7t3Lcz3jhCL009TAxE-1_wv@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3803119820625761824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 01/21/2011 11:07 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2011/1/20 Denis Kenzior <denkenz@gmail.com>:
>> My view is that checking mallocs of small structures is pretty much
>> pointless on Linux.
> =

> =

> The glib functions that ofono uses extensively don't do any malloc
> checking, and it makes checking on the  ofono side bit pointless. If
> malloc fails, ofono will crash. If it has not get killed by oom
> police.
> =


Well the g_try_ series do allow you to recover from a bad malloc, which
is what we generally use.

Regards,
-Denis

--===============3803119820625761824==--

