Content-Type: multipart/mixed; boundary="===============8029729701106086803=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: CEREG support for LTE network status reporting
 in AT modem
Date: Tue, 22 Feb 2011 10:35:19 -0600
Message-ID: <4D63E5C7.9010804@gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9F98CA08@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8029729701106086803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/22/2011 10:08 AM, Soum, RedouaneX wrote:
> Hi guys,
> =

> =

>>> I agree with you , both bearers are almost similar.Minor difference i
>>> see are context managment (especially default context creation) and some
>>> eps related spill over on other existing atoms (For ex SIM would not
>>> contain some ISIM (IMPU/IMPI)related stuff).My idea is seperate atoms
>>> solution would even work for legacy switch back(CSFB) too with a minimal
>>> impact on exiting architecture.Your comments on these ideas would also
>>> very valuable here as i assume you have real modem unlike me.
>>>
>> My main concern is about LTE only modems, these ones would not register =
gprs
>> atom so all stuff from gprs atom needs to be done in eps atom, plus CEREG
>> and initial PDN. Than if you have a mix modem with 3G and LTE than all t=
his "stuff"
>> would be done twice without some additional logic. Sounds complicated to=
 me.
>> About initial PDN, acually I think it can be placed in gprs atom
>> too, it won't influence 3G modems at all and we have +CGEV: handling the=
re already
>> (maybe not the strongest argument but would make things easier).
> =

> I agree, the differences between 2G/3G and LTE are not so big so it'll be=
 better if we keep the logic in the existing atoms.
> A lot of LTE AT commands were extended from 2G/3G to support LTE.
> =

> A good approach would be to extend netreg and gprs atoms to handle lte in=
cluding initial default bearer (as part of attach procedure) and dedicated =
bearers( secondary context in 2G/2G).
> =

> For the concepts that are not present in 2G and 3G, such as IMS related c=
oncepts then we can use a dedicated atom.

One thing to keep in mind about LTE is that we're not only looking to
support GSM style networks.  There are hybrid networks such as Verizon
which have CDMA/LTE mix.  From an API point of view it might not make
sense to expose unneeded GSM details in such situations.

There are also plenty of implementation details inside gprs atom
specific to gprs.  So for ease of implementation it might be sensible to
have a separate LTE atom anyway, even if it still implements the exact
same API.  We can factor out common context / bearer management into a
separate utility / atom if needed.

Regards,
-Denis

--===============8029729701106086803==--

