Content-Type: multipart/mixed; boundary="===============0625001077007925845=="
MIME-Version: 1.0
From: M. Dietrich <ofono@emdete.de>
Subject: Re:  fix for +CMER parser of AT driver (fixes registration)
Date: Sat, 19 Jan 2013 19:28:30 +0100
Message-ID: <20130119182830.GT3604@emdete.de>
In-Reply-To: <50F9E334.4090901@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0625001077007925845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Jan 18, 2013 at 06:05:08PM -0600, Denis Kenzior wrote:
> Case in point your patch, which doesn't even contain a code comment block=
 on
> what it is trying to accomplish.

i understood the response of the modem follows the spec so i thought this w=
ould
be standard. but you are deeper in the specs and i won't tell otherwise.

> (And by the way your coding style is still wrong in several places...)

i just tried to intuitively follow the code standard i found in ofono, sorr=
y if
i got that wrong.

> So far you are the first to report a modem that behaves in this manner wh=
en
> it comes to parameter lists.

yes, because i am probably the first that investigated the problem in depth=
. i
saw alot of complains that the registration state is not reached from many
ofono users. cause for that is exactly the +CMER answer of those modems.

as the modem in question is used in many thinkpads and other notebooks i as=
sume
that the many people can't use ofono out of this reason.

so what do you suggest to support this modem? how would a quirk as you
suggested look like?


regards,
	michael

-- =

M. Dietrich

--===============0625001077007925845==--

