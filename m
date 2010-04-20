Content-Type: multipart/mixed; boundary="===============4717715732721203735=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Tue, 20 Apr 2010 23:03:12 +0200
Message-ID: <i2kfb249edb1004201403saee6351eqc3df2260e1bff89e@mail.gmail.com>
In-Reply-To: <201004201555.33596.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4717715732721203735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20 April 2010 22:55, Denis Kenzior <denkenz@gmail.com> wrote:
>> > So I re-read that part of the spec, and I can see why we might want it.
>> > However, this quote seemed rather interesting: "Le set to '00' indicat=
es
>> > that the terminal expects to receive at most the maximum number of byt=
es,
>> > i.e. 256, in the response ADPU. The UICC may return any number of bytes
>> > in the range 1 to 256."
>> >
>> > Shouldn't that 'FF' be changed to '00'? =C2=A0Also, you might want to =
include
>> > the relevant passage or Spec/Section reference in this code so we don't
>> > wonder where it came from in the future.
>>
>> Attached patch adds a comment and changes the FF to 00. =C2=A0I guess it=
 is
>> largely theoretical right now. =C2=A0The issue again with "any number of
>> bytes in the range 1 to 256" is that this prohibits an empty response,
>> which we want to allow too :) =C2=A0 Maybe this should be a parameter of
>> driver->envelope()
>
> "The maximum number of bytes expected in the data part of the response AP=
DU is
> presented in the parameter Le, which is optional. This means that if the
> terminal does not expect any data in the response APDU Le is absent from =
the
> command"

Well, this is an "if" without "only then" so it doesn't tell us the
meaning of Le being absent.  Additionally the whole passage is later
invalidated in 11.2.2.2, so the SIM implementer really has all the
possible options.

>
> The question really becomes, do we actually want a response and know what=
 to
> do with it?

We only use envelope in CBS data download right now which expects no
response, we could indicate that in a parameter.

Best regards

--===============4717715732721203735==--

