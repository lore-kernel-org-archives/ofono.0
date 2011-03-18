Content-Type: multipart/mixed; boundary="===============1124649281385648359=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/12] gatchat: implementation for +CPOS send
Date: Fri, 18 Mar 2011 09:52:53 -0500
Message-ID: <4D8371C5.8010907@gmail.com>
In-Reply-To: <1300453519.9383.48.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1124649281385648359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

>>> +guint g_at_chat_send_and_expect_short_prompt(GAtChat *chat, const char=
 *cmd,
>>> +			const char **prefix_list, GAtResultFunc func,
>>> +			gpointer user_data, GDestroyNotify notify)
>>> +{
>>> +	if(chat !=3D NULL)
>>> +		chat->parent->syntax->set_hint(chat->parent->syntax,
>>> +					G_AT_SYNTAX_EXPECT_SHORT_PROMPT);
>>
>> So unfortunately you can't do this.  GAtChat is a command queue and we
>> might be in the process of sending / receiving responses for multiple
>> commands that are ahead of this one.  So you can't really manipulate the
>> syntax directly here.  You have to do this only once the CPOSR has been
>> sent on the wire.
>>
> Ok, thanks. Still having trouble to understand GAtChat. =

> Not just sure where I should set the hint then but I get your point.
> Now I'm also a little confused because previously you suggested that I'd
> make a new g_at_chat_send variant that would set the hint so what did
> you mean by it then if not this?

Look at how e.g. expect_pdu boolean is handled.  You need to do
something very similar but after sending the first chunk followed by \r.
(e.g. when AT+CPOS\r was sent).  You probably need to add another
flag/boolean to the command data structure for this.

Regards,
-Denis

--===============1124649281385648359==--

