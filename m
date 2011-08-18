Content-Type: multipart/mixed; boundary="===============8190066422626665654=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: Missing CallRemoved signals
Date: Thu, 18 Aug 2011 08:29:01 +0200
Message-ID: <4E4CB12D.6020005@bmw-carit.de>
In-Reply-To: <4E4BE19B.3080003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8190066422626665654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

OK, that makes sense. Thanks for the workaround.

Regards,
Mikel


On 08/17/2011 05:43 PM, Denis Kenzior wrote:
> Hi Mikel,
>
> On 08/17/2011 04:58 AM, Mikel Astiz wrote:
>> Hi all,
>>
>> I'm doing further tests with oFono with a simple UI that handles the
>> calls of a certain modem (bluetooth modem in this case).
>>
>> I keep track of the existing calls by listening to 'VoiceCallManager'
>> signals, 'CallAdded' and 'CallRemoved'. The list is initialized using
>> 'VoiceCallManager.GetCalls()' at startup.
>>
>> The problem I have found is that some 'CallRemoved' signals are
>> apparently never emitted. It is in fact quite easy to reproduce, if a
>> modem is powered down while a call is in progress.
> By convention oFono interfaces do not emit any signals when they're
> being removed (e.g. when the modem is powered down).  In most cases
> there isn't a meaningful value we can emit anyway, or doing so would
> result in too many redundant signals.
>
>> Having a look at oFono's source code (src/voicecall.c), my feeling is
>> that some calls to 'voicecall_dbus_unregister' are not accompanied by a
>> call to 'voicecalls_emit_call_removed', inside the function
>> 'voicecall_unregister'.
>>
>> Could anyone confirm if this is a bug in oFono or suggest any workaround
>> for the client app?
> The application can track the 'Interfaces' property on the modem object
> to figure out when an interface goes live / ceases to exist.  If
> VoiceCallManager goes away, you can mark all relevant calls accordingly.
>
>> Regards,
>> Mikel
> Regards,
> -Denis


--===============8190066422626665654==--

