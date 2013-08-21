Content-Type: multipart/mixed; boundary="===============0062194509236063151=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] hfp_hf_bluez5: Handle org.bluez.Profile1.Release()
Date: Wed, 21 Aug 2013 10:21:55 -0500
Message-ID: <5214DB13.3070507@gmail.com>
In-Reply-To: <CABBYNZJVqmvtEBf5094t1GPizups6Kdd=nA2Zh3rzHamC9ztqg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0062194509236063151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On 08/21/2013 05:29 AM, Luiz Augusto von Dentz wrote:
> Hi Denis,
>
> On Tue, Aug 20, 2013 at 6:41 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Luiz,
>>
>>
>>>> I agree. Going to fix, and send a patch to BlueZ to add that label.
>>>
>>>
>>> While at it you might consider actually handling the Release because
>>> right now oFono doesn't react to either org.bluez disappearing nor
>>> adapter proxy being removed so if one of those events happen without
>>> calling RequestDisconnection oFono will keep the connection.
>>>
>>
>> As long as BlueZ calls shutdown() on the socket, the resources will be
>> cleaned up by the oFono HUP handler.
>
> That works as long bluetoothd doesn't crash so it is probably a good
> idea to at least check if the org.bluez has disappeared and cleanup if
> any connection still exists. I also don't understand how the
> enumeration is supposed to work in hfp_hf_bluez5, it doesn't seems to
> be able to detect devices being removed as there is no proxy_removed
> callback, Im missing something?

Correct me if I'm wrong, but BlueZ disappearing should be handled by =

freeing all the proxies associated with it when it goes away.  e.g. =

inside gdbus/client.c message_filter().

oFono does not use proxy_removed, instead we use =

g_dbus_proxy_set_removed_watch.  This lets us avoid an unnecessary hash =

lookup.

>
>>
>>> Before anyone asks, there is another difference between Release and
>>> RequestDisconnection, the former should cause a forceful disconnect if
>>> connected while the latter should disconnect gracefully so bluetoothd
>>> will wait for the response so in theory Release can happen without
>>> RequestDisconnection being called before.
>>>
>>
>> The only time BlueZ calls Release() today is when gracefully shutting do=
wn.
>> It calls shutdown() then anyway.
>>
>> It might be argued that we should shut down the SCO server socket if Blu=
eZ
>> has called Release() on our profile.  Looking at the code, it looks like=
 we
>> only accept SCO connections when a given handsfree_audio_card matches a
>> connection request.  So assuming the kernel has SCO defer setup handling=
, we
>> should be okay with the current behavior.  Comments?
>
> That can create a situation where nobody else can listen on SCO even
> before oFono register HFP, while this is mostly fine as platforms
> should probably have a single solution for HFP it would probably be
> safer to start listening to SCO only when registered so we give a nice
> example how to implement external profiles properly.
>
>

The HFP plugin registers the profile with BlueZ on startup.  So who =

would try to open a SCO socket in that small time window?

Regards,
-Denis

--===============0062194509236063151==--

