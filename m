Content-Type: multipart/mixed; boundary="===============1971644041808219064=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Issues about GPRS state
Date: Fri, 19 Aug 2011 01:21:57 -0500
Message-ID: <4E4E0105.7070300@gmail.com>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A075C8F8@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1971644041808219064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 08/21/2011 09:06 PM, Zhang, Caiwen wrote:
> Hi Denis,
> =

>>> At line 3 gprs_netreg_update() is called, driver_attached is set to
>>> FALSE. Due to there are some AT command in the queue, AT+CGATT=3D0 is
>> not sent out immediately(till at line 20).
>>> At line 18, driver_attached is set to TRUE. In fact after line 21,
>> GPRS is detached.
>>> In src/gprs.c there is only one place to attach GPRS, it is in
>> gprs_netreg_update().
>>> due to driver_attached is TRUE, gprs_netreg_update() will always
>>> return before
>>> gprs->driver->set_attached() invoked.
>>>
>>
>> It seems to me the issue is that we do not check the FLAG_ATTACHING
>> properly inside ofono_gprs_status_notify.  I've already proposed a fix
>> for this a while ago, please see it again (attached).
>>
> =

> Yes, it is a better solution. I remember we have discussed it before,
> please don't forget apply it.
> =


This patch has been pushed upstream now.

>>> For this issue I have submit two patches, please see attached.
>>>
>>> (2) After receive "NW DETACH"/"ME DETACH" unsolicited message, GPRS
>> is
>>> not re-attached. It will cause can not connect GPRS connection any
>> more.
>>>
>>> (3) In AT modem GPRS driver, the attach status query
>>> function(.attached_status) is implememted as query the GPRS
>> registration status. Is it by mistake or intended? It is very
>> confusable.
>>>
>>
>> Attached means whether we're actually attached to PS service.  The
>> reason the driver method is called attached_status is that some modems
>> (e.g. isi) do not have (and rightfully so) a concept of 'PS
>> registration status' as returned by CGREG.  So yes, it is on purpose
>> and it is not a mistake.
>>
> =

> Please have a look https://bugs.meego.com/show_bug.cgi?id=3D17921. The is=
sue the
> tester encountered when verified this bug should be issue (2) mentioned a=
bove.
> =


That particular bug doesn't have AT traces for me to tell what is going
on properly.  Can you please ask the tester to update the logs with
OFONO_AT_DEBUG set appropriately?

Thanks,
-Denis

--===============1971644041808219064==--

