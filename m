Content-Type: multipart/mixed; boundary="===============7220063068513999993=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Quectel EC25 vs. ofonod 1.29 (on PinePhone)
Date: Thu, 08 Apr 2021 00:56:42 +0200
Message-ID: <20210407225642.GA23328@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7220063068513999993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'm fighting with Quectel EG25 modem (included in PinePhone).

AT+CGMM                                                                    =
     =

EG25                                                                       =
     =

                                                                           =
     =

OK                                                                         =
     =


ofonod 1.29 does not provide incoming calls indication. (Incoming
messages seem to work okay).

Talking to modem directly... I don't see "RING" either.

Best I can do is get CDIP notification, and then ask using CLCC...

+CDIP: "",128                                                              =
     =

AT+CLCC                                                                    =
     =

+CLCC: 1,1,0,1,0,"",128                                                    =
     =

+CLCC: 2,1,4,0,0,"+420XXXXXXX",145                                         =
   =

                                                                           =
     =

OK                                                                         =
     =

                                                                           =
     =


If someone knows what is going on there... let me know.

(It is possible that the modem has also QMI interface...?
https://wiki.merproject.org/wiki/Adaptations/PinePhone64#Modem_EC25)

Best regards,
									Pavel

-- =

http://www.livejournal.com/~pavelmachek

--===============7220063068513999993==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlGMEVBQkVDQUIwV0lRUlBmUE83cjBlQWhr
MDEwdjB3NS9CcWxkdjY4Z1VDWUc0NHFnQUtDUkF3NS9CcWxkdjYKOGlpMEFKOUtYQlpGaHZuVGth
ME90QnZsait2eGZrNEZnUUNmY0xkSVMzMVFDRDRBMzlEMGJtNXNUT3JkNkF3PQo9bkgyOAotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============7220063068513999993==--

