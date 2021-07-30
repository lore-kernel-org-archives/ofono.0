Content-Type: multipart/mixed; boundary="===============0628585381593128853=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] simfs: Fix reads beyond the first block
Date: Fri, 30 Jul 2021 18:52:38 +0300
Message-ID: <022b8cde-8fff-2802-697a-dbeb52aefa8c@jolla.com>
In-Reply-To: <352f49b0-d29b-b43e-3658-9879007773c2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0628585381593128853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30/07/2021 18.37, Denis Kenzior wrote:
> Hi Slava,
>
> On 7/30/21 7:07 AM, Slava Monich wrote:
>> ---
>> =C2=A0 src/simfs.c | 17 ++++++++---------
>> =C2=A0 1 file changed, 8 insertions(+), 9 deletions(-)
>>
>
> Funny how long this bug has been lurking around.
>

Until we finally had a crash on reading an icon or something out of SIM. =

Which most SIMs apparently don't have or else it would've been noticed =

earlier.


>> diff --git a/src/simfs.c b/src/simfs.c
>> index 3d4f6283..cf770265 100644
>> --- a/src/simfs.c
>> +++ b/src/simfs.c
>> @@ -383,18 +383,18 @@ static void sim_fs_op_read_block_cb(const =

>> struct ofono_error *error,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_block =3D op->offset / 256;
>> -=C2=A0=C2=A0=C2=A0 end_block =3D (op->offset + (op->num_bytes - 1)) / 2=
56;
>> +=C2=A0=C2=A0=C2=A0 end_block =3D op->num_bytes ? (op->offset + op->num_=
bytes - 1) / =

>> 256 :
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start_block;
>
> Curious why this is needed?=C2=A0 op->num_bytes should never be zero sinc=
e =

> it gets set to the file length?
>

I admit that it's a bit paranoid, but op->num_bytes is assigned without =

checking and I figured that it wouldn't hurt to do a check here. Feel =

free to drop this part if it looks like too much of an overkill to you.


> Rest looks good to me.
>
> Regards,
> -Denis


Cheers,

-Slava

--===============0628585381593128853==--

