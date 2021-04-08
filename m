Content-Type: multipart/mixed; boundary="===============0358971116244384014=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Quectel EC25 vs. ofonod 1.29 (on PinePhone)
Date: Thu, 08 Apr 2021 20:34:47 +0200
Message-ID: <20210408183447.GA7673@duo.ucw.cz>
In-Reply-To: <20210407235127.2848.76714@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0358971116244384014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> =

> I can only speak for Ubuntu Touch and Plasma Mobile, but we're using the =
QMI interface provided by the EG25G. We had more trouble trying to use the =
AT interface than it seemed worth working on. One problem was, indeed, havi=
ng trouble receiving the RING indication reliably. Another was trying to ge=
t WWAN set up correctly.
> =

> Ubuntu Touch messily applies QMI call patches to oFono in a branch on our=
 GitHub repository of it: https://github.com/ubports/ofono/tree/xenial_-_ed=
ge_-_pine. I'll send another reply once I know where Plasma Mobile gets its=
 builds. Hopefully they've got a bit cleaner commit log.
>

Thank you for the information. I assume... even if I fixed
modem<->ofono communication, there would be still nontrivial work
involved getting the audio to work... right?


> You will have problems with the modem further than you're having now, tho=
ugh: for one, it likes to fall off of USB every now and again when waking f=
rom sleep. We're currently investigating this issue since all PinePhone ope=
rating systems have devised workarounds that are far more complicated than =
the issue seems to warrant. If you want to talk more PinePhone development,=
 I recommend you join us at #pinedev on freenode or #pine-dev:matrix.org

I can do irc.

Best regards,
								Pavel
-- =

http://www.livejournal.com/~pavelmachek

--===============0358971116244384014==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWUc5TXh3QUtDUkF3NS9CcWxkdjYKOHIydUFLQ2FlN0s5Y2o5NGMy
S3NkenowNjd0ZGhMZElxd0NlSzhMZVV3MjFEMUpkRWdUOFVWbWNwL3h2NUtvPQo9c3FIOAotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============0358971116244384014==--

