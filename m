Content-Type: multipart/mixed; boundary="===============8410114579179573675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix issue with AT parser in gatserver
Date: Mon, 11 Jul 2011 16:25:48 -0500
Message-ID: <4E1B6A5C.7060100@gmail.com>
In-Reply-To: <CA+QXtDuRd8zPZh7h584z7yQ7Nr3RB7VLwS9r-Ovz4bgw+mJBBg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8410114579179573675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On 07/08/2011 09:44 AM, Dalleau, Frederic wrote:
> Hi Denis,
> =

> 2011/7/7 Denis Kenzior <denkenz@gmail.com>:
>> Hi Fr=C3=A9d=C3=A9ric,
>>
>> On 07/07/2011 09:19 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
>>> This patch fix an issue with AT parser in gatserver.
>>>
>>> If an empty command is issued after AT, then 2 answers are sent. The pa=
rser can
>>> also get in a bad state where next commands will not be handled. After =
that the
>>> parser will get back on his feets. This is caused by reentrency:
>>> new_bytes() calls g_at_server_send_final(), which in turns calls server=
_resume
>>> which calls new_bytes() again synchronously.
>>>
>>
>> We should not try to set the read handler if it already set.  Have you
>> tried adding:
>>
>> if (server->suspended =3D=3D FALSE)
>>        return;
>>
> =

> I like the idea of this one, but it still exhibit an issue in the case of=
 A/:
> Server_parse_line suspends and resumes in the
> same function.
> =


I think I fixed this one as well in commit 329f2d7.  Let me know if you
encounter further problems.

Regards,
-Denis

--===============8410114579179573675==--

