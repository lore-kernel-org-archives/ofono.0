Content-Type: multipart/mixed; boundary="===============6355721832260870204=="
MIME-Version: 1.0
From: M. Dietrich <ofono@emdete.de>
Subject: Re:  fix for +CMER parser of AT driver (fixes registration)
Date: Fri, 18 Jan 2013 23:44:52 +0100
Message-ID: <20130118224452.GS3604@emdete.de>
In-Reply-To: <50F76FD6.30008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6355721832260870204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 16, 2013 at 09:28:22PM -0600, Denis Kenzior wrote:
> It is only a problem if the modem is broken, in which case you need to
> use a quirk and parsing the result of CMER=3D? is likely unnecessary.
> For broken devices it is likely easier to simply skip CMER probing and
> just set the wanted CMER settings.

i assume more or less all modems are in one or the other way
"broken". even the spec is (in my opinion) broken.

so if only the output of an option list just does not follow the spec
but most other stuff of the modem works fine why not be more tolerant
parsing the option list?

if you instead have a quirk for this and only this modem you fixed only
a single one. i assume that also other modems are broken in this way and
fixing it in the parser would enable more modems to work.

> >marcel already pointer out that a generic aproach may be
> >unnecessarily complex where i agree if it comes to strings and nested
> >brackets but for plain integer cases it would be quite useful to get
> >this done in one place for all. if interested i could implement such
> >stuff into gatchat/gatresult.c which then can be used for the
> >integer-only cases. what do you think?
> Not sure what you're asking here, can you elaborate?

the AT parser code for the option list is redundant, a re-use of a
single implementation would make some sense and i offered a more generic
way of parsing an option list. marcel pointed out that a completly
generic parser would be unnecessarily complex and i agree. so i suggest
a re-usable code for integer option lists.

anyway i would like to see the patch in ofono. on the one side it does
not break any existing modem, on the other side it makes some modem
work.

regards,
	michael

-- =

M. Dietrich

--===============6355721832260870204==--

