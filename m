Content-Type: multipart/mixed; boundary="===============4851401753622894188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming patch HS2330 detection, plugins/udev.c
Date: Thu, 30 Jun 2011 01:47:24 -0500
Message-ID: <4E0C1BFC.8060904@gmail.com>
In-Reply-To: <1309437084-3062-1-git-send-email-ofonoconn@encambio.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4851401753622894188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 06/30/2011 07:31 AM, Michael Schloh von Bennewitz wrote:
> This patch is assembled according to discussions on #ofono
> irc.freenode.net and mailing list thread 'Problem detecting/using wwan0
> modem' in June 2011, after comprehensive guidance from Denis KENZIOR.
> =

> Denis had already modified plugins/udev.c in git commit
> 6a2847f7aba5d84b06940ee29300d4b6fd31d682 to correct detection of
> OEM Ericsson F3607gw modems relabeled by HP and sold as HS2330.
> Because some (or all?) HS2330 modems contain flawed text identifiers
> containing strange (probably erroneous) binary sequences in place of
> the ASCII space '\x20' character, the previous commit is incomplete.
> The following logic detects the modem properly, by comparing binary
> data as well as ASCII text values.
> =


Patch has been applied with a slightly reformatted commit message.

Regards,
-Denis

--===============4851401753622894188==--

