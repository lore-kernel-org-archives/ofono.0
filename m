Content-Type: multipart/mixed; boundary="===============1307218020062077726=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 11:40:53 -0500
Message-ID: <96075ac8-b6bb-5219-91b1-10f1c88df9df@gmail.com>
In-Reply-To: <CAKSBH7Ezq_3Tiiohk7FHAkcES5sgGuWJDYQv7=DN9PoWS0C+JA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1307218020062077726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/20/2018 11:28 AM, Giacinto Cifelli wrote:
> Hi Denis,
> =

> On Sat, Oct 20, 2018 at 6:23 PM Denis Kenzior <denkenz@gmail.com> wrote:
>>
>> Hi Giacinto,
>>
>>> I need to probe with 'AT' once per second the modem and the
>>> application port, one after the other.
>>> It needs to be repeated a few times, because the device might be
>>> booting up, but it could also be that the device is not responding
>>> (because, for example, mapped on the RS232).
>>
>> Ugh.  Doesn't your firmware provide some sort of ready notification?
> =

> yes, but what if the modem has already booted up?

But then your query AT command will succeed no?

See how plugins/mbm.c does this with EMRDY for example.  If your modem =

is completely unresponsive for a certain amount of time then you might =

need to send AT\r or something directly via GAtIO/GIOChannel bypassing =

GAtChat.

> =

>>
>> But anyway, you can still accomplish this with
>> g_at_chat_send/g_timeout_add/g_at_chat_cancel...
> =

> I have tried but it doesn't abort the current 'AT' waiting for an answer.

As I said, we don't support AT command aborts.  You can't simply start =

writing the next AT command to the serial port.  There are special rules =

for this with weird timings.  See V.250 for details.  Also many AT =

command interpreter implementations simply don't support this at all or =

support aborts for a limited subset of commands.

You're doing something extremely specific, so you can either try and =

abuse the g_at_chat_set_wakeup_command (which was added specifically for =

one extremely insane modem) or do this manually via GAtIO / GIOChannel.

> =

>>
>>>
>>> Another use could be to abort a long-running command (eg: SMS sending,
>>> which can take up to 3 minutes), to allow the application to do
>>> something else, eg: emergency call.
>>
>> This is why they invented the multiplexer.  Also note that we don't
>> implement actual AT command abortions.  So it depends on the behavior of
>> your AT command interpreter whether this works as you think.
>>
>> I'm not taking this patch as things stand right now.
> =

> I don't have a way out without this. Any suggestions?
> =


Implement proper AT command abort logic per V.250?  Or work around some =

other way.

Regards,
-Denis

--===============1307218020062077726==--

