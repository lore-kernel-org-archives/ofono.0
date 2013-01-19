Content-Type: multipart/mixed; boundary="===============3165852283466521560=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: fix for +CMER parser of AT driver (fixes registration)
Date: Fri, 18 Jan 2013 18:05:08 -0600
Message-ID: <50F9E334.4090901@gmail.com>
In-Reply-To: <20130118224452.GS3604@emdete.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3165852283466521560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> so if only the output of an option list just does not follow the spec
> but most other stuff of the modem works fine why not be more tolerant
> parsing the option list?
>

Actually we do not want to be tolerant.  If something is broken, we want =

to make sure that any work-around code-path is explicitly called out. =

There are many reasons for this, one of the main ones being code =

efficiency.  The other code readability.  Over time such 'workarounds' =

pollute the code base and make it ugly; and the reasons for why it is =

that way are either lost or become murky.  Case in point your patch, =

which doesn't even contain a code comment block on what it is trying to =

accomplish.  (And by the way your coding style is still wrong in several =

places...)

> if you instead have a quirk for this and only this modem you fixed only
> a single one. i assume that also other modems are broken in this way and
> fixing it in the parser would enable more modems to work.
>

I do not accept your assumption.  We have been using almost the exact =

same structure for parsing parameter lists in the SMS driver for over 3 =

years.  So far you are the first to report a modem that behaves in this =

manner when it comes to parameter lists.

Regards,
-Denis

--===============3165852283466521560==--

