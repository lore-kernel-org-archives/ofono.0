Content-Type: multipart/mixed; boundary="===============1695255888197426429=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 17/20] stkutil: Add the Event Download envelope builder
Date: Fri, 11 Jun 2010 21:27:37 +0200
Message-ID: <AANLkTimppyAsTK346PXxtdlRG0JF2DwvU-yMuKPLXxti@mail.gmail.com>
In-Reply-To: <201006092006.01114.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1695255888197426429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 10 June 2010 03:06, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Network Byte Order */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int ipv4;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guint32 ipv4;
>
> Why?

int has no guranteed size except at the ABI level.  So the SysV r4
ABIs for x86, ARM and amd64 make it 32-bit but you don't know what
happens elsewhere.  I'll remove this change as it's unlikely int will
be < 32-bit and if it's wider we don't care.  (I, too, prefer stdint
types like uint32_t).

>
>> @@ -799,7 +909,9 @@ struct stk_frame_layout {
>> =C2=A0 */
>> =C2=A0struct stk_frames_info {
>> =C2=A0 =C2=A0 =C2=A0 unsigned char id;
>> - =C2=A0 =C2=A0 unsigned char list[126];
>> + =C2=A0 =C2=A0 struct {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int width, height;
>
> do you mean unsigned char here?

I'll change it to char, a;though int isn't bad as these are integers
(something you can perform arithmetics on, not like an 8-bit
identifier).

>
>> + =C2=A0 =C2=A0 } list[66];
>
> Do you mean 63 here?

Yes :)

>
>> =C2=A0 =C2=A0 =C2=A0 unsigned int len;
>> =C2=A0};
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct stk_reader_status car=
d_reader_status;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *language_selecti=
on;
>
> Per IRC conversation, lets not use const pointers in these structures.

Ok.

Regards

--===============1695255888197426429==--

