Content-Type: multipart/mixed; boundary="===============0480450670392680790=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] sim: Added new properties to simmanager for DSSA
Date: Wed, 27 Mar 2019 14:33:26 -0500
Message-ID: <aa405cd7-95ca-3487-7f80-ac6707e34a9b@gmail.com>
In-Reply-To: <20190327122545.GA2737@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0480450670392680790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 03/27/2019 07:25 AM, Pavel Machek wrote:
> On Wed 2019-03-27 17:39:12, Antara Borwankar wrote:
>> Adding two new properties to sim manager interface to handle
>> dual SIM single active use case.
>>
>> CardSlotCount [readonly]
>> Contains the count of number of SIM card slots available.
>>
>> ActiveCardSlot [readwrite]
>> Contains the index of the currently active SIM card slot
>> for dual SIM single active mode.
> =

> Hmm. There are already modems which can have both SIMs active at the
> same time. Would it make sense to have the APIs ready for that?
> =

> 								Pavel

This is better handled by instantiating multiple modem objects for each =

logical modem device.  In the case of Dual SIM Dual Active you =

essentially have 2 independent modems anyway.  Dual SIM Dual Standby is =

pretty similar except one 'modem' goes offline during a call.  Jolla has =

done it this way for example, but their APIs are bolted on top of the =

oFono one.

We could consider handling this as a single modem object with a bunch of =

API extensions (e.g. like allowing multiple sim atoms) as well.  Not =

sure if such a solution is better or worse.  Either way, I'm not aware =

of anyone working on this at the moment.

Regards,
-Denis

--===============0480450670392680790==--

