Content-Type: multipart/mixed; boundary="===============3519536121553348575=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Problem when disable GPRS context and try to re-enable it
Date: Tue, 21 May 2013 16:11:09 +0200
Message-ID: <519B807D.6080306@syscom-instruments.com>
In-Reply-To: <519B7582.4050102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3519536121553348575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 21. 05. 13 15:24, Denis Kenzior wrote:
> On 05/17/2013 05:33 AM, Viallard Anthony wrote:
>> ofonod[10347]: drivers/atmodem/gprs-context.c:at_gprs_activate_primary()
>> cid 1
>> ofonod[10347]: src/gprs.c:pri_activate_callback() 0x108698
>> ofonod[10347]: src/gprs.c:pri_activate_callback() Activating context
>> failed with error: Unknown error type
>> ---------------------------
>>
>> I read the code, added some logs and found the function
>> at_chat_send_common() doesn't do his job because chat->command_queue is
>> NULL.
>>
>> I guess chat->command_queue is free and set to NULL in
>> chat_cleanup(struct at_chat *chat) but I don't dig more why this
>> function is call...
>>
>> Any ideas ?
>
> I think I've seen this before, or something similar. It may be that when
> the modem hangs up the PPP link it also hangs up the serial port (e.g.
> using a HUP). GAtChat thinks that the port has been closed and things no
> longer work.
>
> On most devices this behavior can be turned off by sending AT&C0 init
> string. Try that?
>

AT&C0 fixes the wrong behavior. Thanks !

Regards,
Anthony.

--===============3519536121553348575==--

