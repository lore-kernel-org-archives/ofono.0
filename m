Content-Type: multipart/mixed; boundary="===============3126024270617787432=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 11:04:45 -0500
Message-ID: <a96c428a-500d-1a92-a7ae-1f2c0690cebf@gmail.com>
In-Reply-To: <20181020102616.26572-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3126024270617787432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/20/2018 05:26 AM, Giacinto Cifelli wrote:
> added the function g_at_chat_finish_command, in order to be able to
> interrupt a pending command.
> The function is useful in special cases, for example to implement
> a custom g_at_chat_set_wakeup_command. This command will never
> return if the device does not answer, and therefore it is unsuitable
> to probe configurations.

I don't think this is a good idea.  In general the caller has no clue =

what command he is actually finishing since there may be other commands =

being queued.

You might want to provide more context as to what you're actually trying =

to accomplish.  It might be easier to just use g_at_chat_cancel and a =

g_timeout_add_seconds combination for this...

Regards,
-Denis

--===============3126024270617787432==--

