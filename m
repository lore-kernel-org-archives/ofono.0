Content-Type: multipart/mixed; boundary="===============4062997655113087008=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: qmimodem: GPRS context stay Active when GPRS attach is lost
Date: Sat, 29 Apr 2017 14:51:36 +0200
Message-ID: <140c89fb-6172-9dd3-0db6-400e118b2704@southpole.se>
In-Reply-To: <acc564b8-0170-aeed-da59-397de3f49a68@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4062997655113087008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 04/28/2017 04:28 PM, Christophe Ronco wrote:
>
> Hello,
>
> Even with detach_shutdown method implemented in qmimodem (patch done =

> by Jonas Bonn two or three weeks ago), I still sometimes have problems =

> when I have a lot of GPRS deconnections.
>
> I use a MC7304 modem and to simulate short GPRS network losses, I =

> simply unplug and replug modem antenna.
>
>
> I've done a patch that seems to correct the problem for me. I simply =

> do not handle anymore QMI_WDS_PKT_STATUS_IND notifications. I assume =

> it is not needed anymore (after Jonas Bonn patch implementing =

> detach_shutdown method in qmimodem driver). But I might be wrong...
>
> I'll send the patch after this message.
>

I'm pretty sure that handling the notification is necessary because the =

network can still disconnect the context spontaneously and the =

indication is the only way of detecting that.

I just pushed a short series for QMI LTE support.  Patch 1/4 in that =

series, I hope, addresses the issue you reported.  It would be great if =

you could give that a try and see if it works for you...

Best regards,
Jonas


--===============4062997655113087008==--

