Content-Type: multipart/mixed; boundary="===============6466488052788845820=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 12/20] stkutil: Add the Call Control envelope builder
Date: Fri, 11 Jun 2010 21:18:27 +0200
Message-ID: <AANLkTincE0TeBlPw8gnaNmOoRMK46USpW3XBHZ0aNWU6@mail.gmail.com>
In-Reply-To: <201006091757.48688.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6466488052788845820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 10 June 2010 00:57, Denis Kenzior <denkenz@gmail.com> wrote:
>> ---
>> =C2=A0src/stkutil.c | =C2=A0178
>> =C2=A0++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> src/stkutil.h |
>> =C2=A0 31 ++++++++++
>> =C2=A02 files changed, 207 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/stkutil.c b/src/stkutil.c
>> index 83ff5c7..b9a152a 100644
>> --- a/src/stkutil.c
>> +++ b/src/stkutil.c
>> @@ -319,8 +319,6 @@ static gboolean parse_dataobj_subaddress(struct
>> =C2=A0comprehension_tlv_iter *iter, unsigned int len;
>>
>> =C2=A0 =C2=A0 =C2=A0 len =3D comprehension_tlv_iter_get_length(iter);
>> - =C2=A0 =C2=A0 if (len < 1)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FALSE;
>
> This seems wrong. =C2=A0Can you point me to the test that uses empty suba=
ddresses?

I removed this from the new version of the patch.  Empty subaddress
("null object") is only used in the response to the Call Control
ENVELOPE (second half of section 7.3.1.6).

>
>> +/* Used both in the ENVELOPE message to UICC and response from UICC */
>> +struct stk_envelope_call_control {
>> + =C2=A0 =C2=A0 /* Exactly one of the following 5 fields must be present=
 */
>
> Why are we not using a union then?

We don't know which one of 5 is valid if it's a union.  We could add a
field to indicate that but I guess it's simpler the way it is.

>
>> + =C2=A0 =C2=A0 struct stk_address address;
>> + =C2=A0 =C2=A0 struct stk_address ss_string;
>> + =C2=A0 =C2=A0 struct stk_ussd_string {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char dcs;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const unsigned char *string;
>
> Please don't do that. =C2=A0These objects will be passed around like cand=
y and I
> don't want to deal with dangling pointers.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len;
>> + =C2=A0 =C2=A0 } ussd_string;
>
> The ussd string is limited to 160 bytes according to 23.038. =C2=A0So bre=
aking this
> out into a proper stk datatype like:
> struct stk_ussd_string {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char dcs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned char ussd[160];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int len;
> };
> would be better

Ok.  I'll resend these four patches and add the remaining ENVELOPEs.

Regards

--===============6466488052788845820==--

