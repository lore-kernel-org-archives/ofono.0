Content-Type: multipart/mixed; boundary="===============4033306833431784403=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH 0/3] mmsd: get delivery_report setting
Date: Tue, 17 Jul 2012 10:22:19 +0200
Message-ID: <500520BB.8050107@linux.intel.com>
In-Reply-To: <5003C1D7.2080605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4033306833431784403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 07/16/2012 09:25 AM, Denis Kenzior wrote:
> Hi Ronald,
>
> On 07/06/2012 04:32 AM, Ronald Tessier wrote:
>> This set of patches concerns mmsd and is related to delivery_report.
>> Add delivery report flag and API (to set its value) to service.
>> Get and track the delivery report setting used by oFono in the message
>> manager
>> and use it in mmsd.
>
> Maybe I'm not seeing something, but why are we tracking the delivery
> report flag in oFono in mmsd?  I'm guessing you want to synchronize the
> two, but I do not see why you would want to?
>
> Regards,
> -Denis
>

This flag is set by the application layer to request delivery report in =

oFono, since mmsd is an oFono plugin I want to use the same flag for all =

kind of messages (SMS and MMS) and not add a new flag in mmsd.

If you prefer, I define a new flag (with almost the same API and file =

settings mechanism) in mmsd. Let me know.

Regards,

Ronald

--===============4033306833431784403==--

