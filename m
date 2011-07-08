Content-Type: multipart/mixed; boundary="===============4609394041659399148=="
MIME-Version: 1.0
From: Dalleau, Frederic <frederic.dalleau@intel.com>
Subject: Re: [PATCH] Fix issue with AT parser in gatserver
Date: Fri, 08 Jul 2011 16:44:30 +0200
Message-ID: <CA+QXtDuRd8zPZh7h584z7yQ7Nr3RB7VLwS9r-Ovz4bgw+mJBBg@mail.gmail.com>
In-Reply-To: <4E154BFA.50504@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4609394041659399148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/7/7 Denis Kenzior <denkenz@gmail.com>:
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 07/07/2011 09:19 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
>> This patch fix an issue with AT parser in gatserver.
>>
>> If an empty command is issued after AT, then 2 answers are sent. The par=
ser can
>> also get in a bad state where next commands will not be handled. After t=
hat the
>> parser will get back on his feets. This is caused by reentrency:
>> new_bytes() calls g_at_server_send_final(), which in turns calls server_=
resume
>> which calls new_bytes() again synchronously.
>>
>
> We should not try to set the read handler if it already set. =C2=A0Have y=
ou
> tried adding:
>
> if (server->suspended =3D=3D FALSE)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>

I like the idea of this one, but it still exhibit an issue in the case of A=
/:
Server_parse_line suspends and resumes in the
same function.

Regards,
Fr=C3=A9d=C3=A9ric

--===============4609394041659399148==--

