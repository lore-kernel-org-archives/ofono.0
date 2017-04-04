Content-Type: multipart/mixed; boundary="===============4415714949309338724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmi: Optimize structure allocations
Date: Tue, 04 Apr 2017 10:37:41 -0500
Message-ID: <44fd1c14-0d00-e7e7-751a-65f3df685e2d@gmail.com>
In-Reply-To: <9e6ec554-a321-88e6-661e-1c277bcb4bce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4415714949309338724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 04/04/2017 02:53 AM, Lukasz Nowak wrote:
> Hi Denis,
>
> On 03/04/17 19:13, Denis Kenzior wrote:
>> struct discovery was allocated for every discovery procedure that was
>> kicked off, which itself allocated a structure.  This patch uses a
>> class/subclass concept to only allocate a single structure per discovery
>> procedure.
>
> The primary problem with this is that it still does not cover the shutdown

Yes I know.  But as I mentioned before, I don't think the shutdown logic =

should be lumped together with the various discovery procedures. =

Besides, the shutdown code was bizarre and not thought through properly.

I have now pushed this patch out as well as another commit that should =

fix the shutdown case.

> callback, which is 100% segfaulting for me.
> I am pretty sure that shutdown_reply() and gobi.c:shutdown_cb() is curren=
tly
> guaranteed to arrive after gobi_remove() calls g_free(data).

I actually don't see how.  We should only be calling qmi_device_shutdown =

if the modem is being turned off cleanly (e.g. via Powered=3DFalse).  In =

the case of a hot-unplug, we'd be going directly to the .remove method. =

Is your device jumping off the USB bus when .disable is being called by =

any chance?

If so, then you should consider fixing your driver or tell the =

manufacturer to fix their firmware ;)

Regards,
-Denis

--===============4415714949309338724==--

