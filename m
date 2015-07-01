Content-Type: multipart/mixed; boundary="===============7356239491733427871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HE910 + ofono: "Activating context failed with error: Unknown
 error type"
Date: Tue, 30 Jun 2015 19:44:10 -0500
Message-ID: <559337DA.8070109@gmail.com>
In-Reply-To: <55939285.1000306@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7356239491733427871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

 >
> Before receiving  the "NO CARRIER" signal,
> the modem leaves the data mode
> and enters the chat mode (apparently too early).
>
> In my log you can see that it gets some leftovers
> of a PPP package,including an opening double quote
>   ... but it never gets the closing one, and therefore
> oFono is not responding any more.
>
> Here is the log:
> (the modem has already established a data connection,
> and I pull out the SIM card of its slot)

Aha.  Now I understand.  You're removing the SIM card, which triggers =

at_gprs_context_remove.  And the modem firmware is not smart enough to =

send the final HDLC frame prior to sending us the SIM removed event.

> ofonod[2816]: Modem: < ~\377}#\300!}%}"} }$Y(~
> ofonod[2816]: Modem: < \r\nNO CARRIER\r\n

And indeed, we switch out of HDLC mode too early in this case.

>
>
>>
>>> I think this is an major issue that should be fixed in oFono.
>>> The syntax parser has to be extended to handle such cases.
>>>
>>
>> Any suggestions on how oFono should detect this condition?
>
> Here is our "quick" solution to this problem.
>
> --- gatchat.c (f83233d)
> +++ gatchat.c (a3cb2b2)
> @@ -957,6 +957,11 @@
>       g_at_io_set_debug(chat->io, chat->debugf, chat->debug_data);
>       g_at_io_set_read_handler(chat->io, new_bytes, chat);
>
> +    /* Prevent garbage that arrives from the late data connection to
> +     * switch the AT syntax parser to string mode (when it contains a
> doublequote) */
> +    if (chat->syntax->set_hint)
> +        chat->syntax->set_hint(chat->syntax, G_AT_SYNTAX_EXPECT_GARBAGE);
> +
>       if (g_queue_get_length(chat->command_queue) > 0)
>           chat_wakeup_writer(chat);
>   }
>
>
> --- gatsyntax.c (359f790)
> +++ gatsyntax.c (a3cb2b2)
> @@ -57,6 +57,8 @@
>       GSM_PERMISSIVE_STATE_PROMPT,
>       GSM_PERMISSIVE_STATE_GUESS_SHORT_PROMPT,
>       GSM_PERMISSIVE_STATE_SHORT_PROMPT,
> +    GSM_PERMISSIVE_STATE_GUESS_GARBAGE,
> +    GSM_PERMISSIVE_STATE_GARBAGE,
>   };
>
>   static void gsmv1_hint(GAtSyntax *syntax, GAtSyntaxExpectHint hint)
> @@ -270,6 +272,8 @@
>           syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_PDU;
>       else if (hint =3D=3D G_AT_SYNTAX_EXPECT_SHORT_PROMPT)
>           syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_SHORT_PROMPT;
> +    else if (hint =3D=3D G_AT_SYNTAX_EXPECT_GARBAGE)
> +        syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_GARBAGE;
>   }
>
>   static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *syntax,
> @@ -358,6 +362,21 @@
>               syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
>               return G_AT_SYNTAX_RESULT_UNSURE;
>
> +        case GSM_PERMISSIVE_STATE_GUESS_GARBAGE:
> +            if (byte !=3D '\r' && byte !=3D '\n')
> +                syntax->state =3D GSM_PERMISSIVE_STATE_GARBAGE;
> +            break;
> +
> +        case GSM_PERMISSIVE_STATE_GARBAGE:
> +            if (byte =3D=3D '\r') {
> +                syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
> +
> +                i +=3D 1;
> +                res =3D G_AT_SYNTAX_RESULT_GARBAGE;
> +                goto out;
> +            }
> +            break;
> +
>           default:
>               break;
>           };
>
>
> --- gatsyntax.h (21f9da9)
> +++ gatsyntax.h (a3cb2b2)
> @@ -30,7 +30,8 @@
>       G_AT_SYNTAX_EXPECT_PDU,
>       G_AT_SYNTAX_EXPECT_MULTILINE,
>       G_AT_SYNTAX_EXPECT_PROMPT,
> -    G_AT_SYNTAX_EXPECT_SHORT_PROMPT
> +    G_AT_SYNTAX_EXPECT_SHORT_PROMPT,
> +    G_AT_SYNTAX_EXPECT_GARBAGE,
>   };
>
>   typedef enum _GAtSyntaxExpectHint GAtSyntaxExpectHint;
> @@ -42,6 +43,7 @@
>       G_AT_SYNTAX_RESULT_MULTILINE,
>       G_AT_SYNTAX_RESULT_PDU,
>       G_AT_SYNTAX_RESULT_PROMPT,
> +    G_AT_SYNTAX_RESULT_GARBAGE,
>   };
>
>   typedef enum _GAtSyntaxResult GAtSyntaxResult;
>
>
> Our opinion is that the modem should only switch its
> mode once it really received the NO CARRIER
> signal (or something in this manner).
>

Correct.  However, we currently expect all atom drivers to cleanup =

immediately (e.g. at_gprs_context_remove), so doing this cleanly is tricky.

> P.S. We would also like to post a patch regarding oFono.
> How can we do this?
>

git send-email.

Regards,
-Denis


--===============7356239491733427871==--

