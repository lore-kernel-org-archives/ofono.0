Content-Type: multipart/mixed; boundary="===============1521301409211194360=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [RFC] gatchat: implement timeout setting for commands
Date: Thu, 05 Sep 2019 13:41:11 +0200
Message-ID: <2f677fc5-4d56-77e2-5722-4d2751867d04@geanix.com>
In-Reply-To: <0035204a-e272-92cd-d59a-e252299dffef@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1521301409211194360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/09/2019 23.25, Denis Kenzior wrote:
> Hi Martin,
> =

> On 9/2/19 4:10 PM, Martin Hundeb=C3=B8ll wrote:
>> The adds a function to the set a chat-wide timeout for at commands. It
>> allows plugins to handle cases where the modem fails to respond with
>> either an OK or an error.
> =

> Okay, this is sort of a known problem without a really good solution...
> =

>>
>> Without these timeouts, the plugin is never notified about a hanging
>> command, and it has no way to detect it; effectively leaving the device
>> in a broken state, where only a full restart of the ofono service
>> unbreaks it.
> =

> The trouble is, what if this happens on a command handled by a generic =

> atmodem driver atom?=C2=A0 Are you going in and adding timeout handling t=
o =

> all command callbacks?

My initial thought was that calling the command callback with ok=3Dfalse =

would be handled already. But that might be too optimistic?

> If this timeout only happens in special cases, then those can be taken =

> care of by setting up your own timeout...

Our problem is that this was seen during SIM initialization when doing =

so too early on the quectel modem (worked around in my latest quectel =

sim patches.) So it needs to be chat-wide.

>>
>> If a timeout occurs, the passed callback is invoked with 'ok' set to
>> false, and no final response in the result. This allows callbacks to
>> identify the timeout with this snippet:
>>
>> =C2=A0=C2=A0 if (!ok) {
>> =C2=A0=C2=A0=C2=A0=C2=A0 decode_at_error(&error, g_at_result_final_respo=
nse(result));
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (error.type =3D=3D OFONO_ERROR_TYPE_FAILURE)=
 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* handle timeout */
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0 }
> =

> About the only thing I can suggest is to create a separate timeout =

> callback for the GAtChat object that the modem driver can set.=C2=A0 That=
 way =

> if the timeout happens, the modem driver can just reset the entire =

> setup.=C2=A0 E.g. maybe via ofono_modem_reset.

That could work too.

I have one concern with my current patches though:
The timeout needs to accommodate long-lasting commands like AT+COPS, =

which is can take up to 80 seconds or so. But that is much longer than =

the timeout for powering up the modem.

So if:
   1: user enables modem
   2: gatchat gets stuck with no command
   3: set_powered_timeout() triggers
   4: gatchat timeout fires

What happens is the user tries to enable the modem again after step 3? =

Should the plugin enable function clean up after potential timeouts to =

avoid step 4?

// Martin

--===============1521301409211194360==--

