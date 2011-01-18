Content-Type: multipart/mixed; boundary="===============1391869600267864065=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Wed, 19 Jan 2011 00:08:01 +0200
Message-ID: <AANLkTikjpeNkcdf3rXa4TV-Arhudh1AJWAviTgfZwk6d@mail.gmail.com>
In-Reply-To: <4D360B38.9030107@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1391869600267864065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/1/18 Denis Kenzior <denkenz@gmail.com>:
>> 2011/1/18 Denis Kenzior <denkenz@gmail.com>:
>>> I think we can track the cached flag for conditional CFs independently
>>> from CFU. =C2=A0The question is really whether the networks allow us to
>>> modify conditional CFs when CFU is active. =C2=A0In my testing the answ=
er is No.
>>
>> You can erase (##67#) or deactivate (#67#) them.
>
> So CFB active.
>
> Activate CFU
> Query CFB -> Inactive
>
> Deregister CFB -> OK
> Query CFB -> Inactive
>
> Register CFB -> Error
>
> Deactivate CFU
> Query CFB -> Inactive
>
> Correct?

That is how I think it works.

> Jeez, who thought this stuff up.

> So my thinking is that we should:
> - Not update conditional cfs when cfu is active (whether via
> GetProperties or mmi)
> - only clear the conditional cache flag if a conditional operation is
> attempted and succeeds while cfu is active
> - Report conditional cfs as empty when CFU is active (and emit signals
> appropriately when cfu is activated / deactivated)
> - Don't bother running conditional cf queries via GetProperties if cfu
> is active
>
> Do you see any issues with this?

Nope, it sounds reasonable.

-- =

Pekka.Pessi mail at nokia.com

--===============1391869600267864065==--

