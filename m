Content-Type: multipart/mixed; boundary="===============5465036204374638152=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Reg: Memory capacity exceeded
Date: Mon, 20 Sep 2010 07:44:45 -0500
Message-ID: <4C97573D.90406@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A519E5@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5465036204374638152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/20/2010 07:39 AM, Jeevaka.Badrappan(a)elektrobit.com wrote:
> Hi,
> =

>> Of course, one can argue whether this feature really has some real =

>> world relevance or is purely theoretical.
>>
>> I wonder if it is a type approval requirement to support?
> =

>> I'm afraid there is a PICS case for this thing. I cannot recall how we
> got N900 through this particular hoop, but probably we just waived this
> particular test case irrelevant.
> =

> correct. There is a USIM conformance case on this message capacitiy
> exceeded information. As per the 3GPP 31.121 specification section 8.2:
> =

> "If all SMS data field are full and furthermore all memory capacity
> reserved for SMS inside the ME is filled up to maximum and a SM(Short
> Message) was rejected, then this shall be indicated in the SMS Status
> file.(EFsmss)"

The thing is, oFono configures SMS for direct delivery (e.g. no SM/ME
storage).  And even if direct delivery does not work (e.g. crappy modem
or Class 2 / Class 3 messages) oFono still removes the SMS as soon as it
is delivered.  We should never hit a sim/me memory full conditions.

So I don't see how this test case even applies.

Regards,
-Denis

--===============5465036204374638152==--

