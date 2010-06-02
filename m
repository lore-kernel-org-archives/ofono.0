Content-Type: multipart/mixed; boundary="===============4491017885703680103=="
MIME-Version: 1.0
From: Naresh Mehta <nareshtechs@gmail.com>
Subject: Re: [PATCH] Introduction of HACKING file in phonesim
Date: Wed, 02 Jun 2010 08:25:30 +0200
Message-ID: <AANLkTikAmLw-Egjot6fDe4NlpsVKTApAN6xPnXjvFs6T@mail.gmail.com>
In-Reply-To: <1275446423.2182.9.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4491017885703680103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks All. Will keep the different things in mind in my next patches.

BR; Naresh

On Wed, Jun 2, 2010 at 4:40 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Yang,
>
>> >+When using "./configure --enable-maintainer-mode" the automake scripts=
 will
>> >+use the plugins directly from within the repository. This removes the =
need
>> >+to use "make install" when testing "phonesim". The "bootstrap-configur=
e"
>> >+automatically includes this option.
>> >+
>> >+ =C2=A0Run phonesim in foreground using the following options
>> >+ =C2=A0 =C2=A0# ./src/phonesim -p 12345 -gui xml/default.xml
>>
>> The "xml" directory has been removed. So here should be "src/default.xml=
".
>
> good catch. I fixed that up. Thanks.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



-- =


BR; Naresh

visit me at:
http://www.naresh.se/

--===============4491017885703680103==--

