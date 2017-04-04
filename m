Content-Type: multipart/mixed; boundary="===============4225280069867277647=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: [PATCH] qmi: Optimize structure allocations
Date: Tue, 04 Apr 2017 21:10:26 +0100
Message-ID: <af80c14f-fcfc-bee6-c2e2-40fbe796c54c@gmail.com>
In-Reply-To: <44fd1c14-0d00-e7e7-751a-65f3df685e2d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4225280069867277647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 04/04/17 16:37, Denis Kenzior wrote:
> Hi Lukasz,
> =

> On 04/04/2017 02:53 AM, Lukasz Nowak wrote:
>> Hi Denis,
>>
>> On 03/04/17 19:13, Denis Kenzior wrote:
>>> struct discovery was allocated for every discovery procedure that was
>>> kicked off, which itself allocated a structure.  This patch uses a
>>> class/subclass concept to only allocate a single structure per discovery
>>> procedure.
>>
>> The primary problem with this is that it still does not cover the shutdo=
wn
> =

> Yes I know.  But as I mentioned before, I don't think the shutdown logic =
should be lumped together with the various discovery procedures. Besides, t=
he shutdown code was bizarre and not thought through properly.
> =

> I have now pushed this patch out as well as another commit that should fi=
x the shutdown case.

Thanks. The patch works fine.

> =

>> callback, which is 100% segfaulting for me.
>> I am pretty sure that shutdown_reply() and gobi.c:shutdown_cb() is curre=
ntly
>> guaranteed to arrive after gobi_remove() calls g_free(data).
> =

> I actually don't see how.  We should only be calling qmi_device_shutdown =
if the modem is being turned off cleanly (e.g. via Powered=3DFalse).  In th=
e case of a hot-unplug, we'd be going directly to the .remove method. Is yo=
ur device jumping off the USB bus when .disable is being called by any chan=
ce?

gobi_disable() is always called right before gobi_remove(). The path for th=
is is:

src/modem.c:modem_unregister()
src/modem.c:set_powered(FALSE)
driver->disable()

and then:
src/modem.c:devinfo_remove()
driver->remove()

As the disable() comes first, gobi does not know that the modem has been re=
moved, and schedules a qmi shutdown timeout(0). Callback would arrive after=
 remove().

Anyway, this is just for reference, as the latest version cancels the callb=
ack correctly.

> =

> If so, then you should consider fixing your driver or tell the manufactur=
er to fix their firmware ;)
> =

> Regards,
> -Denis

--===============4225280069867277647==--

