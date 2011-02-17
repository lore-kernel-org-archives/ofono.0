Content-Type: multipart/mixed; boundary="===============5822538704155139226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-server:Add test of PPP disconnect reason
Date: Thu, 17 Feb 2011 10:50:28 -0600
Message-ID: <4D5D51D4.5010407@gmail.com>
In-Reply-To: <4D5D4EBE.30102@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5822538704155139226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 02/17/2011 10:37 AM, Guillaume Zajac wrote:
> Hi Denis,
> =

> On 17/02/2011 17:14, Denis Kenzior wrote:
>> Hi Guillaume,
>>
>> On 02/17/2011 07:48 AM, Guillaume Zajac wrote:
>>> ---
>>>   gatchat/test-server.c |    6 ++++++
>>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/gatchat/test-server.c b/gatchat/test-server.c
>>> index e574d64..c0a5a4d 100644
>>> --- a/gatchat/test-server.c
>>> +++ b/gatchat/test-server.c
>>> @@ -137,6 +137,12 @@ static void
>>> ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user)
>>>       g_at_ppp_unref(ppp);
>>>       ppp =3D NULL;
>>>
>>> +    if (reason =3D=3D G_AT_PPP_REASON_NET_FAIL) {
>> Don't you mean G_AT_PPP_REASON_LINK_DEAD?
>>
> =

> In case of test-server, I didn't reproduce the crash with/without the
> fix, I applied it to test server first as we don't have dial_cb for
> emulator yet:
> =

> I did ./gsmdial -i localhost -p 12346
> =

> At the end of the exchange:
> ppp_lcp_down_notify() is called
> disconnect reason is G_AT_PPP_REASON_PEER_CLOSED
> then the GAtServer is well resumed.
> =


That is because gsmdial performs graceful shutdown, try killing the app
with -9.

> In case of emulator (based on Gustavo/ZhenZhua dial_cb),
> ppp_lcp_down_notify() is called but just after this one,
> ppp_ipcp_up_notify() fails and sets disconnect reason to
> G_AT_PPP_REASON_NET_FAIL.

Then we probably have a bug.

> Then we get a crash after ppp_disconnect because we call the hdlc write
> handler e.g. can_write_data() into gathldc.c although we have unref the
> PPP server.
> =

> So I called ofono_emulator_remove() that will call the unref GAtServer
> etc... when we get G_AT_PPP_REASON_NET_FAIL into ppp_disconnect
> =

> I don't get G_AT_PPP_REASON_LINK_DEAD disconnect reason when emulator
> crashes.
> =

> So should we call ofono_emulator_remove()/GAtServer_unref() in both
> disconnect reason cases?
> Or is there a specific action to do when G_AT_PPP_REASON_NET_FAIL?
> =


Not necessarily, NET_FAIL basically means the IPCP negotiation failed.
It is not fatal.

Regards,
-Denis

--===============5822538704155139226==--

