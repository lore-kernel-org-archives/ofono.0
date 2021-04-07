Content-Type: multipart/mixed; boundary="===============8551120689683736190=="
MIME-Version: 1.0
From: dalton@ubports.com
Subject: Re: Quectel EC25 vs. ofonod 1.29 (on PinePhone)
Date: Wed, 07 Apr 2021 23:51:27 +0000
Message-ID: <20210407235127.2848.76714@ml01.vlan13.01.org>
In-Reply-To: <20210407225642.GA23328@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8551120689683736190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

I can only speak for Ubuntu Touch and Plasma Mobile, but we're using the QM=
I interface provided by the EG25G. We had more trouble trying to use the AT=
 interface than it seemed worth working on. One problem was, indeed, having=
 trouble receiving the RING indication reliably. Another was trying to get =
WWAN set up correctly.

Ubuntu Touch messily applies QMI call patches to oFono in a branch on our G=
itHub repository of it: https://github.com/ubports/ofono/tree/xenial_-_edge=
_-_pine. I'll send another reply once I know where Plasma Mobile gets its b=
uilds. Hopefully they've got a bit cleaner commit log.

You will have problems with the modem further than you're having now, thoug=
h: for one, it likes to fall off of USB every now and again when waking fro=
m sleep. We're currently investigating this issue since all PinePhone opera=
ting systems have devised workarounds that are far more complicated than th=
e issue seems to warrant. If you want to talk more PinePhone development, I=
 recommend you join us at #pinedev on freenode or #pine-dev:matrix.org
--===============8551120689683736190==--

