Content-Type: multipart/mixed; boundary="===============6515675131148660822=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Reg: Memory capacity exceeded
Date: Mon, 20 Sep 2010 15:39:57 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A519E5@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTi=Mo_RcFNXfoPUhFpXE5JWuDF=cJ-cn48LjR9ab@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6515675131148660822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Of course, one can argue whether this feature really has some real =

> world relevance or is purely theoretical.
>
> I wonder if it is a type approval requirement to support?

> I'm afraid there is a PICS case for this thing. I cannot recall how we
got N900 through this particular hoop, but probably we just waived this
particular test case irrelevant.

correct. There is a USIM conformance case on this message capacitiy
exceeded information. As per the 3GPP 31.121 specification section 8.2:

"If all SMS data field are full and furthermore all memory capacity
reserved for SMS inside the ME is filled up to maximum and a SM(Short
Message) was rejected, then this shall be indicated in the SMS Status
file.(EFsmss)"

For more information on this, refer 3GPP TS 31.121 section 8.2

There is also test cases related to SMS read from USIM. =


Regards,
jeevaka

--===============6515675131148660822==--

