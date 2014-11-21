Content-Type: multipart/mixed; boundary="===============4165902948309026243=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: Re: [PATCH 1/2] sms: Option HSO modem can't really do CNMA
Date: Fri, 21 Nov 2014 02:01:57 +0000
Message-ID: <87wq6pwbu2.fsf@ossau.homelinux.net>
In-Reply-To: <1416534506-19999-1-git-send-email-neil@ossau.homelinux.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4165902948309026243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Neil Jerram <neil@ossau.homelinux.net> writes:

> It appears the Option HSO modem can't really do CNMA, so ignore the
> fact that it returns 1 for the 'service' value in its response to
> AT+CSMS?

To add a bit of context to this patch...

This was triggered by the observation that oFono running on my GTA04
phone - which has an internal GTM601 Option HSO modem - cannot receive
incoming SMSes.

Investigation and comparison against another telephony stack (QtMoko aka
Qtopia) suggested that the key difference was in the CNMI command:

  Nov 20 23:36:06 neo Qtopia: AtChat :  T : "AT+CNMI=3D2,1,2,0,0" =


  ofonod[571]: App: > AT+CNMI=3D2,2,2,1,0\r

  +CNMI=3D[<mode>[,<mt>[,<bm>[,<ds>[,<bfr>]]]]]

  | CNMI | qtmoko | ofono |                                                =
                                                 |
  |------+--------+-------+------------------------------------------------=
-------------------------------------------------|
  | mode |      2 |     2 | 2 =3D buffer new Sms when TE-TA link is reserve=
d and flush them to TE after reservation           |
  |      |        |       |                                                =
                                                 |
  | mt   |      1 |     2 | 1 =3D +CMTI: <mem>,<index> routed to TE;       =
                                                   |
  |      |        |       | 2 =3D for all SMS_DELIVERs except class 2: +CMT=
: routed to TE; class 2 is indicated as in <mt>=3D1; |
  |      |        |       |                                                =
                                                 |
  | bm   |      2 |     2 | <bm>: same as <mt>, but for CBMs;              =
                                                 |
  |      |        |       |                                                =
                                                 |
  | ds   |      0 |     1 | 0 =3D No SMS-STATUS-REPORT are routed to TE;   =
                                                   |
  |      |        |       | 1 =3D SMS-STATUS-REPORTs are routed to TE, usin=
g +CDS                                             |
  |      |        |       |                                                =
                                                 |
  | bfr  |      0 |     0 | 0 =3D TA buffer is flushed to TE (if <mode>=3D1=
..3)                                                 |
  |      |        |       | 1 =3D TA buffer is cleared (if <mode>=3D1..3)  =
                                                     |
  |------+--------+-------+------------------------------------------------=
-------------------------------------------------|

oFono chooses 2 for the "mt" value, rather than 1, if it thinks that the
modem can do "CNMA", which I think means acknowledging each SMS after it
is transferred from the modem to the containing OS.  But:

- in practice the modem never generates the +CMT indications that are
  supposed to go with this mode of operation

- there are other places in the source code nearby where CNMA acking is
  skipped for OFONO_VENDOR_OPTION_HSO.

It seems this adds up to an indication that the modem doesn't really do
CNMA, and the patch that I've submitted does the trick and allows
incoming SMSes to be received successfully.

Thanks,
        Neil

--===============4165902948309026243==--

