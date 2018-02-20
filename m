Content-Type: multipart/mixed; boundary="===============3276541648311130512=="
MIME-Version: 1.0
From: Bassem BOUBAKER <bassem.boubaker@actia.fr>
Subject: RE: Issue with service reporting on a 4G modem
Date: Tue, 20 Feb 2018 09:44:08 +0000
Message-ID: <AM4PR01MB18736B32DD3AC54D61D117B19CCF0@AM4PR01MB1873.eurprd01.prod.exchangelabs.com>
In-Reply-To: <c2267ed4-5ae8-e7db-565e-9c694aa138ad@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3276541648311130512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

Exactly, my modem is creating an additional ethernet interface, and I don't=
 know why.

Please find in the link below the full log of connman.

https://ufile.io/dmgbw

Thanks,
Bassem.

>> Hello community,
>> =

>> I'm having connman version 1.31 along side with ofono running on my boar=
d.
>> =

>> When I activate a context on my 4G modem using ofono, connman creates tw=
o services: one is cellular and the other is ethernet.
>> =

>> *AR Wired ethernet_XX_cable
>> *AO XXX cellular_XXX_context1
>> =

>> In this case, the ideal state is that connman reports only one cellular =
technology related to the modem.
>> =

>> When digging into the logs, I feels like a new ethernet device is enumer=
ated and connman creates the appropriate service for it.
>> =

>> Knowing that my modem net interface is using "cdc_ether" driver, does an=
yone have an idea about what could be the issue here?
>
>=C2=A0From you description I understand that the modem creates an addition=
al =

>ethernet interface? Could you post the corresponding logs (or post a =

>link to the logs)?
>
>I am also not sure what the exact question is. I suspect you want to see =

>only one interface and not two..
>
>Thanks,
>Daniel
   =20
--===============3276541648311130512==--

