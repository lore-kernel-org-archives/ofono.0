Content-Type: multipart/mixed; boundary="===============0539464934373993994=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] gatchat: fix gatsyntax to support +CPOS
Date: Thu, 10 Mar 2011 17:11:27 -0600
Message-ID: <4D795A9F.8010801@gmail.com>
In-Reply-To: <1299766786.3234.23.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0539464934373993994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

>>
>> Is there any particular reason why CPOS is not re-using the prompting
>> feature of AT commands and has to invent its own?  If you think about
>> this a bit harder you will realize that the spec is *completely* broken
>> here and introduces a parser ambiguity which cannot be reliably fixed.
>>
> Well thinking about it a: I noticed the same thing when trying to
> implement b: I didn't write specification c: I'm just the guy who was
> supposed to implement this. So I agree doesn't make sense but need to
> find some solution for this anyway.
> =


Fair enough, sorry for 'shooting the messenger' so to speak ;)

>> At this point my only suggestion is that you need to set a parser hint
>> after every CPOS command sent to the modem.  Or better yet, push a
>> change request to 27.007 to use proper prompting procedures.
>>
> Ok I'm not quite sure what you mean. If you mean using syntax->set_state
> with hint say G_AT_SYNTAX_EXPECT_PROMPT I still need to somehow get
> state to G_AT_SYNTAX_RESULT_PROMPT which I can by if
> G_AT_SYNTAX_EXPECT_PROMPT then GSMV1_STATE_PROMPT and then in gsmv1_feed
> I check that if '\r' and then '\n' then G_AT_SYNTAX_RESULT_PROMPT. =

> Is that what you mean?

Essentially.  You might have to define a new syntax hint for this
prompt, namely EXPECT_BROKEN_PROMPT or something like that.

> The next question is where do I call the set_hint and how? If on driver
> the problem is that I need to get the driver to be aware of _GAtSyntax
> or more precisely set_hint method. If on gatchat the problem is to check
> if the command is +CPOS and do it efficiently.

I'd suggest inventing a new g_at_chat_send variant that would set this
hint for you.  Something like g_at_chat_send_and_expect_broken_prompt ;)

> What comes to making a change request to 27.007. I think that's a very
> long road to take.
> =


You will have a very long road trying to implement this feature reliably
as well.  Lets face it, the spec is broken and the sooner STE modems
(and the spec) are fixed the better it will be for everyone.

Regards,
-Denis

--===============0539464934373993994==--

