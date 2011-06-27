Content-Type: multipart/mixed; boundary="===============8419221202713011460=="
MIME-Version: 1.0
From: Michael Schloh von Bennewitz <ofonoconn@encambio.com>
Subject: Re: Problem detecting/using wwan0 modem
Date: Mon, 27 Jun 2011 21:32:04 +0200
Message-ID: <20110627193204.GB14786@debut.europalab.com>
In-Reply-To: <4E08BC04.3030105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8419221202713011460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Denis,

On Mon., June 27, 2011, Denis Kenzior wrote:
>> ...sorry I think before I mistyped the MeeGo 1.2 (current) ofono
>> version 0.48 as 0.58 incorrectly.
>>
>> But the output shown above is rather good, so I'm at a loss
>> to what could be wrong. Any ideas? Is connman relevant here?
>> =

>Based on the output above, the udev plugin needed to be modified to
>detect the HP version of the MBM modems.  The change can be found in
>commit: 6a2847f7aba5d84b06940ee29300d4b6fd31d682.  I'm also attaching
>this patch for your reference.  Please report back if this solves your
>issue.
>
Wow that's great. I haven't built a new package yet to test your
patch, but if I understand the logic correctly it should solve
the problem. I'll let you know what happens after I'm done.

>>From 6a2847f7aba5d84b06940ee29300d4b6fd31d682 Mon Sep 17 00:00:00 2001
> [...]
> plugins/udev.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
>diff --git a/plugins/udev.c b/plugins/udev.c
>index 1580b02..8ea937c 100644
>--- a/plugins/udev.c
>+++ b/plugins/udev.c
>[...]
>
Thanks,
Michael

--===============8419221202713011460==--

