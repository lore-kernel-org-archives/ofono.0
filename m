Content-Type: multipart/mixed; boundary="===============4809251550869778386=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 12/20] stkutil: Add the Call Control envelope builder
Date: Fri, 11 Jun 2010 22:04:21 +0200
Message-ID: <AANLkTimOSKfYuaotVLDAAak7TLaKV9zBJtxYS1wrSooc@mail.gmail.com>
In-Reply-To: <201006111434.35867.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4809251550869778386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11 June 2010 21:34, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
>
>> >> +/* Used both in the ENVELOPE message to UICC and response from UICC =
*/
>> >> +struct stk_envelope_call_control {
>> >> + =C2=A0 =C2=A0 /* Exactly one of the following 5 fields must be pres=
ent */
>> >
>> > Why are we not using a union then?
>>
>> We don't know which one of 5 is valid if it's a union. =C2=A0We could ad=
d a
>> field to indicate that but I guess it's simpler the way it is.
>
> It seems like a type + union might be better for the consumers of this
> structure though.

Okay, currenlty the UICC will be the only consumer but we may need to
be a consumer too, later.

Regards

--===============4809251550869778386==--

