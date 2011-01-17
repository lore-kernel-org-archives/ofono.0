Content-Type: multipart/mixed; boundary="===============6705264588414321340=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Mon, 17 Jan 2011 16:21:42 +0200
Message-ID: <AANLkTi=AOhqrCET83GrJ3pYHdZOSfkmEGV-qQMJyCbRS@mail.gmail.com>
In-Reply-To: <4D277F2B.8070102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6705264588414321340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

2011/1/7 Denis Kenzior <denkenz@gmail.com>:
>> Considering that from a modem standpoint the CID race condition can be r=
esolved,
>> some modem implementation may not have reserved a range of CID for their=
 own purpose,
>> or may not provide a mechanism to reserve a range of CID.
>
> If the CGDCONT race is guaranteed to be solved by the modem
> manufacturers, great. =C2=A0Unfortunately that is not the only race prese=
nt.
> =C2=A0Hint: The gatchat implementation uses non-blocking IO, select and a
> command queue. =C2=A0So it is fully possible for oFono to reserve a CID, =
send
> out a driver activation request, but receive a network initiated context
> activation / default bearer activation before the CGDCONT was even sent.
>
> Having cid ranges that do not overlap seems the safest approach to me
> right now. =C2=A0Unless someone has a better idea...

The 27.007 for release 9 (from version 9.3.0 onwards) says:

NOTE 1: The <cid>s for network-initiated PDP contexts will have values
outside the ranges indicated for the
<cid> in the test form of the commands +CGDCONT and +CGDSCONT.

The change was proposed by STE last February.

This has some ramifications on how we use the CIDs within driver/core.

-- =

Pekka.Pessi mail at nokia.com

--===============6705264588414321340==--

