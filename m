Content-Type: multipart/mixed; boundary="===============6311480723473525730=="
MIME-Version: 1.0
From: Soum, RedouaneX <redouanex.soum@intel.com>
Subject: RE: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Tue, 22 Feb 2011 16:08:19 +0000
Message-ID: <8281606748F03E4390BB98A3F47F2E948A9F98CA08@irsmsx501.ger.corp.intel.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1E7BDF9@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6311480723473525730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,


>>I agree with you , both bearers are almost similar.Minor difference i
>>see are context managment (especially default context creation) and some
>>eps related spill over on other existing atoms (For ex SIM would not
>>contain some ISIM (IMPU/IMPI)related stuff).My idea is seperate atoms
>>solution would even work for legacy switch back(CSFB) too with a minimal
>>impact on exiting architecture.Your comments on these ideas would also
>>very valuable here as i assume you have real modem unlike me.
>>
>My main concern is about LTE only modems, these ones would not register gp=
rs
>atom so all stuff from gprs atom needs to be done in eps atom, plus CEREG
>and initial PDN. Than if you have a mix modem with 3G and LTE than all thi=
s "stuff"
>would be done twice without some additional logic. Sounds complicated to m=
e.
>About initial PDN, acually I think it can be placed in gprs atom
>too, it won't influence 3G modems at all and we have +CGEV: handling there=
 already
>(maybe not the strongest argument but would make things easier).

I agree, the differences between 2G/3G and LTE are not so big so it'll be b=
etter if we keep the logic in the existing atoms.
A lot of LTE AT commands were extended from 2G/3G to support LTE.

A good approach would be to extend netreg and gprs atoms to handle lte incl=
uding initial default bearer (as part of attach procedure) and dedicated be=
arers( secondary context in 2G/2G).

For the concepts that are not present in 2G and 3G, such as IMS related con=
cepts then we can use a dedicated atom.

Regards,




---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6311480723473525730==--

