Content-Type: multipart/mixed; boundary="===============4761528327373818571=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC v3] Readout technology form Option HSO modems
Date: Wed, 09 Jun 2010 15:06:00 +0200
Message-ID: <4C0F91B8.9090306@monom.org>
In-Reply-To: <20100609113456.GA9175@pc0043.bmw-carit.intra>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4761528327373818571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> This version just relys on CREG appearing _after_ the OCTI OSSYSI
> [OUWCTI] sequence. I've uploaded a log of the current version with
> timestamps added.
>
> http://pastebin.com/qUMsh6sk
>
> An intereseting sequence in the log file is from line 376 to 401.
> This is roaming from 2g to 3g, but OUWCTI is comming late
> so that CREG doesn't pick up the late OUWCTI. On line 396 then
> OUWCTI appears (2 seconds after CREG) but the next CREG is 28 seconds
> away.

Here is another log with a lot of roaming.

http://pastebin.com/LZhHSkmK

There are many OUWCTI withouth OCTI OSSYSI updates. It toggles between =

UMTS and HSPA. connman_netreg_status_notify is called very seldom =

because there is no CREG. So this approach doesn't work good enough.

I think at least updates on OUWCTI should immediately use =

connman_netreg_status_notify.

What about having a separate connman_netreg_tech_notify call? This would =

make the code here much simpler? And Huawei modems could also use the =

same function for tech updates.

cheers,
daniel


--===============4761528327373818571==--

