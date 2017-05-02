Content-Type: multipart/mixed; boundary="===============3870857036594476627=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: qmimodem: GPRS context stay Active when GPRS attach is lost
Date: Tue, 02 May 2017 11:55:10 +0200
Message-ID: <fef721ca-8cee-9f63-55ee-02ab1dd731cf@kerlink.fr>
In-Reply-To: <140c89fb-6172-9dd3-0db6-400e118b2704@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3870857036594476627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,


On 04/29/2017 02:51 PM, Jonas Bonn wrote:
> Hi Christophe,
>
> On 04/28/2017 04:28 PM, Christophe Ronco wrote:
>>
>> Hello,
>>
>> Even with detach_shutdown method implemented in qmimodem (patch done =

>> by Jonas Bonn two or three weeks ago), I still sometimes have =

>> problems when I have a lot of GPRS deconnections.
>>
>> I use a MC7304 modem and to simulate short GPRS network losses, I =

>> simply unplug and replug modem antenna.
>>
>>
>> I've done a patch that seems to correct the problem for me. I simply =

>> do not handle anymore QMI_WDS_PKT_STATUS_IND notifications. I assume =

>> it is not needed anymore (after Jonas Bonn patch implementing =

>> detach_shutdown method in qmimodem driver). But I might be wrong...
>>
>> I'll send the patch after this message.
>>
>
> I'm pretty sure that handling the notification is necessary because =

> the network can still disconnect the context spontaneously and the =

> indication is the only way of detecting that.
>
> I just pushed a short series for QMI LTE support.  Patch 1/4 in that =

> series, I hope, addresses the issue you reported.  It would be great =

> if you could give that a try and see if it works for you...
I tried to reproduce the race condition I saw with your patch and I failed.
So the patch seems to fix my problem.

Thanks for this patch and your analysis on mine,

Christophe



--===============3870857036594476627==--

