Content-Type: multipart/mixed; boundary="===============3091446548929935355=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= DALLEAU <frederic.dalleau@linux.intel.com>
Subject: Re: [PATCH v5 7/7] handsfree-audio: Add USR1 signal to connect audio
Date: Fri, 30 Aug 2013 12:23:43 +0200
Message-ID: <522072AF.7090807@linux.intel.com>
In-Reply-To: <521F85BA.5090100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3091446548929935355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

Le 29/08/2013 19:32, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 08/27/2013 11:59 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
>> From: Frederic Danis <frederic.danis@linux.intel.com>
>>
>> ---
>>   tools/handsfree-audio.c |   90
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>
>
> Can this patch be replaced by a simple python script?

IIRC, the problem is that oFono makes sure the Connect call comes from
a registered agent.

Regards,
Fred


--===============3091446548929935355==--

