Content-Type: multipart/mixed; boundary="===============3174122480448882023=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: [PATCH] Cache EF-PNN, EF-OPL sim files on disk.
Date: Sat, 18 Jul 2009 14:42:54 +0200
Message-ID: <fb249edb0907180542t118fc96fmab94c22d846bd5d4@mail.gmail.com>
In-Reply-To: <fb249edb0907180432x4a44eafcu8f1ed47914cfae35@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3174122480448882023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/7/18 andrzej zaborowski <balrogg@gmail.com>:
> 2009/7/18 Denis Kenzior <denkenz@gmail.com>:
>> However, not all files can be updated by the user. =C2=A0Namely files wi=
th the 'ADM'
>> for UPDATE access condition. =C2=A0The only way they can be changed is a=
t a service
>> center.
>>
>> What do you think of transparently caching only such files? =C2=A0This w=
ould include
>> the ones we're really interested in caching anyway, namely EFspn, EFpnn,
>> EFopl, EFust, etc.
>
> True, I was going to add code or a TODO in ofono_sim_write() to
> invalidate cache but it's a good point about updating outside ofono
> control. =C2=A0I now added a parameter to ofono_sim_read() to indicate th=
at
> a file can be cached on disk, making it a little less transparent.

Actually, ignore this, the response to SELECT gives access conditions
so we can use that.  I'll fix it and resend later.

Regards

--===============3174122480448882023==--

