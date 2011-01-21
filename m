Content-Type: multipart/mixed; boundary="===============5619548415341170203=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] PPP: Fix transmit ACCM and receive ACCM setting issue
Date: Fri, 21 Jan 2011 14:10:08 -0600
Message-ID: <4D39E820.7060802@gmail.com>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD34F6CD39@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5619548415341170203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>> You still forgot to apply my earlier comment.  The recv ACCM should be
>> set to what is acked by the peer.  e.g.:
> That is not this patch want to resolve. This patch is just used to fix th=
e mixing up of setting recv ACCM and transit ACCM, And fix Huawei modem iss=
ue.
> =

> 1. Currently, it is just ACKed by peer. You know It is called at lcp_rca,=
 and here the code always use ACCM as 0x0. So that is just the acked ACCM.

Then please send a 2nd patch that just sets the recv ACCM to the one
acked by the peer if you want to be pedantic.  But changing the chunk
once, then changing it in the second chunk to some other value will only
serve to confuse me or anyone who reviews your patch submissions.

Regards,
-Denis

--===============5619548415341170203==--

