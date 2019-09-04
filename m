Content-Type: multipart/mixed; boundary="===============0573991631339364501=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] gatchat: implement timeout setting for commands
Date: Wed, 04 Sep 2019 08:15:38 -0500
Message-ID: <da2f3f27-9cce-6509-a6a5-601e7116e720@gmail.com>
In-Reply-To: <2f677fc5-4d56-77e2-5722-4d2751867d04@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0573991631339364501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 9/5/19 6:41 AM, Martin Hundeb=C3=B8ll wrote:
> Hi Denis,
> =

> On 02/09/2019 23.25, Denis Kenzior wrote:
>> Hi Martin,
>>
>> On 9/2/19 4:10 PM, Martin Hundeb=C3=B8ll wrote:
>>> The adds a function to the set a chat-wide timeout for at commands. It
>>> allows plugins to handle cases where the modem fails to respond with
>>> either an OK or an error.
>>
>> Okay, this is sort of a known problem without a really good solution...
>>
>>>
>>> Without these timeouts, the plugin is never notified about a hanging
>>> command, and it has no way to detect it; effectively leaving the device
>>> in a broken state, where only a full restart of the ofono service
>>> unbreaks it.
>>
>> The trouble is, what if this happens on a command handled by a generic =

>> atmodem driver atom?=C2=A0 Are you going in and adding timeout handling =
to =

>> all command callbacks?
> =

> My initial thought was that calling the command callback with ok=3Dfalse =

> would be handled already. But that might be too optimistic?
> =


Sort of.  The problem is that there's no concept of a timeout at the =

protocol level.  And we don't have any idea whether the timeout really =

happened, or things are just taking a while.  Nor do we know if it is a =

bug, e.g. in GAtSyntax or just the modem not adhering to the spec.

Another issue is that even if a timeout happens, we have no idea whether =

it is safe to send any subsequent commands.  Command cancelation is a =

gray area, with some manufacturers supporting it partially and some not =

at all.  Even just blindly sending on the next command would not =

necessarily work.

Hence my point that special (and probably vendor specific) handling of =

timeouts would need to be added _everywhere_ in the generic callbacks. =

So basically exposing this is generally a bad idea.

>> If this timeout only happens in special cases, then those can be taken =

>> care of by setting up your own timeout...
> =

> Our problem is that this was seen during SIM initialization when doing =

> so too early on the quectel modem (worked around in my latest quectel =

> sim patches.) So it needs to be chat-wide.
> =


SIM initialization or modem initialization?  Maybe you want to take care =

of this prior to setting up the MUX?

>>>
>>> If a timeout occurs, the passed callback is invoked with 'ok' set to
>>> false, and no final response in the result. This allows callbacks to
>>> identify the timeout with this snippet:
>>>
>>> =C2=A0=C2=A0 if (!ok) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 decode_at_error(&error, g_at_result_final_resp=
onse(result));
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (error.type =3D=3D OFONO_ERROR_TYPE_FAILURE=
) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* handle timeout */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0 }
>>
>> About the only thing I can suggest is to create a separate timeout =

>> callback for the GAtChat object that the modem driver can set.=C2=A0 Tha=
t =

>> way if the timeout happens, the modem driver can just reset the entire =

>> setup.=C2=A0 E.g. maybe via ofono_modem_reset.
> =

> That could work too.
> =

> I have one concern with my current patches though:
> The timeout needs to accommodate long-lasting commands like AT+COPS, =

> which is can take up to 80 seconds or so. But that is much longer than =

> the timeout for powering up the modem.

That's the other problem.  The timeout should be variable and per =

command.  Which means g_at_chat_send should be modified with a timeout =

value and that change would be quite invasive.  Given that timeouts =

shouldn't even happen, it just makes the whole thing a huge mess.

> =

> So if:
>  =C2=A0 1: user enables modem
>  =C2=A0 2: gatchat gets stuck with no command
>  =C2=A0 3: set_powered_timeout() triggers
>  =C2=A0 4: gatchat timeout fires
> =

> What happens is the user tries to enable the modem again after step 3? =

> Should the plugin enable function clean up after potential timeouts to =

> avoid step 4?

No clue.  That is completely manufacturer dependent.

Regards,
-Denis

--===============0573991631339364501==--

