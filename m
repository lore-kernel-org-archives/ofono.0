Content-Type: multipart/mixed; boundary="===============2407321580584691117=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 18/18] gsmdial: implement mechanism to send +++ -> ATO0 ->
 +++ -> ATH0
Date: Thu, 31 Mar 2011 10:39:04 -0500
Message-ID: <4D94A018.9010003@gmail.com>
In-Reply-To: <4D9492DE.2000809@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2407321580584691117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> The logic for sending a guard timeout, +++, guard timeout should really
>> belong in GAtChat, otherwise every single client has to repeat the same
>> state machine.
> =

> I can implement a g_at_chat_send_escape_sequence() to manage:
> <pause> --> +++ <pause> timing
> =

> I would still write directly on at_chat GAtIO because using
> at_chat_send_common() would add a '\r' that would cancel the suspend
> data call.
> =


Yes, of course.

Regards,
-Denis

--===============2407321580584691117==--

