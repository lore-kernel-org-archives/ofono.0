Content-Type: multipart/mixed; boundary="===============4806135182338615407=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 20/24] stk: don't rely on undefined behavior when casting
 function pointers
Date: Mon, 25 Apr 2016 12:21:47 -0500
Message-ID: <571E522B.8090804@gmail.com>
In-Reply-To: <571DBB6D.8010207@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4806135182338615407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi John,

<snip>

 >>> -    g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
>>> +    g_queue_foreach(stk->envelope_q, free_envelope_item, NULL);
>>
>> Why not g_queue_free_full?
> It would require a glib required version bump from 2.28 to 2.32, the
> solution in the patch is 2.28 friendly. If it's ok to bump glib, I will
> redo the patch to use g_queue_free_full instead.
>>

Given than glib 2.32 is over 4 years old, I think it safe to do that.

Regards,
-Denis


--===============4806135182338615407==--

