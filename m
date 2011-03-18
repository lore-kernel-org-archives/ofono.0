Content-Type: multipart/mixed; boundary="===============2439773696926211553=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/12] gatchat: fix gatsyntax to support +CPOS
Date: Fri, 18 Mar 2011 09:49:50 -0500
Message-ID: <4D83710E.6040309@gmail.com>
In-Reply-To: <1300456602.9383.69.camel@poutijar-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2439773696926211553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

>>> @@ -298,6 +310,13 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSynt=
ax *syntax,
>>>  				i +=3D 1;
>>>  				res =3D G_AT_SYNTAX_RESULT_PROMPT;
>>>  				goto out;
>>> +			} else if (byte =3D=3D '\r')
>>> +				break;
>>> +			else if (byte =3D=3D '\n') {
>>> +				syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
>>> +				i +=3D 1;
>>> +				res =3D G_AT_SYNTAX_RESULT_PROMPT;
>>> +				goto out;
>>
>> Same comment here, and man you better pray that your modem doesn't
>> insert unsolicited notifications between you sending a CPOSR and you
>> receiving a prompt ;)
>>
> Yep. Btw now that I think about it, shouldn't the patch that I proposed
> to ste.c help? I know it's ste specific solution but still..

If you mean running GNSS on a dedicated mux channel, then yes it will
help ;)

But really, using a proper prompt would be way better.

Regards,
-Denis

--===============2439773696926211553==--

