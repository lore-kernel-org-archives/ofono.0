Content-Type: multipart/mixed; boundary="===============3677416911513079942=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simfs: Fix reads beyond the first block
Date: Fri, 30 Jul 2021 11:08:44 -0500
Message-ID: <a2b59a8d-4ba5-5b46-6f59-d3ec27cb7256@gmail.com>
In-Reply-To: <022b8cde-8fff-2802-697a-dbeb52aefa8c@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3677416911513079942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 7/30/21 10:52 AM, Slava Monich wrote:
> On 30/07/2021 18.37, Denis Kenzior wrote:
>> Hi Slava,
>>
>> On 7/30/21 7:07 AM, Slava Monich wrote:
>>> ---
>>> =C2=A0 src/simfs.c | 17 ++++++++---------
>>> =C2=A0 1 file changed, 8 insertions(+), 9 deletions(-)
>>>
>>
>> Funny how long this bug has been lurking around.
>>
> =

> Until we finally had a crash on reading an icon or something out of SIM. =
Which =

> most SIMs apparently don't have or else it would've been noticed earlier.
> =


Figured :)

> =

>>> diff --git a/src/simfs.c b/src/simfs.c
>>> index 3d4f6283..cf770265 100644
>>> --- a/src/simfs.c
>>> +++ b/src/simfs.c
>>> @@ -383,18 +383,18 @@ static void sim_fs_op_read_block_cb(const struct =

>>> ofono_error *error,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_block =3D op->offset / 256;
>>> -=C2=A0=C2=A0=C2=A0 end_block =3D (op->offset + (op->num_bytes - 1)) / =
256;
>>> +=C2=A0=C2=A0=C2=A0 end_block =3D op->num_bytes ? (op->offset + op->num=
_bytes - 1) / 256 :
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_block;
>>
>> Curious why this is needed?=C2=A0 op->num_bytes should never be zero sin=
ce it gets =

>> set to the file length?
>>
> =

> I admit that it's a bit paranoid, but op->num_bytes is assigned without c=
hecking =

> and I figured that it wouldn't hurt to do a check here. Feel free to drop=
 this =

> part if it looks like too much of an overkill to you.
> =


I'm all for being paranoid, but there's not much sense doing a round-trip t=
o the =

SIM for a 0 byte read.  So I rather we catch this elsewhere.

There's some sanity checking of num_bytes being 0 once the file info has be=
en =

obtained.  It should be reset to file length if it is zero, which is genera=
lly =

what we want for simple binary files.

Invocations of ofono_sim_read_bytes() should probably sanity check the leng=
th if =

they want to be fully paranoid.

I went ahead and applied this patch without this particular chunk.

Regards,
-Denis
--===============3677416911513079942==--

