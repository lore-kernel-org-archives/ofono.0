Content-Type: multipart/mixed; boundary="===============5939444395893843183=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: Re: [RFC patches 01/13] Update .gitignore to ignore cscope databases
 and backup files
Date: Fri, 28 May 2010 11:17:11 -0300
Message-ID: <AANLkTinQ4TyOpS2HxmqEQeFTmV4It_Sx1T2AK_C6TgCW@mail.gmail.com>
In-Reply-To: <1275055691.4706.70.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5939444395893843183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2010 at 11:08, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Inaky,
>
>> diff --git a/.gitignore b/.gitignore
>> index 1ce7067..d7e9254 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -1,3 +1,4 @@
>> +*~
>
> believe it or not, I always left that out on purpose. I like having git
> status show me all the stupid backup files my editor creates.
>
>> =C2=A0*.o
>> =C2=A0*.lo
>> =C2=A0*.la
>> @@ -16,6 +17,8 @@ config.sub
>> =C2=A0configure
>> =C2=A0depcomp
>> =C2=A0compile
>> +cscope.files
>> +cscope.out
>> =C2=A0install-sh
>> =C2=A0libtool
>> =C2=A0ltmain.sh
>
> Please put the cscope stuff behind autom4te.cache since it is not part
> of autoconf/automake.
>

Does this makes sense since this files are not related to the project
itself but to specific tools? I usually put those on my personal
gitignore file.

-- =

Jo=C3=A3o Paulo Rechi Vita
http://jprvita.wordpress.com/

--===============5939444395893843183==--

